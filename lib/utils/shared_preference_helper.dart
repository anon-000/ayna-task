import 'package:ayna_task/data_models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Created by Auro on 25/06/24
///

class SharedPreferenceHelper {
  static const ACCESS_TOKEN_KEY = 'accessToken';
  static const USER_KEY = 'user';

  static SharedPreferences? preferences;

  static String? get accessToken => preferences?.getString(ACCESS_TOKEN_KEY);

  static void storeAccessToken(String? token) {
    if (token != null) {
      preferences?.setString(ACCESS_TOKEN_KEY, token);
    }
  }

  static void storeUser(User? user) {
    if (user != null) {
      preferences?.setString(USER_KEY, userToJson(user));
    } else {
      preferences?.remove(USER_KEY);
    }
  }

  static User? get user => preferences?.getString(USER_KEY) == null
      ? null
      : userFromJson(preferences?.getString(USER_KEY) ?? '');

  static void clear() {
    preferences?.clear();
  }
}
