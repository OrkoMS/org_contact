import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:org_contact/packages/services/anim/logo_binder.dart';

class MySplashAnim extends StatefulWidget {
  @override
  MySplashAnimState createState() => MySplashAnimState();
}
class MySplashAnimState extends State<MySplashAnim> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    animation = Tween(begin: 100.0, end: 350.0).animate(animationController);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LogoAnimation(
      animation: animation,
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}

class LogoAnimation extends AnimatedWidget {
  LogoAnimation({Key key, Animation animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Center(
      child: Container(
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(150.0),
//          boxShadow: <BoxShadow>[
//            BoxShadow(color: Colors.black, offset: Offset(1.0, 6.0), blurRadius: 10.0),
//          ],
//        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(150.0),
          child: Hero(tag: "logo", child: LogoBinder(animation.value,animation.value,1.0)),
        ),

    ),
    );
  }
}