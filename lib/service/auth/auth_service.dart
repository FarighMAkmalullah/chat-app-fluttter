import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  //instance of auth
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //get user yang login
  User? getCurrentUser() {
    return _firebaseauth.currentUser;
  }

  //sign in
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseauth
          .signInWithEmailAndPassword(email: email, password: password);

      //Membuat jika user belum masuk database
      _firebaseFirestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign out

  Future<void> signOut() async {
    return await _firebaseauth.signOut();
  }

  // sign up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      //membuat user
      UserCredential userCredential = await _firebaseauth
          .createUserWithEmailAndPassword(email: email, password: password);

      // mengambil unfo user di beda dokumen / memasukan di firestore database

      _firebaseFirestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
