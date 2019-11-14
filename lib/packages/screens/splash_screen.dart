import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:org_contact/packages/services/anim/logo_anim.dart';
import 'dart:async';
import 'package:org_contact/route/direct_to_screen.dart';
import 'package:org_contact/route/routing_constants.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NavigationRouter router = NavigationRouter();
  MySplashAnim mySplashAnim = MySplashAnim();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(image: new AssetImage("assets/background.png"), fit: BoxFit.fill,),
      ),
      child: Stack(
        children: <Widget>[
          //MySlideInAnim(),
          MySplashAnim(),
        ],
      ),
    );


  }
  startTime() async {
    var _duration = new Duration(milliseconds: 2500);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {

    router.directTo(context, LoginScreenRoute);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }


  @override
  void initState() {
    super.initState();
    startTime();
  }
}