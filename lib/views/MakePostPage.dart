import 'package:flutter/material.dart';
import 'package:groupproject/models/PostOnline.dart';
import 'package:provider/provider.dart';
/*Sources:
Stopped overflow error: https://www.geeksforgeeks.org/flutter-pixels-overflow-error-while-launching-keyboard/#:~:text=Solution%20%3A,the%20entire%20UI%20is%20centered.
Date format: https://stackoverflow.com/questions/51579546/how-to-format-datetime-in-flutter
*/
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
        child: SingleChildScrollView(
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

                ElevatedButton(
                    onPressed:(){
                      String? postTime = formatTime();
                      timeString = postTime;
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
                      var snackBar = const SnackBar(
                          duration: Duration(seconds: 1), content: Text("Article Posted!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pop(newPost);
                    },
                    child: Text("Create Post")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? formatTime() {
    DateTime now = DateTime.now();
    String dayHalf = "";
    int adjustedHour = now.hour;
    String? adjustedMinute = now.minute.toString();
    String? adjustedSecond = now.second.toString();
    if (adjustedHour >= 12)
      {
        dayHalf = "pm";
        if (adjustedHour != 12)
          {
            adjustedHour -= 12;
          }
      }
    else
      {
        dayHalf = "am";
        if (adjustedHour == 0)
          {
            adjustedHour += 12;
          }
      }
    if (now.minute < 10)
      {
        adjustedMinute = "0$adjustedMinute";
      }
    if (now.second < 10)
      {
        adjustedSecond = "0$adjustedSecond";
      }
    return "${now.day}-${now.month}-${now.year} at $adjustedHour:$adjustedMinute:$adjustedSecond$dayHalf";
  }
}
