import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits_app/domain/request/requestSaveUserHabit.dart';

abstract class ApiHabitRepositoryInterface {
  Future<QuerySnapshot?> getPredeterminatedHabits();
  Future<String?> saveHabit(RequestSaveUserHabit habito);
  Future<String?> saveUserHabit(RequestSaveUserHabit habito);
  Future<List<dynamic>> getUserHabits();
  Future<List<dynamic>> getToDoListHabits(int today);
  Future<void> updateHabitUser(String nameHabit);
}
