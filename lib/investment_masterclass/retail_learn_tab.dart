import 'package:auroim/investment_masterclass/masterclass_courses_screen.dart';
import 'package:auroim/reusable_widgets/search_bar.dart';
import 'package:flutter/material.dart';

class RetailLeanTab extends StatefulWidget {
  @override
  _RetailLeanTabState createState() => _RetailLeanTabState();
}

class _RetailLeanTabState extends State<RetailLeanTab> {
  final TextEditingController searchEditingController = TextEditingController();

  @override
  void dispose() {
    searchEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            SearchBar(
              controller: searchEditingController,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    child: Image.asset("assets/auro_edu.png"),
                  ),
                ],
              ),
            ),
            box("Investing - Beginners Guide", context, width * 0.866),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                box("Fundamental", context, width * 0.4),
                box("Quant", context, width * 0.4),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                box("Crypto", context, width * 0.4),
                box("Real Estate", context, width * 0.4),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                box("Global Market", context, width * 0.4),
                box("AI", context, width * 0.4),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                box("Hedge Fund", context, width * 0.4),
                box("Financial Market", context, width * 0.4),
              ],
            ),
          ],
        ),
      ),
    );
  }

  box(text, context, width) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MasterClassCoursesScreen(),
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
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Roboto",
              color: Color(0xFFD8AF4F),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
