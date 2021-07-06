import 'package:habits_app/domain/models/user.model.dart';
import 'package:habits_app/domain/repository/local_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepositoryImpl extends LocalRepositoryInterface {
  static const _preferences_token = 'TOKEN';
  static const _preferences_correo = 'MAIL';
  static const _preferences_edad = 'ADGE';
  static const _preferences_sexo = 'SEXO';
  static const _preferences_nombre = 'NAME';
  static const _preferences_rahca = 'RACHA';
  static const _preferences_UID = 'UID';

  @override
  Future<void> clearDataInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_preferences_UID);
  }

  @override
  Future<Usuario?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return Usuario(
      uid: sharedPreferences.getString(_preferences_UID)!,
      edad: sharedPreferences.getString(_preferences_edad)!,
      sexo: sharedPreferences.getString(_preferences_sexo)!,
      correo: sharedPreferences.getString(_preferences_correo)!,
      nombreCompeto: sharedPreferences.getString(_preferences_nombre)!,
      constrasena: '',
      racha: sharedPreferences.getInt(_preferences_rahca)!,
    );
  }

  @override
  Future<Usuario?> saveUser(Usuario usuario) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_preferences_UID, usuario.uid);
    sharedPreferences.setString(_preferences_nombre, usuario.nombreCompeto);
    sharedPreferences.setString(_preferences_edad, usuario.edad);
    sharedPreferences.setString(_preferences_sexo, usuario.sexo);
    sharedPreferences.setString(_preferences_correo, usuario.correo);
    sharedPreferences.setInt(_preferences_rahca, usuario.racha);
    return usuario;
  }

  @override
  Future<String?> saveToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_preferences_token, token);
    return token;
  }
}
