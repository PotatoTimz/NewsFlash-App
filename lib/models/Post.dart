class Post{
  String? userName;
  String? timeString;
  String? description;
  String? imageURL;
  int numComments = 0;
  int numRetweets = 0;
  int numLikes = 0;

  Post({this.userName, this.timeString, this.description,this.imageURL});

}