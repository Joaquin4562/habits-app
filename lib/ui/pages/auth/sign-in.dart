import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_auth_repo_impl.dart';
import 'package:habits_app/data/datasource/local_repository_impl.dart';
import 'package:habits_app/domain/request/requestSignIn.dart';
import 'package:habits_app/ui/widgets/btn-auth.dart';
import 'package:habits_app/ui/widgets/btn-google-sign-in.dart';
import 'package:habits_app/ui/widgets/custom-divider.dart';
import 'package:habits_app/ui/widgets/custom_input.dart';
import 'package:habits_app/ui/widgets/snackbar.dart';
import 'package:validators/validators.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    LocalRepositoryImpl().clearDataInformation();
    LocalRepositoryImpl().getToken().then((value) {
      if (value != null) {
        Navigator.pushReplacementNamed(context, 'home');
      }
    });

    super.initState();
  }

  final requestSignIn = RequestSignIn(password: '', email: '');
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final medida = (MediaQuery.of(context).size.width > 400);
    return Scaffold(
      backgroundColor: CustomColors.azul.dark,
      body: Form(
        key: _formKey,
        child: ListView(
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
              onPressed: () async {
                final response = await ApiAuthRepositoryImplement().signUpWithGoogle();
                if (response!.error) {
                  ScaffoldMessenger.of(context).showSnackBar(getSnackBar(response.message));
                } else {
                  final user =
                      await LocalRepositoryImpl().saveUser(response.usuario!);
                  LocalRepositoryImpl().saveToken(user!.uid);
                  Navigator.pushReplacementNamed(context, 'home');
                }
              },
            ),
            CustomDivider(),
            CustomInput(
              label: 'Correo electrónico',
              icono: Icons.mail,
              onSaved: (value) {
                requestSignIn.email = value!;
              },
              validator: (value) =>
                  isEmail(value!) ? null : 'Ingrese un correo valido',
            ),
            CustomInput(
              label: 'Contraseña',
              icono: Icons.lock,
              isPassword: true,
              onSaved: (value) {
                requestSignIn.password = value!;
              },
              validator: (value) =>
                  value!.isEmpty ? 'No dejes este campo vacio' : null,
            ),
            Hero(
              tag: 'button-auth',
              child: ButtonAuth(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final response =
                        await ApiAuthRepositoryImplement().signIn(requestSignIn);
                    if (!response!.error) {
                      final user = await LocalRepositoryImpl()
                          .saveUser(response.usuario!);
                      print(user!.uid);
                      LocalRepositoryImpl().saveToken(user.uid);
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(getSnackBar(response.message));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(getSnackBar('Rellene todos los campos'));
                  }
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
      ),
    );
  }
}
