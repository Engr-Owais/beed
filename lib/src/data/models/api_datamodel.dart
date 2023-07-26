import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'result.dart';


@HiveType(typeId: 0)
class APIDataModel {
  APIDataModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  @HiveField(0)
  int count;
  @HiveField(1)
  String? next;
  @HiveField(2)
  String? previous;
  @HiveField(3)
  List<Result> results;

  factory APIDataModel.fromJson(Map<String, dynamic> json) => APIDataModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
