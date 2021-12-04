import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../screens/edit_note_screen.dart';


class NoteItem extends StatelessWidget {
  final NoteModel noteModel;
  final String docsid;

  const NoteItem({Key? key, required this.noteModel, required this.docsid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(noteModel.title),
        subtitle: Text(noteModel.description),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNoteScreen(
                docsid: docsid,
                note: noteModel,
              ),
            ),
          );
        },
      ),
    );
  }
}
