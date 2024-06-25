import 'package:ayna_task/api_services/db_services.dart';
import 'package:ayna_task/blocs/auth_bloc/auth_bloc.dart';
import 'package:ayna_task/blocs/chats_bloc/chat_bloc.dart';
import 'package:ayna_task/config/app_page_routes.dart';
import 'package:ayna_task/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  SharedPreferenceHelper.preferences = await SharedPreferences.getInstance();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    DbServices.initBoxes();
  }

  @override
  void dispose() {
    ChatsBloc().close();
    AuthBloc().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ChatsBloc>(create: (context) => ChatsBloc()),
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        ],
        child: MaterialApp.router(
          title: 'Ayna Task',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xff7F265B)),
            useMaterial3: true,
            canvasColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
          ),
          routerConfig: AppPages.router,
          // routerDelegate: AppPages.router.routerDelegate,
          // routeInformationParser: AppPages.router.routeInformationParser,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
