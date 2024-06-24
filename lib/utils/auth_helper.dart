import 'package:ayna_task/utils/shared_preference_helper.dart';

///
/// Created by Auro on 24/06/24
///

class AuthHelper {
  static bool get isLoggedIn => SharedPreferenceHelper.accessToken != null;
}
