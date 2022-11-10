import 'package:flutter/material.dart';
import 'package:groupproject/models/PostOnline.dart';
import 'package:provider/provider.dart';

//TODO: Username should eventually be automatically filled in via the username that the user is currently logged in with.
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
        child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Author",
                    hintText: "Enter your Username here",
                  ),
                  onChanged: (value){
                    userName = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Headline",
                      hintText: "Enter the title of your article"
                  ),
                  onChanged: (value){
                    title = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Subtitle",
                      hintText: "Enter the subtitle of your article"

                  ),
                  onChanged: (value){
                    shortDecription = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Body",
                      hintText: "Here is the body of your article"
                  ),
                  onChanged: (value){
                    longDescription = value;
                  },
                ),
                //TODO: Captions for the images
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Image",
                      hintText: "Enter a Valid URL for an image"
                  ),
                  onChanged: (value){
                    imageURL = value;
                  },
                ),
                //TODO: Set time to datetime.now() so it's automatically showed
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
                    child: Text("Create Post")
                ),
              ],
            ),
        ),
      ),
    );
  }
}
