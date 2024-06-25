import 'package:ayna_task/blocs/base_state.dart';

///
/// Created by Auro on 25/06/24
///

/// Initialized
class ChatsState extends BaseState {
  ChatsState();

  @override
  String toString() => 'ChatsState';

  @override
  BaseState getStateCopy() {
    return ChatsState();
  }
}

///loaded
class ChatsLoadedState extends BaseState {
  ChatsLoadedState();

  @override
  String toString() => 'ChatsLoadedState';

  @override
  BaseState getStateCopy() {
    return ChatsLoadedState();
  }
}
