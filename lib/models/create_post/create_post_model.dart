class PostModel
{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? postImage;
  String? postText;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.postImage,
    this.postText,
});

  PostModel.fromJson(Map<String,dynamic>? json)
  {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    postText = json['postText'];
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
  };
}

}