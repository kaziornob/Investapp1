import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(),
              SizedBox(
                height: 10,
              ),
              practiceText(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: rowWidget('xxx+ curated module/topic wise tests', 'masterclass/testQuiz.png'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: rowWidget('xxx+ curated topic wise Quizzes', 'masterclass/topicwise_quiz.png'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: rowWidget('Achieve the target of thorough understanding.', 'masterclass/target.png'),
              ),
              SizedBox(
                height: 40,
              ),
              buyButton()
            ],
          ),
        ),
      ),
    ));
  }

  backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 15),
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  practiceText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10),
      child: Text(
        "Practice the concepts learned and evaluate your preparation with our wide range of test and quizzes.",
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.left,
      ),
    );
  }

  rowWidget(String title, String assets) {
    return ListTile(
      dense: true,
      leading: Image.asset(
        "assets/$assets",
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }

  buyButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {},
          child: Card(
            elevation: 3,
            shadowColor: Colors.grey,
            child: Container(
              height: 40,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2.3,
              child: Text(
                "Buy 15\$",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Card(
            elevation: 3,
            shadowColor: Colors.grey,
            child: Container(
              height: 40,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2.3,
              child: Text(
                "Buy Bundle",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        )
      ],
    );
  }
}
