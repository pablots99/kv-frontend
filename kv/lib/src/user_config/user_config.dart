import 'package:shared_preferences/shared_preferences.dart';

class UserConfig {
  static final UserConfig _instancia = new UserConfig._internal();

  factory UserConfig() {
    return _instancia;
  }

  UserConfig._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('last_page') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('last_page', value);
  }
}
