import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';

class HabitsHomeButton extends StatefulWidget {
  const HabitsHomeButton({
    Key? key,
    this.imagen = 'assets/img/habit.png',
    required this.label,
    this.pLeft = 30.0,
    this.pRight = 30.0,
    this.pBottom = 15.0,
    this.pTop = 15.0,
    this.colorText,
    this.colorButton = CustomColors.lila,
    this.category,
    this.time,
    this.hourColor = CustomColors.lila,
  }) : super(key: key);
  final String label;
  final double pLeft;
  final double pRight;
  final double pTop;
  final double pBottom;
  final String imagen;
  final String? time;
  final String? category;
  final Color? colorText;
  final Color? colorButton;
  final Color? hourColor;
  @override
  _HabitsHomeButtonState createState() => _HabitsHomeButtonState();
}

class _HabitsHomeButtonState extends State<HabitsHomeButton> {
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
        child: Stack(
          children: [
            Padding(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.label,
                            style: TextStyle(
                              fontSize: medida ? 24 : 20,
                              fontWeight: FontWeight.bold,
                              color: widget.colorText,
                            ),
                          ),
                          Text(
                            widget.category!,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              color: widget.colorText,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  widget.hourColor!,
                                  widget.hourColor!,
                                  widget.hourColor!.withAlpha(200),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                widget.time!,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: widget.colorText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: medida ? 50 : 40,
                            width: medida ? 50 : 40,
                            decoration: BoxDecoration(
                              color: CustomColors.azul,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      CustomColors.azul.dark!.withOpacity(0.5),
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 7.0,
                                ),
                                BoxShadow(
                                  color: CustomColors.blanco.withOpacity(0.06),
                                  offset: Offset(-5.0, -5.0),
                                  blurRadius: 7.0,
                                ),
                              ],
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: CustomColors.blanco,
                                size: medida ? 40 : 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -21,
              right: medida ? 80 : 50,
              child: Image(
                width: medida ? 110 : 60,
                image: AssetImage(widget.imagen),
              ),
            )
          ],
        ),
      ),
    );
  }
}
