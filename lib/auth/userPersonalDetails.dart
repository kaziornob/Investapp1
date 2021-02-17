import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/investorType.dart';
import 'package:auroim/auth/signInScreen.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class UserPersonalDetails extends StatefulWidget {
  @override
  _UserPersonalDetailsState createState() => _UserPersonalDetailsState();
}

class _UserPersonalDetailsState extends State<UserPersonalDetails> {
  bool _isDetailInProgress = false;
  bool _isClickOnDetail = false;
  bool _visible = false;
  final _detailFormKey = new GlobalKey<FormState>();
  ApiProvider request = new ApiProvider();

  String selectedCountry;

  List<String> countryList = <String>['Afghanistan','Algeria','Andorra','Angola',
    'Antigua and Barbuda','Argentina','Armenia','Australia, Austria','Azerbaijan',
    'Bahamas','Bahrain','Bangladesh, Barbados','Belarus','Belgium, Belize','Benin',
    'Bhutan, Bolivia, Bosnia and Herzegovina','Botswana','Brazil','Brunei Darussalam','Bulgaria','Burkina Faso','Burundi','Cambodia','Cameroon','Canada','Cape Verde',
    'Central African Republic','Chad','Chile','China','Colombia','Comoros','Congo','Costa Rica','Croatia','Cuba','Cyprus','Czech Republic','Democratic Peoples Republic of Korea (North Korea]',
    'Democratic Republic of the Congo','Denmark','Djibouti','Dominica'
  ];

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();

  bool dobFound = true;
  static final now = DateTime.now();
  final datePicker = DropdownDatePicker(
    dateFormat: DateFormat.ymd,
    firstDate: ValidDate(year: now.year - 100, month: 1, day: 1),
    lastDate: ValidDate(year: now.year, month: now.month, day: now.day),
    textStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme(),
    dropdownColor: Colors.white,
    // dateHint: DateHint(day: 'day',year: 'year', month: 'month'),
    dateHint: DateHint(year: 'Year', month: 'Month', day: 'Day'),
    ascending: false,
  );


