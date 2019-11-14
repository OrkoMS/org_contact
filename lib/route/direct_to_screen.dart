import 'package:flutter/material.dart';

class NavigationRouter {
  directTo(BuildContext context, String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        routeName,
            (route) => route.isCurrent
            ? route.settings.name == routeName
            ? false
            : true
            : true);

  }

//  static Router router;
//  static void initPaths() {
//    router = Router()
//      ..define('login', handler: Handler(
//          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
//            return LoginScreen();
//          }))
//      ..define('home', handler: Handler(
//          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
//            return HomeScreen();
//          }));
//  }
//  static void navigateTo(
//      BuildContext context,
//      String path, {
//        bool replace = false,
//        TransitionType transition = TransitionType.native,
//        Duration transitionDuration = const Duration(milliseconds: 250),
//        RouteTransitionsBuilder transitionBuilder,
//      }) {
//    router.navigateTo(
//      context,
//      path,
//      replace: replace,
//      transition: transition,
//      transitionDuration: transitionDuration,
//      transitionBuilder: transitionBuilder,
//    );
//  }
}