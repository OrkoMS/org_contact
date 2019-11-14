import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:org_contact/packages/models/contactModel.dart';
import 'package:org_contact/packages/services/common/colors.dart';
import 'package:org_contact/packages/services/contact_services.dart';

class Details extends StatefulWidget {
  final String contactKey;
  BuildContext contextB;
  Details({Key key,
    this.contactKey,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  ContactService cService = ContactService();
  Contact contact =new Contact("", "", "", "", "", "", "", "", "");
  bindFieldText()async{
    DataSnapshot contactSnapshot = await cService.getOtherUserContactDetails(widget.contactKey);
    var keys = contactSnapshot.value.keys;
    var data = contactSnapshot.value;
    for (var key in keys) {
      contact = Contact(
          "",
          data[key]["name"],
          data[key]["phoneNo"],
          data[key]["companyName"],
          data[key]["designation"],
          data[key]["telephoneNo"],
          data[key]["email"],
          data[key]["webLink"],
          data[key]["imageLink"]);
    }

    build(widget.contextB);
    //print(contactSnapshot.value);
  }
  @override
  void initState() {
    super.initState();
    bindFieldText();
  }

  @override
  Widget build(BuildContext context) {
    widget.contextB=context;
        return Scaffold(
          body: FutureBuilder(
              future: cService.getOtherUserContactDetails(widget.contactKey),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return Container(
                    child: Center(
                      child: Text("Something went wrong", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: primaryColor),),
                    ),
                  );
                }
                else if(snapshot.hasData){
                  return Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        title: Text("Contact Details",style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 20
                        ),),
                        backgroundColor: primaryColor,
                      ),
                      body: Container(
                        color: listBgColor,
                        height: MediaQuery.of(context).size.height,
                        child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  //color: const Color(0xFF66BB6A),
                                    boxShadow: [BoxShadow(
                                        color: shadowColor,
                                        spreadRadius: -28,
                                        blurRadius: 5.0
                                    ),]
                                ),
                                child: Card(
                                  margin: EdgeInsets.only(left:30.0,right: 30.0,top: 30.0),
                                  //elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height/1.24,
                                    padding: EdgeInsets.all(10),
                                    //padding: EdgeInsets.all(16.0),
                                    child: ListView(
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(16.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 12.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 50,
                                                          backgroundColor: primaryColor,
                                                          foregroundColor: appBarTextColor,
                                                          child: ClipOval(
                                                            child: new SizedBox(
                                                              width: 200.0,
                                                              height: 200.0,
                                                              child: Image.network(contact.imageLink,fit: BoxFit.fill,),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(width: 10,height: 10,color: appBarColor,),
                                                            SizedBox(width: 5,),
                                                            Text("Name",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 16.0,
                                                                fontFamily: 'Montserrat',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Text(contact.name,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16.0,
                                                            fontFamily: 'Montserrat',
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  //Divider(color: Colors.black54, height: 1.0, indent: 0.0,),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 12.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Container(width: 10,height: 10,color: appBarColor,),
                                                            SizedBox(width: 5,),
                                                            Text("Phone number",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 16.0,
                                                                fontFamily: 'Montserrat',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Text(contact.phoneNo,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16.0,
                                                            fontFamily: 'Montserrat',
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox(height: 5,),
                                                  //Divider(color: Colors.black54, height: 1.0, indent: 0.0,),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 12.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Container(width: 10,height: 10,color: appBarColor,),
                                                            SizedBox(width: 5,),
                                                            Text("Organization",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 16.0,
                                                                fontFamily: 'Montserrat',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Text(contact.companyName,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16.0,
                                                            fontFamily: 'Montserrat',
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  //Divider(color: Colors.black54, height: 1.0, indent: 0.0,),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 12.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Container(width: 10,height: 10,color: appBarColor,),
                                                            SizedBox(width: 5,),
                                                            Text("Name",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 16.0,
                                                                fontFamily: 'Montserrat',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Text(contact.name,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16.0,
                                                            fontFamily: 'Montserrat',
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                      ],
                                                    ),
                                                  ),SizedBox(height: 5,),
                                                  //Divider(color: Colors.black54, height: 1.0, indent: 0.0,),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 12.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Container(width: 10,height: 10,color: appBarColor,),
                                                            SizedBox(width: 5,),
                                                            Text("Designation",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 16.0,
                                                                fontFamily: 'Montserrat',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Text(contact.designation,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16.0,
                                                            fontFamily: 'Montserrat',
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  //Divider(color: Colors.black54, height: 1.0, indent: 0.0,),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 12.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Container(width: 10,height: 10,color: appBarColor,),
                                                            SizedBox(width: 5,),
                                                            Text("Email",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 16.0,
                                                                fontFamily: 'Montserrat',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Text(contact.email,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16.0,
                                                            fontFamily: 'Montserrat',
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  //Divider(color: Colors.black54, height: 1.0, indent: 0.0,),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 12.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Container(width: 10,height: 10,color: appBarColor,),
                                                            SizedBox(width: 5,),
                                                            Text("Website",
                                                              style: TextStyle(
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 16.0,
                                                                fontFamily: 'Montserrat',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Text(contact.webLink,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16.0,
                                                            fontFamily: 'Montserrat',
                                                          ),
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ),
                      )
                  );
                }
                else{
                  return Container(
                      child:Center(
                        child: CircularProgressIndicator(),
                      )
                  );
                }
                //return snapshot.hasData ? Notice(meetings: snapshot.data):Center(child: CircularProgressIndicator());
              }),
        );
  }
}