import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
abstract class BaseAuth {

  Future<String> getCurrentUser();
  Future<String> userAuthentication(String email, String password);
  Future<String> userRegistration(String email, String password);
  Future<void> signOut();
}
class Auth implements BaseAuth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> userRegistration(String email, String pass)async {

    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);

    return user.uid;
  }
  Future<String> userAuthentication(String email, String pass)async {

    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);

    return user.uid;
  }
  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}