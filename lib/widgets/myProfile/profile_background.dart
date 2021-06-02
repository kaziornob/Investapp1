import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/settings/add_about_info.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/widgets/myProfile/addEditEducation.dart';
import 'package:auroim/widgets/myProfile/addEditEmployment.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileBackground extends StatefulWidget {
  final userName;

  const ProfileBackground({Key key, this.userName}) : super(key: key);

  @override
  _ProfileBackgroundState createState() => _ProfileBackgroundState();
}

class _ProfileBackgroundState extends State<ProfileBackground> {
  String title = "";
  List eduList = [
    {
      "id": 1,
      "title": "B.Ed",
      "start_year": 2012,
      "end_year": 2016,
      "desc": ""
    },
  ];

  List empList = [
    {
      "id": 1,
      "title": "Tatras",
      "start_year": 2012,
      "end_year": 2021,
      "desc": ""
    },
  ];

  Widget getEmpList(data) {
    if (data != null && data.length != 0) {
      return new ListView.builder(
        itemCount: data.length,
        physics: NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 20.0,
                backgroundImage: new AssetImage('assets/user_outline.png'),
                backgroundColor: Colors.transparent,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    data[index]['title'],
                    style: new TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      package: 'Roboto-Regular',
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                "${data[index]['start_year']}" +
                    "-" +
                    "${data[index]['end_year']}",
                style: new TextStyle(
                  color: AllCoustomTheme.getTextThemeColor(),
                  fontSize: ConstanceData.SIZE_TITLE16,
                  fontFamily: "Roboto",
                  package: 'Roboto-Regular',
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          "No data available yet",
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: AllCoustomTheme.getTextThemeColor(),
            fontSize: ConstanceData.SIZE_TITLE18,
            fontFamily: "Rasa",
          ),
        ),
      );
    }
  }

  Widget getEduList(data) {
    if (data != null && data.length != 0) {
      return new ListView.builder(
        itemCount: data.length,
        physics: NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 20.0,
                backgroundImage: new AssetImage('assets/user_outline.png'),
                backgroundColor: Colors.transparent,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    data[index]['title'],
                    style: new TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      package: 'Roboto-Regular',
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                "${data[index]['start_year']}" +
                    "-" +
                    "${data[index]['end_year']}",
                style: new TextStyle(
                  color: AllCoustomTheme.getTextThemeColor(),
                  fontSize: ConstanceData.SIZE_TITLE16,
                  fontFamily: "Roboto",
                  package: 'Roboto-Regular',
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          "No data available yet",
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: AllCoustomTheme.getTextThemeColor(),
            fontSize: ConstanceData.SIZE_TITLE18,
            fontFamily: "Rasa",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 5.0,
            top: 10.0,
          ),
          child: Container(
            child: Text(
              "Your Background",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: ConstanceData.SIZE_TITLE18,
                fontFamily: "Roboto",
                package: 'Roboto-Regular',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 15.0,
            top: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Current Employer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      package: 'Roboto-Regular',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) =>
                              AddEditEmployment(),
                        ),
                      );
                    },
                    child: Image.asset(
                      "assets/pen_outline.png",
                      width: 20,
                      height: 20,
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: getEmpList(empList),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Highest Education Qualification',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      package: 'Roboto-Regular',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) => AddEditEducation(),
                        ),
                      );
                    },
                    child: Image.asset(
                      "assets/pen_outline.png",
                      width: 20,
                      height: 20,
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      // decoration: BoxDecoration(
                      //   border: Border.all(),
                      // ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: getEduList(eduList),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        ExpandablePanel(
          header: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 20,
            ),
            child: Container(
              // decoration: BoxDecoration(border: Border.all()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'About',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AllCoustomTheme.getTextThemeColor(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                      fontFamily: "Roboto",
                      package: 'Roboto-Regular',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Material(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    elevation: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          hasIcon: false,
          expanded: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "My name is Tatras and I am a Developer who is working to be an entrepreneur.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddAboutInfo(),
                      ),
                    );
                  },
                  child: Image.asset(
                    "assets/pen_outline.png",
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(
              FontAwesomeIcons.edit,
              color: Colors.black,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Request a recommendation",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: "Roboto",
                  color: Colors.black,
                ),
              ),
            ),
            subtitle: Text(
              "Request a recommendation From Auro.AI on any topic",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Roboto",
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
