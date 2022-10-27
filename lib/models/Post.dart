import 'package:flutter/material.dart';

class Post{
  String? userName;
  String? timeString;
  String? description;
  String? imageURL;
  String? title;
  //CommentPage
  // List<Comment> = [];

  int numComments = 0;
  int numReposts = 0;
  int numLikes = 0;
  int numDislikes = 0;

  Post({this.userName, this.timeString, this.description, this.imageURL, this.title});

  @override
  String toString() {
    return "$userName";
  }
}

class PostsListBLoC with ChangeNotifier{
  List<Post> _posts = [
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        description:
        "Lambda calculus (also written as λ-calculus) is a formal system in mathematical logic for expressing computation based on function abstraction and application using variable binding and substitution. It is a universal model of computation that can be used to simulate any Turing machine.",
        imageURL:
        "https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/40377/square_thumb%402x.jpg",
        title: "Test Title MUST BE VERY LONG"),
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        description:
        "words words words words words words words words words words words words",
        imageURL:
        "https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/40377/square_thumb%402x.jpg",
        title: "Test Title"),
  ];

  List<Post> get posts => _posts;

  set posts(newPostList){
    _posts = newPostList;
    notifyListeners();
  }
  addPost(newPost){
    _posts.add(newPost);
    notifyListeners();
  }
}
