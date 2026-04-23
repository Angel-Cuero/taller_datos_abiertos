import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/endpoints_config.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00695C), Color(0xFF00897B)],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Parcial 2 - Datos Abiertos',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          _DrawerItem(
            title: 'Dashboard',
            icon: Icons.dashboard_outlined,
            onTap: () => context.go('/'),
          ),
          const Divider(height: 12),
          ...EndpointsConfig.items.map(
            (endpoint) => _DrawerItem(
              title: endpoint.title,
              icon: endpoint.icon,
              onTap: () => context.go('/list/${endpoint.key}'),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
    );
  }
}