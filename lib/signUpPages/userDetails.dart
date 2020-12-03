import 'package:auro/signUpPages/investorType.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:auro/style/theme.dart' as Theme;
import 'package:auro/shared/dialog_helper.dart';
import 'package:auro/serverConfigRequest/AllRequest.dart';


class UserDetails extends StatefulWidget {
  static bool userDetailKeyboardVisible=false;
  static bool userDetailPressed=false;
  
  UserDetails({Key key}) : super(key: key);

  @override
  _UserDetailsState createState() => new _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> with SingleTickerProviderStateMixin {
  AllHttpRequest request = new AllHttpRequest();
  final GlobalKey<FormState> _userDetailFormKey = GlobalKey<FormState>();
  DialogHelper helper = new DialogHelper();


  final FocusNode myFocusNodeFirstName = FocusNode();
  final FocusNode myFocusNodeLastName = FocusNode();
  final FocusNode myFocusNodeDob = FocusNode();
  final FocusNode myFocusNodeCountry = FocusNode();
  
  TextEditingController detailFirstNameController = new TextEditingController();
  TextEditingController detailLastNameController = new TextEditingController();
  TextEditingController detailDobController = new TextEditingController();
  TextEditingController detailCountryController = new TextEditingController();

  
  PageController _userDetailPageController;

  Color left = Colors.black;
  Color right = Colors.white;

  bool _saving;
  @override
  void dispose() {
    myFocusNodeFirstName.dispose();
    myFocusNodeLastName.dispose();
    myFocusNodeDob.dispose();
    myFocusNodeCountry.dispose();
    _userDetailPageController?.dispose();
    _saving = false;
    super.dispose();
  }

  ScrollController _userDetailScrollController = new ScrollController();

  @override
  void initState() {

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {

        setState(() {
          UserDetails.userDetailKeyboardVisible = visible;
        });

        if(visible==true)
        {
          _userDetailScrollController.animateTo(_userDetailScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 700), curve: Curves.linear);
        }
        else
        {
          _userDetailScrollController.animateTo(_userDetailScrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 700), curve: Curves.linear);
        }
      },
    );
    super.initState();
    _saving = false;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _userDetailPageController = PageController();
  }

  List<Widget> _signUpBuildForm(BuildContext context) {
    Form form = new Form(

        child: new ListView(
          controller: _userDetailScrollController,
          children: <Widget>[

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*1.1,
              decoration: new BoxDecoration(
                color: Theme.Colors.backgroundColor,
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0,bottom: 10.0),
                    child: new Image(
                        width: 280.0,
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/login_logo.png')),
                  ),
                  
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _userDetailPageController,
                      children: <Widget>[
                        new ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                           child: new Form(
                             key: _userDetailFormKey,
                             // autovalidate: _autoSignUpValidate,
                             child: _buildUserDetail(context),
                           ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );

    var l = new List<Widget>();
    l.add(form);

    if (_saving) {
      var modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          new Center(
            child: new CircularProgressIndicator(),
          ),
        ],
      );
      l.add(modal);
    }

    return l;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: new Stack(
        children: _signUpBuildForm(context),
      ),
    );
  }

  Widget _buildUserDetail(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 322.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 0.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          focusNode: myFocusNodeFirstName,
                          controller: detailFirstNameController,
                          validator: validateName,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.textHeight,
                              color: Colors.black,
                            ),
                            hintText: "First Name",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 0.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          focusNode: myFocusNodeLastName,
                          controller: detailLastNameController,
                          validator: validateName,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.textHeight,
                              color: Colors.black,
                            ),
                            hintText: "Last Name",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 0.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          focusNode: myFocusNodeDob,
                          controller: detailDobController,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.calendar,
                              color: Colors.black,
                            ),
                            hintText: "dd/mm/yyyy",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextFormField(
                          focusNode: myFocusNodeCountry,
                          controller: detailCountryController,
                          validator: validateResident,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.home,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Country of residency",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 400.0),
                decoration: new BoxDecoration(
                  color: Color(0xFFfec20f),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: MaterialButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),
                  onPressed: () async {
                    if (_userDetailFormKey.currentState.validate()) //    If all data are correct then save data to out variables
                      {
                          _userDetailFormKey.currentState.save();
                          var valueResp =  detailSubmit();
                      }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getPopUp() {
    showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Warning..."),
            content: Text("InProgress..."),
            actions: <Widget>[IconButton(
                icon: Icon(Icons.check), onPressed: () {
              Navigator.of(context).pop();
            })
            ],);
        }
    );
  }

  String validateName(String value)
  {
    Pattern pattern =
        r'^[A-Za-z _]*[A-Za-z][A-Za-z _]*$';
    RegExp regex = new RegExp(pattern);

    if(value!='' && value!=null)
    {
      if (!regex.hasMatch(value))
        return 'Name Consist Only Alphabets';
      else
        return null;
    }
    else
    {
      return 'Enter Name';
    }
  }

  String validateResident(String value)
  {
    Pattern pattern =
        r'^[A-Za-z _]*[A-Za-z][A-Za-z _]*$';
    RegExp regex = new RegExp(pattern);

    if(value!='' && value!=null)
    {
      if (!regex.hasMatch(value))
        return 'Country Consist Only Alphabets';
      else
        return null;
    }
    else
    {
      return 'Enter country';
    }
  }

  String validateInst(String value)
  {
    Pattern pattern =
        r'^[A-Za-z _]*[A-Za-z][A-Za-z _ 0-9]*$';
    RegExp regex = new RegExp(pattern);

    if(value!='' && value!=null)
    {
      if (!regex.hasMatch(value))
        return 'Institute Consist Only Alphanumeric';
      else
        return null;
    }
    else
    {
      return 'Enter Institute';
    }
  }


  // sign up process
  Future detailSubmit() async {


    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) =>
            InvestorType()));

/*    setState(() {
      _saving = true;
      UserDetails.userDetailPressed = false;
    });

    var firstName = detailFirstNameController.text;
    var lastName = detailLastNameController.text;
    var dob = detailDobController.text;
    var country = detailCountryController.text;
    // set up POST request arguments
    String json =
        '{"firstName":"$firstName","lastName":"$lastName","dob":"$dob","country":"$country"}';
    var response = await request.submitSignUp(json);
    return response;*/
  }

}
