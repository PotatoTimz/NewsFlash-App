import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
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

  Post({this.userName, this.timeString, this.longDescription, this.imageURL, this.title, this.shortDescription, this.numLikes, this.numDislikes, this.numReposts, this.comments});

  Post.fromMap(var map, {this.reference}){
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

  Map<String, Object?> Tomap(){
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


  @override
  String toString() {
    return "$shortDescription";
  }
}

class PostsListBLoC with ChangeNotifier{
  List<Post> _posts = [
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        longDescription:
        "Lambda calculus (also written as λ-calculus) is a formal system in mathematical logic for expressing computation based on function abstraction and application using variable binding and substitution. It is a universal model of computation that can be used to simulate any Turing machine.",
        imageURL:
        "https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/40377/square_thumb%402x.jpg",
        title: "Test Title MUST BE VERY LONG",
        shortDescription: "this small article is about lambda calculus!this small article is about lambda calculus!this small article is about lambda calculus!this small article is about lambda calculus!",
        comments: ["I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that"],
        numLikes: 0, numDislikes: 0, numReposts: 0),
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        longDescription:
        "When Mr. Bilbo Baggins of Bag End announced that he would shortly be celebrating his eleventy-first birthday with a party of special magnificence, there was much talk and excitement in Hobbiton.Bilbo was very rich and very peculiar, and had been the wonder of the Shire for sixty years, ever since his remarkable disappearance and unexpected return. The riches he had brought back from his travels had now become a local legend, and it was popularly believed, whatever the old folk might say, that the Hill at Bag End was full of tunnels stuffed with treasure. And if that was not enough for fame, there was also his prolonged vigour to marvel at. Time wore on, but it seemed to have little effect on Mr. Baggins. At ninety he was much the same as at fifty. At ninety-nine they began to call him well-preserved ; but unchanged would have been nearer the mark. There were some that shook their heads and thought this was too much of a good thing; it seemed unfair that anyone should possess (apparently) perpetual youth as well as (reputedly) inexhaustible wealth.It will have to be paid for, they said. It isn’t natural, and trouble will come of it!But so far trouble had not come and as Mr. Baggins was generous with his money, most people were willing to forgive him his oddities and his good fortune. He remained on visiting terms with his relatives (except, of course, the Sackville-Bagginses), and he had many devoted admirers among the hobbits of poor and unimportant families. But he had no close friends, until some of his younger cousins began to grow up.The eldest of these, and Bilbo’s favourite, was young Frodo Baggins. When Bilbo was ninety-nine he adopted Frodo as his heir, and brought him to live at Bag End; and the hopes of the Sackville-Bagginses were finally dashed. Bilbo and Frodo happened to have the same birthday, September 22nd. ‘You had better come and live here, Frodo my lad,’ said Bilbo one day; ‘and then we can celebrate our birthday-parties comfortably together.’ At that time Frodo was still in his tweens, as the hobbits called the irresponsible twenties between childhood and coming of age at thirty-three.Twelve more years passed. Each year the Bagginses had given very lively combined birthday-parties at Bag End; but now it was understood that something quite exceptional was being planned for that autumn. Bilbo was going to be eleventy-one , 111, a rather curious number, and a very respectable age for a hobbit (the Old Took himself had only reached 130); and Frodo was going to be thirty-three , 33, an important number: the date of his ‘coming of age’.Tongues began to wag in Hobbiton and Bywater and rumour of the coming event travelled all over the Shire. The history and character of Mr. Bilbo Baggins became once again the chief topic of conversation; and the older folk suddenly found their reminiscences in welcome demand.",
        imageURL:
        "https://i.harperapps.com/covers/9780008108298/y648.jpg",
        title: "Test Title",
        shortDescription: "The Lord of the Rings is the saga of a group of sometimes reluctant heroes who set forth to save their world from consummate evil. Its many worlds and creatures were drawn from Tolkien’s extensive knowledge of philology and folklore.",
        comments: ["I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that"],
        numLikes: 0, numDislikes: 0, numReposts: 0),
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        longDescription:
        "words words words words words words words words words words words words",
        imageURL:
        "https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/40377/square_thumb%402x.jpg",
        title: "Test Title",
        shortDescription: "ok this is a short description",
        comments: ["I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that"],
        numLikes: 0, numDislikes: 0, numReposts: 0),
    Post(
        userName: "Mr.man",
        timeString: "3hr",
        longDescription:
        "words words words words words words words words words words words words",
        imageURL:
        "https://d26oc3sg82pgk3.cloudfront.net/files/media/edit/image/40377/square_thumb%402x.jpg",
        title: "Test Title",
        shortDescription: "ok this is a short description",
        comments: ["I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that","I want to rock and roll night and party everyday!", "wow what an informative post thanks for that"],
        numLikes: 0, numDislikes: 0, numReposts: 0),
  ];

  List<Post> get posts => _posts;

  set posts(newPostList){
    _posts = newPostList;
    notifyListeners();
  }

  removePost(index){
    _posts.removeAt(index);
    notifyListeners();
  }

  addPost(newPost){
    _posts.add(newPost);
    notifyListeners();
  }

  updatePost(index, newPost){
    _posts[index] = newPost;
    notifyListeners();
  }

  addComment(index, comment){
    _posts[index].comments?.add(comment);
    notifyListeners();
  }

}
