import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_auth_repo_impl.dart';
import 'package:habits_app/ui/widgets/btn-auth.dart';
import 'package:habits_app/ui/widgets/custom_input.dart';
import 'package:habits_app/ui/widgets/snackbar.dart';
import 'package:validators/validators.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({Key? key}) : super(key: key);

  @override
  _RecoveryPageState createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  bool _disabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.azul.dark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                validator: (value) =>
                    isEmail(value!) ? null : 'Ingresa un correo valido',
                onSaved: (value) => this.setState(() => email = value!),
              ),
              Hero(
                tag: 'button-auth',
                child: ButtonAuth(
                  waiting: _disabled,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      this.setState(() => _disabled = true);
                      final resp = await ApiAuthRepositoryImplement()
                          .recoveryPassword(email);
                      this.setState(() => _disabled = false);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(getSnackBar(resp!));
                    }
                  },
                  label: 'Recuperar contraseña',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
