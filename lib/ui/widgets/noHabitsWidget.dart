import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';

class NoHabitsWidget extends StatelessWidget {
  const NoHabitsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'No hay habitos',
            style: TextStyle(
              color: CustomColors.blanco,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Image(
            image: AssetImage('assets/img/fisico.png'),
            width: 200,
            color: CustomColors.lila,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Añade uno',
                style: TextStyle(
                  color: CustomColors.blanco,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(width: 20),
              Icon(
                Icons.arrow_downward_rounded,
                size: 50,
                color: CustomColors.blanco,
              )
            ],
          )
        ],
      ),
    );
  }
}
