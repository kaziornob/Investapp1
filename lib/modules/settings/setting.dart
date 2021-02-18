import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/global.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _isSettingInProgress = false;

  @override
  void initState() {
    super.initState();
    loadUserDetails();
  }

  loadUserDetails() async {
    setState(() {
      _isSettingInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isSettingInProgress = false;
    });
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        //globe icon
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:3.0),
              child: Image(
                  height: 40,
                  width: 40,
                  image: new AssetImage('assets/appIcon.png')
              ),
            ),
            FractionalTranslation(
              translation: Offset(-0.5, 0.0),
              child: GestureDetector(
                onTap: () {
                },
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 6.0,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(65.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AllCoustomTheme.getAppBarBackgroundThemeColors(),
                title: _buildAppBar(context),
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall: _isSettingInProgress,
            opacity: 0,
            progressIndicator: CupertinoActivityIndicator(
              radius: 12,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: !_isSettingInProgress
                    ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: appBarheight,
                    ),
                    Row(
                      children: <Widget>[
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Animator(
                            tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0.2, 0)),
                            duration: Duration(milliseconds: 500),
                            cycles: 0,
                            builder: (anim) => FractionalTranslation(
                              translation: anim.value,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AllCoustomTheme.getTextThemeColors(),
                              ),
                            ),
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
                                'User Profile',
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
                      children: <Widget>[
                        Text(
                          'Name',
                          style: TextStyle(
                            color: AllCoustomTheme.getsecoundTextThemeColor(),
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Denis',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                        AnimatedForwardArrow(
                          isShowingarroeForward: false,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: AnimatedDivider(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'E-Mail',
                          style: TextStyle(
                            color: AllCoustomTheme.getsecoundTextThemeColor(),
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'denisabdulin@gmail.com',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                        AnimatedForwardArrow(
                          isShowingarroeForward: false,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: AnimatedDivider(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Change Password',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                        AnimatedForwardArrow(
                          isShowingarroeForward: true,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: AnimatedDivider(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Delete account',
                          style: TextStyle(
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                        AnimatedForwardArrow(
                          isShowingarroeForward: true,
                        ),
                      ],
                    ),
                  ],
                )
                    : SizedBox(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
