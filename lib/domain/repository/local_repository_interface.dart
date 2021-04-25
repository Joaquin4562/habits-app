import 'package:habits_app/domain/models/user.model.dart';

abstract class LocalRepositoryInterface {
  Future<String?> getToken();
  Future<void> clearDataInformation();
  Future<Usuario?> saveUser(Usuario usuario);
  Future<Usuario?> getUser();
  Future<String?> saveToken(String token);
}