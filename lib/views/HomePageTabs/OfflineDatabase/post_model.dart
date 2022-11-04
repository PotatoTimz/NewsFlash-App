
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import '../../../models/PostOffline.dart';
import 'db_utils.dart';

class PostModel {
  Future<int> insertPosts(PostOffline post) async{

    final db = await DBUtils.init();
    // print("model : $grade");
    // print(grade.toMap());
    return db.insert(
      'downloaded_posts_manager',
      post.toMapOffline(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deletePostByID(int id) async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtils.init();
    return db.delete(
      'downloaded_posts_manager',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updatePost(PostOffline post) async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtils.init();
    return db.update(
      'downloaded_posts_manager',
      post.toMapOffline(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }


  Future getAllPosts() async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtils.init();
    final List maps = await db.query('downloaded_posts_manager');
    List<PostOffline> result = [];
    for (int i = 0; i < maps.length; i++){
      result.add(
          PostOffline.fromMap(maps[i])
      );
    }
    return result;
  }

}