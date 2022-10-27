import 'package:flutter/material.dart';
import 'package:groupproject/models/Post.dart';
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
  String? description = '';
  String? title = '';
  String? imageURL = '';
  String? timeString = '';

  @override
  Widget build(BuildContext context) {

    PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context);

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
                  labelText: "Description"
              ),
              onChanged: (value){
                description = value;
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
                  Post newPost = Post(
                    userName: userName,
                    timeString: timeString,
                    description: description,
                    imageURL: imageURL,
                    title: title
                  );
                  postsListBLoC.addPost(newPost);
                  Navigator.of(context).pop(newPost);
                },
                child: Text("Create Post"))
          ],
        ),
      ),
    );
  }
}
