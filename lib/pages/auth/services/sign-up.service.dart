import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habits_app/pages/auth/services/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future signUpWithApp(Usuario usuario) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('usuarios');
  await auth
      .createUserWithEmailAndPassword(
          email: usuario.correo, password: usuario.constrasena)
      .then((value) {
    userCollection.doc(value.user!.uid).set({
      'nombre_completo': usuario.nombreCompeto,
      'edad': usuario.edad,
      'correo': usuario.correo,
      'sexo': usuario.sexo,
    }).catchError((error) {
      return error;
    });
    return 'Usuario registrado';
  }).catchError((error) {
    return error;
  });
}

signUpWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final user = await FirebaseAuth.instance.signInWithCredential(credential);
  final docReference = FirebaseFirestore.instance.collection('usuarios').doc(user.user!.uid);
  docReference.get().then((value) {
    if (value.exists) {
      return user;
    } else {
      addNewUserToFirestore(user);
    }
  }).catchError((error) {
    print(error);
  });
}

void addNewUserToFirestore(UserCredential user) {
  final collection = FirebaseFirestore.instance.collection('usuarios');
  final usuario = user.additionalUserInfo!.profile;
  collection.doc(user.user!.uid).set({
    'nombre_completo': usuario!['name'],
    'correo': usuario['email'],
    'edad': '',
    'sexo': '',
  }).catchError((error) {
    print(error);
  });
}