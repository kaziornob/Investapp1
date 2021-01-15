import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class PollOption {
  final String id;
  String textTitle;
  String textLink;

  PollOption(this.id,this.textTitle,this.textLink);
}

class CreatePoll extends StatefulWidget {
  @override
  _CreatePollState createState() => _CreatePollState();
}

class _CreatePollState extends State<CreatePoll> {
  bool _isInProgress = false;
  double optionHeight = 0.0;
  
  List<PollOption> optionList = [];
  int _optionIndex = 1;

  List<String> pollDurationList = <String>['7 days','14 days','21 days'];

  String selectedPollDuration;

  @override
  void initState() {
    super.initState();
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

  void takeOptionNumber(String text, String from , String itemId) {

    try {
      if(optionList!=null && optionList.length!=0)
      {
        for (PollOption optObj in optionList)
        {
          if(optObj.id == itemId)
          {
            if(from=="title")
              optObj.textTitle = text;
            else if (from=="link")
              optObj.textLink = text;
          }
        }

      }

    } on FormatException {}
  }



  Widget getDurationDropDownList()
  {
    if (pollDurationList != null && pollDurationList.length != 0)
    {
      return new DropdownButtonHideUnderline(
        child: new DropdownButton(
          value: selectedPollDuration,
          dropdownColor: AllCoustomTheme.getThemeData().primaryColor,
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedPollDuration = newValue;
            });
          },
          items: pollDurationList.map((String value) {
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
      );
    }
    else
    {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }



  Widget getDurationField()
  {
    return new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: 'Poll duration',
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE20,
                color: AllCoustomTheme.getTextThemeColors()
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
            ),

            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: selectedPollDuration == '',
          child: getDurationDropDownList(),
        );
      },
      validator: (val) {
        return ((val != null && val!='') || (selectedPollDuration!=null && selectedPollDuration!='')) ? null : 'choose one';
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
              ],
            ),
          ),
        ),
        SafeArea(
            bottom: true,
            child: Scaffold(
              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
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
                                    'Create a poll',
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
                        Container(
                          height: 100,
                          child: TextField(
                            maxLines: 10,
                            decoration: InputDecoration(
                              labelText: 'Your Question',
                              hintText: 'Which Tech stock offers the best upside return for the next 1 year? ',
                              hintStyle: TextStyle(
                                  fontSize: ConstanceData.SIZE_TITLE10,
                                  color: AllCoustomTheme.getTextThemeColors()
                              ),
                              labelStyle: TextStyle(
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                  color: AllCoustomTheme.getTextThemeColors()
                              ),
                              fillColor: Colors.white,
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 1.0),
                              ),
                            ),
                            style: TextStyle(
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: optionList.length!=0 ? optionHeight : 0.0,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: optionList.length,
                              itemBuilder: (context, index) {
                                if (optionList.isEmpty) {
                                  return Row();
                                } else {
                                  return Dismissible(
                                    key: Key(optionList[index].id.toString()),
                                    direction: DismissDirection.startToEnd,
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          height: 70,
                                          margin: EdgeInsets.only(bottom: 20.0),
                                          child: TextFormField(
                                            onChanged: (text) {
                                              takeOptionNumber(text,'title' ,optionList[index].id);
                                            },
                                            initialValue: optionList[index].textTitle,
                                            decoration: InputDecoration(
                                              border: new OutlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: AllCoustomTheme.getsecoundTextThemeColor(),
                                                      width: 12.0
                                                  )),
                                              // labelText: 'Option 1',
                                              hintText: 'Eg: Apple ',
                                              hintStyle: TextStyle(
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                  color: AllCoustomTheme.getTextThemeColors()
                                              ),
                                              labelText: 'Option ${index+1} ',
                                              labelStyle: TextStyle(
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                  color: AllCoustomTheme.getTextThemeColors()
                                              ),
                                              fillColor: Colors.white,
                                              focusedBorder:OutlineInputBorder(
                                                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Colors.white, width: 1.0),
                                              ),

                                            ),
                                            style: TextStyle(
                                              color: AllCoustomTheme.getTextThemeColors(),
                                              fontSize: ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                size: 20.0,
                                                color: Colors.red,
                                              ),
                                            ),
                                            onTap: ()
                                            {
                                              _showConfirmation('option',index);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40, left: 14, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                                child:  Container(
                                  height: 30,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: AllCoustomTheme.getThemeData().textSelectionColor,
                                    border: new Border.all(color: Colors.white, width: 1.5),
                                  ),
                                  child: MaterialButton(
                                    splashColor: Colors.grey,
                                    child: Text(
                                      "Add Option",
                                      style: TextStyle(
                                        color: AllCoustomTheme.getTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        optionList.add(PollOption("$_optionIndex",'',''));
                                        _optionIndex++;
                                        optionHeight = optionHeight + 100.0;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: getDurationField(),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 14, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 50,
                                child: Animator(
                                  tween: Tween<double>(begin: 0.8, end: 1.1),
                                  curve: Curves.easeInToLinear,
                                  cycles: 0,
                                  builder: (anim) => Transform.scale(
                                    scale: anim.value,
                                    child: Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        border: new Border.all(color: Colors.white, width: 1.5),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            globals.buttoncolor1,
                                            globals.buttoncolor2,
                                          ],
                                        ),
                                      ),
                                      child: MaterialButton(
                                        splashColor: Colors.grey,
                                        child: Text(
                                          "Done",
                                          style: TextStyle(
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                        : SizedBox(),
                  ),
                ),
              ),
            )
        )
      ],
    );
  }


  void _showConfirmation(from,index) {
    double cWidth = MediaQuery.of(context).size.width * 0.71;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
                'Are you sure to delete it?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              )),
          actions: <Widget>[
            new Container(
                width: cWidth,
                child: new Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: <Widget>[
                    new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                    ),
                    new FlatButton(
                      padding: EdgeInsets.fromLTRB(120, 0.0, 20, 0.0),
                      onPressed: () async {
                        if(from=='option')
                        {
                          dynamic option;
                          setState(() {
                            option = optionList.removeAt(index);
                            optionHeight = optionHeight - 100.0;
                          });

                          if(option!=null)
                            {
                              Toast.show("Deleted successfully", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            }
                          else
                            {
                              Toast.show("Not Found", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            }
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(fontSize: 18.0, color: Colors.blue),
                      ),
                    ),
                  ],
                ))
          ],
        );
      },
    );
  }
}
