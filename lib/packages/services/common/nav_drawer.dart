import 'package:flutter/material.dart';
import 'package:org_contact/packages/services/auth/auth.dart';
import 'package:org_contact/packages/services/common/colors.dart';
import 'package:org_contact/packages/services/common/shared_pref.dart';
import 'package:org_contact/packages/services/contact_services.dart';
import 'package:org_contact/route/direct_to_screen.dart';
import 'package:org_contact/route/routing_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  final bool hasContact;
  CustomDrawer({Key key,
    this.hasContact,
  }) : super(key: key);
    @override
  State createState() => CustomDrawerState();
}
class CustomDrawerState extends State<CustomDrawer>{
  SharedPref sharedPref = SharedPref();
  NavigationRouter router =NavigationRouter();
  String userName ='';
  String userEmail ='';
  @override
  void initState() {
    super.initState();
    sharedPref.getUserAppData("userName").then(updateUserName);
    sharedPref.getUserAppData("userEmailID").then(updateUserEmail);
  }
  void updateUserEmail(String value) {
    setState(() {
      userEmail = value;
    });
  }
  void updateUserName(String value) {
    setState(() {
      userName = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    var _deviceWidth = MediaQuery.of(context).size.width;
    print(userName);
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            // ListView contains a group of widgets that scroll inside the drawer
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(userName??""),
                  accountEmail: Text(userEmail??""),
                  decoration: BoxDecoration(
                    color: appBarColor
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: statusBarColor,
                    child: Icon(Icons.account_circle, size: _deviceWidth/6, color: primaryColor,),

                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: _deviceWidth/12),
                  title: Text('Home'),
                  onTap: ()async{
                    Navigator.pop(context);
                    router.directTo(context, HomeScreenRoute);
                  },
                ),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Divider(color: Colors.black54, height: 1.0,indent: 10.0,),
                ),
                widget.hasContact?
                ListTile(
                  contentPadding: EdgeInsets.only(left: _deviceWidth/12),
                  title: Text('Delete Contact'),
                  onTap: (){
                    Navigator.pop(context);
                    router.directTo(context, HomeScreenRoute);
                    ContactService cService = ContactService();
                    cService.deleteUserContact();

                  },
                ):Container(),
                widget.hasContact?
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Divider(color: Colors.black54, height: 1.0,indent: 10.0,),
                ):Container(),
              ],
            ),
          ),
          Container(
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Divider(color: Colors.black54, height: 1.0,indent: 10.0,),
                          ListTile(
                            title: Text('Logout'),
                            trailing: Icon(Icons.exit_to_app),
                            onTap: (){
                              Auth auth = Auth();
                              auth.signOut();
                              router.directTo(context, LoginScreenRoute);
                            },
                          ),
                        ],
                      )
                  )
              )
          )
        ],
      ),
    );
  }
}