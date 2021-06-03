
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits_app/data/datasource/local_repository_impl.dart';
import 'package:habits_app/domain/models/event.model.dart';
import 'package:habits_app/domain/repository/api_habit_repo.dart';
import 'package:habits_app/domain/request/requestSaveUserHabit.dart';

class ApiHabitRepositoryImplement extends ApiHabitRepositoryInterface {
  @override
  Future<QuerySnapshot?> getPredeterminatedHabits() async {
    QuerySnapshot snapshot;
    CollectionReference habitsCollection =
        FirebaseFirestore.instance.collection('habitos');
    snapshot = await habitsCollection.get();
    return snapshot;
  }

  // this metod add a preteterminate habit to firebase
  @override
  Future<String?> saveHabit(RequestSaveUserHabit habito) async {
    try {
      final res =
          await ApiHabitRepositoryImplement().getPredeterminatedHabits();
      CollectionReference habitCollection =
          FirebaseFirestore.instance.collection('habitos');
      final uid =
          res!.docs.firstWhere((e) => e.data()['nombre'] == habito.category);
      final userRef = habitCollection.doc(uid.id);
      userRef.update({
        'habitos-predeterminados': FieldValue.arrayUnion([
          {
            'nombre': habito.name,
            'dias': habito.days,
            'hora': habito.hour,
            'categoria': habito.category,
          }
        ]),
      });
      return 'Se inserto';
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String?> saveUserHabit(RequestSaveUserHabit habito) async {
    try {
      CollectionReference userCollection =
          FirebaseFirestore.instance.collection('usuarios');
      final uid = await LocalRepositoryImpl().getToken();
      final userRef = userCollection.doc(uid);
      userRef.update({
        'habitos': FieldValue.arrayUnion([
          {
            'nombre': habito.name,
            'categoria': habito.category,
            'dias': habito.days,
            'hora': habito.hour,
            'finalizada': false,
          }
        ]),
      });
      return 'Se inserto';
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<dynamic>> getUserHabits() async {
    final collection = FirebaseFirestore.instance.collection('usuarios');
    final uid = await LocalRepositoryImpl().getToken();
    final userDoc = await collection.doc(uid).get();
    return userDoc.data()!['habitos'];
  }

  @override
  Future<List<dynamic>> getToDoListHabits(int today) async {
    final uid = await LocalRepositoryImpl().getToken();
    final userDocument =
        await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
    List lista = [];
    final List habitList = userDocument.data()!['habitos'];
    habitList.forEach((element) {
      final List listOfDays = element['dias'];
      listOfDays.asMap().forEach((index, value) {
        if (value) {
          if (index == today) {
            lista.add(element);
          }
        }
      });
    });
    return lista;
  }
}
