import 'dart:convert';

import 'package:flutter/cupertino.dart';

CommentResponseModel commentResponseModelFromJson(String str) => CommentResponseModel.fromJson(json.decode(str));

String commentResponseModelToJson(CommentResponseModel data) => json.encode(data.toJson());

class CommentResponseModel {
  CommentResponseModel({
    this.auth,
    this.message,
  });

  bool auth;
  Message message;

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) => CommentResponseModel(
    auth: json["auth"] == null ? null : json["auth"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth,
    "message": message == null ? null : message.toJson(),
  };
}

bool value = false;

class Message {
  Message({
    this.classId,
    this.answers,
  });

  String classId;
  List<Answer> answers;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    classId: json["class_id"] == null ? null : json["class_id"],
    answers: json["answers"] == null ? null : List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "class_id": classId == null ? null : classId,
    "answers": answers == null ? null : List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class Answer {
  Answer({
    this.userId,
    this.answer,
    this.idAnswer,
    this.likes,
    this.dislikes,
  });

  int userId;
  String answer;
  int idAnswer;
  int likes;
  int dislikes;
  ValueNotifier<bool>  showComment = ValueNotifier(false);


  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    userId: json["user_id"] == null ? null : json["user_id"],
    answer: json["answer"] == null ? null : json["answer"],
    idAnswer: json["id_answer"] == null ? null : json["id_answer"],
    likes: json["likes"] == null ? null : json["likes"],
    dislikes: json["dislikes"] == null ? null : json["dislikes"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "answer": answer == null ? null : answer,
    "id_answer": idAnswer == null ? null : idAnswer,
    "likes": likes == null ? null : likes,
    "dislikes": dislikes == null ? null : dislikes,
  };
}
