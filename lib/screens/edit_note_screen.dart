import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../services/firestore_service.dart';
import '../widgets/scaffold_message.dart';

class EditNoteScreen extends StatefulWidget {
  final String docsid;
  final NoteModel note;

  const EditNoteScreen({Key? key, required this.docsid, required this.note})
      : super(key: key);
  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text('Are you sure to delete the note?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          FirestoreService.deleteNote(widget.docsid);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No')),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: descriptionController,
                minLines: 5,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: loading
          ? const CircularProgressIndicator()
          : FloatingActionButton(
              onPressed: () async {
                if (titleController.text == "" ||
                    descriptionController.text == "") {
                  Utils.customMessage(
                      context, "All fields are required!", Colors.redAccent);
                } else {
                  setState(() {
                    loading = true;
                  });
                  await FirestoreService.updateNote(titleController.text,
                      descriptionController.text, widget.docsid);
                  setState(() {
                    loading = false;
                  });
                }
                Navigator.pop(context);
              },
              child: const Icon(Icons.save),
            ),
    );
  }
}
