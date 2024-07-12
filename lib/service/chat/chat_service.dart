import 'package:chat_application/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  //mendapatkan instace firestore dan mendapatkan auh
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //mendapatkan user stream / mendapatkan semua data user
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((e) {
        //untuk go setiap individual user
        final user = e.data();
        return user;
      }).toList();
    });
  }

  //mengirim pesan
  Future<void> sendMessege(String receiverID, message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new messege
    Message newMeggage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    // construct chat room ID for the two user ( sorted to ensure uniqueness )
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomID = ids.join("_");
    //  add new messege to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("message")
        .add(newMeggage.toMap());
  }
  //mendapatkan pesan

  Stream<QuerySnapshot> getMessage(String userID, otherUserID) {
    // construct a chatroom ID for this two users
    List<String> ids = [userID, otherUserID];

    ids.sort();
    String chatRoomID = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
