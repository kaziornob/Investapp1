import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:auroim/investment_masterclass/invesment_masterclass_models/next_question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class IVMChapterQuizProvider with ChangeNotifier {
  List<NextQuestionModel> dataToShowAtLast = [];
  List<int> answersSelectedByUser = [];
  NextQuestionModel nextQuestionModel;

  Future getNextQuestion(int classId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String url =
        GlobalInstance.apiBaseUrl + 'forum/get_next_inv_chapter_question';
    print("post req url: $url");
    print("session token: $sessionToken");

    Map<String, dynamic> body = {"class_id": classId.toString()};

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $sessionToken',
    };

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    print("post submit response: ${response.statusCode}");

    nextQuestionModel = nextQuestionModelFromJson(response.body);
    dataToShowAtLast.add(nextQuestionModel);

    notifyListeners();
  }

  Future postNextQuestion(
    int classId,
    int questionId,
    String responseString,
    int optionSelected,
  ) async {
    //save option selected by user
    answersSelectedByUser.add(optionSelected);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String url = GlobalInstance.apiBaseUrl + 'forum/post_inv_chapter_response';
    print("post req url: $url");
    print("session token: $sessionToken");

    Map<String, dynamic> body = {
      "class_id": classId.toString(),
      "response": responseString,
      "question_id": questionId.toString()
    };

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $sessionToken',
    };

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    print("post submit response: ${response.statusCode}");

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"]["message"] ==
          "Response saved successfully") {
        await getNextQuestion(classId);
        notifyListeners();
      }
    }
  }
}
