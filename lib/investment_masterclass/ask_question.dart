import 'package:flutter/material.dart';

class AskQuestion extends StatefulWidget {
  const AskQuestion({Key key}) : super(key: key);

  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  TextEditingController askController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                backButton(),
                Image.asset(
                  'assets/thought_cloud.png',
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  height: 20,
                ),
                textFieild(),
                SizedBox(
                  height: 20,
                ),
                askQuestionText(),
                SizedBox(
                  height: 20,
                ),
                leranerText(),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          userImage(),
                          usernameText(),
                          SizedBox(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.center,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Image.asset(
                                    'assets/star.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fill,
                                  );
                                },
                              ),
                            ),
                          ),
                          occuptionText(),
                          quoteText(),
                        ],
                      );
                    },
                  ),
                ),
                askText(),
                SizedBox(
                  height: 15,
                ),
                buyButton(),
                SizedBox(
                  height: 30,
                ),
                noteText()
              ],
            ),
          ),
        ),
      ),
    );
  }

  backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  textFieild() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        controller: askController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            border: OutlineInputBorder(),
            fillColor: Color(0xFFECECEC),
            filled: true,
            hintStyle: TextStyle(
              fontSize: 15,
            ),
            hintText: "Ask your question here.."),
      ),
    );
  }

  askQuestionText() {
    return Text(
      "Ask questions on any Investment modules to Auro's Investment team",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    );
  }

  leranerText() {
    return Text(
      "What other learner have to say about us?",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      textAlign: TextAlign.center,
    );
  }

  userImage() {
    return Container(
      alignment: Alignment.center,
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.grey,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.asset('assets/person_avatar.png'),
      ),
    );
  }

  usernameText() {
    return Text(
      "User Name",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    );
  }

  occuptionText() {
    return Text(
      "Occuption",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
      textAlign: TextAlign.center,
    );
  }

  quoteText() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/quote_left.png',
          width: 35,
          height: 25,
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vestibulum maecenas tincidunt mauris donec commodo.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'assets/quote_right.png',
            width: 35,
            height: 25,
          ),
        ),
      ],
    );
  }

  askText() {
    return Text(
      "Ask Auro 5 questions for just 15\$",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    );
  }

  buyButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {},
          child: Card(
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Color(0xff000000).withOpacity(0.15),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                )
              ]),
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
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Color(0xff000000).withOpacity(0.15),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                )
              ]),
              width: MediaQuery.of(context).size.width / 2.3,
              child: Text(
                "Buy Bundle",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  noteText() {
    return Text(
      "Please note that this does  noot consider investment advice. Questions should be on investment concepts and not of any individual securities?",
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
      textAlign: TextAlign.justify,
    );
  }
}
