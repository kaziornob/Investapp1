import 'package:auroim/investment_masterclass/invesment_masterclass_models/practionars.dart';
import 'package:flutter/material.dart';

class GroupLiveClasses extends StatefulWidget {
  const GroupLiveClasses({Key key}) : super(key: key);

  @override
  _GroupLiveClassesState createState() => _GroupLiveClassesState();
}

class _GroupLiveClassesState extends State<GroupLiveClasses> {
  String groupModuleName, oneModuleName;
  bool groupVisible = false;
  bool groupModuleVisible = false;
  bool oneVisible = false;
  bool oneModuleVisible = false;

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
                Center(
                  child: Image.asset(
                    'assets/auro_edu.png',
                    width: MediaQuery.of(context).size.width * 0.60,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                firstText(),
                const SizedBox(
                  height: 25,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => PractionarsScreen(),
                      ),
                    );
                  },
                  leading: Image.asset(
                    "assets/conference.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    "View Investment Practitioner Mentor profiles",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  trailing: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Image.asset(
                    "assets/academic_theory.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    "Not just academic theory but real-life investment case studies across Listed , Unlisted and Digital assets",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  trailing: SizedBox(),
                ),
                const SizedBox(
                  height: 40,
                ),
                Visibility(
                  visible: oneVisible,
                  child: SizedBox.shrink(),
                  replacement: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Group  Live Classes',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ListTile(
                          title: Text(
                            'Learn with like-minded peers in live classes guided by dedicated mentors',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(0),
                          trailing: InkWell(
                            onTap: () {
                              if (groupVisible) {
                                groupModuleName = null;
                                groupModuleVisible = false;
                              }
                              groupVisible = !groupVisible;
                              setState(() {});
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: RotatedBox(
                                  quarterTurns: groupVisible ? 45 : 0,
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: oneVisible,
                  child: SizedBox.shrink(),
                  replacement: const SizedBox(
                    height: 25,
                  ),
                ),
                Visibility(
                  visible: groupVisible,
                  child: SizedBox.shrink(),
                  replacement: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1 to 1 Session',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ListTile(
                          title: Text(
                            'A tailor-made class based on individual request guided by practitioners or dedicated mentors',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(0),
                          trailing: InkWell(
                            onTap: () {
                              if (oneVisible) {
                                oneModuleName = null;
                                oneModuleVisible = false;
                              }
                              oneVisible = !oneVisible;
                              setState(() {});
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.white,
                                child: RotatedBox(
                                  quarterTurns: oneVisible ? 45 : 0,
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: groupVisible,
                  child: SizedBox.shrink(),
                  replacement: const SizedBox(
                    height: 25,
                  ),
                ),
                Visibility(
                  visible: groupVisible,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        focusColor: Colors.white,
                        value: groupModuleName,
                        //elevation: 5,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: <String>[
                          'Module Name 1',
                          'Module Name 2',
                          'Module Name 3',
                          'Module Name 4',
                          'Module Name 5',
                          'Module Name 6',
                          'Module Name 7',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        icon: RotatedBox(
                          quarterTurns: 45,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                        ),
                        hint: Text(
                          "Select Module",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            groupModuleName = value;
                            groupModuleVisible = true;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: oneVisible,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        focusColor: Colors.white,
                        value: oneModuleName,
                        //elevation: 5,
                        style: TextStyle(color: Colors.white),
                        iconEnabledColor: Colors.black,
                        items: <String>[
                          'Module Name 1',
                          'Module Name 2',
                          'Module Name 3',
                          'Module Name 4',
                          'Module Name 5',
                          'Module Name 6',
                          'Module Name 7',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        icon: RotatedBox(
                          quarterTurns: 45,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                        ),
                        hint: Text(
                          "Select Module",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String value) {
                          setState(() {
                            oneModuleName = value;
                            oneModuleVisible = true;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: groupModuleVisible,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Please book your seats buy clicking this button',
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Card(
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff000000).withOpacity(0.15),
                                        offset: const Offset(
                                          5.0,
                                          5.0,
                                        ),
                                        blurRadius: 5.0,
                                        spreadRadius: 2.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(7)),
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: Text(
                                  'Pay 49\$',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: oneModuleVisible,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title: Text(
                          'Please select Date and time.',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Card(
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff000000).withOpacity(0.15),
                                        offset: const Offset(
                                          5.0,
                                          5.0,
                                        ),
                                        blurRadius: 5.0,
                                        spreadRadius: 2.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(7)),
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: Text(
                                  'Pay 500\$',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget backButton() {
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

  Widget firstText() {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Text(
        'Prefer to learn in LIVE class with marquis teachers who will also become your mentors?',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget titleSubtitle(String title, String subtitle) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 20, right: 20),
      padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ListTile(
            title: Text(
              subtitle,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            contentPadding: EdgeInsets.all(0),
            trailing: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // Text(
          //   subtitle,
          //   style: TextStyle(
          //     fontFamily: 'Roboto',
          //     fontSize: 16,
          //     fontWeight: FontWeight.w300,
          //   ),
          // )
        ],
      ),
    );
  }
}
