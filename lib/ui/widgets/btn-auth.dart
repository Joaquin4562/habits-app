import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';

class ButtonAuth extends StatefulWidget {
  const ButtonAuth({
    Key? key,
    required this.onPressed,
    required this.label,
    this.waiting = false,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String label;
  final bool waiting;
  @override
  _ButtonAuthState createState() => _ButtonAuthState();
}

class _ButtonAuthState extends State<ButtonAuth> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
      child: Container(
        width: size.width,
        child: RawMaterialButton(
          splashColor: CustomColors.amarillo,
          fillColor: CustomColors.azul.light,
          onPressed: widget.waiting ? null : widget.onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: widget.waiting
                ? CircularProgressIndicator(
                  color: CustomColors.blanco,
                )
                : Text(
                    widget.label,
                    style: TextStyle(
                      color: CustomColors.blanco,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
