import 'package:ayna_task/blocs/base_state.dart';
import 'package:ayna_task/blocs/chats_bloc/chat_bloc.dart';
import 'package:ayna_task/blocs/chats_bloc/chat_events.dart';
import 'package:ayna_task/blocs/chats_bloc/chats_states.dart';
import 'package:ayna_task/config/app_assets.dart';
import 'package:ayna_task/config/app_colors.dart';
import 'package:ayna_task/config/app_decorations.dart';
import 'package:ayna_task/pages/chats/widgets/animated_avatar.dart';
import 'package:ayna_task/pages/chats/widgets/chat_tile.dart';
import 'package:ayna_task/utils/app_socket_helper.dart';
import 'package:ayna_task/utils/shared_preference_helper.dart';
import 'package:ayna_task/widgets/dialogs/alert_dialog.dart';
import 'package:ayna_task/widgets/fallbacks/fallback_widgets.dart';
import 'package:ayna_task/widgets/loaders/app_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
      // backgroundColor: AppColors.loginSideBG.withOpacity(0.05),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.chatBg),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Center(
          child: Container(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxWidth: 700),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: const Color(0xffcccccc).withOpacity(0.6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  child: Row(
                    children: [
                      const AnimatedSkull(),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "The Echo Bot",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "🟢 Online",
                              style: TextStyle(
                                color: Colors.lightGreenAccent,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: "Log Out",
                        onPressed: () async {
                          bool? result = await showAppAlertDialog(
                            context: context,
                            title: 'Log Out',
                            description: 'Are you sure you want to Log Out?',
                            positiveText: 'Yes',
                            negativeText: 'No',
                          );
                          if (result != null && result) {
                            SharedPreferenceHelper.storeUser(null);
                            GoRouter.of(context).pushReplacementNamed('/login');
                          }
                        },
                        icon: const Icon(
                          Icons.power_settings_new_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<ChatsBloc, BaseState>(
                    builder: (context, state) {
                      if (state is LoadingBaseState) {
                        return const Center(child: AppProgress());
                      }
                      if (state is ErrorBaseState) {
                        return AppErrorWidget(
                          title: state.errorMessage,
                        );
                      }
                      if (state is EmptyBaseState) {
                        return AppEmptyWidget(
                          onReload: () {
                            bloc.add(HandleCreateChatEvent("Hii..."));
                          },
                          buttonText: " Greetings ! Say hi to your bot 👋 ",
                        );
                      }
                      if (state is ChatsLoadedState) {
                        return ListView.separated(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          reverse: true,
                          itemBuilder: (c, i) => ChatTile(bloc.chats[i]),
                          separatorBuilder: (c, i) =>
                              const SizedBox(height: 16),
                          itemCount: bloc.chats.length,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                BlocBuilder<ChatsBloc, BaseState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: bloc.textEditingController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onSubmitted: (String value) {
                                if (bloc
                                    .textEditingController.text.isNotEmpty) {
                                  bloc.add(HandleCreateChatEvent(
                                      bloc.textEditingController.text));
                                }
                              },
                              decoration:
                                  AppDecorations.textFieldDecoration(context)
                                      .copyWith(hintText: "Type something..."),
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              if (bloc.textEditingController.text.isNotEmpty) {
                                bloc.add(HandleCreateChatEvent(
                                    bloc.textEditingController.text));
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
