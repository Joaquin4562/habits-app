import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarTab extends StatelessWidget {
  const CalendarTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        backgroundColor: CustomColors.azul,
        cellBorderColor: CustomColors.blanco,
        showNavigationArrow: true,
        headerHeight: 100,
        headerStyle: CalendarHeaderStyle(
          textStyle: TextStyle(
            color: CustomColors.blanco,
            fontSize: 20,
          ),
        ),
        monthViewSettings: MonthViewSettings(
          monthCellStyle: MonthCellStyle(
            textStyle: TextStyle(
              color: CustomColors.blanco,
              fontSize: 20,
            ),
            backgroundColor: CustomColors.azul,
            leadingDatesBackgroundColor: CustomColors.azul.dark,
            leadingDatesTextStyle: TextStyle(
              color: CustomColors.blanco,
              fontSize: 18,
            ),
            trailingDatesBackgroundColor: CustomColors.azul.dark,
            trailingDatesTextStyle: TextStyle(
              color: CustomColors.blanco,
              fontSize: 18,
            ),
          ),
        ),
        selectionDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: CustomColors.cea,
        ),
        view: CalendarView.month,
      ),
    );
  }
}
