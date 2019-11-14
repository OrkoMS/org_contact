import 'package:flutter/material.dart';

class LogoBinder extends StatefulWidget {
  double heightRatio =1.0;
  double height=0.0;
  double width=0.0;

  LogoBinder(this.height,this.width,this.heightRatio);

  @override
  _LogoBinderState createState() => _LogoBinderState();
}

class _LogoBinderState extends State<LogoBinder> {
  @override
  Widget build(BuildContext context) {
    if(widget.height ==0.0 && widget.width==0.0) {
      widget.height = (MediaQuery
          .of(context)
          .size
          .height);
      widget.width = (MediaQuery
          .of(context)
          .size
          .width);
    }
    return Container(
      color: Colors.white,
      height: widget.height/widget.heightRatio,
      width: widget.width,
      child: Stack(
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                color: Colors.transparent,
                image: new DecorationImage(image: new AssetImage("assets/con_logo.png"), fit: BoxFit.contain,),
              ),
            ),
          ]
      ),
    );
  }
}