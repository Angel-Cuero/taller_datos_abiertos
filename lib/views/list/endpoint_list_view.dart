import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/endpoints_config.dart';
import '../../models/api_colombia_item.dart';
import '../../services/api_colombia_service.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/state_widgets.dart';

class EndpointListView extends StatefulWidget {
  const EndpointListView({
    super.key,
    required this.endpointKey,
  });

  final String endpointKey;

  @override
  State<EndpointListView> createState() => _EndpointListViewState();
}

class _EndpointListViewState extends State<EndpointListView> {
  late Future<List<ApiColombiaItem>> _futureItems;
  final ApiColombiaService _service = ApiColombiaService();

  @override
  void initState() {
    super.initState();
    _futureItems = _service.getItems(widget.endpointKey);
  }

  void _reload() {
    setState(() {
      _futureItems = _service.getItems(widget.endpointKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    final endpoint = EndpointsConfig.byKey(widget.endpointKey);
    final title = endpoint?.title ?? 'Listado';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: const CustomDrawer(),
      body: FutureBuilder<List<ApiColombiaItem>>(
        future: _futureItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView(message: 'Cargando listado...');
          }

          if (snapshot.hasError) {
            return ErrorView(
              message: 'Error al cargar datos: ${snapshot.error}',
              onRetry: _reload,
            );
          }

          final items = snapshot.data ?? <ApiColombiaItem>[];
          if (items.isEmpty) {
            return const EmptyView(
              message: 'El endpoint no devolvio resultados.',
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _reload(),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: _buildImage(item.imageUrl),
                  title: Text(item.title),
                  subtitle: Text(
                    item.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => context.push(
                    '/detail/${widget.endpointKey}/${item.id}',
                    extra: item,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.isEmpty) {
      return const CircleAvatar(child: Icon(Icons.folder_open_outlined));
    }

    return CircleAvatar(
      backgroundImage: NetworkImage(imageUrl),
      onBackgroundImageError: (error, stackTrace) {},
      child: imageUrl.isEmpty ? const Icon(Icons.image_not_supported_outlined) : null,
    );
  }
}