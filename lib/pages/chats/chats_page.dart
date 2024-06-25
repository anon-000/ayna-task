import 'package:ayna_task/blocs/chats_bloc/chat_bloc.dart';
import 'package:ayna_task/blocs/chats_bloc/chat_events.dart';
import 'package:ayna_task/config/app_colors.dart';
import 'package:ayna_task/config/app_decorations.dart';
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
  ChatsBloc get bloc => ChatsBloc();

  @override
  void initState() {
    super.initState();
    AppSocketHelper.initSocket();
    bloc.add(LoadChatsEvent());
  }

  @override
  void dispose() {
    super.dispose();
    AppSocketHelper.disposeSocket();
  }

  // AppSocketHelper.sendMessage("Hello World");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginSideBG.withOpacity(0.3),
      appBar: AppBar(
        elevation: 2,
        title: const Text("The Echo Bot ☠️"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Log Out",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        // onChanged: (v) => bloc.add(HandleNameChangeEvent(v)),
                        decoration: AppDecorations.textFieldDecoration(context)
                            .copyWith(hintText: "Type something..."),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
