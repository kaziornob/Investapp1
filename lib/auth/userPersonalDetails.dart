import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/auth/investorType.dart';
import 'package:auroim/auth/signInScreen.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
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

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();

  static final now = DateTime.now();
  final datePicker = DropdownDatePicker(
    dateFormat: DateFormat.ymd,
    firstDate: ValidDate(year: now.year - 100, month: 1, day: 1),
    lastDate: ValidDate(year: now.year, month: now.month, day: now.day),
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: ConstanceData.SIZE_TITLE16,
      color: AllCoustomTheme.getTextThemeColors(),
    ),
    dropdownColor: Colors.black,
    dateHint: DateHint(year: 'year', month: 'month', day: 'day'),
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
        Scaffold(
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          body: ModalProgressHUD(
            inAsyncCall: _isDetailInProgress,
            opacity: 0,
            progressIndicator: SizedBox(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
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
                                    color: AllCoustomTheme.getTextThemeColors(),
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
                                              color: AllCoustomTheme.getTextThemeColors(),
                                              fontSize: ConstanceData.SIZE_TITLE18,
                                              fontWeight: FontWeight.bold,
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
                          height: 40,
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
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
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
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                                  color: AllCoustomTheme.boxColor(),
                                ),
                                child: Form(
                                  key: _detailFormKey,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 0.5,
                                      ),
                                      Container(
                                        height: 5,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(2)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              globals.buttoncolor1,
                                              globals.buttoncolor2,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 14, top: 4),
                                              child: TextFormField(
                                                validator: _validateName,
                                                controller: firstNameController,
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
                                                  hintText: 'Enter First name here...',
                                                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                                  labelText: 'First Name',
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
                                              padding: EdgeInsets.only(left: 14, top: 4),
                                              child: TextFormField(
                                                validator: _validateName,
                                                controller: lastNameController,
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
                                                  hintText: 'Enter Last name here...',
                                                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                                  labelText: 'Last Name',
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
                                              "DOB :",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: ConstanceData.SIZE_TITLE16,
                                                color: AllCoustomTheme.getTextThemeColors(),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 14, top: 4),
                                                child: datePicker
                                              )
                                          ),
/*                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 14, top: 4),
                                              child: TextFormField(
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
                                                  hintText: 'Enter DOB here...',
                                                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                                  labelText: 'Date Of Birth',
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
                                              ),
                                            ),
                                          ),*/
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 14, top: 4),
                                              child: TextFormField(
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
                                              ),
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
                                                              gradient: LinearGradient(
                                                                begin: Alignment.topLeft,
                                                                end: Alignment.bottomRight,
                                                                colors: [
                                                                  globals.buttoncolor1,
                                                                  globals.buttoncolor2,
                                                                ],
                                                              ),
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
    if (_detailFormKey.currentState.validate() == false) {
      setState(() {
        _isDetailInProgress = false;
      });
      return;
    }

    var firstName = firstNameController.text.trim();
    var lastName = lastNameController.text.trim();
    var country = countryController.text.trim();
    var dob = datePicker.getDate();

    String jsonReq = "users/add_details?first_name=$firstName&last_name=$lastName&residence_country=$country&dob=$dob";

    var response = await request.postSubmitWithParams(jsonReq);
    print("details response: $response");

    // && response.containsKey('auth') && response['auth']==true

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
    }
    
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
