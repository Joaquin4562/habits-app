import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/ui/widgets/boucing.dart';
import 'package:habits_app/ui/widgets/customDropDown.dart';
import 'package:habits_app/ui/widgets/custom_input.dart';

class DialogCreateHabit extends StatefulWidget {
  DialogCreateHabit({Key? key}) : super(key: key);

  @override
  _DialogCreateHabitState createState() => _DialogCreateHabitState();
}

class _DialogCreateHabitState extends State<DialogCreateHabit> {
  TimeOfDay time = TimeOfDay.now();
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
                          children: [
                            circleDay('D'),
                            circleDay('L'),
                            circleDay('M'),
                            circleDay('M'),
                            circleDay('J'),
                            circleDay('V'),
                            circleDay('S'),
                          ],
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
                      top: 15.0, left: 10.0, right: 10.0, bottom: 5.0),
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

  Padding circleDay(String label) {
    final medida = MediaQuery.of(context).size.width < 400;
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Container(
        width: medida ? 35 : 40,
        height: medida ? 35 : 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.azul,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF150638),
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
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
