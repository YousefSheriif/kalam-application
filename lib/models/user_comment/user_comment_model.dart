class CommentModel
{
  String? name;
  String? uId;
  String? postId;
  String? image;
  String? dateTime;
  String? commentText;

  CommentModel({
    this.name,
    this.uId,
    this.postId,
    this.image,
    this.dateTime,
    this.commentText,
});

  CommentModel.fromJson(Map<String,dynamic>? json)
  {
    name = json!['name'];
    uId = json['uId'];
    postId = json['postId'];
    image = json['image'];
    dateTime = json['dateTime'];
    commentText = json['commentText'];
  }


  Map<String,dynamic> toMap()
  {
    return
      {
      'name':name,
      'uId':uId,
      'postId':postId,
      'image':image,
      'dateTime':dateTime,
      'commentText':commentText,
  };
}

}