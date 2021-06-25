enum Type { multiple, boolean }

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
  final int diffScore;
  final List<dynamic> qusImages;
  List<dynamic> userAnswer;
  final List<dynamic> qusOptions;

  Question(
      {this.type,
      this.qusImages,
      this.question,
      this.videoLink,
      this.questionType,
      this.diffScore,
      this.questionId,
      this.qusOptions,
      this.userAnswer});

  Question.fromMap(Map<String, dynamic> data)
      : type = data["question_type"] == "mcq" ? Type.multiple : Type.boolean,
        questionType = data["question_type"],
        diffScore = data["diff_score"],
        question = data["question_text"],
        videoLink = data["video_link"],
        questionId = data["question_id"],
        qusImages = data.containsKey('image') &&
                data["image"] != null &&
                data["image"].length != 0
            ? data["image"]
            : null,
        userAnswer = [],
        qusOptions = data["option"];

  /*factory Question.fromData(Map<String, dynamic> json) {
    return Question(
      email: json['email'],
      id: json['id'],
    );
  }*/

/*  static fromData(Map<String,dynamic> data){
    print("question model data: $data");
    return data;
  }*/

}
