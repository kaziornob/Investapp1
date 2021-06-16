// To parse this JSON data, do
//
//     final nextQuestionModel = nextQuestionModelFromJson(jsonString);

import 'dart:convert';

NextQuestionModel nextQuestionModelFromJson(String str) => NextQuestionModel.fromJson(json.decode(str));

String nextQuestionModelToJson(NextQuestionModel data) => json.encode(data.toJson());

class NextQuestionModel {
  NextQuestionModel({
    this.auth,
    this.message,
  });

  bool auth;
  Message message;

  factory NextQuestionModel.fromJson(Map<String, dynamic> json) => NextQuestionModel(
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
    this.questionId,
    this.question,
    this.classId,
    this.answers,
    this.assetText,
    this.assetImage,
    this.assetVideo,
    this.questionType,
  });

  int questionId;
  String question;
  int classId;
  Map<String, List<String>> answers;
  String assetText;
  String assetImage;
  String assetVideo;
  int questionType;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    questionId: json["question_id"] == null ? null : json["question_id"],
    question: json["question"] == null ? null : json["question"],
    classId: json["class_id"] == null ? null : json["class_id"],
    answers: json["answers"] == null ? null : Map.from(json["answers"]).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))),
    assetText: json["asset_text"] == null ? null : json["asset_text"],
    assetImage: json["asset_image"] == null ? null : json["asset_image"],
    assetVideo: json["asset_video"] == null ? null : json["asset_video"],
    questionType: json["question_type"] == null ? null : json["question_type"],
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId == null ? null : questionId,
    "question": question == null ? null : question,
    "class_id": classId == null ? null : classId,
    "answers": answers == null ? null : Map.from(answers).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
    "asset_text": assetText == null ? null : assetText,
    "asset_image": assetImage == null ? null : assetImage,
    "asset_video": assetVideo == null ? null : assetVideo,
    "question_type": questionType == null ? null : questionType,
  };
}
