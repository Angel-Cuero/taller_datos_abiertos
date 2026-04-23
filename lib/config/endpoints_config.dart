import 'package:flutter/material.dart';

class EndpointConfig {
  const EndpointConfig({
    required this.key,
    required this.title,
    required this.path,
    required this.description,
    required this.icon,
  });

  final String key;
  final String title;
  final String path;
  final String description;
  final IconData icon;
}

class EndpointsConfig {
  static const List<EndpointConfig> items = [
    EndpointConfig(
      key: 'department',
      title: 'Departamentos',
      path: 'Department',
      description: 'Listado oficial de departamentos de Colombia.',
      icon: Icons.map_outlined,
    ),
    EndpointConfig(
      key: 'region',
      title: 'Regiones',
      path: 'Region',
      description: 'Regiones geograficas y administrativas del pais.',
      icon: Icons.public_outlined,
    ),
    EndpointConfig(
      key: 'president',
      title: 'Presidentes',
      path: 'President',
      description: 'Presidentes de Colombia y su informacion historica.',
      icon: Icons.account_balance_outlined,
    ),
    EndpointConfig(
      key: 'airport',
      title: 'Aeropuertos',
      path: 'Airport',
      description: 'Aeropuertos del territorio colombiano.',
      icon: Icons.flight_takeoff_outlined,
    ),
  ];

  static EndpointConfig? byKey(String key) {
    try {
      return items.firstWhere((endpoint) => endpoint.key == key);
    } catch (_) {
      return null;
    }
  }
}