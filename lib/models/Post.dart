class Post{
  String? userName;
  String? timeString;
  String? description;
  String? imageURL;
  String? title;
  //CommentPage
  // List<Comment> = [];

  int numComments = 0;
  int numReposts = 0;
  int numLikes = 0;
  int numDislikes = 0;

  Post({this.userName, this.timeString, this.description, this.imageURL, this.title});

  @override
  String toString() {
    return "$userName";
  }
}