import 'dart:developer';

import 'package:bson/bson.dart';
import 'package:hive_flutter/hive_flutter.dart';

///
/// Created by Auro on 25/06/24
///

class DbServices {
  static late final BoxCollection collection;
  static late final CollectionBox usersBox;
  static late final CollectionBox chatsBox;

  static initBoxes() async {
    // Create a box collection
    collection = await BoxCollection.open(
      'AyanaDB', // Name of your database
      {'users_box', 'chats_box'}, // Names of your boxes
      path: './',
    );
    usersBox = await collection.openBox("users_box");
    chatsBox = await collection.openBox("chats_box");
  }

  ///
  ///  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ///

  // GET ALL USERS >>>>>>>>
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final data = await usersBox.getAllValues();
    return data.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  // ADD USER >>>>>>>>
  static Future<Map<String, dynamic>?> createUser(
      Map<String, dynamic> datum) async {
    final user = await getUserByEmail(datum['email']);
    if (user == null || user.entries.isEmpty) {
      ObjectId id = ObjectId();
      String generatedId = id.oid;
      Map<String, dynamic> body = {
        ...datum,
        '_id': generatedId,
        'createdAt': DateTime.now().toIso8601String(),
      };
      await usersBox.put(generatedId, body);
      return body;
    } else {
      throw "Email ID is already registered with us.";
    }
  }

  // DELETE USER
  static Future<void> deleteUser(String id) async {
    await usersBox.delete(id);
  }

  // GET USER BY ID
  static Future<Map<String, dynamic>> getUserById(String id) async {
    return await usersBox.get(id);
  }

  // GET USER BY EMAIL
  static Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final data = await usersBox.getAllValues();
    log("Result $data");
    return data.values
        .map((e) => Map<String, dynamic>.from(e))
        .firstWhere((e) => e['email'] == email, orElse: () => {});
  }

  ///
  ///  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ///

  // GET ALL CHATS >>>>>>>>
  static Future<List<Map<String, dynamic>>> getAllChats() async {
    final data = await chatsBox.getAllValues();
    log("$data");
    return [data];
  }

  // ADD A CHAT >>>>>>>>
  static Future<Map<String, dynamic>> createChat(
      Map<String, dynamic> datum) async {
    ObjectId id = ObjectId();
    String generatedId = id.oid;
    Map<String, dynamic> body = {
      ...datum,
      '_id': generatedId,
      'createdAt': DateTime.now().toIso8601String(),
    };
    await chatsBox.put(generatedId, body);
    return body;
  }

  // DELETE CHAT
  static Future<void> deleteChat(String id) async {
    await chatsBox.delete(id);
  }

  // GET CHAT BY ID
  static Future<Map<String, dynamic>> getChatById(String id) async {
    return await chatsBox.get(id);
  }

  ///
  ///  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ///
}
