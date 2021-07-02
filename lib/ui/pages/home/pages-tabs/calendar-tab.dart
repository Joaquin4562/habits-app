import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/ui/widgets/circleNumberWidget.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({Key? key}) : super(key: key);

  @override
  _CalendarTabState createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  DateTime _currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.azul,
      body: SafeArea(
        child: Column(
          children: [
            CalendarCarousel(
              customGridViewPhysics: BouncingScrollPhysics(),
              showOnlyCurrentMonthDate: true,
              pageScrollPhysics: NeverScrollableScrollPhysics(),
              headerTextStyle: TextStyle(
                color: CustomColors.blanco,
                fontSize: 20.0,
              ),
              iconColor: CustomColors.blanco,
              locale: Localizations.localeOf(context).languageCode,
              height: 450.0,
              weekFormat: false,
              weekdayTextStyle: TextStyle(
                fontSize: 20,
                color: CustomColors.lila,
              ),
              daysTextStyle: TextStyle(
                color: CustomColors.blanco,
                fontSize: 18.0,
              ),
              weekendTextStyle: TextStyle(
                color: CustomColors.amarillo,
                fontSize: 18.0,
              ),
              todayButtonColor: CustomColors.nature,
              selectedDateTime: _currentDate,
              minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
              maxSelectedDate: _currentDate.add(const Duration(days: 360)),
              markedDatesMap: EventList(events: {
                DateTime(2021, 06, 24): [
                  Event(
                    date: DateTime(2021, 06, 24),
                    title: 'Evento X',
                    dot: Container(
                      color: CustomColors.redAccion,
                      height: 5.0,
                      width: 5.0,
                    )
                  )
                ]
              }),
              selectedDayButtonColor: CustomColors.redAccion,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: CustomColors.blanco,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 7.0,
                    right: 7.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Habitos del dia',
                            style: TextStyle(
                              fontSize: 28,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CircleNumberWidget(
                            number: '10',
                            colorText: CustomColors.blanco,
                            backgroundColor: CustomColors.azul,
                            borderColor: CustomColors.blanco,
                            shadowColor1: Colors.black38,
                            shadowColor2: CustomColors.blanco,
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Image(
                        image: AssetImage('assets/img/new.png'),
                        width: MediaQuery.of(context).size.width * 0.6,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
