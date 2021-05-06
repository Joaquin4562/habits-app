import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/domain/models/user.model.dart';
import 'package:habits_app/domain/repository/api_repository_interface.dart';
import 'package:habits_app/domain/response/response_signIn.dart';
import 'package:habits_app/domain/request/requestSignUp.dart';
import 'package:habits_app/domain/request/requestSignIn.dart';
import 'package:habits_app/domain/response/response_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface {
  @override
  Future<ResponseSignIn?> signIn(RequestSignIn requestSignIn) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final collection = FirebaseFirestore.instance.collection('usuarios');
    try {
      final userCredencials = await auth.signInWithEmailAndPassword(
        email: requestSignIn.email,
        password: requestSignIn.password,
      );
      final docReference = collection.doc(userCredencials.user!.uid);
      final documentSnapshot = await docReference.get();
      final userData = documentSnapshot.data();
      return ResponseSignIn(
        message: 'Usuario ${userData!['nombre_completo']} Logeado',
        error: false,
        usuario: Usuario(
          uid: userCredencials.user!.uid,
          constrasena: userData['contrasena'],
          correo: userData['correo'],
          edad: userData['edad'],
          nombreCompeto: userData['nombre_completo'],
          sexo: userData['sexo'],
        ),
      );
    } on FirebaseAuthException catch (e) {
      return ResponseSignIn(message: e.code, error: true);
    }
  }

  @override
  Future<void> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
  }

  @override
  Future<ResponseSignUp?> signUp(RequestSignUp requestSignUp) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('usuarios');
    try {
      final userCredencials = await auth.createUserWithEmailAndPassword(
          email: requestSignUp.correo, password: requestSignUp.contrasena);
      userCollection.doc(userCredencials.user!.uid).set({
        'nombre_completo': requestSignUp.nombre,
        'edad': requestSignUp.edad,
        'correo': requestSignUp.correo,
        'sexo': requestSignUp.sexo,
      });
      return ResponseSignUp(false, 'Usuario registrado');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return ResponseSignUp(true, 'El correo ya esta registrado');
      } else {
        return ResponseSignUp(true, 'Error al registrar');
      }
    }
  }

  @override
  Future<ResponseSignIn?> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      final docReference =
          FirebaseFirestore.instance.collection('usuarios').doc(user.user!.uid);
      final documentSnapshot = await docReference.get();
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data();
        final userData = data;
        return ResponseSignIn(
          message: 'Usuario logeado',
          error: false,
          usuario: Usuario(
            uid: user.user!.uid,
            constrasena: userData!['contrasena'],
            correo: userData['correo'],
            edad: userData['edad'],
            nombreCompeto: userData['nombre_completo'],
            sexo: userData['sexo'],
          ),
        );
      } else {
        final collection = FirebaseFirestore.instance.collection('usuarios');
        final usuario = user.additionalUserInfo!.profile;
        final userData = {
          'nombre_completo': usuario!['name'],
          'correo': usuario['email'],
          'edad': '',
          'sexo': '',
        };
        collection.doc(user.user!.uid).set(userData).then((value) {
          return ResponseSignIn(error: false, message: 'Usuario logeado');
        });
      }
    } catch (e) {
      return ResponseSignIn(message: e.toString(), error: false);
    }
  }

  @override
  Future<String?> recoveryPassword() {
    // TODO: Recovery password implementation
    throw UnimplementedError();
  }

  @override
  Future<QuerySnapshot?> getPredeterminatedHabits() async {
    QuerySnapshot snapshot;
    CollectionReference habitsCollection =
        FirebaseFirestore.instance.collection('habitos');
    snapshot = await habitsCollection.get();
    return snapshot;
  }

  @override
  Future<String?> saveHabit(Habitos habito) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // TODO: save habit in the firestore with reference to User
  }
}
