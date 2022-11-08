import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../models/PostOffline.dart';
import '../models/PostOnline.dart';
import 'HomePage.dart';

Future insertOnlineDatabase(newPost) async{
  await FirebaseFirestore.instance.collection('posts').doc().set(newPost.toMapOnline());
}

Future updateOnlineDatabase(selectedIndex, updatedPost, fireBaseInstance) async{
  QuerySnapshot querySnapshot = await fireBaseInstance.get();
  PostOnline post =  PostOnline.fromMap(querySnapshot.docs[selectedIndex].data(), reference: querySnapshot.docs[selectedIndex].reference);
  await FirebaseFirestore.instance.collection('posts').doc(post.reference?.id.toString()).set(updatedPost.toMapOnline());
}

Future deleteOnlineDatabase(selectedIndex, fireBaseInstance) async{
  QuerySnapshot querySnapshot = await fireBaseInstance.get();
  PostOnline post = PostOnline.fromMap(querySnapshot.docs[selectedIndex].data(), reference: querySnapshot.docs[selectedIndex].reference);

  post.reference!.delete();
}

Future initializeOfflineDataBase(context) async{
  PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context, listen: false);
  List posts = await model.getAllPosts();
  postsListBLoC.posts = posts as List<PostOffline>;

  try {
    print("Loading saved offline database!");
    lastInsertedId = posts[posts.length - 1].id!;
  }
  catch(RangeError){
    print("No offline database currently found!");
    lastInsertedId = 0;
  }

}

void deleteOfflineDatabase(int selectedIndex, context){
  PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context, listen: false);

  model.deletePostByID(postsListBLoC.posts[selectedIndex].id!);
  postsListBLoC.removePost(selectedIndex);

}

Future readOfflineDatabase()  async{
  List posts = await model.getAllPosts();
  print("Post Offline Database:");
  for (PostOffline post in posts){
    print(post);
  }
}

Future addOfflineDatabase(PostOffline post, context) async{
  PostsListBLoC postsListBLoC = Provider.of<PostsListBLoC>(context, listen: false);
  lastInsertedId = await model.insertPosts(post);
  postsListBLoC.addPost(post);
  print("Post Inserted to offline database: ${post.toString()}");
}