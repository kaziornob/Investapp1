import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/home/add_comment_bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MainPlusTab extends StatefulWidget {
  @override
  _MainPlusTabState createState() => _MainPlusTabState();
}

class _MainPlusTabState extends State<MainPlusTab> {
  bool _isInProgress = false;
  List<String> userList = <String>['Abhinav', 'Amar'];

  String selectedUser = "Abhinav";
  List<String> tagItemList = <String>['native', 'fixed'];

  @override
  void initState() {
    // displayModalBottomSheet(context);
    super.initState();
    onInitDisplayBootomSheet();
    loadUserDetails();
  }

  loadUserDetails() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isInProgress = false;
    });
  }

  Widget getUserField() {
    return new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE20,
                color: AllCoustomTheme.getTextThemeColor()),
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
                dropdownColor: Colors.white,
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
                        color: AllCoustomTheme.getTextThemeColor(),
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontFamily: "Roboto",
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

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        SafeArea(
            bottom: true,
            child: Scaffold(
              backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
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
              body: ModalProgressHUD(
                inAsyncCall: _isInProgress,
                opacity: 0,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 12,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: !_isInProgress
                        ? Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      //   _homeScaffoldKey.currentState.openDrawer();
                                    },
                                    child: Animator(
                                      tween: Tween<Offset>(
                                          begin: Offset(0, 0),
                                          end: Offset(0.2, 0)),
                                      duration: Duration(milliseconds: 500),
                                      cycles: 0,
                                      builder: (anim) => FractionalTranslation(
                                        translation: anim.value,
                                        child: Icon(
                                          Icons.sort,
                                          color: AllCoustomTheme
                                              .getsecoundTextThemeColor(),
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
                                          'Start Post',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: AllCoustomTheme
                                                .getTextThemeColor(),
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                ConstanceData.SIZE_TITLE20,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
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
                                child: TextField(
                                  maxLines: 50,
                                  decoration: InputDecoration(
                                    hintText: 'What do you want to talk about?',
                                    hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: ConstanceData.SIZE_TITLE14),
                                    labelStyle: AllCoustomTheme
                                        .getTextFormFieldLabelStyleTheme(),
                                    focusColor:
                                        AllCoustomTheme.getTextThemeColor(),
                                    fillColor:
                                        AllCoustomTheme.getTextThemeColor(),
                                  ),
                                  cursorColor:
                                      AllCoustomTheme.getTextThemeColor(),
                                  style: AllCoustomTheme
                                      .getTextFormFieldBaseStyleTheme(),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                  ),
                ),
              ),
            ))
      ],
    );
  }

  displayModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
      builder: (builder) {
        return AddCommentBottomSheetWidget();
      },
    );
  }

  onInitDisplayBootomSheet() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(
        context: context,
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        builder: (builder) {
          return AddCommentBottomSheetWidget();
        },
      );
    });
  }
}
