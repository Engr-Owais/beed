import 'package:hive/hive.dart';

part 'beer_model.g.dart';

@HiveType(typeId: 0)
class BeerModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String tagline;

  BeerModel({
    required this.id,
    required this.name,
    required this.tagline,
  });

  factory BeerModel.fromJson(Map<String, dynamic> json) {
    return BeerModel(
      id: json['id'],
      name: json['name'],
      tagline: json['tagline'],
    );
  }
}


