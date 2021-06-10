import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/domain/models/habits.model.dart';

class TodoItemWidget extends StatelessWidget {
  const TodoItemWidget({Key? key, required this.item}) : super(key: key);
  final Habitos item;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 85,
          child: Text(
            item.hora,
            style: TextStyle(
              color: CustomColors.blanco,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: item.isFinished
                  ? CustomColors.nature
                  : CustomColors.redAccion,
            ),
            width: 10,
            height: 10,
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.blanco,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.nombre,
                                style: TextStyle(
                                  color: CustomColors.azul,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                item.categoria,
                                style: TextStyle(
                                  color:
                                      CustomColors.azul.light!.withOpacity(0.7),
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          item.isFinished ? Icons.done : Icons.clear,
                          color: item.isFinished
                              ? CustomColors.nature
                              : CustomColors.redAccion,
                          size: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                right: 60,
                child: Image(
                  image: AssetImage('assets/img/alimentacion.png'),
                  width: 60,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
