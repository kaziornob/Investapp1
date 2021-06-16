import 'dart:convert';

import 'package:auroim/constance/global.dart';
import 'package:auroim/investment_masterclass/invesment_masterclass_models/comment_answer_response_model.dart';
import 'package:auroim/investment_masterclass/invesment_masterclass_models/comment_response_models.dart';
import 'package:auroim/investment_masterclass/invesment_masterclass_models/module_details_response_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InvestmentMasterclassPresenter {
  /// Loading - 0, Success - 1 , Failure - 2
  List<int> status = [0, 1, 2];
  int statusValue = 0;
  ModuleDetailsResponseModel moduleDetailsResponseModel;
  CommentResponseModel commentResponseModel;
  CommentAnswerResponseModel commentAnswerResponseModel;

  Future getModuleDetails(String moduleName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String url = GlobalInstance.apiBaseUrl + 'forum/get_module_details';
    print("post req url: $url");
    print("session token: $sessionToken");

    Map<String, dynamic> body = {"module_name": moduleName};

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $sessionToken',
    };

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    print("post submit response: ${response.statusCode}");

    moduleDetailsResponseModel =
        moduleDetailsResponseModelFromJson(response.body);
    print(moduleDetailsResponseModel.message[0].classTopic);
    return moduleDetailsResponseModel;

  }

  Future getClassAnswers(int classId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String url = GlobalInstance.apiBaseUrl + 'forum/get_inv_class_answer';
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

    commentResponseModel = commentResponseModelFromJson(response.body);
    print(commentResponseModel.message.answers.length);

    return commentResponseModel;
  }

  Future getClassAnswersComment(int answerId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String url = GlobalInstance.apiBaseUrl + 'forum/get_inv_class_answer_comment';
    print("post req url: $url");
    print("session token: $sessionToken");

    Map<String, dynamic> body = {"answer_id": answerId.toString()};

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $sessionToken',
    };

    var response =
    await http.post(url, headers: headers, body: jsonEncode(body));
    print("post submit response: ${response.statusCode}");

    commentAnswerResponseModel = commentAnswerResponseModelFromJson(response.body);
    print(commentAnswerResponseModel.message.comments.length);

    return commentAnswerResponseModel;
  }

  Future submitClassAnswers(int classId,String answer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String url = GlobalInstance.apiBaseUrl + 'forum/create_inv_class_answer';
    print("post req url: $url");
    print("session token: $sessionToken");

    Map<String, dynamic> body = {"class_id": classId.toString(),"answer" : answer};

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $sessionToken',
    };

    var response =
    await http.post(url, headers: headers, body: jsonEncode(body));
    print("post submit response: ${response.statusCode}");

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }


  }

  Future submitClassAnswersComment(int answerId,String answer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    String url = GlobalInstance.apiBaseUrl + 'forum/create_inv_class_answer_comment';
    print("post req url: $url");
    print("session token: $sessionToken");

    Map<String, dynamic> body = {"answer_id": answerId.toString(),"comment" : answer};

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $sessionToken',
    };

    var response =
    await http.post(url, headers: headers, body: jsonEncode(body));
    print("post submit response: ${response.statusCode}");

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }


  }
}
