import 'dart:developer';

import 'package:ayna_task/api_services/db_services.dart';
import 'package:ayna_task/blocs/chats_bloc/chat_bloc.dart';
import 'package:ayna_task/blocs/chats_bloc/chats_states.dart';
import 'package:ayna_task/data_models/chat.dart';
import 'package:ayna_task/utils/app_socket_helper.dart';
import 'package:ayna_task/utils/shared_preference_helper.dart';
import 'package:ayna_task/utils/toast_helper.dart';
import 'package:flutter/material.dart';

import '../base_state.dart';

///
/// Created by Auro on 25/06/24
///

@immutable
abstract class ChatsEvent {
  Stream<BaseState> applyAsync({BaseState currentState, ChatsBloc bloc});
}

class LoadChatsEvent extends ChatsEvent {
  LoadChatsEvent();

  @override
  String toString() => 'LoadChatsEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState? currentState, ChatsBloc? bloc}) async* {
    try {
      bloc!.chats = [];
      yield LoadingBaseState();
      final result = await DbServices.getAllChats();
      final tempList =
          List<Chat>.from(result.map((e) => Chat.fromJson(e))).toList();
      if (tempList.isEmpty) {
        yield EmptyBaseState();
      } else {
        bloc.chats = tempList;
        yield ChatsLoadedState();
      }
    } catch (e, s) {
      log("Error", error: e, stackTrace: s);
      yield ErrorBaseState(e.toString());
    }
  }
}

class HandleCreateChatEvent extends ChatsEvent {
  final String text;
  final bool byServer;

  HandleCreateChatEvent(this.text, {this.byServer = false});

  @override
  String toString() => 'CreateChatEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState? currentState, ChatsBloc? bloc}) async* {
    String tempId = "${DateTime.now().millisecondsSinceEpoch}";
    try {
      if (!byServer) bloc!.buttonLoading = true;

      Map<String, dynamic> body = {
        "_id": tempId,
        "text": text,
        "createdBy": byServer ? "SERVER" : SharedPreferenceHelper.user!.id,
        "conversation": SharedPreferenceHelper.user!.id,
      };

      /// send msg to server
      if (!byServer) AppSocketHelper.sendMessage(text);

      /// add temp chat
      bloc!.chats.add(Chat.fromJson(body));
      final result = await DbServices.createChat(body);
      final newChat = Chat.fromJson(result);

      /// replace temp with db chat
      int index = bloc.chats.indexWhere((e) => e.id == tempId);
      if (index != -1) {
        bloc.chats[index] = newChat;
      }

      if (!byServer) bloc.buttonLoading = false;
      yield ChatsLoadedState();
    } catch (e, s) {
      bloc!.chats.removeWhere((e) => e.id == tempId);
      yield ChatsLoadedState();
      log("Error", error: e, stackTrace: s);
      AppToastHelper.showToast("$e");
    }
  }
}
