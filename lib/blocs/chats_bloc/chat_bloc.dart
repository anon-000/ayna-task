import 'package:ayna_task/api_services/db_services.dart';
import 'package:ayna_task/blocs/base_state.dart';
import 'package:ayna_task/blocs/chats_bloc/chat_events.dart';
import 'package:ayna_task/blocs/chats_bloc/chats_states.dart';
import 'package:ayna_task/data_models/chat.dart';
import 'package:ayna_task/utils/shared_preference_helper.dart';
import 'package:ayna_task/utils/toast_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

import '../../utils/app_socket_helper.dart';

///
/// Created by Auro on 25/06/24
///

class ChatsBloc extends Bloc<ChatsEvent, BaseState> {
  static final ChatsBloc _chatsBlocSingleton = ChatsBloc._internal();

  factory ChatsBloc() {
    return _chatsBlocSingleton;
  }

  ChatsBloc._internal() : super(LoadingBaseState()) {
    on<LoadChatsEvent>(_handleLoadChats);
    on<HandleCreateChatEvent>(_handleCreateChatEvent);
  }

  List<Chat> chats = [];
  bool buttonLoading = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  Future<void> close() async {
    _chatsBlocSingleton.close();
    await super.close();
  }

  Future<void> _handleLoadChats(
    LoadChatsEvent event,
    Emitter<BaseState> emit,
  ) async {
    try {
      chats = [];
      emit(LoadingBaseState());
      final result =
          await DbServices.getAllChatsByUser(SharedPreferenceHelper.user!.id!);
      final tempList = List<Chat>.from(result.map((e) => Chat.fromJson(e)))
          .reversed
          .toList();
      developer.log("$result");
      if (tempList.isEmpty) {
        emit(EmptyBaseState());
      } else {
        chats = tempList;
        emit(ChatsLoadedState());
      }
    } catch (_) {
      developer.log("$_");
      emit(ErrorBaseState(_.toString()));
    }
  }

  Future<void> _handleCreateChatEvent(
    HandleCreateChatEvent event,
    Emitter<BaseState> emit,
  ) async {
    String tempId = "${DateTime.now().millisecondsSinceEpoch}";
    try {
      if (!event.byServer) buttonLoading = true;

      Map<String, dynamic> body = {
        "_id": tempId,
        "text": event.text,
        "createdBy":
            event.byServer ? "SERVER" : SharedPreferenceHelper.user!.id,
        "conversation": SharedPreferenceHelper.user!.id,
        "createdAt": DateTime.now().toIso8601String(),
      };

      /// add temp chat
      chats.insert(0, Chat.fromJson(body));
      textEditingController.clear();
      emit(ChatsLoadedState());

      /// send msg to server
      if (!event.byServer) AppSocketHelper.sendMessage(event.text);

      final result = await DbServices.createChat(body);
      final newChat = Chat.fromJson(result);

      /// replace temp with db chat
      int index = chats.indexWhere((e) => e.id == tempId);
      if (index != -1) {
        chats[index] = newChat;
      }

      if (!event.byServer) buttonLoading = false;
      emit(ChatsLoadedState());
    } catch (e, s) {
      textEditingController.text = event.text;
      chats.removeWhere((e) => e.id == tempId);
      emit(ChatsLoadedState());
      developer.log("Error", error: e, stackTrace: s);
      AppToastHelper.showToast("$e");
    }
  }
}
