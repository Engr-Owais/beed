class BeerrModel {
  final int id;
  final String name;
  final String tagline;

  BeerrModel({
    required this.id,
    required this.name,
    required this.tagline,
  });

  factory BeerrModel.fromJson(Map<String, dynamic> json) {
    return BeerrModel(
      id: json['id'],
      name: json['name'],
      tagline: json['tagline'],
    );
  }
}
