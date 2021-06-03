import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_habit_repo_impl.dart';
import 'package:habits_app/domain/models/event.model.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/ui/widgets/todoItemWidget.dart';
import 'package:intl/intl.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final locale = Localizations.localeOf(context).toString();
    final dayOfWeek = (today.weekday + 7) % 7;
    final _scrollController = ScrollController();
    return Scaffold(
      backgroundColor: CustomColors.azul,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
              right: 50.0,
              left: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.MMMM(locale).format(today),
                      style: TextStyle(
                        color: CustomColors.blanco,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        DateFormat.EEEE(locale).format(today),
                        style: TextStyle(
                          color: CustomColors.lila,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: CustomColors.azul,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: CustomColors.azul.dark!.withOpacity(0.5),
                            offset: Offset(5.0, 5.0),
                            blurRadius: 7.0,
                          ),
                          BoxShadow(
                            color: CustomColors.blanco.withOpacity(0.06),
                            offset: Offset(-5.0, -5.0),
                            blurRadius: 7.0,
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 95,
                          height: 95,
                          decoration: BoxDecoration(
                            color: CustomColors.azul.dark,
                            shape: BoxShape.circle,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              DateFormat('d').format(today),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: CustomColors.blanco,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List>(
                future:
                    ApiHabitRepositoryImplement().getToDoListHabits(dayOfWeek),
                builder: (context, snapshot) {
                  final habits = snapshot.data;
                  if (snapshot.connectionState != ConnectionState.waiting) {
                    if (snapshot.hasData) {
                      return RawScrollbar(
                        controller: _scrollController,
                        radius: Radius.circular(20),
                        thumbColor: CustomColors.amarillo.withOpacity(0.5),
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: habits!.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final habit = habits[index];
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TodoItemWidget(
                                item: Habitos(
                                  categoria: habit['categoria'],
                                  dias: habit['dias'],
                                  hora: habit['hora'],
                                  nombre: habit['nombre'],
                                  isFinished: habit['finalizada'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No hay habitos para este día 😔',
                              style: TextStyle(
                                color: CustomColors.blanco,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'No olvides de agregar unos cuantos',
                              style: TextStyle(
                                color: CustomColors.blanco,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Image(
                              image: AssetImage('assets/img/estilo.png'),
                              width: MediaQuery.of(context).size.width * 0.6,
                              color: CustomColors.morado,
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cargando habitos...',
                            style: TextStyle(
                              color: CustomColors.blanco,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
