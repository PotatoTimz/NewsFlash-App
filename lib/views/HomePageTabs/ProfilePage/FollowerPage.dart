//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:groupproject/models/Polls.dart';
import 'package:groupproject/views/HomePageTabs/ProfilePage/ProfilePageBuilder.dart';

import '../../../models/Account.dart';

class FollowerPage extends StatefulWidget {
  FollowerPage({Key? key}) : super(key: key);

  @override
  State<FollowerPage> createState() => _FollowerPageState();
}

var followerlist = ["followeruser1","followeruser2","followeruser3","followeruser4","followeruser5",];

class _FollowerPageState extends State<FollowerPage> {
  var formKey = GlobalKey<FormState>();

  //Function that displays accounts that follow user
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProfileArguments;

    int? fol = args.loggedInUser?.followers;

    int i = 100;
    return Scaffold(
      appBar: AppBar(title: const Text("Follower List"),),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [

          for (int i=0; i<followerlist.length; i++)
            ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [Text(followerlist[i],style: TextStyle(fontSize: 20)),
                  IconButton(icon: Icon(Icons.delete,size: 20,),onPressed: ()=> {deleteuser(i),args.loggedInUser?.followers =  followerlist.length,Navigator.of(context).pop(),
                    Navigator.pushNamed(
                        context, '/followerlist', arguments: ProfileArguments(
                      args.loggedInUser,

                    )) })],
              ),],


          ElevatedButton.icon(
            onPressed: ()async{

              Navigator.of(context).pop();

            },
            label: Text('exit'),
            icon: Icon(

              Icons.exit_to_app,
              size: 24.0,
            ),

          ),


        ],
      ),
    );
  }

  //Function that removes a user from their follower list
  deleteuser(index) async{
    followerlist.removeAt(index);
    print(index);
    print(followerlist);

  }
}