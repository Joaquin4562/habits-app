import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.label,
    this.icono,
    this.isPassword,
    this.onSaved,
    this.validator,
  }) : super(key: key);
  final String label;
  final IconData? icono;
  final Function(String?)? onSaved;
  final FormFieldValidator<String>? validator;
  final bool? isPassword;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
            child: Text(
              label,
              style: TextStyle(
                color: CustomColors.blanco,
                fontSize: 20,
              ),
            ),
          ),
          TextFormField(
            validator: validator,
            onSaved: (value) {
              onSaved!(value);
            },
            cursorColor: CustomColors.blanco,
            style: TextStyle(
              color: CustomColors.blanco,
              fontSize: 20,
            ),
            obscureText: (isPassword == true) ? true : false,
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.red.shade300,
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
              ),
              suffixIcon: Icon(
                icono,
                color: CustomColors.blanco,
              ),
              contentPadding: EdgeInsets.all(20),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: CustomColors.blanco,
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: CustomColors.blanco,
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
              ),
              errorStyle: TextStyle(
                color: Colors.red.shade300,
                fontSize: 18,
              )
            ),
          )
        ],
      ),
    );
  }
}
