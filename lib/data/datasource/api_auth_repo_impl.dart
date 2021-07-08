import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habits_app/data/datasource/local_repository_impl.dart';
import 'package:habits_app/domain/models/user.model.dart';
import 'package:habits_app/domain/repository/api_auth_repo.dart';
import 'package:habits_app/domain/response/response_signIn.dart';
import 'package:habits_app/domain/request/requestSignUp.dart';
import 'package:habits_app/domain/request/requestSignIn.dart';
import 'package:habits_app/domain/response/response_signup.dart';

class ApiAuthRepositoryImplement extends ApiAuthRepositoryInterface {
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
          constrasena: '',
          correo: userData['correo'],
          edad: userData['edad'],
          nombreCompeto: userData['nombre_completo'],
          sexo: userData['sexo'],
          racha: userData['racha'],
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'NADA';
      switch (e.code) {
        case 'wrong-password':
          message = 'Contraseña incorrecta';
          break;
        case 'too-many-requests':
          message = 'Demaciadas solicitudes';
          break;
        case 'user-not-found':
          message = 'Usuario no encontrado';
          break;
      }
      return ResponseSignIn(message: message, error: true);
    }
  }

  @override
  Future<void> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    await GoogleSignIn().signOut();
    await LocalRepositoryImpl().clearDataInformation();
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
        'racha': 0,
        'enRacha': false,
      });
      return ResponseSignUp(false, 'Usuario registrado');
    } on FirebaseAuthException catch (e) {
      String msg = 'Error no encontrado';
      switch (e.code) {
        case 'weak-password':
          msg = 'La contraseña es muy corta';
          break;
        case 'email-already-in-use':
          msg = 'El correo ya esta registrado';
          break;
      }
      return ResponseSignUp(true, msg);
    }
  }

  @override
  Future<ResponseSignIn> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final user = await FirebaseAuth.instance.signInWithCredential(credential);
      print(user);
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
            constrasena: '',
            correo: userData!['correo'],
            edad: userData['edad'],
            nombreCompeto: userData['nombre_completo'],
            sexo: userData['sexo'],
            racha: userData['racha'],
          ),
        );
      } else {
        final collection = FirebaseFirestore.instance.collection('usuarios');
        final usuario = user.additionalUserInfo!.profile;
        final userData = {
          'nombre_completo': usuario!['name'],
          'correo': usuario['email'],
          'edad': 'none',
          'sexo': 'none',
          'racha': 0,
          'enRacha': false,
        };
        await collection.doc(user.user!.uid).set(userData);
        return ResponseSignIn(
          error: false,
          message: 'Usuario logeado',
          usuario: Usuario(
            uid: '',
            constrasena: '',
            correo: usuario['email'],
            edad: 'none',
            nombreCompeto: usuario['name'],
            sexo: 'none',
            racha: 0,
          ),
        );
      }
    } catch (e) {
      return ResponseSignIn(message: 'el error es $e', error: true);
    }
  }

  @override
  Future<String?> recoveryPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'Se envio el correo correctamente, verificalo';
    } on FirebaseAuthException catch (e) {
      String msg = 'Ocurrio un error ${e.code}';
      switch (e.code) {
        case 'user-not-found':
          msg = 'Usuario no encontrado';
          break;
      }
      return msg;
    }
  }
}
