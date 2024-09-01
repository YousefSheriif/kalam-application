class PostModel
{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? postImage;
  String? postText;
  String? postId;
  int? likesNumbers;
  int? commentsNumbers;
  bool? iLikedThisPost;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.postImage,
    this.postText,
    this.postId,
    this.likesNumbers,
    this.commentsNumbers,
    this.iLikedThisPost,
});

  PostModel.fromJson(Map<String,dynamic>? json)
  {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    postText = json['postText'];
    postId = json['postId'];
    likesNumbers = json['likesNumbers'];
    commentsNumbers = json['commentsNumbers'];
    iLikedThisPost = json['iLikedThisPost'];
  }


  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'dateTime':dateTime,
      'postImage':postImage,
      'postText':postText,
      'postId':postId,
      'likesNumbers':likesNumbers,
      'commentsNumbers':commentsNumbers,
      'iLikedThisPost':iLikedThisPost,
  };
}

}