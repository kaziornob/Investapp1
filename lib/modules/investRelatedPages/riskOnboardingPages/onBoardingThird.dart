import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/onBoardingFourth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';


class OnBoardingThird extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingThird({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _OnBoardingThirdState createState() => _OnBoardingThirdState();
}

class _OnBoardingThirdState extends State<OnBoardingThird> {
  bool _isInProgress = false;


  List teamMemberList = List();
  List<String> teamMemberIds = List();

  List<String> selectionList = List();


  List<String> countryList = <String>['Afghanistan','Algeria','Andorra','Angola',
    'Antigua and Barbuda','Argentina','Armenia','Australia, Austria','Azerbaijan',
    'Bahamas','Bahrain','Bangladesh, Barbados','Belarus','Belgium, Belize','Benin',
    'Bhutan, Bolivia, Bosnia and Herzegovina','Botswana','Brazil','Brunei Darussalam','Bulgaria','Burkina Faso','Burundi','Cambodia','Cameroon','Canada','Cape Verde',
    'Central African Republic','Chad','Chile','China','Colombia','Comoros','Congo','Costa Rica','Croatia','Cuba','Cyprus','Czech Republic','Democratic Peoples Republic of Korea (North Korea]',
    'Democratic Republic of the Congo','Denmark','Djibouti','Dominica'
  ];

  List<String> sectorList = <String>['Architecture/Engineering','Arts/Design','Business, Non-Finance','Community/Social Service',
    'Computer/Information Technology','Construction/Extraction','Education/Training/Library','Farming, Fishing and Forestry','Finance/Broker Dealer (407 flag)',
    'Food Preparation and Servicing','Healthcare','Installation, Maintenance, and Repair','Legal','Life, Physical and Social Science','Media and Communications',
    'Military/Law Enforcement, Government, Protective Service','Personal Care/Service','Production','Transportation and Material Moving'
  ];

  String selectedCountry;
  String selectedSector;

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
    });
  }

  void setSelectionArea(){
    var val ;
    var exist = false;

    if(selectedCountry!=null && selectedCountry!="" && selectedSector!=null && selectedSector!="")
    {
      val= "$selectedCountry"+"-"+"$selectedSector";
    }
    else if((selectedCountry!=null && selectedCountry!="") && (selectedSector==null || selectedSector==""))
    {
      val = "$selectedCountry";
    }

    else if((selectedSector!=null && selectedSector!="") && (selectedCountry==null || selectedCountry==""))
    {
      val = "$selectedSector";
    }

    if(selectionList!=null && selectionList.length!=0)
    {
      for(var i = 0; i<selectionList.length; i++){
        print("val: $val");
        print("selectionList: ${selectionList[i]}");
        if(selectionList[i].toLowerCase().contains(val.toLowerCase().trim())) {
          setState(() {
            exist = true;
          });
          break;
        }
      }
    }

    // check value exist or not
    if(exist==false)
    {
      setState(() {
        selectionList.add(val.trim());
      });
    }
    else
    {
      Toast.show("Already exist", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    }
  }

  Widget getCountryDropDownList()
  {
    if (countryList != null && countryList.length != 0)
    {
      return new DropdownButtonHideUnderline(
        child: new DropdownButton(
          value: selectedCountry,
          dropdownColor: AllCoustomTheme.getThemeData().primaryColor,
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedCountry = newValue;
            });
          },
          items: countryList.map((String value) {
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

  Widget getSectorDropDownList()
  {
    if (sectorList != null && sectorList.length != 0)
    {
      return new DropdownButtonHideUnderline(
        child: new DropdownButton(
          value: selectedSector,
          dropdownColor: AllCoustomTheme.getThemeData().primaryColor,

          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedSector = newValue;
            });
          },
          items: sectorList.map((String value) {
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

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
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
                  child: !_isInProgress
                      ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*1.7,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
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
                                  tween: Tween<Offset>(
                                      begin: Offset(0, 0), end: Offset(0.2, 0)),
                                  duration: Duration(milliseconds: 500),
                                  cycles: 0,
                                  builder: (anim) => FractionalTranslation(
                                    translation: anim.value,
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color:
                                      AllCoustomTheme.getTextThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Container(
                                  height: MediaQuery.of(context).size.height * 0.12,
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: Center(
                                    child: new Image(
                                        width: 200.0,
                                        fit: BoxFit.fill,
                                        image: new AssetImage('assets/logo.png')
                                    ),
                                  )
                              ),
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 15.0,right: 3.0),
                            child: Text(
                              "Which sector and geography pair do you definitely want in your portfolio for equities?",
                              style: new TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  color: Color(0xFFFFFFFF), fontSize: 16.0,
                                  letterSpacing: 0.1
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 20.0,right: 20.0),
                                  child: Text(
                                    'Country',
                                    style: new TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20.0,right: 20.0),
                                  decoration: new BoxDecoration(
                                    color: AllCoustomTheme.boxColor(),
                                  ),
                                  child: getCountryDropDownList(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20.0,right: 20.0),
                            child: Text(
                              'AND/OR',
                              style: new TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                fontSize: ConstanceData.SIZE_TITLE18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 20.0,right: 20.0),
                                  child: Text(
                                    'Sector',
                                    style: new TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20.0,right: 20.0),
                                  decoration: new BoxDecoration(
                                    color: AllCoustomTheme.boxColor(),
                                  ),
                                  child: getSectorDropDownList(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AllCoustomTheme.getThemeData().textSelectionColor,
                              border: new Border.all(color: Colors.white, width: 1.5),
                            ),
                            child: MaterialButton(
                              splashColor: Colors.grey,
                              child: Text(
                                "ADD",
                                style: TextStyle(
                                  color: AllCoustomTheme.getTextThemeColors(),
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () async {
                                if((selectedCountry==null || selectedCountry=="") && (selectedSector==null || selectedSector==""))
                                {
                                  Toast.show("choose any one", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                }
                                else
                                  setSelectionArea();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15.0,right: 3.0),
                            child: Text(
                              "Example of pairs: Indian Pharma, China biotech, Usa, Technology,Usa technology, Japan hardware tech",
                              style: new TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  // color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                  letterSpacing: 0.1
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    'Selections',
                                    style: new TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8.0, bottom: 24.0,left: 15.0),
                                  // height: MediaQuery.of(context).size.height*0.90,
                                  child: StaggeredGridView.countBuilder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: selectionList != null ? selectionList.length : 0,
                                    physics: NeverScrollableScrollPhysics(),
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                    shrinkWrap: true,
                                    staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                                    itemBuilder: (context, index){
                                      return Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4.0),
                                              border: Border.all(color: Colors.grey, width: 1.0)),
                                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  '${selectionList[index]}',
                                                  style: TextStyle(
                                                      color: AllCoustomTheme.getTextThemeColors(),
                                                      fontSize: ConstanceData.SIZE_TITLE12,
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.normal,
                                                      height: 1.3
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      selectionList.removeAt(index);
                                                    });

                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    color: AllCoustomTheme.getTextThemeColors(),
                                                    size: 15.0,
                                                  ))
                                            ],
                                          ));
                                    },
                                  ),
                                ),
/*                                Container(
                                  decoration: new BoxDecoration(
                                    color: AllCoustomTheme.boxColor(),
                                  ),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height*0.15,
                                    width: MediaQuery.of(context).size.width*0.85,
                                    child: StaggeredGridView.countBuilder(
                                      itemCount: selectionList != null ? selectionList.length : 0,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 8.0,
                                      shrinkWrap: true,
                                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                                      itemBuilder: (context, index){
                                        return Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15.0),
                                                border: Border.all(color: Colors.grey, width: 1.0)),
                                            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                            margin: EdgeInsets.only(top: 5.0,left: 5.0,right: 5.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    '${selectionList[index]}',
                                                    style: TextStyle(
                                                        color: AllCoustomTheme.getTextThemeColors(),
                                                        fontSize: ConstanceData.SIZE_TITLE14,
                                                        fontStyle: FontStyle.normal,
                                                        fontWeight: FontWeight.normal,
                                                        height: 1.3
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        selectionList.removeAt(index);
                                                      });

                                                    },
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 15.0,
                                                    ))
                                              ],
                                            )
                                        );
                                      },
                                    ),
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.15,
                            child: Container(
                                margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                                child: ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0,top: 6.0),
                                      child: Text(
                                        "Don't worry if this question sounds like greek or latin to you. You can skip this question and change it later in settings whenever you want!!",
                                        style: new TextStyle(
                                            fontFamily: "WorkSansSemiBold",
                                            color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFFCD853F),
                                            fontSize: 16.0,
                                            letterSpacing: 0.1
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 35,
                                      child: Container(
                                        height: 35,
                                        width: 120,
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
                                            "SKIP",
                                            style: TextStyle(
                                              color: AllCoustomTheme.getTextThemeColors(),
                                              fontSize: ConstanceData.SIZE_TITLE18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () async
                                          {
                                            submit();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 35,
                                      child: Container(
                                        height: 35,
                                        width: 120,
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
                                            "NEXT",
                                            style: TextStyle(
                                              color: AllCoustomTheme.getTextThemeColors(),
                                              fontSize: ConstanceData.SIZE_TITLE18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          onPressed: () async
                                          {
                                            submit();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                  )
                      : SizedBox(),
                ),
              ),
            )
        )
      ],
    );
  }

  Future submit() async {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) =>
        new OnBoardingFourth(logo: widget.logo,callingFrom: widget.callingFrom,)));
  }
}