import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/bussPost/createPoll.dart';
import 'package:auroim/modules/bussPost/portfolioPitch.dart';
import 'package:auroim/modules/bussPost/stockPitch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPlusTab extends StatefulWidget {
  @override
  _MainPlusTabState createState() => _MainPlusTabState();
}

class _MainPlusTabState extends State<MainPlusTab> {
  List<String> userList = <String>['Pooja', 'Ritika'];

  String selectedUser = "Pooja";
  List<String> tagItemList = <String>['native', 'fixed'];

  @override
  void initState() {
    // displayModalBottomSheet(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          displayModalBottomSheet(context);
        },
        child: Icon(
          Icons.more_vert_outlined,
          color: AllCoustomTheme.getTextThemeColors(),
          size: 30.0,
        ),
        backgroundColor: AllCoustomTheme.getsecoundTextThemeColor(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Column(
              children: <Widget>[
                /*SizedBox(
            height: appBarheight,
          ),*/
                Row(
                  children: <Widget>[
                    GestureDetector(
                      // onTap: () {
                      //   _homeScaffoldKey.currentState.openDrawer();
                      // },
                      child: Icon(
                        Icons.sort,
                        color: AllCoustomTheme.getsecoundTextThemeColor(),
                      ),
                    ),
                    Expanded(
                      child: Animator(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.decelerate,
                        cycles: 1,
                        builder: (anim) => Transform.scale(
                          scale: anim.value,
                          child: Text(
                            'Start Post',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontWeight: FontWeight.bold,
                              fontSize: ConstanceData.SIZE_TITLE20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                    Expanded(
                      child: getUserField(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      // labelText: 'Employment Status',
                      hintText: 'What do you want to talk about?',
                      hintStyle: TextStyle(
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors()),
                      labelStyle: TextStyle(
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors()),
                    ),
                  ),
                ),
/*            Container(
            child: displayModalBottomSheet(context),
          ),*/
              ],
            )),
      )
    );
  }

  displayModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        builder: (builder) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40.0,
                    ),
                    CircleAvatar(
                      backgroundColor:
                      AllCoustomTheme.getsecoundTextThemeColor(),
                      radius: 20,
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: AllCoustomTheme.boxColor(),
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    CircleAvatar(
                      backgroundColor:
                      AllCoustomTheme.getsecoundTextThemeColor(),
                      radius: 20,
                      child: Icon(
                        Icons.video_call,
                        color: AllCoustomTheme.boxColor(),
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    CircleAvatar(
                      backgroundColor:
                      AllCoustomTheme.getsecoundTextThemeColor(),
                      radius: 20,
                      child: Icon(
                        Icons.image,
                        color: AllCoustomTheme.boxColor(),
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                  ],
                ),
                Divider(
                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Text(
                        'Upload stock pitch',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE18,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) => StockPitch(),
                      ),
                    );
                  },
                ),
                Divider(
                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Center(
                      child: Text(
                        'Upload portfolio pitch',
                        style: TextStyle(
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE18,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (BuildContext context) => PortfolioPitch(),
                      ),
                    );
                  },
                ),
                Divider(
                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Text(
                      'Ask a question',
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE18,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Text(
                      'Add a document',
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE18,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: AllCoustomTheme.getsecoundTextThemeColor(),
                ),
                InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) => CreatePoll(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                      child: Center(
                        child: Text(
                          'Create a poll',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE18,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          );
        });
  }

  Widget getUserField() {
    return new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE20,
                color: AllCoustomTheme.getTextThemeColors()),
            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: selectedUser == '',
          child: getUserDropDownList(),
        );
      },
      validator: (val) {
        return ((val != null && val != '') ||
                (selectedUser != null && selectedUser != ''))
            ? null
            : 'choose One';
      },
    );
  }

  Widget getUserDropDownList() {
    if (userList != null && userList.length != 0) {
      return new DropdownButtonHideUnderline(
        child: ButtonTheme(
            alignedDropdown: true,
            child: Container(
              height: 20.0,
              child: new DropdownButton(
                value: selectedUser,
                dropdownColor: AllCoustomTheme.getThemeData().primaryColor,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    selectedUser = newValue;
                  });
                },
                items: userList.map((String value) {
                  return new DropdownMenuItem(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                  );
                }).toList(),
              ),
            )),
      );
    } else {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }
}
