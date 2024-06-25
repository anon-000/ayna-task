import 'package:flutter/material.dart';

///
/// Created by Auro on 25/06/24
///

@immutable
abstract class AuthEvent {}

class HandleAuthTypeEvent extends AuthEvent {
  final int type;

  HandleAuthTypeEvent(this.type);
}

class HandleAutoValidateEvent extends AuthEvent {
  final AutovalidateMode autoValidateMode;

  HandleAutoValidateEvent(this.autoValidateMode);
}

class HandleLoginEvent extends AuthEvent {
  final VoidCallback? onSuccess;

  HandleLoginEvent({this.onSuccess});
}

class HandleSignUpEvent extends AuthEvent {
  final VoidCallback? onSuccess;

  HandleSignUpEvent({this.onSuccess});
}

class HandleNameChangeEvent extends AuthEvent {
  final String name;

  HandleNameChangeEvent(this.name);
}

class HandlePasswordChangeEvent extends AuthEvent {
  final String password;

  HandlePasswordChangeEvent(this.password);
}

class HandleEmailChangeEvent extends AuthEvent {
  final String email;

  HandleEmailChangeEvent(this.email);
}
