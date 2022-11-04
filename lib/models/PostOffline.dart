import 'package:flutter/material.dart';

class PostOffline{

  String? userName;
  String? timeString;
  String? longDescription;
  String? shortDescription;
  String? imageURL;
  String? title;

  int? id;

  PostOffline({this.userName, this.timeString, this.longDescription, this.imageURL, this.title, this.shortDescription, this.id});

  Map<String, Object?> toMapOffline(){
    return{
      // 'name' : this.name,
      'userName' :this.userName,
      'timeString':this.timeString,
      'longDescription' :this.longDescription,
      'shortDescription':this.shortDescription,
      'imageURL':this.imageURL,
      'title' :this.title,
      'id':this.id,
    };
  }

  PostOffline.fromMap(Map map){
    this.userName = map['userName'];
    this.timeString = map['timeString'];
    this.longDescription = map['longDescription'];
    this.shortDescription = map['shortDescription'];
    this.imageURL = map['imageURL'];
    this.title = map['title'];
    this.id = map['id'];
  }

  String toString(){
    return "$id : $userName";
  }

}

class PostsListBLoC with ChangeNotifier{
  List<PostOffline> _posts = [
    PostOffline(),
  ];

  List<PostOffline> get posts => _posts;

  set posts(newPostList){
    _posts = newPostList;
    notifyListeners();
  }

  removePost(index){
    print(index);
    _posts.removeAt(index);
    notifyListeners();
  }

  addPost(newPost){
    _posts.add(newPost);
    notifyListeners();
  }


}
