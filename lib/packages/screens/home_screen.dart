import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:org_contact/packages/models/contactModel.dart';
import 'package:org_contact/packages/screens/add_contact.dart';
import 'package:org_contact/packages/screens/contact_details.dart';
import 'package:org_contact/packages/services/common/colors.dart';
import 'package:org_contact/packages/services/common/nav_drawer.dart';
import 'package:org_contact/packages/services/contact_services.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _image;
  List<Contact> contacts = List();
  Contact contact;
  DatabaseReference contactRef;
  bool hasContact = false;
  ContactService cService = ContactService();
  //String contactKey;
  void asyncFunction() async {
    hasContact= await cService.currentUserHasContact();
    //contactKey= await cService.getUserContactKey();
  }

  @override
  void initState() {
    super.initState();
    asyncFunction();
    final FirebaseDatabase database = FirebaseDatabase.instance;
    contactRef = database.reference().child("contacts");
    contactRef.onChildAdded.listen(_onEntryAdded);
    contactRef.once().then((DataSnapshot snapshot) {
    });

  }
  _onEntryAdded(Event event) {
    setState(() {
      asyncFunction();
      contacts.add(Contact.fromSnapshot(event.snapshot));
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do you really want to exit the app?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () => SystemNavigator.pop(),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    //CustomDrawer _customDrawer = CustomDrawer();
   return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: Text(
            'Home',
            style: TextStyle(color: appBarTextColor),
          ),
          elevation:
              defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
          backgroundColor: primaryColor,
          iconTheme: new IconThemeData(color: appBarTextColor),
        ),
        drawer: CustomDrawer(hasContact: hasContact,),
        body: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: FirebaseAnimatedList(
                  query: contactRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    return GestureDetector(
                      onTap: (){
                        print(contacts[index].key);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title: Text('Contact'),
                                children: <Widget>[
                                  SimpleDialogOption(
                                    onPressed: () async{
                                      //_launchCaller(contacts[index].phoneNo);
                                      Navigator.pop(context);
                                      await UrlLauncher.launch('tel://+88${contacts[index].phoneNo.toString()}');
                                    },
                                    child: const Text('Call'),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Details(contactKey: contacts[index].name)));
                                    },
                                    child: const Text('View details'),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: primaryColor,
                                foregroundColor: appBarTextColor,
                                child: ClipOval(
                                  child: new SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: (_image==null)?Image.network(
                                      contacts[index].imageLink,
                                      fit: BoxFit.fill,
                                    ):Icon(Icons.camera_alt),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(contacts[index].name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  Text(contacts[index].designation, style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                                  Text(contacts[index].phoneNo, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddContact(hasContact: hasContact?true:false,uID: "",)));
          },
          label: Container(
            child: Row(
              children: <Widget>[
                Text(hasContact ? "Update Contact":"Add yours"),
                Icon(Icons.add),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
