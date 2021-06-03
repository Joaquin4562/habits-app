import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/local_repository_impl.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    LocalRepositoryImpl().getToken().then((value) {
      if (value != null) {
      Future.delayed(Duration(milliseconds: 1500)).then(
        (value) => Navigator.pushNamed(context, 'home'),
      );
    } else {
      Future.delayed(Duration(milliseconds: 1500)).then(
        (value) => Navigator.pushNamed(context, 'sign-in'),
      );
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.azul,
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/img/logo.png'),
            width: MediaQuery.of(context).size.width * 0.9,
          ),
          const SizedBox(height: 40),
          Container(
            width: 75,
            height: 75,
            child: CircularProgressIndicator(
            backgroundColor: CustomColors.azul,
            strokeWidth: 10,
            valueColor: AlwaysStoppedAnimation(CustomColors.lila),
          ),
          )
        ],
      ),
    ));
  }
}
