import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/endpoints_config.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/endpoint_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard API Colombia'),
      ),
      drawer: const CustomDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Selecciona un endpoint',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Esta pantalla cumple el rol de Dashboard y permite navegar al listado de cada recurso.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ...EndpointsConfig.items.map(
            (endpoint) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: EndpointCard(
                endpoint: endpoint,
                onTap: () => context.push('/list/${endpoint.key}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}