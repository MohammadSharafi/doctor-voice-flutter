import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  Future<bool> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(CacheManagerKey.TOKEN.toString());
  }
  Future<bool> saveOTPToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CacheManagerKey.OTP_TOKEN.toString(), token);
    return true;
  }

  Future<String?> getOTPToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(CacheManagerKey.OTP_TOKEN.toString());
  }
  
}

enum CacheManagerKey { TOKEN,OTP_TOKEN }
