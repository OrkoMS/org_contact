import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:org_contact/packages/screens/home_screen.dart';
import 'package:org_contact/packages/screens/login_screen.dart';
import 'package:org_contact/packages/services/anim/circular_reveal/circular_reveal.dart';
import 'package:org_contact/packages/services/common/colors.dart';
import 'package:org_contact/packages/services/common/shared_pref.dart';
import 'package:org_contact/packages/services/common/validations.dart';
import 'package:org_contact/route/direct_to_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

asyncFunction()async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("test", true);
}
class StartAnimation extends StatefulWidget {

  StartAnimation({Key key, this.buttonController,this.user,this.pass,this.valid,this.buttonText})
      : shrinkButtonAnimation = new Tween(
      begin: 320.0,
      end: 60.0
  ).animate(CurvedAnimation(
      parent: buttonController,
      curve:  Interval(
          0.0,
          0.150
      )
  ),

  ),

  zoomAnimation= new Tween(
      begin: 70.0,
      end: 900.0
  ).animate(CurvedAnimation(
      parent: buttonController,
      curve: Interval(
        0.550,
        0.999,
        curve: Curves.bounceInOut,
      )
  )),
  super(key:key);

  final AnimationController buttonController;
  final Animation shrinkButtonAnimation;
  final Animation zoomAnimation;

  final String user;
  final String pass;
  final String valid;
  final String buttonText;




  Widget _buildAnimation(BuildContext context, Widget child){
    return Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child:
        zoomAnimation.value <=300 ?
        new Container(
          alignment: FractionalOffset.center,
          width: shrinkButtonAnimation.value,
          height: 60.0,
          decoration: BoxDecoration(
              color: buttonBgColor,
              borderRadius: BorderRadius.all(const Radius.circular(30.0))),
          child: shrinkButtonAnimation.value > 60
              ? Text(
            buttonText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3),
          )
              : CircularProgressIndicator(
              strokeWidth: 1.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
          ),)
            //: user=='orko@cokreates.com' && pass=='testest'?
         : (((valid!=null )&&(valid!=""))|| buttonText=='Register')?
        Circular(0)
            : new Container(
          alignment: FractionalOffset.center,
          width: shrinkButtonAnimation.value,
          height: 60.0,
          decoration: BoxDecoration(
              color: primaryAccentColor,
              borderRadius: BorderRadius.all(const Radius.circular(30.0))),
          child: shrinkButtonAnimation.value > 60
              ? Text(
            buttonText,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3),
          )
              : CircularProgressIndicator(
              strokeWidth: 1.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
          ),)



    );
  }

  @override
  _StartAnimationState createState() => new _StartAnimationState();

}

class _StartAnimationState extends State<StartAnimation> with SingleTickerProviderStateMixin{
  SharedPref sharedPref =SharedPref();
   NavigationRouter router = NavigationRouter();
  final snackBar = SnackBar(content: Text('Wrong Username or Password'));
  Validations validations =Validations();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.buttonController.addListener((){
      if(widget.zoomAnimation.isCompleted){
        //if (widget.user=='orko@cokreates.com' && widget.pass=='testest'){
          if ((widget.valid!=null )&&(widget.valid!="")){
          sharedPref.setUserAppData("userID", widget.user);
          print(widget.user);
          asyncFunction();
          SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          if(widget.buttonText=='Login') {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
          else if(widget.buttonText=='Register') {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        }
        else
          {
            Scaffold.of(context).showSnackBar(snackBar);
          }
      }
    },
    );
   return new AnimatedBuilder(
     builder: widget._buildAnimation,
     animation: widget.buttonController,
   );
  }
}