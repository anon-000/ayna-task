///
/// Created by Auro on 24/06/24 at 9:24 pm
///

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? email;
  String? password;
  String? name;
  String? id;
  DateTime? createdAt;

  User({
    this.email,
    this.password,
    this.name,
    this.id,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        password: json["password"],
        name: json["name"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
      };
}
