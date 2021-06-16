import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_habit_repo_impl.dart';
import 'package:habits_app/domain/request/requestSaveUserHabit.dart';
import 'package:habits_app/ui/widgets/boucing.dart';
import 'package:habits_app/ui/widgets/customDropDown.dart';
import 'package:habits_app/ui/widgets/custom_input.dart';
import 'package:habits_app/ui/widgets/day_button.dart';
import 'package:habits_app/ui/widgets/snackbar.dart';

class DialogCreateHabit extends StatefulWidget {
  DialogCreateHabit({
    Key? key,
    this.category,
    this.dayList,
    this.hour,
    this.name,
  }) : super(key: key);
  final String? name;
  final List<dynamic>? dayList;
  final String? hour;
  final String? category;
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
    false, // domingo
    false, // lunes
    false, // martes
    false, // miercoles
    false, // jueves
    false, // viernes
    false, // sabado
  ];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String name = widget.name == null ? '' : widget.name!;
    if (widget.dayList != null) {
      modifyActiveDays();
    }
    String category = widget.category == null ? '' : widget.category!;
    final medida = MediaQuery.of(context).size.width < 400;
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
            child: Form(
              key: _formKey,
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
                  CustomInput(
                    label: 'Nombre.',
                    initialValue: name,
                    onSaved: (value) {
                      name = value!;
                    },
                    validator: (value) =>
                        value!.isEmpty ? 'Asegurate de escribir algo' : null,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 3.0),
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
                            children: List.generate(
                              7,
                              (index) => builButtonDay(index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<List<String>>(
                      future: getCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return CustomDropDown(
                            label: 'Categoria.',
                            items: snapshot.data!,
                            initialValue: widget.category,
                            onSaved: (value) {
                              category = value!;
                            },
                          );
                        } else {
                          return CustomDropDown(
                            label: 'Cargando datos...',
                            items: [''],
                          );
                        }
                      }),
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
                                    widget.hour == null ? '${time.format(context)}' : widget.hour!,
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
                                  if (value != null) {
                                    setState(() {
                                      time = value;
                                    });
                                  }
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
                        BoucingWidget(
                          onPress: () => Navigator.pop(context),
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              color: CustomColors.blanco,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        BoucingWidget(
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              final res = await ApiHabitRepositoryImplement()
                                  .saveUserHabit(
                                RequestSaveUserHabit(
                                  name: name,
                                  category: category,
                                  days: activeDays,
                                  hour: time.format(context),
                                ),
                              );
                              Navigator.pushReplacementNamed(context, 'home');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(getSnackBar(res!));
                            }
                          },
                          child: Text(
                            'Aceptar',
                            style: TextStyle(
                              color: CustomColors.blanco,
                              fontSize: 20,
                            ),
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

  modifyActiveDays() {
    widget.dayList!.asMap().forEach((index, value) {
      activeDays[index] = value;
    });
  }

  Future<List<String>> getCategories() async {
    final res = await ApiHabitRepositoryImplement().getPredeterminatedHabits();
    List<String> list =
        res!.docs.map<String>((element) => element['nombre']).toList();
    return list;
  }
}
