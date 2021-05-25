import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/domain/models/event.model.dart';
import 'package:habits_app/ui/widgets/habitsHomeButton.dart';
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
    final list = [
      Event(
          name: 'Salir a correr al parque',
          category: 'Salud mental',
          time: '4:50 pm',
          isFinished: false),
      Event(
          name: 'Salir con amigos',
          category: 'Estilo de vida',
          time: '2:00 pm',
          isFinished: true),
      Event(
          name: 'Comer mejor',
          category: 'Alimentacion',
          time: '4:50 pm',
          isFinished: true),
      Event(
          name: 'Conocer personas nuevas en mi ciudad',
          category: 'Salud mental',
          time: '4:50 pm',
          isFinished: false),
      Event(
          name: 'Salir a correr',
          category: 'Salud mental',
          time: '4:50 pm',
          isFinished: false),
      Event(
          name: 'comer con mis amigos',
          category: 'Salud mental',
          time: '4:50 pm',
          isFinished: true),
      Event(
          name: 'Salir a correr',
          category: 'Salud mental',
          time: '4:50 pm',
          isFinished: false),
    ];
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
            child: RawScrollbar(
              controller: _scrollController,
              radius: Radius.circular(20),
              thumbColor: CustomColors.amarillo.withOpacity(0.5),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: list.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          list[index].time!,
                          style: TextStyle(
                            color: CustomColors.blanco,
                            fontSize: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: list[index].isFinished!
                                  ? CustomColors.nature
                                  : CustomColors.redAccion,
                            ),
                            width: 10,
                            height: 10,
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: CustomColors.blanco,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                list[index].name!,
                                                style: TextStyle(
                                                  color: CustomColors.azul,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                list[index].category!,
                                                style: TextStyle(
                                                  color: CustomColors
                                                      .azul.light!
                                                      .withOpacity(0.7),
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Icon(
                                          list[index].isFinished!
                                              ? Icons.done
                                              : Icons.clear,
                                          color: list[index].isFinished!
                                              ? CustomColors.nature
                                              : CustomColors.redAccion,
                                          size: 40,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -20,
                                right: 60,
                                child: Image(
                                  image: AssetImage('assets/img/alimentacion.png'),
                                  width: 60,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
