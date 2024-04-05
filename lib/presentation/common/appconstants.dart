import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static Future<bool?> checkSharedPref() async {
    final shared = await SharedPreferences.getInstance();
    return shared.getBool("login");
  }
}
