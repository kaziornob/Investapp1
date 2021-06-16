import 'package:auroim/investment_masterclass/user_masterclass_progress_screen.dart';
import 'package:auroim/modules/questionAndAnswerModule/ui/pages/error.dart';
import 'package:auroim/modules/questionAndAnswerModule/ui/pages/questionTemplate.dart';
import 'package:auroim/reusable_widgets/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:auroim/modules/questionAndAnswerModule/models/question.dart';
import 'package:auroim/modules/questionAndAnswerModule/resources/question_api_provider.dart';

class MasterClassCoursesScreen extends StatefulWidget {
  final String type;

  const MasterClassCoursesScreen({Key key, this.type}) : super(key: key);

  @override
  _MasterClassCoursesScreenState createState() =>
      _MasterClassCoursesScreenState();
}

class _MasterClassCoursesScreenState extends State<MasterClassCoursesScreen> {
  final TextEditingController searchEditingController = TextEditingController();

  Map allMasterClassLinks = {
    "Investing - Beginners Guide": {
      "Beginner": ["Fundamental 101"],
      "Intermediate": [],
      "Advanced": [],
    },
    "Fundamental": {
      "Beginner": ["Fundamental 101"],
      "Intermediate": [
        "STYLE BASED INVESTING",
        "Angel/ Seed",
        "Venture Capital",
        "Private Equity",
        "Fixed Income and Bonds",
      ],
      "Advanced": [
        "Securitization",
      ],
    },
    "Quant": {
      "Beginner": ["Introduction to Technical Analysis for Beginners"],
      "Intermediate": [
        "Technical Analysis",
      ],
      "Advanced": [
        "Trading Strategies",
        "Algorithmic Trading",
        "Machine Learning in Trading",
      ],
    },
    "Real Estate": {
      "Beginner": ["Real Estate Investing 101"],
      "Intermediate": [
        "Real Estate Investing Intermediate",
      ],
      "Advanced": [
        "Real Estate Investing Advanced",
      ],
    },
    "Global Macro": {
      "Beginner": ["Global Macro 101"],
      "Intermediate": [],
      "Advanced": [
        "Global Macro - Deep Dive",
      ],
    },
    "Hedge Funds": {
      "Beginner": ["Hedge Fund 101"],
      "Intermediate": ["Hedge Fund Strategies"],
      "Advanced": [
        "Arbitrage",
      ],
    },
    "AI": {
      "Beginner": ["AI 101"],
      "Intermediate": ["AI empowered Investing"],
      "Advanced": [
        "Artificial Intelligence - Deep Dive",
      ],
    },
    "Financial Modelling": {
      "Beginner": ["Financial Modelling -  Beginners "],
      "Intermediate": ["Financial Modelling -  Intermediate"],
      "Advanced": [
        "Quant Modelling",
      ],
    },
    "Crypto": {
      "Beginner": ["Crypto - Beginners Guide"],
      "Intermediate": [
        "Blockchain & Cryptonomics",
        "Blockchain & Financial System",
        "NFTs",
      ],
      "Advanced": [
        "Crypto Currency Trading",
        "Crypto Exchanges - Centralized & Decentralized",
        "Smart Contracts and DApps",
      ],
    },
  };

  @override
  void dispose() {
    searchEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_back_sharp,
          color: Colors.white,
          size: 40,
        ),
        backgroundColor: Color(0xFF8A8A8A),
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                SearchBar(
                  controller: searchEditingController,
                ),
                SizedBox(
                  height: 30,
                ),
                stackedWidget(
                  width * 0.6,
                  height * 0.2,
                  Color(0xFFFFB494),
                  "Auro Beginner",
                  "With no prior investment knowledge",
                  context,
                ),
                SizedBox(
                  height: height * 0.07,
                ),
                widget.type == "Investing - Beginners Guide"
                    ? box2(
                        "Investment Workout Unlimited questions on Investing to hone your skill",
                        context,
                        width * 0.8,
                      )
                    : SizedBox(),
                widget.type == "Investing - Beginners Guide"
                    ? SizedBox()
                    : stackedWidget(
                        width * 0.6,
                        height * 0.2,
                        Color(0xFFD8AF4F),
                        "Auro Intermediate",
                        "With prior investment knowledge",
                        context,
                      ),
                SizedBox(
                  height: height * 0.07,
                ),
                widget.type == "Investing - Beginners Guide"
                    ? SizedBox()
                    : stackedWidget(
                        width * 0.6,
                        height * 0.2,
                        Color(0xFFE3E1F5),
                        "Auro Advanced",
                        "With material investment knowledge",
                        context,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  stackedWidget(width, height, color, title, subtitle, context) {
    return Stack(
      children: [
        Transform.rotate(
          angle: 15 * pi / 180,
          child: box(color, width, height, null, null, context),
        ),
        box(color, width, height, title, subtitle, context),
      ],
    );
  }

  box(Color color, width, height, title, subtitle, context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserMasterclassProgressScreen(
              allClasses: allMasterClassLinks[widget.type]
                  [title.toString().substring(5)],
            ),
          ),
        );
      },
      child: Material(
        elevation: 5,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(width * 0.15),
          borderSide: BorderSide(
            color: color,
          ),
        ),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(width * 0.15),
          ),
          child: title == null
              ? SizedBox()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.09,
                        right: width * 0.09,
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "RobotoLight",
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.09,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.09,
                        right: width * 0.09,
                      ),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "RobotoLight",
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  box2(text, context, width) {
    return GestureDetector(
      onTap: () async {
        Question questions = await getQuestions();
        if (questions == null) {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (_) => ErrorPage(
                    message: "There are not enough questions yet.",
                  )));
          return;
        }
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (BuildContext context) =>
                QuestionTemplate(questions: questions),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        height: 120,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Color(0xFFD8AF4F),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/testQuiz.png",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Roboto",
                  color: Color(0xFFD8AF4F),
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
