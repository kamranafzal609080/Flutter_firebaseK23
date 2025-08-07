// To parse this JSON data, do
//
//     final prioritiyModel = prioritiyModelFromJson(jsonString);

import 'dart:convert';

PrioritiyModel prioritiyModelFromJson(String str) => PrioritiyModel.fromJson(json.decode(str));


class PrioritiyModel {
  final String? docId;
  final String? name;
  final int? createdAt;

  PrioritiyModel({
    this.docId,
    this.name,
    this.createdAt,
  });

  factory PrioritiyModel.fromJson(Map<String, dynamic> json) => PrioritiyModel(
    docId: json["docId"],
    name: json["name"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String docID) => {
    "docId": docID,
    "name": name,
    "createdAt": createdAt,
  };
}
