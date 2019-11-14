import 'package:firebase_database/firebase_database.dart';

class Contact {
  String key;
  String uID;
  String name;
  String phoneNo;
  String companyName;
  String designation;
  String telephoneNo;
  String email;
  String webLink;
  String imageLink;

  Contact(
      this.uID,
      this.name,
      this.phoneNo,
      this.companyName,
      this.designation,
      this.telephoneNo,
      this.email,
      this.webLink,
      this.imageLink,
      );

  Contact.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        uID = snapshot.value["uID"],
        name = snapshot.value["name"],
        phoneNo = snapshot.value["phoneNo"],
        companyName = snapshot.value["companyName"],
        designation = snapshot.value["designation"],
        telephoneNo = snapshot.value["telephoneNo"],
        email = snapshot.value["email"],
        webLink = snapshot.value["webLink"],
        imageLink = snapshot.value["imageLink"];

  toJson() {
    return {
      "uID": uID,
      "name": name,
      "phoneNo": phoneNo,
      "companyName": companyName,
      "designation": designation,
      "telephoneNo": telephoneNo,
      "email": email,
      "webLink": webLink,
      "imageLink": imageLink,
    };
  }
}