import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_habit_repo_impl.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/ui/pages/home/pages-tabs/home-tab-pages/select-habit.dart';
import 'package:habits_app/ui/widgets/boucing.dart';
import 'package:habits_app/ui/widgets/custombtn-habits.dart';
import 'package:habits_app/ui/widgets/dialogInfoHabit.dart';
import 'package:habits_app/ui/widgets/habitsHomeButton.dart';
import 'package:habits_app/ui/widgets/noHabitsWidget.dart';
import 'package:habits_app/ui/widgets/utils/createRoute.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  _HabitsPageState createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.azul,
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: ApiHabitRepositoryImplement().getUserHabits(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              final data = snapshot.data!;
              if (data.length > 0) {
                return RawScrollbar(
                  isAlwaysShown: true,
                  controller: _scrollController,
                  thickness: 5,
                  radius: const Radius.circular(20),
                  thumbColor: CustomColors.amarillo,
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return BoucingWidget(
                        boucingScale: 0.2,
                        onPress: () {
                          showGeneralDialog(
                            context: context,
                            pageBuilder: (context, anim1, anim2) =>
                                const Text(''),
                            transitionBuilder: (context, anim1, anim2, child) {
                              return Transform.scale(
                                scale: anim1.value,
                                child: DialogInfoHabit(
                                  habit: Habitos(
                                    categoria: item['categoria'],
                                    dias: item['dias'],
                                    hora: item['hora'],
                                    nombre: item['nombre'],
                                    isFinished: item['finalizada'],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: HabitsHomeButton(
                          pRight: 40.0,
                          pLeft: 40.0,
                          pTop: 10.0,
                          pBottom: 10.0,
                          label: item['nombre'],
                          category: item['categoria'],
                          time: item['hora'],
                          colorText: CustomColors.azul,
                          colorButton: CustomColors.blanco,
                          imagen: 'assets/img/habit.png',
                        ),
                      );
                    },
                  ),
                );
              } else {
                return NoHabitsWidget();
              }
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cargando hábitos',
                      style: TextStyle(
                        color: CustomColors.blanco,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BoucingWidget(
        boucingScale: 0.10,
        child: CustomBtnHabits(
          icono: Icons.add_circle_outline,
          label: 'Añadir hábito',
          colorIcon: CustomColors.azul,
          colorText: CustomColors.azul,
          colorButton: CustomColors.blanco,
          imagen: 'assets/img/new.png',
        ),
        onPress: () {
          Navigator.push(context, createRoute(CreateHabitPage()));
        },
      ),
    );
  }
}
