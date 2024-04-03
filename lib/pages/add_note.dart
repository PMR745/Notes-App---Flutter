import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:notes_db/mongoDb/mongoDatabase.dart';
import 'package:notes_db/mongoDb/mongoDbModel.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: titleController,
                style: TextStyle(fontSize: 28),
                decoration: InputDecoration(
                  hintText: "Title",
                ),
              ),
              TextField(
                controller: descriptionController,
                style: TextStyle(fontSize: 22),
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Description",
                  border: InputBorder.none,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _insertData(
                        titleController.text, descriptionController.text);
                  },
                  child: const Text("Add Note")),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _insertData(String title, String description) async {
    var _id = M.ObjectId();
    final data = MongoDbModel(id: _id, title: title, description: description);

    var result = await MongoDatabase.insert(data);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted Id: " + _id.oid)));

    Navigator.pop(context);
  }
}
