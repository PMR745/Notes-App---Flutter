import 'package:flutter/material.dart';
import 'package:notes_db/mongoDb/mongoDatabase.dart';
import 'package:notes_db/mongoDb/mongoDbModel.dart';
import 'package:notes_db/pages/add_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "Notes App",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            FutureBuilder(
                future: MongoDatabase.getNotes(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return displayCard(
                                MongoDbModel.fromJson(snapshot.data[index]));
                          });
                    } else {
                      return Text("No Notes Available");
                    }
                  }
                }),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddNote()),
                  ).then((value) {
                    setState(() {});
                  });
                },
                child: const Text("Add Notes")),
          ],
        ),
      ),
    );
  }

  Widget displayCard(MongoDbModel note) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            title: Text("${note.title}"),
            subtitle: Text(
              "${note.description}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              onPressed: () {
                MongoDatabase.delete(note);
                setState(() {});
              },
              icon: const Icon(Icons.delete),
            ),
          )),
    );
  }
}
