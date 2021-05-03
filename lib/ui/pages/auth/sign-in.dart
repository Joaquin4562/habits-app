import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_repository_impl.dart';
import 'package:habits_app/domain/request/requestSignIn.dart';
import 'package:habits_app/ui/widgets/btn-auth.dart';
import 'package:habits_app/ui/widgets/btn-google-sign-in.dart';
import 'package:habits_app/ui/widgets/custom-divider.dart';
import 'package:habits_app/ui/widgets/custom_input.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final medida = (MediaQuery.of(context).size.width > 400);
    return Scaffold(
      backgroundColor: CustomColors.azul.dark,
      body: ListView(
        physics: BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Hero(
              tag: 'logo',
              child: Image(
                width: medida ? 450 : 350,
                image: AssetImage('assets/img/logo.png'),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Iniciar sesión',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: CustomColors.blanco,
              fontSize: 45,
            ),
          ),
          ButtonGoogleSignIn(
            onPressed: () {
              ApiRepositoryImpl().signIn(
                RequestSignIn(
                    password: '121212121', email: 'joaquin@gmail.com'),
              );
            },
          ),
          CustomDivider(),
          CustomInput(
            label: 'Correo electrónico',
            icono: Icons.mail,
          ),
          CustomInput(
            label: 'Contraseña',
            icono: Icons.lock,
            isPassword: true,
          ),
          Hero(
            tag: 'button-auth',
            child: ButtonAuth(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('home');
                // signInWithCredentials('pedro@gmail.com', 'joaquin333');
              },
              label: 'Iniciar',
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'recovery');
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Text(
              '¿Olvidaste tu contraseña?',
              style: TextStyle(
                  color: CustomColors.blanco,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10.0, left: 17.0, bottom: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿No tienes cuenta?',
                    style: TextStyle(
                      color: CustomColors.blanco,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('sign-up');
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Text(
                      'Registrate',
                      style: TextStyle(
                        color: CustomColors.blanco,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
