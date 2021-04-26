import 'package:habits_app/domain/request/requestSignIn.dart';
import 'package:habits_app/domain/request/requestSignUp.dart';
import 'package:habits_app/domain/response/response_signIn.dart';

abstract class ApiRepositoryInterface {
  Future<ResponseSignIn?> signIn (RequestSignIn requestSignIn); 
  Future<String?> signUp (RequestSignUp requestSignUp); 
  Future<String?> signUpWithGoogle (); 
  Future<String?> recoveryPassword (); 
  Future<void> signOut (); 
}