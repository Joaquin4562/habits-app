import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/pages/auth/recovery.dart';
import 'package:habits_app/pages/auth/sign-in.dart';
import 'package:habits_app/pages/auth/sign-up.dart';
import 'package:habits_app/pages/home/home.page.dart';

import 'pages/home/pages-tabs/home-tab-pages/select-habit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'sign-in',
      routes: {
        'sign-in': (_) => SignIn(),
        'sign-up': (_) => SignUp(),
        'recovery': (_) => RecoveryPage(),
        'home': (_) => HomePage(),
        'create-habit': (_) => CreateHabitPage(),
      },
    );
  }
}
