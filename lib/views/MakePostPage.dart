import 'package:flutter/material.dart';
import 'package:groupproject/models/PostOnline.dart';
import 'package:provider/provider.dart';

class CreatePostWidget extends StatefulWidget {
  const CreatePostWidget({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<CreatePostWidget> createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  var formKey = GlobalKey<FormState>();

  String? userName = '';      //temp
  String? longDescription = '';
  String? title = '';
  String? imageURL = '';
  String? timeString = '';
  String? shortDecription = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:Text(widget.title!)),
      body: Form(
        key: formKey,
        child: Column(
          children: [

            TextFormField(
              decoration: const InputDecoration(
                  labelText: "User Name"
              ),
              onChanged: (value){
                userName = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Title"
              ),
              onChanged: (value){
                title = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Long Description"
              ),
              onChanged: (value){
                longDescription = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Short Description"
              ),
              onChanged: (value){
                shortDecription = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "imageURL"
              ),
              onChanged: (value){
                imageURL = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Time"
              ),
              onChanged: (value){
                timeString = value;
              },
            ),

            ElevatedButton(
                onPressed:(){
                  PostOnline newPost = PostOnline(
                    userName: userName,
                    timeString: timeString,
                    longDescription: longDescription,
                    imageURL: imageURL,
                    title: title,
                    shortDescription: shortDecription,
                    numReposts: 0,
                    numLikes: 0,
                    numDislikes: 0,
                    comments: [],
                  );
                  Navigator.of(context).pop(newPost);
                },
                child: Text("Create Post"))
          ],
        ),
      ),
    );
  }
}
