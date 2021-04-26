import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';

class DayButton extends StatefulWidget {
  DayButton({
    Key? key,
    required this.label,
    this.active = false,
  }) : super(key: key);
  final String label;
  final bool active;
  @override
  _DayButtonState createState() => _DayButtonState();
}

class _DayButtonState extends State<DayButton> {
  @override
  Widget build(BuildContext context) {
    final medida = (MediaQuery.of(context).size.width < 400);
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Container(
        width: medida ? 35 : 40,
        height: medida ? 35 : 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.active ? CustomColors.cea : CustomColors.azul.dark,
          border: widget.active
              ? null
              : Border.all(
                  color: CustomColors.blanco,
                  width: 1,
                ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: TextStyle(
              color: CustomColors.blanco,
              fontWeight: FontWeight.bold,
              fontSize: medida ? 17 : 20,
            ),
          ),
        ),
      ),
    );
  }
}
