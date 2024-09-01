class ChatModel
{
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? message;
  String? image;


  ChatModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.message,
    this.image,
  });

  ChatModel.fromJson(Map<String,dynamic>? json)
  {
    senderId = json!['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    message = json['message'];
    image = json['image'];
  }


  Map<String,dynamic> toMap()
  {
    return {

      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,
      'message':message,
      'image':image,
    };
  }

}