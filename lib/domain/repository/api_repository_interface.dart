import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/domain/models/user.model.dart';
import 'package:habits_app/domain/request/requestSignIn.dart';
import 'package:habits_app/domain/request/requestSignUp.dart';
import 'package:habits_app/domain/response/response_signIn.dart';

abstract class ApiRepositoryInterface {
  Future<ResponseSignIn?> signIn(RequestSignIn requestSignIn);
  Future<String?> signUp(RequestSignUp requestSignUp);
  Future<String?> signUpWithGoogle();
  Future<String?> recoveryPassword();
  Future<void> signOut();
  Future<QuerySnapshot?> getPredeterminatedHabits();
  Future<String?> saveHabit(Habitos habito);
}
