class Offer {
  final String id;
  final String name;
  final String description;
  final String coverUrl;
  final String createdAt;

  Offer({
    required this.id,
    required this.name,
    required this.description,
    required this.coverUrl,
    required this.createdAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      coverUrl: json['coverUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
