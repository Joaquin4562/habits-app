import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_habit_repo_impl.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/domain/request/requestSaveUserHabit.dart';
import 'package:habits_app/ui/widgets/boucing.dart';
import 'package:habits_app/ui/widgets/day_button.dart';
import 'package:habits_app/ui/widgets/habitsHomeButton.dart';
import 'package:habits_app/ui/widgets/snackbar.dart';

class HabitInfoPage extends StatelessWidget {
  const HabitInfoPage({Key? key, required this.habit}) : super(key: key);
  final Habitos habit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.azul.dark,
        title: Text(
          'Habito',
          style: TextStyle(
            color: CustomColors.blanco,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CustomColors.azul.dark!,
              CustomColors.azul.dark!,
              CustomColors.blanco,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: CustomColors.azul.dark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.blanco.withOpacity(0.4),
                            offset: Offset(0, 0),
                            blurRadius: 100,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: Hero(
                        tag: 'moon',
                        child: Transform.rotate(
                          angle: 16,
                          child: Image(
                            width: 40,
                            image: AssetImage('assets/img/moon.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: MediaQuery.of(context).size.width * 0.1,
                    child: Text(
                      habit.nombre!,
                      style: TextStyle(
                        color: CustomColors.lila,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Dias',
                        style: TextStyle(
                          fontSize: 30,
                          color: CustomColors.blanco,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DayButton(label: 'Lu', active: true,),
                          DayButton(label: 'Ma'),
                          DayButton(label: 'Mi'),
                          DayButton(label: 'Ju'),
                          DayButton(label: 'Vi'),
                          DayButton(label: 'Sa'),
                          DayButton(label: 'Do'),
                        ],
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
