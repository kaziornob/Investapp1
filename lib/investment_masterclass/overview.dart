import 'package:flutter/material.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({Key key}) : super(key: key);

  @override
  _OverViewScreenState createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/online-course.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("xx Courses")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/quiz.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("100+ Quiz Questions")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/groupPpl.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("99+ Learning with you")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/done.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("25+ Users did this course")
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  "It is a long established fact that a reader will be distracted by. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Skills Covered",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              Row(
                children: [],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/question.png",
                      width: 38,
                      height: 38,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ask Auro",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Ask Auro"),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/testQuiz.png",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Test and Quizzes",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Unlock Testing"),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/certificate.png",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Certificate",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Unlock Accreditation"),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/groupClasses.png",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Group Live Classes",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Unlock 1-1 & group live classes "),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
