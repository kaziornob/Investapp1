import 'dart:convert';
import 'dart:io';
import 'package:auroim/constance/global.dart';
import 'package:auroim/modules/questionAndAnswerModule/models/question.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Question> getQuestions() async {

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String sessionToken = prefs.getString('Session_token');

  String url = GlobalInstance.apiBaseUrl+'qa/question';

  print("post req url: $url");
  print("session token: $sessionToken");

  Map<String, String> headers = {"Content-type": "application/json",
    'Authorization': 'Token $sessionToken',};

  var response = await http.get(url, headers: headers);
  // http.Response res = await http.get(url, headers: headers);
  print("response statusCode: ${response.statusCode}");
  print("response body: ${json.decode(response.body)}");


  if (response.statusCode == 200) {

    var tempBody = json.decode(response.body);
    var tempQusData = tempBody['message'];
    print("tempQusData: $tempQusData");

    var optionData = [];
    var tempQuestions;
    if(tempQusData!=null && tempQusData.containsKey('answer') && tempQusData['answer']!=null)
      {
        final data = tempQusData['answer'] as Map;
        for (final name in data.keys) {
          final value = data[name];
          // print('$name,$value');
          if(value!=null && value.length!=0)
            {
              optionData.add({"option_value": value[0],"checked": false,"is_correct": value[1],"answer_id" : name});
            }
        }
        print("optionData: $optionData");


        tempQuestions = {
          "question_type": "multianswermcq",
          "question_text": "${tempQusData['question']}",
          "question_id": "${tempQusData['master_id']}",
          "image": [],
          "video_link": "${tempQusData['link']}",
          "option": optionData
        };
      }

    Map<String, dynamic> questions = Map<String, dynamic>.from(tempQuestions);

    print("questions: $questions");

    return Question.fromMap(questions);

  } else {
    return null;
  }
}
