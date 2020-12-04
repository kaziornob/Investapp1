import 'package:auro/models/radioQusModel.dart';
import 'package:auro/radioQusTemplate.dart';
import 'package:auro/resources/radioQusTemplateData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:auro/style/theme.dart' as Theme;
import 'package:auro/shared/dialog_helper.dart';
import 'package:auro/serverConfigRequest/AllRequest.dart';


class PiEmpStatus extends StatefulWidget {

  final String parentFrom;

  const PiEmpStatus({Key key, @required this.parentFrom}) : super(key: key);

  static bool piEmpStatusKeyboardVisible=false;
  static bool piEmpStatusSubmitPressed=false;

  @override
  _PiEmpStatusState createState() => new _PiEmpStatusState();
}

class _PiEmpStatusState extends State<PiEmpStatus> with SingleTickerProviderStateMixin {
  AllHttpRequest request = new AllHttpRequest();
  final GlobalKey<FormState> _piEmpStatusFormKey = GlobalKey<FormState>();
  DialogHelper helper = new DialogHelper();


  final FocusNode myFocusNodeEmpStatus = FocusNode();
  final FocusNode myFocusNodeNature = FocusNode();
  final FocusNode myFocusNodeOccp = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  
  TextEditingController piEmpStatusNameController = new TextEditingController();
  TextEditingController piEmpStatusController = new TextEditingController();
  TextEditingController piEmpStatusNatureController = new TextEditingController();
  TextEditingController piEmpStatusOccpController = new TextEditingController();

  
  PageController _piEmpStatusPageController;

  Color left = Colors.black;
  Color right = Colors.white;

  bool _saving;
  @override
  void dispose() {
    myFocusNodeEmpStatus.dispose();
    myFocusNodeNature.dispose();
    myFocusNodeOccp.dispose();
    myFocusNodeName.dispose();
    _piEmpStatusPageController?.dispose();
    _saving = false;
    super.dispose();
  }

  ScrollController _piEmpStatusScrollController = new ScrollController();
  List<String> empStatusList = <String>['Employed','Retired','Self-Employed','At home trader (no other occupation)','Student/ Intern','Unemployed','Homemaker'];
  
  List<String> empNatureBuss = <String>['Architecture/Engineering','Arts/Design','Business, Non-Finance','Community/Social Service',
    'Computer/Information Technology','Construction/Extraction','Education/Training/Library','Farming, Fishing and Forestry','Finance/Broker Dealer (407 flag)',
      'Food Preparation and Servicing','Healthcare','Installation, Maintenance, and Repair','Legal','Life, Physical and Social Science','Media and Communications',
    'Military/Law Enforcement, Government, Protective Service','Personal Care/Service','Production','Transportation and Material Moving'
  ];

  String selectedEmpStatus;
  String selectedEmpBuss;


  @override
  void initState() {

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {

        setState(() {
          PiEmpStatus.piEmpStatusKeyboardVisible = visible;
        });

        if(visible==true)
        {
          _piEmpStatusScrollController.animateTo(_piEmpStatusScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 700), curve: Curves.linear);
        }
        else
        {
          _piEmpStatusScrollController.animateTo(_piEmpStatusScrollController.position.minScrollExtent,
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

    _piEmpStatusPageController = PageController();
  }

  List<Widget> _empStatusBuildForm(BuildContext context) {
    Form form = new Form(

        child: new ListView(
          controller: _piEmpStatusScrollController,
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
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: new Image(
                        width: 290.0,
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/login_logo.png')),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: Text(
                      'YOUR PERSONAL ASSET MANAGER',
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFFFFFFF), fontSize: 16.0,
                          letterSpacing: 0.1
                      ),
                    ),
                  ),
                  
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _piEmpStatusPageController,
                      children: <Widget>[
                        new ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                           child: new Form(
                             key: _piEmpStatusFormKey,
                             // autovalidate: _autoSignUpValidate,
                             child: _buildEmpStatus(context),
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
        children: _empStatusBuildForm(context),
      ),
    );
  }

  Widget getEmpBussDropDownList()
  {
    if (empNatureBuss != null && empNatureBuss.length != 0)
    {
      return new DropdownButtonHideUnderline(
        child: new DropdownButton(
          value: selectedEmpBuss,
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedEmpBuss = newValue;
            });
          },
          items: empNatureBuss.map((String value) {
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



  Widget getEmpBusiness()
  {
    return new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: const Icon(Icons.subject),
            labelText: 'Nature of employer business',
            labelStyle: TextStyle(fontSize: 15.0),
            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: selectedEmpBuss == '',
          child: getEmpBussDropDownList(),
        );
      },
      validator: (val) {
        return ((val != null && val!='') || (selectedEmpBuss!=null && selectedEmpBuss!='')) ? null : 'choose nature of employer business';
      },
    );
  }
  
  
  Widget getEmpStatusDropDownList()
  {
    if (empStatusList != null && empStatusList.length != 0)
    {
      return new DropdownButtonHideUnderline(
        child: new DropdownButton(
          value: selectedEmpStatus,
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedEmpStatus = newValue;
            });
          },
          items: empStatusList.map((String value) {
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
  

  Widget getEmpStatusField()
  {
    return new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            icon: const Icon(Icons.subject),
            labelText: 'Employment Status',
            labelStyle: TextStyle(fontSize: 20.0),
            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: selectedEmpStatus == '',
          child: getEmpStatusDropDownList(),
        );
      },
      validator: (val) {
        return ((val != null && val!='') || (selectedEmpStatus!=null && selectedEmpStatus!='')) ? null : 'Please select employment status';
      },
    );
  }

  Widget _buildEmpStatus(BuildContext context) {
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
                        padding: EdgeInsets.only(bottom: 0.0, left: 25.0, right: 25.0),
                        child: getEmpStatusField(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 0.0, left: 25.0, right: 25.0),
                        child: getEmpBusiness(),
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
                          focusNode: myFocusNodeOccp,
                          controller: piEmpStatusOccpController,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.projectDiagram,
                              color: Colors.black,
                            ),
                            hintText: "Occupation",
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
                          focusNode: myFocusNodeName,
                          controller: piEmpStatusNameController,
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
                              size: 22.0,
                            ),
                            hintText: "Name",
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
                margin: EdgeInsets.only(top: 390.0),
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
                    if (_piEmpStatusFormKey.currentState.validate()) //    If all data are correct then save data to out variables
                      {
                          _piEmpStatusFormKey.currentState.save();
                          var valueResp =  empDetailSubmit();
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

  Future empDetailSubmit() async {

    List<RadioQusModel> questions = await getRadioQusTempData(widget.parentFrom,'empStatus');
    /*if (questions.length < 1) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ErrorPage(
            message:
            "There are not enough questions yet.",
          )));
      return;
    }*/
    Navigator.of(context).pop();
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) =>
            RadioQusTemplate(optionData: questions)));
  }

}
