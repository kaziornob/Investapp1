import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class InvestedAssetModule extends StatefulWidget {
  @override
  _InvestedAssetModuleState createState() => _InvestedAssetModuleState();
}

class _InvestedAssetModuleState extends State<InvestedAssetModule> {

  bool _isInProgress = false;
  String selectedAssetModule;
  String moduleParagraph;
  List<String> disclaimers = [];

  @override
  void initState() {
    super.initState();
    loadDetails();
  }


  loadDetails() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isInProgress = false;
      tableModule.initData([]);
    });
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Activity', 200),
      _getTitleItemWidget('Coins Earned', 200),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(tableModule.moduleTableInfo[index].activity),
      width: 100,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Text(tableModule.moduleTableInfo[index].coinsEarned),
              )
            ],
          ),
          width: 200,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
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
                              child: Container(
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: Center(
                                    child: new Image(
                                        width: 270.0,
                                        fit: BoxFit.fill,
                                        image: new AssetImage('assets/logo.png')
                                    ),
                                  )
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5,right: 5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: new FormField(
                                builder: (FormFieldState state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      ),
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: ConstanceData.SIZE_TITLE20,
                                          color: AllCoustomTheme.getTextThemeColors()
                                      ),

                                      errorText: state.hasError ? state.errorText : null,
                                    ),
                                    isEmpty: selectedAssetModule == '',
                                    child: new DropdownButtonHideUnderline(
                                        child: ButtonTheme(
                                          alignedDropdown: true,
                                          child: Container(
                                            height: 16.0,
                                            child: new DropdownButton(
                                              value: selectedAssetModule,
                                              dropdownColor: AllCoustomTheme.getThemeData().primaryColor,
                                              isExpanded: true,
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  selectedAssetModule = newValue;
                                                  setAssetModuleData();
                                                });
                                              },
                                              items: <String>['Adaptive Investment Learning', 'Investment Track Record', 'Investment Stock Pitch',
                                                'Investment QnA',
                                                'Social Investment Score']
                                                  .map((String value) {
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
                                          ),
                                        )
                                    ),
                                  );
                                },
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Visibility(
                      visible: selectedAssetModule==null,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5.0),
                          child: Container(
                            child: Text(
                              "Having invested in multiple asset classes for 20+ years,"
                                  " Team Auro has a deep appreciation for what metrics differentiate a good investor from a great investor. "
                                  "Based on that we’ve created Auro Coins to reward our best performing invest.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AllCoustomTheme.getTextThemeColors(),
                                fontSize: ConstanceData.SIZE_TITLE18,
                              ),
                            ),
                          ),
                        ),
                    ),
                    // module paragraph section
                    Visibility(
                      visible: selectedAssetModule!=null && moduleParagraph!=null && moduleParagraph!="",
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5,right: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                     "$moduleParagraph",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AllCoustomTheme.getTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE18,
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: moduleParagraph!="",
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    // table content
                    Visibility(
                      visible: selectedAssetModule!=null,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5.0),
                          child: Container(
                            child: HorizontalDataTable(
                              leftHandSideColumnWidth: 200,
                              rightHandSideColumnWidth: 200,
                              isFixedHeader: true,
                              headerWidgets: _getTitleWidget(),
                              leftSideItemBuilder: _generateFirstColumnRow,
                              rightSideItemBuilder: _generateRightHandSideColumnRow,
                              itemCount: tableModule.moduleTableInfo.length,
                              rowSeparatorWidget: const Divider(
                                color: Colors.black54,
                                height: 1.0,
                                thickness: 0.0,
                              ),
                              leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
                              rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
                            ),
                            height: MediaQuery.of(context).size.height * 0.70,
                          )
                      ),
                    ),
                    Visibility(
                      visible: disclaimers.length!=0,
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    // disclaimers box
                    Visibility(
                      visible: selectedAssetModule!=null && disclaimers.length!=0,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 13,right: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height*0.35,
                                  child: ListView.builder(
                                    itemCount: disclaimers.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          "${disclaimers[index]}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE16,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
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

  setAssetModuleData()
  {

    setState(() {
      if(selectedAssetModule=="Adaptive Investment Learning")
        {
          moduleParagraph = "A user can watch educational videos and attempt Investment questions, that are customized to their level of investment knowledge,  to earn coins:";
          disclaimers =[];

          var tempData = [
            {
              "activity": "Beginner Questions",
              "coinsEarned": "1"
            },
            {
              "activity": "Intermediate Questions",
              "coinsEarned": "2"
            },
            {
              "activity": "Advanced Questions",
              "coinsEarned": "3"
            }
          ];
          tableModule.initData(tempData);
        }

      else if(selectedAssetModule=="Investment Track Record")
        {
          moduleParagraph="";
          disclaimers.add("* These rewards are earned only portfolio has been managed for more than 3 months");
          var tempData = [
            {
              "activity": "Weekly return>33bps",
              "coinsEarned": "500"
            },
            {
              "activity": "Weekly return>50bps",
              "coinsEarned": "1000"
            },
            {
              "activity": "Weekly return>75bps",
              "coinsEarned": "1500"
            },
            {
              "activity": "Weekly return>1%",
              "coinsEarned": "2000"
            },
            {
              "activity": "Monthly return>1%",
              "coinsEarned": "500"
            },
            {
              "activity": "Monthly return>2%",
              "coinsEarned": "1000"
            },
            {
              "activity": "Monthly return>3%",
              "coinsEarned": "1500"
            },
            {
              "activity": "Monthly return>4%",
              "coinsEarned": "2000"
            },
            {
              "activity": "Quarterly return>5%",
              "coinsEarned": "1000"
            },
            {
              "activity": "Quarterly return>10%",
              "coinsEarned": "1500"
            },
            {
              "activity": "Quarterly return>15%",
              "coinsEarned": "2000"
            },
            {
              "activity": "Annual return>15%",
              "coinsEarned": "1500"
            },
            {
              "activity": "Annual return>20%",
              "coinsEarned": "2000"
            },
            {
              "activity": "Annual return>30%",
              "coinsEarned": "3000"
            },
            {
              "activity": "Annual return>40%",
              "coinsEarned": "4000"
            },
            {
              "activity": "Annual return>50%",
              "coinsEarned": "5000"
            },
            {
              "activity": "Sharpe ratio >1,ann return >15%",
              "coinsEarned": "*2000"
            },
            {
              "activity": "Sharpe ratio <0.5",
              "coinsEarned": "*-1500"
            },
            {
              "activity": "Sharpe ratio<2, return>15%",
              "coinsEarned": "*3000"
            },
            {
              "activity": "Sharpe ratio<1, return>20%",
              "coinsEarned": "*4000"
            },
            {
              "activity": "Sharpe ratio<2, return>20%",
              "coinsEarned": "*5000"
            }
          ];

          tableModule.initData(tempData);
        }

      else if(selectedAssetModule=="Investment Stock Pitch")
      {
        moduleParagraph="";
        disclaimers.add("* : Minimum return of 15%");
        disclaimers.add("** :  Atleast 10 reviews, >50% True");
        disclaimers.add("# : Atleast 10 reviews, <50% True");
        disclaimers.add("## : Value falls by more than 50%");
        disclaimers.add("^ :Value goes up by more than 50%");

        var tempData = [
          {
            "activity": "Approval Long",
            "coinsEarned": "500"
          },
          {
            "activity": "Approval Short",
            "coinsEarned": "1000"
          },
          {
            "activity": "1-yr Long Tgt price achieved (+-3%)​ *",
            "coinsEarned": "1500"
          },
          {
            "activity": "1-yr Short Tgt price achieved (+-3%)​",
            "coinsEarned": "2500"
          },
          {
            "activity": "1-yr Long loses money​",
            "coinsEarned": "-1500"
          },
          {
            "activity": "1-yr Short loses >20%​",
            "coinsEarned": "-1500"
          },
          {
            "activity": "1-yr Rev achieved (+-3%)​",
            "coinsEarned": "-1500"
          },
          {
            "activity": "1-yr eps achieved (+-3%)",
            "coinsEarned": "2000"
          },
          {
            "activity": "inv thesis peer review - True  **",
            "coinsEarned": "2000"
          },
          {
            "activity": "inv thesis peer review - False  #",
            "coinsEarned": "-1000"
          },
          {
            "activity": "Closing a loss-making long trade before 1- Year",
            "coinsEarned": "-1000"
          },
          {
            "activity": "Closing a loss-making short trade before 1- Year",
            "coinsEarned": "-500"
          },
          {
            "activity": "Breaching max drawdown on long #",
            "coinsEarned": "#2000"
          },
          {
            "activity": "Breaching max drawdown on short #",
            "coinsEarned": "^-1000"
          }
        ];

        tableModule.initData(tempData);
      }

      else if(selectedAssetModule=="Investment QnA")
      {
        moduleParagraph="";
        disclaimers.add("* if it is not the highest upvoted answer as given below");
        disclaimers.add("** Net score= total upvoted- total downvoted");
        disclaimers.add("# if it is not answer with lowest score as below");
        disclaimers.add("## Only for answer with lowest net score and if there are more than 5 answers to the question");

        var tempData = [
          {
            "activity": "Ask a Question",
            "coinsEarned": "-5"
          },
          {
            "activity": "Answer a Question",
            "coinsEarned": "10"
          },
          {
            "activity": "Answer a Question with video/whiteboard​",
            "coinsEarned": "25"
          },
          {
            "activity": "Question is voted up",
            "coinsEarned": "1"
          },
          {
            "activity": "Answer is upvoted",
            "coinsEarned": "1*"
          },
          {
            "activity": "Answer with highest net score",
            "coinsEarned": "25**"
          },
          {
            "activity": "Comments added to above answer",
            "coinsEarned": "1"
          },
          {
            "activity": "Answer is marked accepted",
            "coinsEarned": "50"
          },
          {
            "activity": "Award a bounty for answers",
            "coinsEarned": "50-500"
          },
          {
            "activity": "Award a bounty for consltation",
            "coinsEarned": "500-5000"
          },
          {
            "activity": "Bounty awarded to your answers",
            "coinsEarned": "Full bounty"
          },
        ];

        tableModule.initData(tempData);
      }

      else if(selectedAssetModule=="Social Investment Score")
      {
        moduleParagraph="";
        disclaimers = [];

        var tempData = [
          {
            "activity": "Receive coins by referring a friend",
            "coinsEarned": "100"
          },
          {
            "activity": "> Daily Login Bonus",
            "coinsEarned": "1"
          },
          {
            "activity": "> Weekly Login Bonus",
            "coinsEarned": "10"
          },
          {
            "activity": "Quarterly Streak (Logged in daily for last 3 months)",
            "coinsEarned": "50"
          },
          {
            "activity": "Go pro",
            "coinsEarned": "50"
          },
          {
            "activity": "Go Live and make First Cash Deposit",
            "coinsEarned": "100"
          },
          {
            "activity": "Raise your Question to top of All Questions page",
            "coinsEarned": "-500"
          },
          {
          "activity": "Raise your Question to top of Questions page for a partimar tag",
          "coinsEarned": "-100"
          },
          {
          "activity": "Raise your profile to top of All Profile Page ",
          "coinsEarned": "-1000"
          },
          {
            "activity": "Raise your profile to top of Profiles page for a particular Club",
            "coinsEarned": "-100"
          }
        ];

        tableModule.initData(tempData);
      }

    });
  }
}

TableModule tableModule = TableModule();

class TableModule {
  List<AssetModuleTableInfo> moduleTableInfo;

  void initData(tableData) {

    moduleTableInfo = [];
    for(var i=0 ; i <tableData.length; i++)
      {
        moduleTableInfo.add(AssetModuleTableInfo(tableData[i]["activity"],tableData[i]["coinsEarned"]));
      }
  }
}

class AssetModuleTableInfo {
  String activity;
  String coinsEarned;

  AssetModuleTableInfo(this.activity, this.coinsEarned);
}