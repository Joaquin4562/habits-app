import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

signInWithCredentials(String email, String pass) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final collection = FirebaseFirestore.instance.collection('usuarios');
  await auth
      .signInWithEmailAndPassword(email: email, password: pass)
      .then((value) {
    final docReference = collection.doc(value.user!.uid);
    docReference.get().then((value) => print(value.data()));
  }).catchError((error) {
    print(error);
  });
}
