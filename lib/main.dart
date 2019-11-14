import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:org_contact/packages/services/common/colors.dart';
import 'package:org_contact/route/route.dart' as route;
import 'package:org_contact/route/routing_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: statusBarColor));
  SystemChrome.setEnabledSystemUIOverlays([]);
  String _screen =SplashScreenRoute;
  final prefs = await SharedPreferences.getInstance();
  final test = prefs.getBool("test") ?? false;
  if(test)
  {
    _screen=ToDosScreenRoute;
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: primaryColor,
      accentColor: primaryAccentColor,
    ),
    title: "Contacts",
    onGenerateRoute: route.generateRoute,
//
    initialRoute: _screen,
  ));
}