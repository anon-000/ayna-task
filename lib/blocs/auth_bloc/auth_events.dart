import 'dart:developer';

import 'package:ayna_task/blocs/auth_bloc/auth_bloc.dart';
import 'package:ayna_task/blocs/auth_bloc/auth_states.dart';
import 'package:flutter/material.dart';

import '../base_state.dart';

///
/// Created by Auro on 25/06/24
///

@immutable
abstract class AuthEvent {
  Stream<BaseState> applyAsync({BaseState currentState, AuthBloc bloc});
}

class HandleAuthTypeEvent extends AuthEvent {
  final int type;

  HandleAuthTypeEvent(this.type);

  @override
  String toString() => 'HandleAuthTypeEvent';

  @override
  Stream<BaseState> applyAsync(
      {BaseState? currentState, AuthBloc? bloc}) async* {
    try {
      bloc!.authType = type;
      yield AuthLoadedState();
    } catch (e, s) {
      log("Error", error: e, stackTrace: s);
      yield AuthLoadedState();
    }
  }
}
