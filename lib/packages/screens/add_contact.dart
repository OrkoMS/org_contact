import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:org_contact/packages/models/contactModel.dart';
import 'package:org_contact/packages/screens/home_screen.dart';
import 'package:org_contact/packages/services/auth/auth.dart';
import 'package:org_contact/packages/services/common/colors.dart';
import 'package:org_contact/packages/services/contact_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddContact extends StatefulWidget {
  final bool hasContact;
  final String uID;
  AddContact({Key key,this.hasContact,this.uID}):super(key:key);
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final _formKey = GlobalKey<FormState>();
  String userKey;
  final uID= TextEditingController();
  final name= TextEditingController();
  final phoneNo= TextEditingController();
  final companyName= TextEditingController();
  final designation= TextEditingController();
  final telephoneNo= TextEditingController();
  final email= TextEditingController();
  final webLink= TextEditingController();
  final imageLink= TextEditingController();
  Contact contact;
  ContactService cService = ContactService();
  DatabaseReference contactRef;
  File _image;
  String imageUrl="";

  bindControllerText()async{
    DataSnapshot contactSnapshot = await cService.getCurrentUserContactDetails();
    var keys = contactSnapshot.value.keys;

    var data = contactSnapshot.value;
    for (var key in keys) {
          userKey = key;
          uID.text=data[key]["uID"];
          name.text=data[key]["name"];
          phoneNo.text=data[key]["phoneNo"];
          companyName.text=data[key]["companyName"];
          designation.text=data[key]["designation"];
          telephoneNo.text=data[key]["telephoneNo"];
          email.text=data[key]["email"];
          webLink.text=data[key]["webLink"];
          imageLink.text=data[key]["imageLink"];
    }
    imageUrl =await cService.getUserImage();
    setState(() {
      imageUrl=imageUrl;
      imageLink.text=imageUrl;
    });
  }
  @override
  void initState() {
    super.initState();
    //contact =Contact("","","","","","","","","");
    if(widget.hasContact==true){
      bindControllerText();
    }

    final FirebaseDatabase database = FirebaseDatabase.instance;
    contactRef = database.reference().child("contacts");
  }
  @override
  Widget build(BuildContext context) {
    Future uploadPic() async{
      Auth auth =Auth();
      String fileName = await auth.getCurrentUser(); //basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("imageFiles").child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot =await uploadTask.onComplete;
      imageUrl="";
      imageUrl =await cService.getUserImage();
      setState(() {
        imageLink.text = imageUrl;
      });
    }
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        uploadPic();
      });
    }


    TextFormField inputName = TextFormField(
      controller: name,
      autofocus: true,
      onSaved: (val) => contact.name = val,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Name',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Empty';
        }
        return null;
      },
    );


    TextFormField inputPhoneNumber = new TextFormField(
      controller: phoneNo,
      maxLength: 16,
      keyboardType: TextInputType.phone,
      onSaved: (val) => contact.phoneNo = val,
      decoration: new InputDecoration(
        labelText: "Mobile No.",
        icon: Icon(Icons.phone),
      ),
    );
    TextFormField inputCompanyName = TextFormField(
      controller: companyName,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      onSaved: (val) => contact.companyName = val,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Company',
        icon: Icon(Icons.airport_shuttle),
      ),
    );

    TextFormField inputDesignation = TextFormField(
      controller: designation,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      onSaved: (val) => contact.designation = val,
      decoration: InputDecoration(
        labelText: 'Designation',
        icon: Icon(Icons.work),
      ),
    );
    TextFormField inputTelephoneNumber = new TextFormField(
      controller: telephoneNo,
      maxLength: 16,
      keyboardType: TextInputType.phone,
      onSaved: (val) => contact.telephoneNo = val,
      decoration: new InputDecoration(
        labelText: "Telephone No.",
        icon: Icon(Icons.phone),
      ),
    );
    TextFormField inputEmail = TextFormField(
      controller: email,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.emailAddress,
      onSaved: (val) => contact.email = val,
      decoration: InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
      ),
    );
    TextFormField inputWebSite = TextFormField(
      controller: webLink,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      onSaved: (val) => contact.webLink = val,
      decoration: InputDecoration(
        labelText: 'Website',
        icon: Icon(Icons.web),
      ),
    );
    TextFormField inputImageLink = TextFormField(
      controller: imageLink,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      onSaved: (val) => contact.imageLink = val,
      decoration: InputDecoration(
        labelText: 'Image Link',
        icon: Icon(Icons.image),
      ),
    );

    final picture = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            getImage();
          },
          child: Container(
            width: 120.0,
            height: 120.0,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: primaryColor,
              foregroundColor: appBarTextColor,
              child: ClipOval(
                child: new SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: (_image!=null)?Image.file(
                    _image,
                    fit: BoxFit.fill,
                  ):widget.hasContact?Image.network(imageUrl.toString(),fit: BoxFit.fill,):Icon(Icons.camera_alt),

                ),
              ),
            ),
          ),
        ),
      ],
    );

    ListView content = ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        SizedBox(height: 20),
        picture,
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[

              inputName,
              inputPhoneNumber,
              inputCompanyName,
              inputDesignation,
              inputTelephoneNumber,
              inputEmail,
              inputWebSite,
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Contact"),
        actions: <Widget>[
          Container(
            width: 80,
            child: IconButton(
              icon: Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () async{
                final FormState form = _formKey.currentState;
                Auth auth = Auth();
                String userUID= await auth.getCurrentUser();
                if (form.validate()) {
                  contact = Contact(
                      userUID,
                      name.text,
                      phoneNo.text,
                      companyName.text,
                      designation.text,
                      telephoneNo.text,
                      email.text,
                      webLink.text,
                      imageUrl);

                  form.save();


                 if(widget.hasContact){
                   await contactRef.child(userKey).set(contact.toJson());
                  }
                  else{
                   await contactRef.push().set(contact.toJson());
                  }
                }

                Navigator.of(context).pop();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
          )
        ],
      ),
      body: content,
    );
  }
}