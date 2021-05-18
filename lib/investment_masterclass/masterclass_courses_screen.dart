import 'package:auroim/investment_masterclass/user_masterclass_progress_screen.dart';
import 'package:auroim/reusable_widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MasterClassCoursesScreen extends StatefulWidget {
  @override
  _MasterClassCoursesScreenState createState() => _MasterClassCoursesScreenState();
}

class _MasterClassCoursesScreenState extends State<MasterClassCoursesScreen> {
  final TextEditingController searchEditingController = TextEditingController();

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
                    context),
                SizedBox(
                  height: height * 0.07,
                ),
                stackedWidget(
                    width * 0.6,
                    height * 0.2,
                    Color(0xFFD8AF4F),
                    "Auro Intermediate",
                    "With prior investment knowledge",
                    context),
                SizedBox(
                  height: height * 0.07,
                ),
                stackedWidget(
                    width * 0.6,
                    height * 0.2,
                    Color(0xFFE3E1F5),
                    "Auro Advance",
                    "With material investment knowledge",
                    context),
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
            builder: (context) => UserMasterclassProgressScreen(),
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
}
