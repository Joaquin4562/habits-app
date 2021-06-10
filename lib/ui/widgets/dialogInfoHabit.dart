import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/ui/widgets/boucing.dart';
import 'package:habits_app/ui/widgets/day_button.dart';

class DialogInfoHabit extends StatelessWidget {
  const DialogInfoHabit({Key? key, required this.habit}) : super(key: key);
  final Habitos habit;
  @override
  Widget build(BuildContext context) {
    final daysWeek = [
      'D',
      'L',
      'M',
      'M',
      'J',
      'V',
      'S',
    ];
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: CustomColors.blanco,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(
              scale: 3,
              image: AssetImage('assets/img/estilo.png'),
              alignment: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                habit.nombre,
                style: TextStyle(
                  color: CustomColors.azul,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColors.azul,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      habit.categoria,
                      style: TextStyle(
                        color: CustomColors.blanco,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    habit.hora,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  children: List.generate(
                    7,
                    (index) => DayButton(
                      label: daysWeek[index],
                      active: habit.dias[index],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              BoucingWidget(
                onPress: () {
                  Navigator.pop(context);
                },
                boucingScale: 0.8,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColors.azul,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 10.0, bottom: 10.0),
                    child: Center(
                      child: Text(
                        'Cerrar',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
