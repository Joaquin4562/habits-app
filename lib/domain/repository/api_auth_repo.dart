import 'package:habits_app/domain/request/requestSignIn.dart';
import 'package:habits_app/domain/request/requestSignUp.dart';
import 'package:habits_app/domain/response/response_signIn.dart';
import 'package:habits_app/domain/response/response_signup.dart';

abstract class ApiAuthRepositoryInterface {
  Future<ResponseSignIn?> signIn(RequestSignIn requestSignIn);
  Future<ResponseSignUp?> signUp(RequestSignUp requestSignUp);
  Future<ResponseSignIn> signUpWithGoogle();
  Future<String?> recoveryPassword(String email);
  Future<void> signOut();
}
