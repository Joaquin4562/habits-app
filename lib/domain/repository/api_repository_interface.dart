import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/domain/request/requestSaveUserHabit.dart';
import 'package:habits_app/domain/request/requestSignIn.dart';
import 'package:habits_app/domain/request/requestSignUp.dart';
import 'package:habits_app/domain/response/response_signIn.dart';
import 'package:habits_app/domain/response/response_signup.dart';

abstract class ApiRepositoryInterface {
  Future<ResponseSignIn?> signIn(RequestSignIn requestSignIn);
  Future<ResponseSignUp?> signUp(RequestSignUp requestSignUp);
  Future<ResponseSignIn?> signUpWithGoogle();
  Future<String?> recoveryPassword();
  Future<void> signOut();
  Future<QuerySnapshot?> getPredeterminatedHabits();
  Future<String?> saveHabit(Habitos habito);
  Future<String?> saveUserHabit(RequestSaveUserHabit habito);
  Future<List<dynamic>> getUserHabits();
}
