///
/// Created by Auro on 24/06/24 at 9:26 pm
///

// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'dart:convert';

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));

String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  String? conversation;
  String? text;
  String? createdBy;
  String? id;
  DateTime? createdAt;

  Chat({
    this.conversation,
    this.text,
    this.createdBy,
    this.id,
    this.createdAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        conversation: json["conversation"],
        text: json["text"],
        createdBy: json["createdBy"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "conversation": conversation,
        "text": text,
        "createdBy": createdBy,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
      };
}
