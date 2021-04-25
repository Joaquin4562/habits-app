import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/ui/widgets/boucing.dart';
import 'package:habits_app/ui/widgets/custombtn-habits.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final list = List.generate(
        10, (i) => Habitos(categoria: 'Categoria $i', nombre: 'Habito X $i'));
    final _scrollController = ScrollController();
    return Scaffold(
      backgroundColor: CustomColors.azul,
      body: Container(
        child: RawScrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          thickness: 5,
          radius: Radius.circular(20),
          thumbColor: CustomColors.amarillo,
          child: ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return Dismissible(
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cleaning_services_outlined,
                          size: 50,
                          color: CustomColors.blanco,
                        ),
                        Text(
                          'Terminar habito',
                          style: TextStyle(
                            color: CustomColors.blanco,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                  ),
                  key: Key(item.nombre!),
                  onDismissed: (direccion) {
                    print(direccion.index);
                  },
                  child: CustomBtnHabits(
                    pRight: 40.0,
                    pLeft: 40.0,
                    pTop: 20.0,
                    pBottom: 10.0,
                    icono: Icons.outlined_flag_rounded,
                    label: item.nombre!,
                    colorIcon: CustomColors.azul,
                    colorText: CustomColors.azul,
                    colorButton: CustomColors.lila,
                    imagen: 'assets/img/habit.png',
                  ),
                );
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
          Navigator.pushNamed(context, 'create-habit');
        },
      ),
    );
  }
}

