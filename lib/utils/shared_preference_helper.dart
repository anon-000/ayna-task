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
}
