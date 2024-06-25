import 'package:ayna_task/blocs/auth_bloc/auth_events.dart';
import 'package:ayna_task/blocs/auth_bloc/auth_states.dart';
import 'package:ayna_task/blocs/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

import '../../widgets/buttons/app_primary_button.dart';

///
/// Created by Auro on 25/06/24
///

class AuthBloc extends Bloc<AuthEvent, BaseState> {
  static final AuthBloc _authBlocSingleton = AuthBloc._internal();

  factory AuthBloc() {
    return _authBlocSingleton;
  }

  AuthBloc._internal() : super(AuthState());

  /// state vars
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  int authType = 0;

  /// Auth type : 0-login, 1-signup

  @override
  Future<void> close() async {
    await super.close();
  }

  @override
  Stream<BaseState> onEvent(AuthEvent event) async* {
    super.onEvent(event);
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'AuthBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
