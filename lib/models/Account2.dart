import 'package:cloud_firestore/cloud_firestore.dart';

class Account2{
  String? userName;
  String? password;
  String? email;
  int? numposts;
  int? following;
  int? followers;



  DocumentReference? reference;

  Account2({this.userName, this.password, this.email, this.numposts, this.following, this.followers});

  Account2.fromMap(var map, {this.reference}){
    this.followers = map['followers'];
    this.following = map['following'];
    this.numposts = map['numposts'];
    this.email = map['email'];
    this.password = map['password'];
    this.userName = map['username'];
  }

  Map<String, Object?> toMapOnline(){
    return{
      // 'name' : this.name,
      'followers' :this.followers,
      'following':this.following,
      'numposts' :this.numposts,
      'email':this.email,
      'password':this.password,
      'username' :this.userName,
    };
  }

  String toString(){
    return "$userName";
  }
}
