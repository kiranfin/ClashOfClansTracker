import 'package:shared_preferences/shared_preferences.dart';

class UserSP {
  static late SharedPreferences _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setCurrentUser(String tag) async => await _preferences.setString("currentuser", tag);
  static Future setUsers(List<String> user) async => await _preferences.setStringList("user", user);
  static Future setUserNames(List<String> user) async => await _preferences.setStringList("usernames", user);

  static String getCurrentUser() => _preferences.getString("currentuser") ?? (getUser().isEmpty? "" : getUser()[0]);
  static List<String> getUser() => _preferences.getStringList("user") ?? [];
  static List<String> getUserNames() => _preferences.getStringList("usernames") ?? [];
}