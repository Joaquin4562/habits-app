import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/ui/widgets/circleNumberWidget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTab extends StatelessWidget {
  const CalendarTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.azul,
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              headerStyle: HeaderStyle(
                headerPadding: EdgeInsets.all(20),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: CustomColors.blanco,
                ),
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: CustomColors.blanco,
                ),
                decoration: BoxDecoration(
                  color: CustomColors.azul.dark,
                ),
                titleTextStyle: TextStyle(
                  color: CustomColors.blanco,
                  fontSize: 20,
                ),
                formatButtonTextStyle: TextStyle(
                  color: CustomColors.blanco,
                ),
                titleCentered: true,
              ),
              daysOfWeekHeight: 60,
              daysOfWeekStyle: DaysOfWeekStyle(
                decoration: BoxDecoration(
                  color: CustomColors.azul.dark,
                ),
                weekdayStyle: TextStyle(
                  color: CustomColors.blanco,
                  fontSize: 20,
                ),
                weekendStyle: TextStyle(
                  color: CustomColors.lila,
                  fontSize: 20,
                ),
              ),
              calendarStyle: CalendarStyle(
                cellMargin: EdgeInsets.all(0),
                rowDecoration: BoxDecoration(
                  color: CustomColors.azul,
                ),
                weekendTextStyle: TextStyle(color: CustomColors.lila),
                outsideTextStyle: TextStyle(color: CustomColors.blanco),
                defaultTextStyle: TextStyle(color: CustomColors.blanco),
              ),
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
                            'Racha de habitos',
                            style: TextStyle(
                              fontSize: 27,
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
