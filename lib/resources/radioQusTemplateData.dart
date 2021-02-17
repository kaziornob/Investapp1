
import 'package:auroim/model/radioQusModel.dart';

Future<List<RadioQusModel>> getRadioQusTempData(parentFrom,childFrom) async {

  var tempQuestions;
  if(childFrom=="empStatus")
    {
        tempQuestions = [
        {
          "screenBackGroundColor" : parentFrom=='Accredited Investor' ? 0xFF000000 : 0xFF87b5eb,
          "buttonBackGroundColor" : parentFrom=='Accredited Investor' ? 0xFFfec20f : 0xFF4682B4,
          "parentFrom": parentFrom,
          "childFrom": childFrom,
          "logo": "login_logo.png",
          "logoBottomLine": "YOUR PERSONAL ASSET MANAGER",
          "qusID":"1",
          "qusHeadline": "What is your level of investing experience?",
          "qusOptions":
          [
            {
              "title": "Newbie - no experience",
              "subTitle": "(0 years of trading experience)",
              "option_value": "0",
            },
            {
              "title": "Investo-curious - know a little about investing",
              "subTitle": "(1-2 years of trading experience)",
              "option_value": "1-2",
            },
            {
              "title": "Up-and-Comer-have tried investing before",
              "subTitle": "(3-5 years of trading experience)",
              "option_value": "3-5",
            },
            {
              "title": "Veteran - lots of experience",
              "subTitle": "(>5 years of trading experience)",
              "option_value": ">5",
            },
          ]
        }
      ];
    }
  else if(childFrom=="piVersion")
    {
      tempQuestions = [
        {
          "screenBackGroundColor" : parentFrom=='Accredited Investor' ? 0xFF000000 : 0xFF87b5eb,
          "buttonBackGroundColor" : parentFrom=='Accredited Investor' ? 0xFFfec20f : 0xFF4682B4,
          "parentFrom": parentFrom,
          "childFrom": childFrom,
          "logo": "login_logo.png",
          "logoBottomLine": "YOUR PERSONAL ASSET MANAGER",
          "qusID":"2",
          "qusHeadline": "Help us understand your attitude towards risk, by choosing the options that suits you the most",
          "qusOptions":
          [
            {
              "title": "Cautious (Low risk appetite, expected returns higher than saving accounts, ideal for individuals at a late stage in their carrer)",
              "subTitle": "",
              "option_value": "Cautious",
              "num_value": "0.07"
            },
            {
              "title": "Modest (Medium risk appetite,looking for average returns, with slight ability to sustain losses)",
              "subTitle": "",
              "option_value": "Modest",
              "num_value": "0.15"

            },
            {
              "title": "Aggressive (High-risk appetite seeking significant returns with the ability to sustain losses, investing with long-term goals)",
              "subTitle": "",
              "option_value": "Aggressive",
              "num_value": "0.25"

            },
            {
              "title": "Extremely Aggressive (Extremely high-risk appetite, seeking great returns willing to take on the risk)",
              "subTitle": "",
              "option_value": "Extremely Aggressive",
              "num_value": "0.35"

            },
          ]
        }
      ];
    }

  List<Map<String, dynamic>> questions = List<Map<String, dynamic>>.from(tempQuestions);
  return RadioQusModel.fromData(questions);

}
