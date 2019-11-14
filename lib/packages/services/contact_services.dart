import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:org_contact/packages/models/contactModel.dart';
import 'package:org_contact/packages/services/auth/auth.dart';

class ContactService{

  Future<bool> currentUserHasContact()async{
    Auth auth = Auth();
    String userID = await auth.getCurrentUser();
    var obj = FirebaseDatabase.instance
        .reference().child("contacts")
        .orderByChild("uID")
        .equalTo(userID).once().then((DataSnapshot value) {
          if(value.value==null){
            return false;
          }
          else{
            return true;
          }
    });
    return await obj;

  }
  Future<DataSnapshot> getCurrentUserContactDetails()async{
    Auth auth = Auth();
    String userID = await auth.getCurrentUser();
    var obj = FirebaseDatabase.instance
        .reference().child("contacts")
        .orderByChild("uID")
        .equalTo(userID).once().then((DataSnapshot value) {
        return value;
    });
    return await obj;

  }
  Future<String> getUserContactKey()async{
    Auth auth = Auth();
    String userID = await auth.getCurrentUser();
    var obj = FirebaseDatabase.instance
        .reference().child("contacts")
        .orderByChild("uID")
        .equalTo(userID).once().then((DataSnapshot snapshot) {
      return snapshot.key;
    });
    return await obj;

  }
  Future<DataSnapshot> getOtherUserContactDetails(String name)async{
    var obj = FirebaseDatabase.instance
        .reference().child("contacts")
        .orderByChild("name")
        .equalTo(name).once().then((DataSnapshot contactSnapshot) {
      return contactSnapshot;
    });
    return await obj;

  }
  Future<String> getUserImage()async{
    Auth auth = Auth();
    String userID = await auth.getCurrentUser();
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("imageFiles").child(userID);
    return await firebaseStorageRef.getDownloadURL();
  }
  Future<String> getUserImageList()async{
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("imageFiles");

    return "";
  }
  void deleteUserContact()async{
    String snapShotKeyToDel;
    Auth auth = Auth();
    String userID = await auth.getCurrentUser();
    var obj = await FirebaseDatabase.instance
        .reference().child("contacts")
        .orderByChild("uID")
        .equalTo(userID).once().then((DataSnapshot snapshot) {
      Map map = snapshot.value;
      snapShotKeyToDel = map.keys.toList()[0].toString();
      return snapShotKeyToDel;
    });
    FirebaseDatabase.instance.reference()
        .child("contacts").child(obj).remove();
  }
}