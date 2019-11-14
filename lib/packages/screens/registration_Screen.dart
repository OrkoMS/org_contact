import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:flutter/scheduler.dart';
import 'package:org_contact/packages/screens/login_screen.dart';
import 'package:org_contact/packages/services/anim/progress_button/loginAnimation.dart';
import 'package:org_contact/packages/services/auth/auth.dart';
import 'package:org_contact/packages/services/common/colors.dart';
import 'package:org_contact/packages/services/common/shared_pref.dart';
import 'package:org_contact/packages/services/common/validations.dart';
import 'package:org_contact/route/direct_to_screen.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => new _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with TickerProviderStateMixin{
  var statusClick = 0;
  Auth auth = Auth();
  SharedPref sharedPref =SharedPref();
  NavigationRouter router = NavigationRouter();
  Validations validations =Validations();
  var _regEmailTextController = TextEditingController();
  var _regPasswordTextController = TextEditingController();
  var _confirmPasswordTextController = TextEditingController();
  AnimationController animationControllerButton;

  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible =false;
  bool isConfirmPasswordVisible =false;
  String _email;
  String _password;
  String _confirmPassword;
  String _validUser="";

  void emailValueUpdate(String value) {
    setState(() {
      _regEmailTextController.text = value;
    });
  }
  void passwordValueUpdate(String value) {
    setState(() {
      _regPasswordTextController.text = value;
    });
  }
  bool validateAndSave() {
    final form = formKey.currentState;
    if(form.validate())
    {
      form.save();
      return true;
    }else{
      return false;
    }
  }
  bool registerAndSubmit(){
    if(validateAndSave()) {
      try {
        if(_password!=_confirmPassword){
          Flushbar(
            message:  "Passwords do not match",
            duration:  Duration(seconds: 3),
          )..show(context);
          return false;
        }
        _email=_email.toLowerCase().trim();
        _password =_password;
        return true;
      } catch (e) {
        print(e);
      }
    }
    else{
      return false;
    }
    return false;
  }
  @override
  void initState() {

    isPasswordVisible = false;


    sharedPref.getUserAppData("Email").then(emailValueUpdate);
    sharedPref.getUserAppData("Password").then(passwordValueUpdate);

    super.initState();
    animationControllerButton= AnimationController(duration: Duration(seconds: 3),vsync: this)
      ..addStatusListener((status){
        if(status == AnimationStatus.dismissed){
          setState(() {
            statusClick=0;
          });
        }
      });

  }
  @override
  void dispose() {
    super.dispose();
    animationControllerButton.dispose();
  }


  Future<Null> _playAnimation() async{
    try{
      await animationControllerButton.forward();
      await animationControllerButton.reverse();
    } on TickerCanceled{}
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: statusBarColor));
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      // ignore: missing_return
        onWillPop: ()async{
          SystemNavigator.pop();
        },
        child: Scaffold(
          resizeToAvoidBottomPadding: true,
          body: Container(
            decoration: BoxDecoration(
              image: new DecorationImage(image: new AssetImage("assets/background.png"), fit: BoxFit.fill),
            ),

            child: _keyboardIsVisible() && height>width?
            ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Logo(width,height,3.4,5.4),
                    RegisterText(width,height,26.0,0.0),
                  ],
                ),
                Column(
                  children: <Widget>[
                    formViewContainer(context, width, height,0),
                    //poweredByLogo(height),
                  ],
                ),

              ],
            )
            //===============================keyboard visible false=============================
                :
            ListView(
              children: <Widget>[
                SizedBox(height: height/30,),
                Logo(width,height,1.4,3.4),
                RegisterText(width, height, 34.0, 1.0),
                SizedBox(height: height/35,),
                //Login form===============================================================================
                Column(
                  children: <Widget>[
                    formViewContainer(context, width, height,1),
                    //poweredByLogo(height),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }
  void saveUserCredentials() {
    sharedPref.setUserAppData("Email", _regEmailTextController.text);
    sharedPref.setUserAppData("Password", _regPasswordTextController.text);
  }

  FutureOr validateUser(String value) {
    setState(() {
      _validUser=value;
    });
  }

  void validUser(String email, String password) async{
    await auth.userRegistration(email, password).then(validateUser);
  }

  Widget formViewContainer(BuildContext context,var width, var height,var keyOn) {
    return Container(
      child: Form(
          key: formKey,
          child:Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 50, right: 50.0),
                decoration:new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(7),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "EMAIL",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(),
                    ),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: _regEmailTextController,
                  validator: validations.validateEmail,
                  onSaved: (value)=>_email=value,
                ),
              ),
              keyOn==0?SizedBox(height: height/70,):SizedBox(height: height/35,),
              Container(
                margin: const EdgeInsets.only(left: 50, right: 50.0),
                decoration:new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(7)
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "PASSWORD",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide()
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(isPasswordVisible?Icons.visibility:Icons.visibility_off),
                        onPressed: (){
                          setState(() {
                            isPasswordVisible =!isPasswordVisible;
                          });
                        }
                    ),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,),
                  ),
                  keyboardType: TextInputType.text,
                  validator: validations.validatePassword,
                  onSaved: (value)=>_password=value,
                  obscureText: !isPasswordVisible,
                  controller: _regPasswordTextController,
                ),
              ),
              keyOn==0?SizedBox(height: height/70,):SizedBox(height: height/35,),
              Container(
                margin: const EdgeInsets.only(left: 50, right: 50.0),
                decoration:new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(7)
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "CONFIRM PASSWORD",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide()
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(isConfirmPasswordVisible?Icons.visibility:Icons.visibility_off),
                        onPressed: (){
                          setState(() {
                            isConfirmPasswordVisible =!isConfirmPasswordVisible;
                          });
                        }
                    ),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,),
                  ),
                  keyboardType: TextInputType.text,
                  validator: validations.validatePassword,
                  onSaved: (value)=>_confirmPassword=value,
                  obscureText: !isConfirmPasswordVisible,
                  controller: _confirmPasswordTextController,
                ),
              ),
              keyOn==0?SizedBox(height: height/150,):SizedBox(height: height/35,),
              statusClick == 0
                  ? new InkWell(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  setState(() {
                    statusClick = 1;
                    //_validUser=true;
                  });
                  if(registerAndSubmit()) {
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: statusBarColor));
                    _playAnimation();
                  }
                  else{
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: statusBarColor));
                    statusClick = 0;
                  }
                  validUser(_regEmailTextController.text,_regPasswordTextController.text);
                },
                child: Register(),
              )
                  : StartAnimation(
                buttonController: animationControllerButton.view,
                user:_regEmailTextController.text,
                pass: _regPasswordTextController.text,
                valid: _validUser,
                buttonText: 'Register',
              ),
              SizedBox(height: 5),

              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: primaryColor,
                              fontWeight: FontWeight.normal,),
                          ),
                          Text(
                            'Login',
                              style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: primaryColor,
                              fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                    )
                ),
              ),
              keyOn==0?SizedBox(height: 0,):SizedBox(height: height/15,),
              statusClick==1?
              Container():poweredByLogo(height),
            ],
          )
      ),
    );
  }
  Widget poweredByLogo(var height) {
    return Container(
      padding: EdgeInsets.all(height/170),
      height: height/20,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Image(image: new AssetImage("assets/cokreates.png"), fit: BoxFit.fitHeight),
      ),
    );
  }
}
class Register extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryColor));
    return Container(
      margin: const EdgeInsets.only(left: 50, right: 50.0),
      alignment: FractionalOffset.center,
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      decoration: BoxDecoration(
          color: buttonBgColor,
          borderRadius: BorderRadius.all(const Radius.circular(30.0))),
      child: Text(
        "Register",
        style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3),
      ),
    );
  }
}
class Logo extends StatelessWidget {
  final double width;
  final double height;
  final double widthDiv;
  final double heightDiv;

  Logo(this.width,this.height,this.widthDiv,this.heightDiv);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widthDiv>2?const EdgeInsets.only(left: 30):const EdgeInsets.only(left: 0),
      padding: EdgeInsets.all(5),
      width: width/widthDiv,
      height: height/heightDiv,
      child: Hero(tag: "logo", child: Image.asset("assets/con_logo.png")),
    );
  }
}
class RegisterText extends StatelessWidget {
  final double width;
  final double height;
  final double fontSize;
  final double keyOn;
  RegisterText(this.width,this.height,this.fontSize,this.keyOn);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: keyOn==0?const EdgeInsets.only( right: 50.0):const EdgeInsets.only(left: 50, right: 50.0),
      alignment: Alignment.centerLeft,
      child: Hero(
        tag: "Register",
        child: Text("Register",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            decoration: null,
          ),
        ),
      ),
    );
  }
}
