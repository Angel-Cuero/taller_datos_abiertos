class ApiColombiaItem {
  ApiColombiaItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.raw,
  });

  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final Map<String, dynamic> raw;

  factory ApiColombiaItem.fromJson(Map<String, dynamic> json) {
    final dynamic idValue =
        json['id'] ?? json['code'] ?? json['airportCode'] ?? json['name'];

    final String title = (json['name'] ??
            json['nombre'] ??
            json['title'] ??
            json['presidentName'] ??
            'Sin titulo')
        .toString();

    final String subtitle = (json['description'] ??
            json['summary'] ??
            json['regionDescription'] ??
            json['capital'] ??
            json['city'] ??
            json['status'] ??
            'Sin descripcion disponible')
        .toString();

    final String imageUrl = (json['image'] ??
            json['imageUrl'] ??
            json['urlImage'] ??
            json['coverImage'] ??
            '')
        .toString();

    return ApiColombiaItem(
      id: idValue.toString(),
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      raw: json,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'raw': raw,
    };
  }
}