import 'package:flutter/material.dart';
import 'package:org_contact/packages/screens/home_screen.dart';
import 'package:org_contact/packages/screens/login_screen.dart';
import 'package:org_contact/packages/screens/splash_screen.dart';
import 'package:org_contact/packages/services/anim/fadePageRoute.dart';
import 'package:org_contact/packages/services/anim/page_transition.dart';
import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {

  switch (settings.name){
    case SplashScreenRoute:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case LoginScreenRoute:
      return FadePageRoute(widget: LoginScreen());
    case HomeScreenRoute:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    default:
      return SlideRoute(page: LoginScreen());
  }
}