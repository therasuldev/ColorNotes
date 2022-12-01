import 'package:flutter/material.dart';

Future rTlRoute(
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
          return _rTlRouteBuilderAnimation(animation, child);
        },
      ),
      (route) => back);
}

Widget _rTlRouteBuilderAnimation(Animation<double> animation, Widget child) {
  return Align(
    child: SlideTransition(
      position: Tween(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    ),
  );
}
