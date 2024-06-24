import 'package:ayna_task/pages/auth/login_page.dart';
import 'package:ayna_task/pages/chats/chats_page.dart';
import 'package:ayna_task/pages/splash_screen/splash_screen_page.dart';
import 'package:ayna_task/utils/auth_helper.dart';
import 'package:go_router/go_router.dart';

///
/// Created by Auro on 24/06/24
///

class AppPages {
  static final router = GoRouter(
    routes: [
      GoRoute(
        name: ChatsPage.routeName,
        path: ChatsPage.routeName,
        builder: (context, state) => const ChatsPage(),
        redirect: (context, state) {
          if (AuthHelper.isLoggedIn) {
            return null;
          } else {
            return LoginPage.routeName;
          }
        },
      ),
      GoRoute(
        name: SplashScreen.routeName,
        path: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
        redirect: (context, state) {
          if (AuthHelper.isLoggedIn) {
            return ChatsPage.routeName;
          } else {
            return LoginPage.routeName;
          }
        },
      ),
      GoRoute(
        name: LoginPage.routeName,
        path: LoginPage.routeName,
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}
