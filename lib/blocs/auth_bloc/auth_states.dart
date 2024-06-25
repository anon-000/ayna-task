import 'package:ayna_task/blocs/base_state.dart';

///
/// Created by Auro on 25/06/24
///

/// Initialized
class AuthState extends BaseState {
  AuthState();

  @override
  String toString() => 'AuthState';

  @override
  BaseState getStateCopy() {
    return AuthState();
  }
}

///loaded
class AuthLoadedState extends BaseState {
  AuthLoadedState();

  @override
  String toString() => 'AuthLoadedState';

  @override
  BaseState getStateCopy() {
    return AuthLoadedState();
  }
}
