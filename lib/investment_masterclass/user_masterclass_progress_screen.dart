import 'package:auroim/investment_masterclass/style.dart';
import 'package:auroim/reusable_widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UserMasterclassProgressScreen extends StatefulWidget {
  final List allClasses;

  const UserMasterclassProgressScreen({
    Key key,
    this.allClasses,
  }) : super(key: key);

  @override
  _UserMasterclassProgressScreenState createState() =>
      _UserMasterclassProgressScreenState();
}

class _UserMasterclassProgressScreenState
    extends State<UserMasterclassProgressScreen> {
  final TextEditingController searchEditingController = TextEditingController();
  LinearGradient progressGradient;

  @override
  void initState() {
    progressGradient = LinearGradient(
      colors: [
        Colors.white,
        Color(0xFF235E77),
      ],
    );
    super.initState();
  }

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
                  height: 15,
                ),
                heading("Investment Masterclass"),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: widget.allClasses
                      .map<Widget>(
                        (className) => singleBox(
                            width * 0.87, height * 0.1, className, 80),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  heading(text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 30,
        fontFamily: "RobotoLight",
        color: Colors.black,
        fontWeight: FontWeight.w100,
      ),
      textAlign: TextAlign.start,
    );
  }

  singleBox(width, height, title, percent) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StyleScreen(title: title,),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Material(
          elevation: 5,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.05),
            borderSide: BorderSide(
              color: Color(0xFFE8E7E7),
            ),
          ),
          child: Stack(
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Color(0xFFE8E7E7),
                  borderRadius: BorderRadius.circular(width * 0.05),
                ),
              ),
              Positioned(
                bottom: 20,
                left: height / 2,
                child: progressBar(width * 0.7, percent),
              ),
              Positioned(
                top: 0,
                left: ((height / 2) * 2) + 10,
                child: Container(
                  // decoration: BoxDecoration(border: Border.all()),
                  width: width * 0.7,
                  height: height * 0.6,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Roboto",
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: (height / 2) - 8,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: (height / 2) - 22,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/play_button.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  progressBar(width, percent) {
    return LinearPercentIndicator(
      percent: percent / 100,
      linearGradient: progressGradient,
      lineHeight: 9,
      width: width,
      trailing: Text("$percent%"),
    );
  }
}
