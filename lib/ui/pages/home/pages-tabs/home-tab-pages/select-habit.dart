import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_repository_impl.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/ui/pages/home/pages-tabs/home-tab-pages/predeterminate.habits.dart';
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
    final colores = [
      CustomColors.rosa,
      CustomColors.morado,
      CustomColors.cea,
      CustomColors.redAccion,
      CustomColors.nature,
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
                    child: Hero(
                      tag: 'moon',
                      child: Image(
                        width: 80,
                        image: AssetImage('assets/img/moon.png'),
                      ),
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
            child: FutureBuilder<QuerySnapshot?>(
              future: ApiRepositoryImpl().getPredeterminatedHabits(),
              builder: (context, snapshot) {
                Widget child = Container(
                  child: Center(
                    child: Text(
                      'No hay datos :c',
                      style: TextStyle(
                        color: CustomColors.blanco,
                        fontSize: 30,
                      ),
                    ),
                  ),
                );
                if (snapshot.hasData) {
                  final habitos = snapshot.data!.docs;
                  child = ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: habitos.length,
                    itemBuilder: (context, index) {
                      return BoucingWidget(
                        boucingScale: 0.2,
                        child: CustomBtnHabits(
                          icono: Icons.arrow_forward_ios_sharp,
                          label: habitos[index]['nombre'],
                          colorIcon: CustomColors.azul.dark,
                          colorText: CustomColors.blanco,
                          colorButton: colores[index],
                          imagen:
                              'assets/img/${habitos[index]['icono']}.png',
                        ),
                        onPress: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PredeterminatedHabits(
                                title: habitos[index]['nombre'],
                                color: colores[index],
                                habitos: habitos[index]['habitos-predeterminados'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return child;
              },
            ),
          ),
        ],
      ),
    );
  }
}
