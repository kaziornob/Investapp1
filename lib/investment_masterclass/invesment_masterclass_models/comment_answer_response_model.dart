// To parse this JSON data, do
//
//     final commentAnswerResponseModel = commentAnswerResponseModelFromJson(jsonString);

import 'dart:convert';

CommentAnswerResponseModel commentAnswerResponseModelFromJson(String str) => CommentAnswerResponseModel.fromJson(json.decode(str));

String commentAnswerResponseModelToJson(CommentAnswerResponseModel data) => json.encode(data.toJson());

class CommentAnswerResponseModel {
  CommentAnswerResponseModel({
    this.auth,
    this.message,
  });

  bool auth;
  Message message;

  factory CommentAnswerResponseModel.fromJson(Map<String, dynamic> json) => CommentAnswerResponseModel(
    auth: json["auth"] == null ? null : json["auth"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "auth": auth == null ? null : auth,
    "message": message == null ? null : message.toJson(),
  };
}

class Message {
  Message({
    this.answerId,
    this.comments,
  });

  String answerId;
  List<Comment> comments;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    answerId: json["answer_id"] == null ? null : json["answer_id"],
    comments: json["comments"] == null ? null : List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "answer_id": answerId == null ? null : answerId,
    "comments": comments == null ? null : List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Comment {
  Comment({
    this.userId,
    this.comment,
    this.idComment,
    this.likes,
    this.dislikes,
  });

  int userId;
  String comment;
  int idComment;
  int likes;
  int dislikes;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    userId: json["user_id"] == null ? null : json["user_id"],
    comment: json["comment"] == null ? null : json["comment"],
    idComment: json["id_comment"] == null ? null : json["id_comment"],
    likes: json["likes"] == null ? null : json["likes"],
    dislikes: json["dislikes"] == null ? null : json["dislikes"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "comment": comment == null ? null : comment,
    "id_comment": idComment == null ? null : idComment,
    "likes": likes == null ? null : likes,
    "dislikes": dislikes == null ? null : dislikes,
  };
}
