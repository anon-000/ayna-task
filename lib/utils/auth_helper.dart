import 'dart:developer';
import 'package:bcrypt/bcrypt.dart';
import 'package:ayna_task/api_services/db_services.dart';
import 'package:ayna_task/utils/shared_preference_helper.dart';

///
/// Created by Auro on 24/06/24
///

class AuthHelper {
  static bool get isLoggedIn => SharedPreferenceHelper.accessToken != null;

  static Future<dynamic> userLoginWithEmail(
      String email, String password) async {
    try {
      /// check exists or not : if yes it'll get an user obj or else null
      final user = await DbServices.getUserByEmail(email);

      if (user == null || user.entries.isEmpty) {
        throw "Please create an account to login.";
      } else {
        /// then check that objects hashed password matches with the given one or not
        final bool checkPassword = BCrypt.checkpw(
          password,
          user['password'],
        );
        if (checkPassword) {
          /// login success
          return user;
        } else {
          /// login failed
          throw "Given password is incorrect";
        }
      }
    } catch (err, s) {
      log("$err");
      // throw ("$err");
    }
  }

  static Future<dynamic> userSignUpWithEmail(
      String name, String email, String password) async {
    try {
      final String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
      final res = await DbServices.createUser({
        "name": name,
        "email": email,
        "password": hashedPassword,
      });
      return res;
    } catch (err, s) {
      log("$err");
      // throw ("$err");
    }
  }
}
