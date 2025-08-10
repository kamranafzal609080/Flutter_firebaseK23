// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));


class Welcome {
  final String? docId;
  final String? title;
  final String? image;
  final String? description;
  final String? priorityID;
  final bool? isCompleted;
  final int? createdAt;

  Welcome({
    this.docId,
    this.title,
    this.description,
    this.priorityID,
    this.image,
    this.isCompleted,
    this.createdAt,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    docId: json["docId"],
    title: json["title"],
    description: json["description"],
    priorityID: json["priorityID"],
    image: json["image"],
    isCompleted: json["isCompleted"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String taskId) => {
    "docId": taskId,
    "title": title,
    "description": description,
    "priorityID": priorityID,
    "image": image,
    "isCompleted": isCompleted,
    "createdAt": createdAt,
  };
}
