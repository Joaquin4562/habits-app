import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_repository_impl.dart';
import 'package:habits_app/ui/pages/home/pages-tabs/home-tab-pages/select-habit.dart';
import 'package:habits_app/ui/widgets/boucing.dart';
import 'package:habits_app/ui/widgets/custombtn-habits.dart';
import 'package:habits_app/ui/widgets/habitsHomeButton.dart';
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
    this._scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.azul,
      body: Container(
        child: RawScrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          thickness: 5,
          radius: Radius.circular(20),
          thumbColor: CustomColors.amarillo,
          child: FutureBuilder<List<dynamic>>(
              future: ApiRepositoryImpl().getUserHabits(),
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  final data = snapshot.data!;
                  return ListView.builder(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return BoucingWidget(
                        boucingScale: 0.2,
                        child: HabitsHomeButton(
                          pRight: 40.0,
                          pLeft: 40.0,
                          pTop: 20.0,
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
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Cargando habitos',
                          style: TextStyle(
                            color: CustomColors.blanco,
                            fontSize: 25,
                          ),
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                }
              }),
        ),
      ),
      bottomNavigationBar: BoucingWidget(
        boucingScale: 0.10,
        child: CustomBtnHabits(
          icono: Icons.add_circle_outline,
          label: 'Añadir habito',
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
