
import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';
import 'package:habits_app/data/datasource/api_auth_repo_impl.dart';
import 'package:habits_app/ui/pages/home/pages-tabs/home-tab-pages/habits.page.dart';
import 'package:habits_app/ui/pages/home/pages-tabs/home-tab-pages/todo.page.dart';
import 'package:habits_app/ui/widgets/boucing.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _selectedIndex = 0;
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final medida = (size.width > 400);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: medida ? 250 : 200,
            decoration: BoxDecoration(
                color: CustomColors.azul.dark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black38,
                    blurRadius: 3,
                  )
                ]),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Hero(
                    tag: 'edificio',
                    child: Image(
                      width: (medida ? 90 : 60),
                      image: AssetImage('assets/img/edificio.png'),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: size.width * 0.85,
                  bottom: 0,
                  child: IconButton(
                    onPressed: () async {
                      await ApiAuthRepositoryImplement().signOut();
                      Navigator.pushReplacementNamed(context, 'sign-in');
                    },
                    icon: Icon(
                      Icons.exit_to_app_rounded,
                      color: CustomColors.lila,
                      size: 40,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 50,
                        left: 20.0,
                        right: 90,
                      ),
                      child: Text(
                        'Crea lo mejor de ti, estos son tus hábitos',
                        style: TextStyle(
                          color: CustomColors.blanco,
                          fontSize: medida ? 35 : 25,
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoucingWidget(
                            onPress: () {
                              setState(() {
                                _selectedIndex = 0;
                                _controller.animateToPage(0,
                                    duration: Duration(microseconds: 500),
                                    curve: Curves.easeInOut);
                              });
                            },
                            boucingScale: 0.5,
                            child: Text(
                              'Hábitos',
                              style: TextStyle(
                                color: (_selectedIndex == 0)
                                    ? CustomColors.lila
                                    : CustomColors.blanco,
                                fontWeight: (_selectedIndex == 0)
                                    ? FontWeight.bold
                                    : FontWeight.w300,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            height: 30,
                            width: 4,
                            color: CustomColors.amarillo,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          BoucingWidget(
                            onPress: () {
                              setState(() {
                                _selectedIndex = 1;
                                _controller.animateToPage(
                                  1,
                                  duration: Duration(microseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              });
                            },
                            boucingScale: 0.5,
                            child: Text(
                              'TODO list',
                              style: TextStyle(
                                color: (_selectedIndex == 1)
                                    ? CustomColors.lila
                                    : CustomColors.blanco,
                                fontWeight: (_selectedIndex == 1)
                                    ? FontWeight.bold
                                    : FontWeight.w300,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - (medida ? 325 : 270),
            child: PageView(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              children: [
                HabitsPage(),
                TodoList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
