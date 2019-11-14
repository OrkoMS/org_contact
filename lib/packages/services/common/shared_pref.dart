import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void setUserAppState(String stateName, bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(stateName, value);
  }

  Future<bool> getUserAppState(String stateName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool appState = sharedPreferences.getBool(stateName);
    return appState;
  }
  void setUserAppData(String dataName, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(dataName, value);
  }

  Future<String> getUserAppData(String dataName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String appState = sharedPreferences.getString(dataName);
    return appState;
  }
}