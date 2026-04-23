import 'dart:convert';

import 'package:flutter/material.dart';

import '../../config/endpoints_config.dart';
import '../../models/api_colombia_item.dart';
import '../../services/api_colombia_service.dart';
import '../../widgets/state_widgets.dart';

class EndpointDetailView extends StatefulWidget {
  const EndpointDetailView({
    super.key,
    required this.endpointKey,
    required this.id,
    this.itemFromExtra,
  });

  final String endpointKey;
  final String id;
  final ApiColombiaItem? itemFromExtra;

  @override
  State<EndpointDetailView> createState() => _EndpointDetailViewState();
}

class _EndpointDetailViewState extends State<EndpointDetailView> {
  late Future<ApiColombiaItem> _futureItem;
  final ApiColombiaService _service = ApiColombiaService();

  @override
  void initState() {
    super.initState();
    _futureItem = widget.itemFromExtra != null
        ? Future.value(widget.itemFromExtra)
        : _service.getItemById(widget.endpointKey, widget.id);
  }

  void _reload() {
    setState(() {
      _futureItem = _service.getItemById(widget.endpointKey, widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final endpoint = EndpointsConfig.byKey(widget.endpointKey);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle ${endpoint?.title ?? ''}'.trim()),
      ),
      body: FutureBuilder<ApiColombiaItem>(
        future: _futureItem,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView(message: 'Cargando detalle...');
          }

          if (snapshot.hasError) {
            return ErrorView(
              message: 'No fue posible cargar el detalle: ${snapshot.error}',
              onRetry: _reload,
            );
          }

          final item = snapshot.data;
          if (item == null) {
            return const EmptyView(message: 'No hay informacion de este registro.');
          }

          final prettyJson = const JsonEncoder.withIndent('  ').convert(item.raw);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (item.imageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.imageUrl,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 220,
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image_outlined, size: 38),
                      );
                    },
                  ),
                ),
              if (item.imageUrl.isNotEmpty) const SizedBox(height: 16),
              Text(
                item.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(item.subtitle),
              const SizedBox(height: 16),
              Text(
                'ID: ${item.id}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Respuesta JSON',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SelectableText(
                  prettyJson,
                  style: const TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}