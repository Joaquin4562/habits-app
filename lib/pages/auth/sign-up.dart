import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/global_widgets/custom_input.dart';
import 'package:habits_app/pages/auth/services/sign-up.service.dart';
import 'package:habits_app/pages/auth/services/user.model.dart';
import 'package:habits_app/pages/auth/widgets/btn-auth.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.azul.dark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('assets/img/logo.png'),
                    height: 70,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Registro',
              style: TextStyle(
                color: CustomColors.blanco,
                fontSize: 35,
              ),
            ),
            CustomInput(
              label: 'Correo electrónico',
              icono: Icons.mail,
            ),
            CustomInput(
              label: 'Contraseña',
              icono: Icons.lock,
              isPassword: true,
            ),
            CustomInput(
              label: 'Nombre completo',
              icono: Icons.person,
            ),
            CustomInput(
              label: 'Edad',
              icono: Icons.person_add_alt_1,
            ),
            CustomInput(
              label: 'Sexo',
              icono: Icons.person_add_alt_1,
            ),
            Hero(
              tag: 'button-auth',
              child: ButtonAuth(
                onPressed: () {
                  signUpWithApp(
                    Usuario(
                      constrasena: 'joaquin333',
                      correo: 'pedro@gmail.com',
                      edad: '10',
                      nombreCompeto: 'gerardo joaquin',
                      sexo: 'masculino',
                    ),
                  );
                },
                label: 'Registrarse',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
