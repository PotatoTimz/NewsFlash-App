import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/Post.dart';

Future insertPost(newPost) async{
  await FirebaseFirestore.instance.collection('posts').doc().set(newPost.Tomap());
}

Future updatePost(selectedIndex, updatedPost, fireBaseInstance) async{
  QuerySnapshot querySnapshot = await fireBaseInstance.get();
  Post post =  Post.fromMap(querySnapshot.docs[selectedIndex].data(), reference: querySnapshot.docs[selectedIndex].reference);

  await FirebaseFirestore.instance.collection('posts').doc(post.reference?.id.toString()).set(updatedPost.Tomap());
}

Future deletePost(selectedIndex, fireBaseInstance) async{
  QuerySnapshot querySnapshot = await fireBaseInstance.get();
  Post post = Post.fromMap(querySnapshot.docs[selectedIndex].data(), reference: querySnapshot.docs[selectedIndex].reference);

  post.reference!.delete();
}