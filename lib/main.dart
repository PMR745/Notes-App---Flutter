import 'package:flutter/material.dart';
import 'package:notes_db/mongoDb/mongoDatabase.dart';
import 'package:notes_db/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}
