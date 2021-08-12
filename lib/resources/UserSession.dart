import 'package:shared_preferences/shared_preferences.dart';
import 'Constants.dart';

Future session;
SharedPreferences pref;

Future<bool> getLoggedIn() async {
  pref = await _sharedPreference();
  final status = pref.getBool(login);
  return status;
}

Future saveLogin() async {
  pref = await _sharedPreference();
  pref.setBool(login, true);
}

Future saveLogout() async {
  pref = await _sharedPreference();
  pref.setBool(login, false);
}

Future<SharedPreferences> _sharedPreference() async {
  return SharedPreferences.getInstance();
}