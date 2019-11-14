import 'package:flutter/material.dart';
import 'package:org_contact/packages/services/anim/circular_reveal/painter.dart';

class Circular extends StatefulWidget {
  final int stateType;

  Circular(this.stateType);

  @override
  CircularState createState() => CircularState();
}

class CircularState extends State<Circular> with TickerProviderStateMixin {

  Animation _animation;
  double _fraction;

  void initState() {
    super.initState();

    if (widget.stateType == 0) {
      reveal();
    } else if (widget.stateType == 1) {
      hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircularAnimationPainter(_fraction, MediaQuery.of(context).size),
    );
  }

  void reveal() {
    _fraction = 0.0;
    AnimationController controller = AnimationController(
        duration: Duration(milliseconds: 800), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });
    controller.forward();
  }

  void hide() {
    _fraction = 1.0;
    AnimationController controller = AnimationController(
        duration: Duration(milliseconds: 800), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _fraction = 1 - _animation.value;
        });
      });
    controller.forward();
  }
}
