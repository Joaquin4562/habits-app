import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_habit_repo_impl.dart';
import 'package:habits_app/ui/widgets/boucing.dart';
import 'package:habits_app/ui/widgets/snackbar.dart';

class AdvanceTab extends StatefulWidget {
  const AdvanceTab({Key? key}) : super(key: key);

  @override
  _AdvanceTabState createState() => _AdvanceTabState();
}

class _AdvanceTabState extends State<AdvanceTab> {
  int strake = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.azul.dark,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    height: size.height * 0.15,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: -20,
                          right: 0,
                          child: Image(
                            image: AssetImage('assets/img/header.png'),
                            width: size.width * 0.9,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.56,
                      decoration: BoxDecoration(
                        color: CustomColors.night,
                        borderRadius: const BorderRadius.only(
                          topLeft: const Radius.circular(30),
                          topRight: const Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.azul.dark!,
                            offset: Offset(6, 10),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 4,
                        children: List.generate(
                          20,
                          (index) => BoucingWidget(
                            onPress: () {
                              if (strake >= (index + 1 * 2)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    getSnackBar('Se completo la racha'));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    getSnackBar('Aun no llegas a esa racha'));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: CustomColors.azul.dark,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1 * 2}',
                                    style: TextStyle(
                                      color: CustomColors.blanco,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.azul.dark,
                    borderRadius: const BorderRadius.only(
                      topLeft: const Radius.circular(30),
                      topRight: const Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Toca una ventana',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustomColors.lila,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Si eres constante con tus hábitos, por los días marcados en las ventanas, se desbloqueara y obtendras una recompenza',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: CustomColors.lila,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Racha de hábitos',
                            style: TextStyle(
                              color: CustomColors.blanco,
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: CustomColors.azul,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  offset: Offset(5, 5),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: FutureBuilder<int>(
                                future: ApiHabitRepositoryImplement()
                                    .getStreakUser(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    Future.delayed(Duration(seconds: 1),() => setState(() => strake = snapshot.data!));
                                    return Center(
                                      child: Text(
                                        '$strake',
                                        style: TextStyle(
                                          color: CustomColors.blanco,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
