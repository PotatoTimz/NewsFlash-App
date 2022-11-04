import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostOnline{
  String? userName;
  String? timeString;
  String? longDescription;
  String? shortDescription;
  String? imageURL;
  String? title;
  List<dynamic>? comments;

  int? numReposts;
  int? numLikes;
  int? numDislikes;

  DocumentReference? reference;

  PostOnline({this.userName, this.timeString, this.longDescription, this.imageURL, this.title, this.shortDescription, this.numLikes, this.numDislikes, this.numReposts, this.comments});

  PostOnline.fromMap(var map, {this.reference}){
    this.userName = map['userName'];
    this.timeString = map['timeString'];
    this.longDescription = map['longDescription'];
    this.shortDescription = map['shortDescription'];
    this.imageURL = map['imageURL'];
    this.title = map['title'];
    this.comments = map['comments'];
    this.numReposts = map['numReposts'];
    this.numLikes = map['numLikes'];
    this.numDislikes = map['numDislikes'];
  }

  Map<String, Object?> toMapOnline(){
    return{
      // 'name' : this.name,
      'userName' :this.userName,
      'timeString':this.timeString,
      'longDescription' :this.longDescription,
      'shortDescription':this.shortDescription,
      'imageURL':this.imageURL,
      'title' :this.title,
      'comments':this.comments,
      'numReposts' :this.numReposts,
      'numLikes':this.numLikes,
      'numDislikes':this.numDislikes,
    };
  }

  Map<String, Object?> toMapOffline(){
    return{
      // 'name' : this.name,
      'userName' :this.userName,
      'timeString':this.timeString,
      'longDescription' :this.longDescription,
      'shortDescription':this.shortDescription,
      'imageURL':this.imageURL,
      'title' :this.title,
    };
  }

  void addComment(newComment){
    comments?.add(newComment);
  }

  void deleteComment(commentIndex){
    comments?.removeAt(commentIndex);
  }

  void editComment(newComment, commentIndex){
    comments![commentIndex] = newComment;
  }

  @override
  String toString() {
    return "$shortDescription";
  }
}