  animation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visible = true;
    });
  }

  @override
  void initState() {
    super.initState();
    animation();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        Scaffold(
          // backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
          body: ModalProgressHUD(
            inAsyncCall: _isDetailInProgress,
            opacity: 0,
            progressIndicator: SizedBox(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                // height: MediaQuery.of(context).size.height,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: appBarheight,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                              child: Animator(
                                tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0.2, 0)),
                                duration: Duration(milliseconds: 500),
                                cycles: 0,
                                builder: (anim) => FractionalTranslation(
                                  translation: anim.value,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AllCoustomTheme.getTextThemeColor(),
                                  ),
                                ),
                              ),
                            ),
                            !_isClickOnDetail
                                ? GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        _isClickOnDetail = true;
                                      });
                                      await Future.delayed(const Duration(milliseconds: 700));

                                      Navigator.of(context, rootNavigator: true)
                                          .push(
                                        CupertinoPageRoute<void>(
                                          builder: (BuildContext context) => SignInScreen(),
                                        ),
                                      )
                                          .then((onValue) {
                                        setState(() {
                                          _isClickOnDetail = false;
                                        });
                                      });
                                    },
                                    child: Animator(
                                      tween: Tween<double>(begin: 0.8, end: 1.1),
                                      curve: Curves.easeInToLinear,
                                      cycles: 0,
                                      builder: (anim) => Transform.scale(
                                        scale: anim.value,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 16),
                                          child: Text(
                                            'Sign In',
                                            style: TextStyle(
                                                color: AllCoustomTheme.getTextThemeColor(),
                                                fontSize: ConstanceData.SIZE_TITLE20,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(right: 14),
                                    child: CupertinoActivityIndicator(
                                      radius: 12,
                                    ),
                                  )
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          children: <Widget>[
                            Animator(
                              tween: Tween<double>(begin: 0, end: 1),
                              duration: Duration(milliseconds: 500),
                              cycles: 1,
                              builder: (anim) => SizeTransition(
                                sizeFactor: anim,
                                axis: Axis.horizontal,
                                axisAlignment: 1,
                                child: Text(
                                  'User Personal Details',
                                  style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE20,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _visible
                            ? Container(
/*                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                                  color: AllCoustomTheme.boxColor(),
                                ),*/
                                child: Form(
                                  key: _detailFormKey,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 0.5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Container(
                                          height: 3,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                    color: Color(0xFFD8AF4F),
                                                    width: 1.6, // Underline width
                                                  )
                                              )
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 14, top: 4,right: 20),
                                              child: TextFormField(
                                                validator: _validateName,
                                                controller: firstNameController,
                                                cursorColor: AllCoustomTheme.getTextThemeColor(),
                                                style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                                                keyboardType: TextInputType.text,
                                                decoration: new InputDecoration(
                                                  focusColor: AllCoustomTheme.getTextThemeColor(),
                                                  fillColor: AllCoustomTheme.getTextThemeColor(),
                                                  hintText: 'Enter First name here...',
                                                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                                  labelText: 'First Name',
                                                  labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme()
                                                ),
                                                //controller: lastnameController,
                                                onSaved: (value) {
                                                  setState(() {
                                                    //lastnamesearchText = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 14, top: 4,right: 20),
                                              child: TextFormField(
                                                validator: _validateName,
                                                controller: lastNameController,
                                                cursorColor: AllCoustomTheme.getTextThemeColor(),
                                                style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                                                keyboardType: TextInputType.text,
                                                decoration: new InputDecoration(
                                                  focusColor: AllCoustomTheme.getTextThemeColor(),
                                                  fillColor: AllCoustomTheme.getTextThemeColor(),
                                                  hintText: 'Enter Last name here...',
                                                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                                  labelText: 'Last Name',
                                                  labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme()
                                                ),
                                                //controller: lastnameController,
                                                onSaved: (value) {
                                                  setState(() {
                                                    //lastnamesearchText = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(left: 14, top: 4),
                                            child: Text(
                                              "Date Of Birth :",
                                              style: AllCoustomTheme.getTextFormFieldLabelStyleTheme()
                                            ),
                                          ),
                                          Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(top: 4),
                                                child: datePicker,
                                              )
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: dobFound==false ? true : false,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(left: 14, top: 4),
                                                child: Text(
                                                  "Please Fill Date Of Birth",
                                                  style: TextStyle(
                                                    fontSize: ConstanceData.SIZE_TITLE12,
                                                    color: Color(0xFFC70039),
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 14, top: 4,right: 20),
                                              child: new FormField(
                                                builder: (FormFieldState state) {
                                                  return InputDecorator(
                                                    decoration: InputDecoration(
                                                      labelText: 'Country Of Residency',
                                                      labelStyle: AllCoustomTheme.getDropDownFieldLabelStyleTheme(),
                                                      errorText: state.hasError ? state.errorText : null,
                                                    ),
                                                    isEmpty: selectedCountry == '',
                                                    child: new DropdownButtonHideUnderline(
                                                      child: new DropdownButton(
                                                        value: selectedCountry,
                                                        dropdownColor: Colors.white,
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
                                                              style: AllCoustomTheme.getDropDownMenuItemStyleTheme()
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                validator: (val) {
                                                  return ((val != null && val!='') || (selectedCountry!=null && selectedCountry!='')) ? null : 'Please '
                                                      'select country';
                                                },
                                              )
/*                                              child: TextFormField(
                                                controller: countryController,
                                                cursorColor: AllCoustomTheme.getTextThemeColors(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                  color: AllCoustomTheme.getTextThemeColors(),
                                                ),
                                                keyboardType: TextInputType.text,
                                                decoration: new InputDecoration(
                                                  focusColor: AllCoustomTheme.getTextThemeColors(),
                                                  fillColor: AllCoustomTheme.getTextThemeColors(),
                                                  hintText: 'Enter Country here...',
                                                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                                  labelText: 'Country Residency',
                                                  labelStyle: TextStyle(
                                                    fontSize: ConstanceData.SIZE_TITLE16,
                                                    color: AllCoustomTheme.getTextThemeColors(),
                                                  ),
                                                ),
                                                //controller: lastnameController,
                                                onSaved: (value) {
                                                  setState(() {
                                                    //lastnamesearchText = value;
                                                  });
                                                },
                                              ),*/
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 20, left: 14, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 50,
                                              child: !_isDetailInProgress
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        _submit();
                                                      },
                                                      child: Animator(
                                                        tween: Tween<double>(begin: 0.8, end: 1.1),
                                                        curve: Curves.easeInToLinear,
                                                        cycles: 0,
                                                        builder: (anim) => Transform.scale(
                                                          scale: anim.value,
                                                          child: Container(
                                                            height: 50,
                                                            width: 50,
                                                            decoration: BoxDecoration(
                                                              border: new Border.all(color: Colors.white, width: 1.5),
                                                              shape: BoxShape.circle,
                                                              color: Color(0xFFD8AF4F),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 3),
                                                              child: Icon(
                                                                Icons.arrow_forward_ios,
                                                                size: 20,
                                                                color: AllCoustomTheme.getTextThemeColors(),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding: EdgeInsets.only(right: 14),
                                                      child: CupertinoActivityIndicator(
                                                        radius: 12,
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  var myDetailScreenFocusNode = FocusNode();

  _submit() async {
    setState(() {
      _isDetailInProgress = true;
    });

    await Future.delayed(const Duration(milliseconds: 700));

    FocusScope.of(context).requestFocus(myDetailScreenFocusNode);
    if (_detailFormKey.currentState.validate() == false || (datePicker.year==null || datePicker.month==null || datePicker.day==null)) {
      setState(() {
        _isDetailInProgress = false;
        dobFound = (datePicker.year==null || datePicker.month==null || datePicker.day==null) ? false : true;
      });
      return;
    }

    var firstName = firstNameController.text.trim();
    var lastName = lastNameController.text.trim();
    var country = selectedCountry.trim();
    var dob = datePicker.getDate();

    var tempJsonReq = {"first_name":"$firstName","last_name":"$lastName","residence_country":"$country","dob":"$dob"};

    String jsonReq = json.encode(tempJsonReq);

    var jsonReqResp = await request.postSubmit('users/add_details', jsonReq);

    var result = json.decode(jsonReqResp.body);
    print("post submit response: $result");


    if(jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201)
    {

      if (result!=null && result.containsKey('auth') && result['auth']==true)
      {
        _detailFormKey.currentState.save();

        Toast.show("${result['message']}", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);

        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) =>
                InvestorType(),
          ),
        ).then((onValue) {
          setState(() {
            _isDetailInProgress = false;
          });
        });
      }
    }
    else if(result!=null && result.containsKey('auth') && result['auth']!=true)
    {

      Toast.show("${result['message']}", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);

      setState(() {
        _isDetailInProgress = false;
      });
    }
    else{
      setState(() {
        _isDetailInProgress = false;
      });
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
    }

/*    String jsonReq = "users/add_details?first_name=$firstName&last_name=$lastName&residence_country=$country&dob=$dob";

    var response = await request.postSubmitWithParams(jsonReq);
    print("details response: $response");

    if (response!=null )
    {
      _detailFormKey.currentState.save();

      Toast.show("$response", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);

      Navigator.of(context, rootNavigator: true).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) =>
              InvestorType(),
        ),
      ).then((onValue) {
        setState(() {
          _isDetailInProgress = false;
        });
      });
    }
    else{
      setState(() {
        _isDetailInProgress = false;
      });
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
    }*/
    
  }



  // ignore: missing_return
  String _validateName(String value)
  {
    Pattern pattern = r'^[A-Za-z _]*[A-Za-z][A-Za-z _]*$';
    RegExp regex = new RegExp(pattern);

    if (value.isEmpty) {
      return "Name cannot be empty";
    }
    else if(value!='' && value!=null)
    {
      if (!regex.hasMatch(value))
        return 'Name Consist Only Alphabets';
      else
        return null;
    }
  }

}
