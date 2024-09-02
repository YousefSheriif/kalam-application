class ChatModel
{
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? message;
  String? name;
  String? image;
  String? date;
  String? time;


  ChatModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.message,
    this.name,
    this.image,
    this.date,
    this.time,
  });

  ChatModel.fromJson(Map<String,dynamic>? json)
  {
    senderId = json!['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    message = json['message'];
    name = json['name'];
    image = json['image'];
    date = json['date'];
    time = json['time'];
  }


  Map<String,dynamic> toMap()
  {
    return {

      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,
      'message':message,
      'name':name,
      'image':image,
      'date':date,
      'time':time,
    };
  }

}