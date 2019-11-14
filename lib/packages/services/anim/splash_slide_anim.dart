import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class MySlideInAnim extends StatefulWidget {
  @override
  MySlideInAnimState createState() => MySlideInAnimState();
}
class MySlideInAnimState extends State<MySlideInAnim> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    animation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
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
    final double width = MediaQuery.of(context).size.width;
    Animation animation = listenable;

    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child){
          return Scaffold(
            body: Transform(
                transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
              child: Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(image: new AssetImage("assets/splash_bg.png"), fit: BoxFit.fill,),
                ),
              ),
            ),
          );
        }
    );
  }
}