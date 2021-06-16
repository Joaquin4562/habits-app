import 'package:flutter/material.dart';

class CircleNumberWidget extends StatelessWidget {
  const CircleNumberWidget({
    Key? key,
    required this.number,
    this.backgroundColor,
    this.borderColor,
    this.shadowColor1,
    this.shadowColor2,
    this.colorText,
  }) : super(key: key);
  final String number;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? shadowColor1;
  final Color? shadowColor2;
  final Color? colorText;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: borderColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: shadowColor1!.withOpacity(0.5),
                offset: Offset(5.0, 5.0),
                blurRadius: 7.0,
              ),
              BoxShadow(
                color: shadowColor2!.withOpacity(0.06),
                offset: Offset(-5.0, -5.0),
                blurRadius: 7.0,
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 95,
              height: 95,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorText,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
