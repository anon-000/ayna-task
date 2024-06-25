import 'package:ayna_task/blocs/auth_bloc/auth_events.dart';
import 'package:ayna_task/blocs/auth_bloc/auth_states.dart';
import 'package:ayna_task/blocs/base_state.dart';
import 'package:ayna_task/data_models/user.dart';
import 'package:ayna_task/utils/auth_helper.dart';
import 'package:ayna_task/utils/shared_preference_helper.dart';
import 'package:ayna_task/utils/toast_helper.dart';
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
    // _authBlocSingleton._router = router!;
    return _authBlocSingleton;
  }

  AuthBloc._internal() : super(AuthState()) {
    on<HandleAuthTypeEvent>(_handleAuthType);
    on<HandleAutoValidateEvent>(_handleAutoValidate);
    on<HandleLoginEvent>(_handleLogin);
    on<HandleSignUpEvent>(_handleSignUp);
    on<HandleEmailChangeEvent>(_handleEmail);
    on<HandleNameChangeEvent>(_handleName);
    on<HandlePasswordChangeEvent>(_handlePassword);
  }

  // GoRouter? _router;

  /// state vars
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  String name = '', email = '', password = '';
  int authType = 0;

  /// Auth type : 0-login, 1-signup

  @override
  Future<void> close() async {
    await super.close();
  }

  Future<void> _handleAuthType(
    HandleAuthTypeEvent event,
    Emitter<BaseState> emit,
  ) async {
    try {
      authType = event.type;
      emit(AuthLoadedState());
    } catch (_) {
      developer.log("$_");
    }
  }

  Future<void> _handleAutoValidate(
    HandleAutoValidateEvent event,
    Emitter<BaseState> emit,
  ) async {
    try {
      autoValidateMode = event.autoValidateMode;
      emit(AuthLoadedState());
    } catch (_) {
      developer.log("$_");
    }
  }

  Future<void> _handleLogin(
    HandleLoginEvent event,
    Emitter<BaseState> emit,
  ) async {
    try {
      // buttonKey.currentState!.showLoader();
      final res = await AuthHelper.userLoginWithEmail(email, password);
      if (res != null) {
        final tempUser = User.fromJson(res);
        SharedPreferenceHelper.storeUser(tempUser);
        // buttonKey.currentState!.hideLoader();
        emit(AuthLoadedState());
        AppToastHelper.showToast("Login Successful");
        event.onSuccess?.call();
      }
    } catch (_) {
      // buttonKey.currentState!.hideLoader();
      developer.log("AUTH BLOC : $_");
      AppToastHelper.showToast("$_");
    }
  }

  Future<void> _handleSignUp(
    HandleSignUpEvent event,
    Emitter<BaseState> emit,
  ) async {
    try {
      // buttonKey.currentState!.showLoader();
      final res = await AuthHelper.userSignUpWithEmail(name, email, password);
      if (res != null) {
        final tempUser = User.fromJson(res);
        SharedPreferenceHelper.storeUser(tempUser);
        // buttonKey.currentState!.hideLoader();
        emit(AuthLoadedState());
        AppToastHelper.showToast("Login Successful");
        event.onSuccess?.call();
      }
    } catch (_) {
      // buttonKey.currentState!.hideLoader();
      developer.log("$_");
      AppToastHelper.showToast("$_");
    }
  }

  Future<void> _handleEmail(
    HandleEmailChangeEvent event,
    Emitter<BaseState> emit,
  ) async {
    try {
      email = event.email;
    } catch (_) {
      developer.log("$_");
    }
  }

  Future<void> _handleName(
    HandleNameChangeEvent event,
    Emitter<BaseState> emit,
  ) async {
    try {
      email = event.name;
    } catch (_) {
      developer.log("$_");
    }
  }

  Future<void> _handlePassword(
    HandlePasswordChangeEvent event,
    Emitter<BaseState> emit,
  ) async {
    try {
      email = event.password;
    } catch (_) {
      developer.log("$_");
    }
  }
}
