// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));


class Welcome {
  final String? docId;
  final String? title;
  final String? description;
  final String? image;
  final bool? isCompleted;
  final int? createdAt;

  Welcome({
    this.docId,
    this.title,
    this.description,
    this.image,
    this.isCompleted,
    this.createdAt,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    docId: json["docId"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    isCompleted: json["isCompleted"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String taskId) => {
    "docId": taskId,
    "title": title,
    "description": description,
    "image": image,
    "isCompleted": isCompleted,
    "createdAt": createdAt,
  };
}
