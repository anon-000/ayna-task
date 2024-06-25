
import 'package:flutter/material.dart';


///
/// Created by Auro on 25/06/24
///

@immutable
abstract class ChatsEvent {}

class LoadChatsEvent extends ChatsEvent {
  LoadChatsEvent();
}

class HandleCreateChatEvent extends ChatsEvent {
  final String text;
  final bool byServer;

  HandleCreateChatEvent(this.text, {this.byServer = false});
}
