import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/Post.dart';
import 'OfflineHomeScreenBuilder.dart';

class PictureViewerBuilder extends StatefulWidget {
  const PictureViewerBuilder({Key? key}) : super(key: key);

  @override
  State<PictureViewerBuilder> createState() => _PictureViewerBuilderState();
}

class _PictureViewerBuilderState extends State<PictureViewerBuilder> {

  final fireBaseInstance = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: fireBaseInstance.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            print("Data is missing from buildGradeList");
            return CircularProgressIndicator();
          }
          else {
            print("Data Loaded!");
            return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2)
                    ,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      Post post = Post.fromMap(snapshot.data.docs[index].data(), reference: snapshot.data.docs[index].reference);
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        onDoubleTap: ()async{
                          setState(() {
                            selectedIndex = index;
                          });
                          var updatedPost = await Navigator.pushNamed(
                              context, '/commentPage',
                              arguments: {'post' : post}
                          );
                          updatePost(index, updatedPost);
                        },
                        child: Container(
                          decoration: BoxDecoration(color: selectedIndex != index ? Colors.white : Colors.black12 ),
                          padding: EdgeInsets.all(10),
                          child: Image.network(
                            "${post.imageURL}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }
                );
          }
    }
    );
    // return
  }

  Future updatePost(selectedIndex, updatedPost) async{
    QuerySnapshot querySnapshot = await fireBaseInstance.get();
    Post post =  Post.fromMap(querySnapshot.docs[selectedIndex].data(), reference: querySnapshot.docs[selectedIndex].reference);

    await FirebaseFirestore.instance.collection('posts').doc(post.reference?.id.toString()).set(updatedPost.Tomap());
  }

}

Future<void> goToCommentPage(context) async{
  var newPost = await Navigator.pushNamed(context, r'/commentPage');
}

