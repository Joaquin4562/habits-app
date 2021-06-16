import 'package:flutter/material.dart';

class CustomBtnHabits extends StatefulWidget {
  const CustomBtnHabits({
    Key? key,
    required this.icono,
    required this.imagen,
    required this.label,
    this.pLeft = 30.0,
    this.pRight = 30.0,
    this.pBottom = 15.0,
    this.pTop = 15.0,
    this.colorText,
    this.colorIcon,
    this.colorButton,
  }) : super(key: key);
  final String label;
  final double pLeft;
  final double pRight;
  final double pTop;
  final double pBottom;
  final IconData icono;
  final String imagen;
  final Color? colorIcon;
  final Color? colorText;
  final Color? colorButton;
  @override
  _CustomBtnHabitsState createState() => _CustomBtnHabitsState();
}

class _CustomBtnHabitsState extends State<CustomBtnHabits> {
  @override
  Widget build(BuildContext context) {
    final medida = (MediaQuery.of(context).size.width > 400);
    return Padding(
      padding: EdgeInsets.only(
        left: widget.pLeft,
        right: widget.pRight,
        top: widget.pTop,
        bottom: widget.pBottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: widget.colorButton,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 10,
            bottom: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: medida ? 24 : 20,
                      fontWeight: FontWeight.bold,
                      color: widget.colorText,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    alignment: Alignment.bottomRight,
                    width: medida ? 70 : 50,
                    height: medida ? 70 : 50,
                    image: AssetImage(widget.imagen),
                  ),
                  const SizedBox(width: 20),
                  Icon(
                    widget.icono,
                    color: widget.colorIcon,
                    size: medida ? 40: 30,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
