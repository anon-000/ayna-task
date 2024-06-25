import 'package:ayna_task/blocs/base_state.dart';
import 'package:ayna_task/blocs/chats_bloc/chat_events.dart';
import 'package:ayna_task/data_models/chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

///
/// Created by Auro on 25/06/24
///

class ChatsBloc extends Bloc<ChatsEvent, BaseState> {
  static final ChatsBloc _chatsBlocSingleton = ChatsBloc._internal();

  factory ChatsBloc() {
    return _chatsBlocSingleton;
  }

  ChatsBloc._internal() : super(LoadingBaseState());

  List<Chat> chats = [];
  bool buttonLoading = false;

  @override
  Future<void> close() async {
    _chatsBlocSingleton.close();
    await super.close();
  }

  Stream<BaseState> mapEventToState(
    ChatsEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ChatsBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
