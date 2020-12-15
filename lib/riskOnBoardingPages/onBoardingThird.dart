import 'package:auro/riskOnBoardingPages/onBoardingFourth.dart';
import 'package:auro/securityPages/securityPageFirst.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as StyleTheme;
import 'package:flutter/painting.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:toast/toast.dart';


class OnBoardingThird extends StatefulWidget {
  final String callingFrom;
  final String logo;

  const OnBoardingThird({Key key, @required this.callingFrom,this.logo}) : super(key: key);

  @override
  _OnBoardingThirdState createState() => _OnBoardingThirdState();
}

class _OnBoardingThirdState extends State<OnBoardingThird> {

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
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedCountry = newValue;
            });
          },
          items: countryList.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value),
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
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedSector = newValue;
            });
          },
          items: sectorList.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(value),
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
    return Scaffold(
        appBar: new AppBar(
          title: Padding(
            padding: EdgeInsets.only(left:25.0),
            child: Image(
              width: 180.0,
              fit: BoxFit.fill,
              image: new AssetImage('assets/${widget.logo}')),
          ),
          backgroundColor: Color(0xFF000000),
          leading: const BackButton(),
          iconTheme: new IconThemeData(color: StyleTheme.Colors.AppBarMenuIconColor),
        ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*1.1,
          decoration: new BoxDecoration(
            color: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accScreenBackgroundColor : StyleTheme.Colors.retailScreenBackgroundColor,
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.0,bottom: 10.0,left: 25.0,right: 3.0),
                child: Text(
                  "Which sector and geography pair do you definitely want in your portfolio for equities?",
                  style: new TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      color: Color(0xFFFFFFFF), fontSize: 18.0,
                      letterSpacing: 0.1
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 40.0,right: 40.0),
                      child: Text(
                        'Country',
                        style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40.0,right: 40.0),
                      decoration: new BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        border: Border.all(
                          color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFfec20f) : Color(0xFF000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: getCountryDropDownList(),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0,left: 40.0,right: 40.0),
                child: Text(
                  'AND/OR',
                  style: new TextStyle(
                    fontFamily: "WorkSansSemiBold",
                    color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                    fontSize: 20.0,
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 40.0,right: 40.0),
                      child: Text(
                        'Sector',
                        style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40.0,right: 40.0),
                      decoration: new BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        border: Border.all(
                          color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFfec20f) : Color(0xFF000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: getSectorDropDownList(),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0,left: 40.0,right: 40.0),
                decoration: new BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  border: Border.all(
                    color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFfec20f) : Color(0xFF000000),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: MaterialButton(
                  splashColor: Colors.grey,
                  child: Text(
                    "ADD",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF000000),
                        fontFamily: "WorkSansBold"),
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
              Container(
                margin: EdgeInsets.only(top: 10.0,bottom: 10.0,left: 25.0,right: 3.0),
                child: Text(
                  "Example of pairs: Indian Pharma, China biotech, Usa, Technology,Usa technology, Japan hardware tech",
                  style: new TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                      fontSize: 16.0,
                      letterSpacing: 0.1
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Selections',
                        style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFFFFFFF) : Color(0xFF000000),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        border: Border.all(
                          color: widget.callingFrom=="Accredited Investor" ?  Color(0xFFfec20f) : Color(0xFF000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
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
                                            color: Colors.black87,
                                            fontSize: 14.0,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            height: 1.3),
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.15,
                child: Container(
                  margin: EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0),
                  decoration: new BoxDecoration(
                    color: widget.callingFrom=="Accredited Investor" ?  Color(0xFF000000) : Color(0xFFCD853F),
                    border: Border.all(
                      color: Color(0xFFfec20f),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(2.0),
                    ),
                  ),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15.0,top: 6.0),
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
              Container(
                  margin: EdgeInsets.only(top: 10.0,left: 20.0,right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: new BoxDecoration(
                          color: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accButtonBackgroundColor : StyleTheme.Colors.retailButtonBackgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: MaterialButton(
                          child: Padding(
                            padding: EdgeInsets.only(left: 30.0,right: 30.0),
                            child: Center(
                              child: Text(
                                "SkIP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            submit();
                          },
                        ),
                      ),
                      Container(
                        width: 33,
                      ),
                      Container(
                        decoration: new BoxDecoration(
                          color: widget.callingFrom=="Accredited Investor" ?  StyleTheme.Colors.accButtonBackgroundColor : StyleTheme.Colors.retailButtonBackgroundColor,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: MaterialButton(
                          child: Padding(
                            padding: EdgeInsets.only(left: 30.0,right: 30.0),
                            child: Center(
                              child: Text(
                                "NEXT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            submit();
                          },
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      )
    );
  }

  Future submit() async {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) =>
        new OnBoardingFourth(logo: widget.logo,callingFrom: widget.callingFrom,)));
  }
}
