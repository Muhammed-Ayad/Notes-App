import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
 static final _firestore = FirebaseFirestore.instance;

static  Future insertNote(String title, String description, String userId) async {
    try {
      await _firestore.collection('notes').add({
        "title": title,
        "description": description,
        "userId": userId
      });
    } catch (e) {
      log(e.toString());
    }
  }

 static Future updateNote(String title, String description, String docId) async {
    try {
      await _firestore.collection('notes').doc(docId).update({
        "title": title,
        "description": description,
      });
    } catch (e) {
      log(e.toString());
    }
  }

 static Future deleteNote(String docId) async {
    try {
      await _firestore.collection('notes').doc(docId).delete();
    } catch (e) {
      log(e.toString());
    }
  }
}
