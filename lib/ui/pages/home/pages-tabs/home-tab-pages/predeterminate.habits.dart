import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_habit_repo_impl.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/domain/request/requestSaveUserHabit.dart';
import 'package:habits_app/ui/pages/home/pages-tabs/home-tab-pages/habitInfoPage.dart';
import 'package:habits_app/ui/widgets/boucing.dart';
import 'package:habits_app/ui/widgets/dialogCreateHabit.dart';
import 'package:habits_app/ui/widgets/habitsHomeButton.dart';
import 'package:habits_app/ui/widgets/snackbar.dart';
import 'package:habits_app/ui/widgets/utils/createRoute.dart';

class PredeterminatedHabits extends StatelessWidget {
  const PredeterminatedHabits({
    Key? key,
    required this.title,
    required this.color,
    required this.habitos,
  }) : super(key: key);
  final String title;
  final Color color;
  final List habitos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.azul.dark,
        title: Text(
          title,
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
              color,
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
                    bottom: 0,
                    right: 0,
                    child: Hero(
                      tag: 'edificio',
                      child: Image(
                        width: 120,
                        image: AssetImage('assets/img/edificio.png'),
                      ),
                    ),
                  ),
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
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ListView.builder(
                  itemCount: habitos.length,
                  itemBuilder: (context, index) {
                    final habito = habitos[index];
                    return BoucingWidget(
                      boucingScale: 0.2,
                      child: HabitsHomeButton(
                        imagen: 'assets/img/new.png',
                        colorText: CustomColors.blanco,
                        hourColor: Colors.deepOrangeAccent[200],
                        colorButton: color.withOpacity(0.9),
                        label: habito['nombre'],
                        time: habito['hora'],
                        category: title,
                      ),
                      onPress: () {
                        showGeneralDialog(
                          context: context,
                          pageBuilder: (
                            context,
                            anim1,
                            anim2,
                          ) {
                            return Text('');
                          },
                          transitionBuilder: (context, anm1, anm2, child) {
                            return Transform.scale(
                              scale: anm1.value,
                              child: DialogCreateHabit(
                                name: habito['nombre'],
                                category: title,
                                dayList: habito['dias'],
                                hour: habito['hora'],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
