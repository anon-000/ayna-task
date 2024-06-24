import 'package:ayna_task/utils/app_socket_helper.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 24/06/24
///

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  static const routeName = "/chats";

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    super.initState();
    AppSocketHelper.initSocket();
  }

  @override
  void dispose() {
    super.dispose();
    AppSocketHelper.disposeSocket();
  }

  // AppSocketHelper.sendMessage("Hello World");

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Chats"),
      ),
    );
  }
}
