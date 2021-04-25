import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/ui/widgets/boucing.dart';
import 'package:habits_app/ui/widgets/custombtn-habits.dart';
import 'package:habits_app/ui/widgets/dialogCreateHabit.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({Key? key}) : super(key: key);

  @override
  _CreateHabitPageState createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  @override
  Widget build(BuildContext context) {
    final habitos = [
      Categories(
        color: CustomColors.rosa,
        icono: 'estilo',
        nombre: 'Estilo de vida',
      ),
      Categories(
        color: CustomColors.morado,
        icono: 'salud',
        nombre: 'Salud Mental',
      ),
      Categories(
        color: CustomColors.cea,
        icono: 'alimentacion',
        nombre: 'Alimentación',
      ),
      Categories(
        color: CustomColors.redAccion,
        icono: 'fisico',
        nombre: 'Cambio físico',
      ),
      Categories(
        color: CustomColors.nature,
        icono: 'hogar',
        nombre: 'Hogar',
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.azul.dark,
        title: Text(
          'Habitos',
          style: TextStyle(
            color: CustomColors.lila,
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
        ),
      ),
      backgroundColor: CustomColors.azul,
      body: Column(
        children: [
          Container(
            height: 130,
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
                  left: 0,
                  child: Hero(
                    tag: 'edificio',
                    child: Image(
                      width: 100,
                      image: AssetImage('assets/img/edificio.png'),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 20,
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
                    child: Image(
                      width: 80,
                      image: AssetImage('assets/img/moon.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: BoucingWidget(
              boucingScale: 0.10,
              child: CustomBtnHabits(
                icono: Icons.add_circle_outline,
                label: 'Crear nuevo habito',
                colorIcon: CustomColors.azul,
                colorText: CustomColors.azul,
                colorButton: CustomColors.blanco,
                imagen: 'assets/img/new.png',
              ),
              onPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogCreateHabit();
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Selecciona una categoría',
                style: TextStyle(
                  color: CustomColors.lila,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: habitos.length,
              itemBuilder: (context, index) {
                return BoucingWidget(
                  boucingScale: 0.2,
                  child: CustomBtnHabits(
                    icono: Icons.arrow_forward_ios_sharp,
                    label: habitos[index].nombre,
                    colorIcon: CustomColors.azul.dark,
                    colorText: CustomColors.blanco,
                    colorButton: habitos[index].color,
                    imagen: 'assets/img/${habitos[index].icono}.png',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
