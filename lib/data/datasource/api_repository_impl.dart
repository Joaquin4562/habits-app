import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habits_app/domain/repository/api_repository_interface.dart';
import 'package:habits_app/domain/response/response_signIn.dart';
import 'package:habits_app/domain/request/requestSignUp.dart';
import 'package:habits_app/domain/request/requestSignIn.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface {
  @override
  Future<ResponseSignIn?> signIn(RequestSignIn requestSignIn) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final collection = FirebaseFirestore.instance.collection('usuarios');
    await auth
        .signInWithEmailAndPassword(
            email: requestSignIn.email, password: requestSignIn.password)
        .then((value) {
      final docReference = collection.doc(value.user!.uid);
      docReference.get().then((value) {
        print(value.data());
        // return response data
        return ResponseSignIn(correo: '', edad: '', nombre: '', sexo: '');
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Future<void> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
  }

  @override
  Future<String?> signUp(RequestSignUp requestSignUp) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('usuarios');
    await auth
        .createUserWithEmailAndPassword(
            email: requestSignUp.correo, password: requestSignUp.contrasena)
        .then((value) {
      userCollection.doc(value.user!.uid).set({
        'nombre_completo': requestSignUp.nombre,
        'edad': requestSignUp.edad,
        'correo': requestSignUp.correo,
        'sexo': requestSignUp.sexo,
      }).catchError((error) {
        return error;
      });
      return 'Usuario registrado';
    }).catchError((error) {
      return error;
    });
  }

  @override
  Future<String?> signUpWithGoogle() async {
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
    docReference.get().then((value) {
      if (value.exists) {
        return user;
      } else {
        final collection = FirebaseFirestore.instance.collection('usuarios');
        final usuario = user.additionalUserInfo!.profile;
        collection.doc(user.user!.uid).set({
          'nombre_completo': usuario!['name'],
          'correo': usuario['email'],
          'edad': '',
          'sexo': '',
        }).then((value) {
          // return user information
        }).catchError((error) {
          print(error);
        });
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Future<String?> recoveryPassword() {
    // TODO: implement recoveryPassword
    throw UnimplementedError();
  }
}
