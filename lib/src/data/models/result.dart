import 'package:hive/hive.dart';

part 'result.g.dart';

@HiveType(typeId: 1)
class Result extends HiveObject {
  Result({
    required this.name,
    required this.url,
  });

  @HiveField(0)
  String name;
  @HiveField(1)
  String url;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
