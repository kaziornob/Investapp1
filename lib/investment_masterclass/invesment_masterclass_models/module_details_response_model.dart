import 'dart:convert';

ModuleDetailsResponseModel moduleDetailsResponseModelFromJson(String str) =>
    ModuleDetailsResponseModel.fromJson(json.decode(str));

String moduleDetailsResponseModelToJson(ModuleDetailsResponseModel data) =>
    json.encode(data.toJson());

class ModuleDetailsResponseModel {
  ModuleDetailsResponseModel({
    this.auth,
    this.message,
  });

  bool auth;
  List<Message> message;

  factory ModuleDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      ModuleDetailsResponseModel(
        auth: json["auth"] == null ? null : json["auth"],
        message: json["message"] == null
            ? null
            : List<Message>.from(
                json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "auth": auth == null ? null : auth,
        "message": message == null
            ? null
            : List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    this.classId,
    this.classTopic,
    this.link,
    this.linkTitle,
    this.linkDescription,
    this.linkDuration,
    this.completed,
    this.likes,
    this.isPlaying = false,
  });

  int classId;
  String classTopic;
  String link;
  String linkTitle;
  String linkDescription;
  String linkDuration;
  int completed;
  int likes;
  bool isPlaying;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        classId: json["class_id"] == null ? null : json["class_id"],
        classTopic: json["class_topic"] == null ? null : json["class_topic"],
        link: json["link"] == null ? null : json["link"],
        linkTitle: json["link_title"] == null ? null : json["link_title"],
        linkDescription:
            json["link_description"] == null ? null : json["link_description"],
        linkDuration:
            json["link_duration"] == null ? null : json["link_duration"],
        completed: json["completed"] == null ? null : json["completed"],
        likes: json["likes"] == null ? null : json["likes"],
      );

  Map<String, dynamic> toJson() => {
        "class_id": classId == null ? null : classId,
        "class_topic": classTopic == null ? null : classTopic,
        "link": link == null ? null : link,
        "link_title": linkTitle == null ? null : linkTitle,
        "link_description": linkDescription == null ? null : linkDescription,
        "link_duration": linkDuration == null ? null : linkDuration,
        "completed": completed == null ? null : completed,
        "likes": likes == null ? null : likes,
      };
}
