import 'dart:convert';
import 'dart:io';
import 'package:auro/questionAndAnswerModule/models/question.dart';
import 'package:http/http.dart' as http;
import 'package:auro/shared/globalInstance.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiUrl = GlobalInstance.apiBaseUrl;

Future<List<Question>> getQuestions() async {

/*  String url = "$apiUrl" + "assessment?assessment_id=$assessmentId";


  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String sessionToken = prefs.getString('Session_token');

  Map<String, String> headers = {
    "Content-type": "application/json",
    "session-token": sessionToken,
  };

  http.Response res = await http.get(url, headers: headers);

  if(scheduleAssessmentId!="")
  {
    GlobalInstance.assessmentTotalTime = '${json.decode(res.body)["assessment"]["total_time"]}';
    GlobalInstance.assessmentEndTime = '${json.decode(res.body)["assessment"]["end_time"]}';
  }
  else
    GlobalInstance.assessmentTotalTime = '0';*/

  var tempQuestions =
  [
      {
        "question_type": "singleanswermcq",
        "question_text": "ABC Limited manufactures energy-saving bulbs. "
            "The variable costs of manufacturing one bulb include dolar 1.70 worth of raw materials, dolar 1.50 direct labor cost, "
            "dolar 0.50 electricity, and dolar 0.30 shipping costs. The company also incurs dolar 3,000 in equipment lease, "
            "dolar 4,500 in factory rent, dolar 20,000 in management salaries, and dolar 7,000 in marketing expenses. "
            "The selling price per unit is dolar 7.50, and the company sold 20,000 bulbs in the previous year. What is the contribution margin after marketing?",
        "question_id": "1",
        "image": [],
        "video_link": "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
        "answer": [
          {"value": "80000"}
        ],
        "option":
          [
            {
            "option_value": "60000",
            },
            {
              "option_value": "70000",
            },
            {
              "option_value": "90000",
            },
            {
              "option_value": "80000",
            },
          ]
      },
      {
        "question_type": "multianswermcq",
        "question_text": "What is Accelerated Depreciation?",
        "question_id": "2",
        "image": [],
        "video_link": "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
        "answer": [
          {"value": "An acceleration clause is a contract provision"
              "that allows a lender to require a borrower to repay all of an outstanding loan if certain requirements are not met"},
          {"value": "An acceleration clause outlines the reasons that the lender can demand loan repayment and the repayment required"}

        ],
        "option":
        [
          {
            "option_value": "An acceleration clause is a contract provision"
                "that allows a lender to require a borrower to repay all of an outstanding loan if certain requirements are not met",
            "checked": false,
          },
          {
            "option_value": "An acceleration clause outlines the reasons that the lender can demand loan repayment and the repayment required",
            "checked": false,
          },
          {
            "option_value": "An acceleration clause or covenant is a contract provision "
                "that allows a lender to require a borrower to repay all of an outstanding loan if specific requirements are not met.",
            "checked": false,
          },
        ]
      },
      {
        "question_type": "multianswermcq",
        "question_text": "What is Accounting Profit?",
        "question_id": "3",
        "image": [],
        "video_link": "http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
        "answer": [
          {"value": "1"}
        ],
        "option":
        [
          {
            "option_value": "They provide a way of expressing the relationship between one accounting data point to another and are the basis of ratio analysis",
            "checked": false,
          },
          {
            "option_value": "Accounting ratios, an important sub-set of financial ratios, "
                "are a group of metrics used to measure the efficiency and profitability of a company based on its financial reports.",
            "checked": false,
          },
          {
            "option_value": "An accounting ratio compares two line items in a company‚"
                "Äôs financial statements, namely made up of its income statement, balance sheet, and cash flow statement.",
            "checked": false,
          },
        ]
      }
  ];


/*  List<Map<String, dynamic>> questions = List<Map<String, dynamic>>.from(
      json.decode(res.body)["assessment"]["questions"]);*/

  List<Map<String, dynamic>> questions = List<Map<String, dynamic>>.from(tempQuestions);

  return Question.fromData(questions);

}
