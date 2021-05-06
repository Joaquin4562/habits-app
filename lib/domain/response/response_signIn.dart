import 'package:habits_app/domain/models/user.model.dart';

class ResponseSignIn {
  ResponseSignIn({
    this.usuario,
    required this.message,
    required this.error,
  });
  Usuario? usuario;
  String message;
  bool error;
}
