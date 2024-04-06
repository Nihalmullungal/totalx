import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static Future<bool?> checkSharedPref() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getBool("login");
  }

  static Future<bool?> setSharedPre(bool value) async {
    final shared = await SharedPreferences.getInstance();
    return shared.setBool("login", value);
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    AppConstants.setSharedPre(false);
  }
}
