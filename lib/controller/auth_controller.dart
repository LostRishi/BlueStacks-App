import '../login.dart';
import '../userdetails.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static login(String userData) async {
    print("userData is : " + userData);

    var prefs = await SharedPreferences.getInstance();
    prefs.setString("userData", userData);
    Get.off(UserDetails());
  }

  Future<bool> tryAutoLogin() async {
    var res = await SharedPreferences.getInstance();
    if (!res.containsKey("userData")) {
      return false;
    }
    return true;
  }

  static logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.off(LoginPage());
  }
}
