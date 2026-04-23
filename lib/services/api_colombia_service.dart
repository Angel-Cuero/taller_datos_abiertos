import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../config/endpoints_config.dart';
import '../models/api_colombia_item.dart';

class ApiColombiaService {
  final String baseUrl = dotenv.env['API_COLOMBIA_BASE_URL'] ??
      'https://api-colombia.com/api/v1';

  Future<List<ApiColombiaItem>> getItems(String endpointKey) async {
    final endpoint = EndpointsConfig.byKey(endpointKey);
    if (endpoint == null) {
      throw Exception('Endpoint no configurado: $endpointKey');
    }

    final uri = Uri.parse('$baseUrl/${endpoint.path}');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Error al cargar ${endpoint.title}. Codigo: ${response.statusCode}',
      );
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

    return data
        .whereType<Map<String, dynamic>>()
        .map(ApiColombiaItem.fromJson)
        .toList();
  }

  Future<ApiColombiaItem> getItemById(String endpointKey, String id) async {
    final endpoint = EndpointsConfig.byKey(endpointKey);
    if (endpoint == null) {
      throw Exception('Endpoint no configurado: $endpointKey');
    }

    final uri = Uri.parse('$baseUrl/${endpoint.path}/$id');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'Error al cargar detalle de ${endpoint.title}. Codigo: ${response.statusCode}',
      );
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;

    return ApiColombiaItem.fromJson(data);
  }
}