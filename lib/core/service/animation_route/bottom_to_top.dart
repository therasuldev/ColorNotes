import 'package:flutter/material.dart';

Future bTtRoute(
    {required BuildContext context,
    required Widget route,
    required bool back}) {
  return Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        opaque: true,
        pageBuilder: (BuildContext context, _, __) {
          return route;
        },
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: Curves.linear, parent: animation);
          return _bTtRouteBuilderAnimation(animation, child);
        },
      ),
      (route) => back);
}

Widget _bTtRouteBuilderAnimation(Animation<double> animation, Widget child) {
  return Align(
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(.0, 1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    ),
  );
}
