import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(jsonDecode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  MongoDbModel({
    required this.id,
    required this.title,
    required this.description,
  });

  ObjectId id;
  String title;
  String description;

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
      id: json["id"], title: json["title"], description: json["description"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
