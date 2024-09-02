class UserModel
{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isTalkToMe;
  String? lastMessageChat;
  String? dateTime;
  String? date;
  String? time;


  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isTalkToMe,
    this.lastMessageChat,
    this.dateTime,
    this.date,
    this.time,
});

  UserModel.fromJson(Map<String,dynamic>? json)
  {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isTalkToMe = json['isTalkToMe'];
    lastMessageChat = json['lastMessageChat'];
    dateTime = json['dateTime'];
    date = json['date'];
    time = json['time'];
  }


  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isTalkToMe':isTalkToMe,
      'lastMessageChat':lastMessageChat,
      'dateTime':dateTime,
      'date':date,
      'time':time,
  };
}

}