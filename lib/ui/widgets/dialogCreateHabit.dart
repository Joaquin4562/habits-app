import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/ui/widgets/boucing.dart';
import 'package:habits_app/ui/widgets/customDropDown.dart';
import 'package:habits_app/ui/widgets/custom_input.dart';
import 'package:habits_app/ui/widgets/day_button.dart';

class DialogCreateHabit extends StatefulWidget {
  DialogCreateHabit({Key? key}) : super(key: key);

  @override
  _DialogCreateHabitState createState() => _DialogCreateHabitState();
}

class _DialogCreateHabitState extends State<DialogCreateHabit> {
  TimeOfDay time = TimeOfDay.now();
  final daysWeek = [
    'D',
    'L',
    'M',
    'M',
    'J',
    'V',
    'S',
  ];
  final activeDays = [
    true,
    false,
    false,
    true,
    false,
    true,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    final medida = MediaQuery.of(context).size.width < 400;
    final list = [
      'Salud mental',
      'Estulo de vida',
      'Alimentación',
      'Cambio fisico',
      'Hogar'
    ];
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: CustomColors.azul.dark,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListBody(
              children: [
                Text(
                  'Crea un habito',
                  style: TextStyle(
                    color: CustomColors.blanco,
                    fontSize: medida ? 35 : 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomInput(label: 'Nombre.'),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 3.0),
                        child: Text(
                          'Dias.',
                          style: TextStyle(
                            fontSize: 20,
                            color: CustomColors.blanco,
                          ),
                        ),
                      ),
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 5,
                          children:
                              List.generate(7, (index) => builButtonDay(index)),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomDropDown(label: 'Categoria.', items: list),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Hora.',
                          style: TextStyle(
                            fontSize: 20,
                            color: CustomColors.blanco,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: BoucingWidget(
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColors.azul,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${time.format(context)}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: CustomColors.blanco,
                                  ),
                                ),
                              ),
                            ),
                            onPress: () {
                              showTimePicker(
                                context: context,
                                helpText: 'Ingresa la hora',
                                cancelText: 'CANCELAR',
                                confirmText: 'INSERTAR',
                                initialEntryMode: TimePickerEntryMode.input,
                                initialTime: TimeOfDay.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: CustomColors.azul,
                                        onSurface: CustomColors.azul,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              ).then((value) {
                                setState(() {
                                  time = value!;
                                });
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 10.0,
                    right: 10.0,
                    bottom: 5.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Cancelar',
                        style: TextStyle(
                          color: CustomColors.blanco,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Aceptar',
                        style: TextStyle(
                          color: CustomColors.blanco,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget builButtonDay(int index) {
    return BoucingWidget(
      child: DayButton(
        label: daysWeek[index],
        active: activeDays[index],
      ),
    onPress: () {
      setState(() {
        bool active = activeDays[index];
        activeDays[index] = !active;
      });
    },
    );
  }
}
