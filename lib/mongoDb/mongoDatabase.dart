import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:notes_db/mongoDb/constants.dart';
import 'package:notes_db/mongoDb/mongoDbModel.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    var arrNotes = await userCollection.find().toList();
    return arrNotes;
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.sucess) {
        return "Notes Inserted successfully";
      } else {
        return "Error while inserting";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static delete(MongoDbModel note) async {
    try {
      await userCollection.deleteOne({"id": note.id});
    } catch (e) {
      print(e.toString());
    }
  }
}
