import 'package:zalo/models/user.dart';

// Message messageFromJson(String str) => Message.fromJson(json.decode(str));

// String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    this.sender,
    this.receiver,
    this.created,
    this.content,
    this.type,
  });

  User sender;
  User receiver;
  int created;
  String content;
  String type;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        sender: User.fromJson(json["sender"]),
        receiver: User.fromJson(json["receiver"]),
        created: json["created"],
        content: json["content"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender.toJson(),
        "receiver": receiver.toJson(),
        "created": created,
        "content": content,
        "type": type,
      };
}