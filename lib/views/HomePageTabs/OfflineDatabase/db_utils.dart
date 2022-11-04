import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils{
  static Future init() async{
    //set up the database
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'downloaded_posts_manager.db'),
      onCreate: (db, version){
        db.execute(
            'CREATE TABLE downloaded_posts_manager(id INTEGER PRIMARY KEY, userName TEXT, timeString TEXT, longDescription TEXT, shortDescription TEXT, imageURL TEXT, title TEXT)'
        );
      },
      version: 1,
    );

    print("Created DB $database");
    return database;
  }
}