import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_auth_repo_impl.dart';
import 'package:habits_app/domain/request/requestSignUp.dart';
import 'package:habits_app/ui/widgets/btn-auth.dart';
import 'package:habits_app/ui/widgets/custom_input.dart';
import 'package:habits_app/ui/widgets/snackbar.dart';
import 'package:validators/validators.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final requestSignUp = RequestSignUp(
      contrasena: '',
      correo: '',
      edad: '',
      nombre: '',
      sexo: '',
    );
    return Scaffold(
      backgroundColor: CustomColors.azul.dark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
              textAlign: TextAlign.center,
              style: TextStyle(
                color: CustomColors.blanco,
                fontSize: 45,
              ),
            ),
            CustomInput(
              label: 'Correo electrónico',
              icono: Icons.mail,
              onSaved: (value) {
                requestSignUp.correo = value!;
              },
              validator: (value) =>
                  isEmail(value!) ? null : 'Ingrese un correo valido',
            ),
            CustomInput(
              label: 'Contraseña',
              icono: Icons.lock,
              isPassword: true,
              onSaved: (value) {
                requestSignUp.contrasena = value!;
              },
              validator: (value) =>
                  value!.isEmpty ? 'No dejes el campo vacio' : null,
            ),
            CustomInput(
              label: 'Nombre completo',
              icono: Icons.person,
              onSaved: (value) {
                requestSignUp.nombre = value!;
              },
              validator: (value) =>
                  value!.isEmpty ? 'No dejes el campo vacio' : null,
            ),
            CustomInput(
              label: 'Edad',
              icono: Icons.person_add_alt_1,
              onSaved: (value) {
                requestSignUp.edad = value!.toString();
              },
              validator: (value) => (value!.isEmpty || !isNumeric(value))
                  ? 'Ingresa un valor valido (numerico)'
                  : null,
            ),
            CustomInput(
              label: 'Sexo',
              icono: Icons.person_add_alt_1,
              onSaved: (value) {
                requestSignUp.sexo = value!;
              },
              validator: (value) =>
                  value!.isEmpty ? 'No dejes el campo vacio' : null,
            ),
            Hero(
              tag: 'button-auth',
              child: ButtonAuth(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final response = await ApiAuthRepositoryImplement().signUp(requestSignUp);
                    if (!response!.error) {
                      Navigator.of(context).pushReplacementNamed('sign-in');
                    }
                    ScaffoldMessenger.of(context).showSnackBar(getSnackBar(response.message));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(getSnackBar('Ingresa los datos'));
                  }
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
