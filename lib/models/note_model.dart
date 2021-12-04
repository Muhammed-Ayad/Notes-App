import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String title;
  final String description;
  final String userId;

  NoteModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.userId});

  factory NoteModel.fromJson(DocumentSnapshot snapshot) {
    return NoteModel(
      id: snapshot.id,
      title: snapshot['title'],
      description: snapshot['description'],
      userId: snapshot['userId'],
    );
  }
}
