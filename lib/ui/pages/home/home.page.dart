import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/customIcons.dart';
import 'package:habits_app/ui/pages/home/pages-tabs/advance-tab.dart';
import 'package:habits_app/ui/pages/home/pages-tabs/calendar-tab.dart';
import 'package:habits_app/ui/pages/home/pages-tabs/home-tab.dart';
import 'package:habits_app/ui/widgets/customBottomNB.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.azul,
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeTab(),
          CalendarTab(),
          AdvanceTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.shifting,
        backgroundColor: CustomColors.azul.dark,
        currentIndex: _selectedIndex,
        selectedItemColor: CustomColors.amarillo,
        elevation: 0,
        iconSize: 26,
        items: [
          customBottomNB('pricipal', CustomIcons.home),
          customBottomNB('calendario', CustomIcons.calendar),
          customBottomNB('avance', Icons.business_rounded)
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _controller.animateToPage(
              index,
              duration: Duration(microseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
    );
  }
}
