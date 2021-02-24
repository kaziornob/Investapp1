import 'package:flutter/widgets.dart';

enum Type {
  multiple,
  boolean
}

//enum Difficulty {
//  easy,
//  medium,
//  hard
//}


class Question {
  final Type type;
  final String question;
  final String questionType;
  final String videoLink;
  final String questionId;


  final List<dynamic> qusImages;


  List<dynamic> userAnswer;
  List<dynamic> defaultAnswer;


  final List<dynamic> qusOptions;

  Question({this.type,this.qusImages, this.question,this.videoLink,this.questionType,this.questionId,this.qusOptions,this.userAnswer,this.defaultAnswer});

  Question.fromMap(Map<String, dynamic> data):
        type = data["question_type"] == "mcq" ? Type.multiple : Type.boolean,
        questionType = data["question_type"],
        question = data["question_text"],
        videoLink = data["video_link"],
        questionId = data["question_id"],
        qusImages = data.containsKey('image') && data["image"]!=null && data["image"].length!=0 ? data["image"]: null,
        userAnswer = [],
        defaultAnswer = data["answer"],
        qusOptions = data["option"];

  static List<Question> fromData(List<Map<String,dynamic>> data){
    return data.map((question) => Question.fromMap(question)).toList();
  }

}
