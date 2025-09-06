import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserSP {
  static late SharedPreferences _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setCurrentUser(String tag) async => await _preferences.setString("currentuser", tag);
  static Future setUsers(List<String> user) async => await _preferences.setStringList("user", user);
  static Future setUserMap(Map<String, dynamic> usermap) async {
    String encodedMap = json.encode(usermap);
    return await _preferences.setString("usermap", encodedMap);
  }

  static Future setUserWalls(String user, String walls) async => await _preferences.setString("userwalls$user", walls);
  static Future setUserDefenses(String user, String defenses) async => await _preferences.setString("userdefenses$user", defenses);
  static Future setUserTraps(String user, String traps) async => await _preferences.setString("usertraps$user", traps);
  static Future setUserArmyBuildings(String user, String army) async => await _preferences.setString("userarmy$user", army);
  static Future setUserResourceBuildings(String user, String resources) async => await _preferences.setString("userresources$user", resources);

  static String getCurrentUser() => _preferences.getString("currentuser") ?? (getUser().isEmpty? "" : getUser()[0]);
  static List<String> getUser() => _preferences.getStringList("user") ?? [];
  static String getUserMap() {
    Map<String, String> defmap = {};
    if(getUser().isNotEmpty) {
      defmap[getUser()[0]] = "-";
    }
    return _preferences.getString("usermap")?? json.encode(defmap);
  }

  static Map<String, dynamic> getDecodedUserMap() {
    String usermap = getUserMap();
    return jsonDecode(usermap) as Map<String, dynamic>;
  }

  static String? getUserWalls(String user) => _preferences.getString("userwalls$user");
  static String? getUserDefenses(String user) => _preferences.getString("userdefenses$user");
  static String? getUserTraps(String user) => _preferences.getString("usertraps$user");
  static String? getUserArmyBuildings(String user) => _preferences.getString("userarmy$user");
  static String? getUserResourceBuildings(String user) => _preferences.getString("userresources$user");
}