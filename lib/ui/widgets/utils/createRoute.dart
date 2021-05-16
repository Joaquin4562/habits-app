import 'package:flutter/widgets.dart';

Route createRoute(Widget child) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = Offset(0.0, 1.0);
        final end = Offset.zero;
        final curve = Curves.easeOutCubic;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
