import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static late SharedPreferences data;

  static Future initLocalStorage() async {
    data = await SharedPreferences.getInstance();
    if (!data.containsKey('is_login')) {
      data.setBool('is_login', false);
    }
  }
}
