import 'dart:developer';
import 'package:ayna_task/blocs/chats_bloc/chat_bloc.dart';
import 'package:ayna_task/blocs/chats_bloc/chat_events.dart';
import 'package:ayna_task/config/environment.dart';
import 'package:web_socket_client/web_socket_client.dart';

///
/// Created by Auro on 24/06/24 at 9:24 pm
///

// For managing socket related operations
mixin AppSocketHelper {
  // Initially wait 0s and increase the wait time by 1s until a maximum of 5s is reached.
  // [0, 1, 2, 3, 4, 5, 5, 5, ...]
  static dynamic backoff = LinearBackoff(
    initial: const Duration(seconds: 0),
    increment: const Duration(seconds: 1),
    maximum: const Duration(seconds: 5),
  );
  static late WebSocket socket;

  static initSocket() async {
    try {
      log("Connecting to Web Socket : [ ${Environment.webSocketURL} ]");
      socket = WebSocket(
        Uri.parse(Environment.webSocketURL),
        backoff: backoff,
      );
      _initListeners();
    } catch (err) {
      log("$err");
    }
  }

  static _initListeners() async {
    // Listen to messages from the server.
    socket.messages.listen((message) {
      // Handle incoming messages.
      log("Incoming Message : $message");
      if (!RegExp(r'Request served by [a-zA-Z0-9]+').hasMatch(message)) {
        ChatsBloc().add(
          HandleCreateChatEvent(
            message,
            byServer: true,
          ),
        );
      }
    });
  }

  static sendMessage(String msg) {
    // Send messages to the server.
    try {
      socket.send(msg);
    } catch (err) {
      log("$err");
    }
  }

  static disposeSocket() async {
    // Dispose the Socket
    log("DISPOSING SOCKET >>>>>>>");
    socket.close();
  }
}
