//temporary
import 'package:flutter/material.dart';

class CreateCommentPage extends StatefulWidget {
  const CreateCommentPage({Key? key}) : super(key: key);

  @override
  State<CreateCommentPage> createState() => _CreateCommentPageState();
}

class _CreateCommentPageState extends State<CreateCommentPage> {

  var formKey = GlobalKey<FormState>();

  String? comment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add a Comment"),),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "New Comment"
              ),
              onChanged: (value){
                comment = value;
              },
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop(comment);
                },
                child: Text("Post comment")
            )
          ],
        ),
      ),
    );
  }
}
