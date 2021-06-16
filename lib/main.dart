import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:habits_app/data/datasource/api_fcm_implements.dart';
import 'package:habits_app/data/services/localNotificationsService.dart';
import 'package:habits_app/ui/pages/auth/recovery.dart';
import 'package:habits_app/ui/pages/auth/sign-in.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habits_app/ui/pages/auth/sign-up.dart';
import 'package:habits_app/ui/pages/home/home.page.dart';
import 'package:habits_app/ui/pages/home/pages-tabs/home-tab-pages/select-habit.dart';
import 'package:habits_app/ui/pages/spashScreen.dart';
Future <void> _hadleMessage(RemoteMessage message) async {
  ApiFCMImplements().messagingBackgroundHandle(message);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print(' TOKEN IS ${await FirebaseMessaging.instance.getToken()}');
  FirebaseMessaging.onBackgroundMessage(_hadleMessage);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    LocalNotificationsService().showNotification(message);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('es', 'MX'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Habits app',
      initialRoute: 'splash',
      routes: {
        'sign-in': (_) => SignIn(),
        'sign-up': (_) => SignUp(),
        'splash': (_) => SplashScreen(),
        'recovery': (_) => RecoveryPage(),
        'home': (_) => HomePage(),
        'create-habit': (_) => CreateHabitPage(),
        'habit-p': (_) => CreateHabitPage(),
      },
    );
  }
}
