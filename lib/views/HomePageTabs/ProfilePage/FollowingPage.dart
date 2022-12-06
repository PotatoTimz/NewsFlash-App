//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:groupproject/models/Polls.dart';
import 'package:groupproject/views/HomePageTabs/ProfilePage/ProfilePageBuilder.dart';

import '../../../models/Account.dart';


class FollowingPage extends StatefulWidget {


  FollowingPage({Key? key}) : super(key: key);



  @override
  State<FollowingPage> createState() => _FollowingePageState();
}

var followinglist = ["user1","user2","user3","user4","user5",];

class _FollowingePageState extends State<FollowingPage> {
  var formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProfileArguments;

    int? fol = args.loggedInUser?.following;

    //final un = args.username;
    //final pw = args.password;
    int i = 100;
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"),),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [

          for (int i=0; i<followinglist.length; i++)
            ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [Text(followinglist[i],style: TextStyle(fontSize: 20)),
                  IconButton(icon: Icon(Icons.delete,size: 20,),onPressed: ()=> {deleteuser(i),args.loggedInUser?.following =  followinglist.length,Navigator.of(context).pop(),
                    Navigator.pushNamed(
                        context, '/followinglist', arguments: ProfileArguments(
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

  deleteuser(index) async{


    followinglist.removeAt(index);
    print(index);
    print(followinglist);


  }




}
