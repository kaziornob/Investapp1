import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/widgets/myProfile/addEditEducation.dart';
import 'package:auroim/widgets/myProfile/addEditEmployment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            child: ListTile(
              leading: CircleAvatar(
                radius: 15.0,
                backgroundImage: new AssetImage('assets/download.jpeg'),
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
/*          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // edu section
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundImage: new AssetImage('assets/download.jpeg'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Text(
                      "${data[index]['qus']}",
                      style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColor(),
                          fontSize: ConstanceData.SIZE_TITLE16,
                          fontFamily: "Roboto",
                          package: 'Roboto-Regular',
                          letterSpacing: 0.2
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          );*/
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
            child: ListTile(
              leading: CircleAvatar(
                radius: 15.0,
                backgroundImage: new AssetImage('assets/download.jpeg'),
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
    var userProvider = Provider.of<UserDetails>(context, listen: false);
    if (widget.userName == null) {
      title = userProvider.userDetails["f_name"] != null &&
          userProvider.userDetails != null
          ? "${userProvider.userDetails["f_name"]}\'s Background"
          : 'Background';
    } else {
      title = "${widget.userName}\'s Background";
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 5.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.09,
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFD8AF4F),
                          fontSize: ConstanceData.SIZE_TITLE18,
                          fontFamily: "Roboto",
                          package: 'Roboto-Regular',
                        ),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.43),
                  padding: EdgeInsets.only(
                    bottom: 3, // space between underline and text
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AllCoustomTheme.getHeadingThemeColors(),
                        width: 1.0, // Underline width
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Current Employer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColor(),
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontFamily: "Roboto",
                        package: 'Roboto-Regular',
                      ),
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
                    child: Icon(
                      empList.length == 0 ? Icons.add_box_sharp : Icons.edit,
                      color: AllCoustomTheme.getSeeMoreThemeColor(),
                      size: 25,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: getEmpList(empList),
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Highest Education Qualification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColor(),
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontFamily: "Roboto",
                        package: 'Roboto-Regular',
                      ),
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
                    child: Icon(
                      eduList.length == 0 ? Icons.add_box_sharp : Icons.edit,
                      color: AllCoustomTheme.getSeeMoreThemeColor(),
                      size: 25,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.20,
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
      ],
    );
  }
}
