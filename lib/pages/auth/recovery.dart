import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/global_widgets/custom_input.dart';
import 'package:habits_app/pages/auth/widgets/btn-auth.dart';

class RecoveryPage extends StatelessWidget {
  const RecoveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.azul.dark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                    height: 200,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Recuperar',
              style: TextStyle(
                color: CustomColors.blanco,
                fontSize: 35,
              ),
            ),
            CustomInput(
              label: 'Correo electrónico',
              icono: Icons.mail,
            ),
            Hero(
              tag: 'button-auth',
              child: ButtonAuth(
                onPressed: () {},
                label: 'Recuperar contraseña',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
