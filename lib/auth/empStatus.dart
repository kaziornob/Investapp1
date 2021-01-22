import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/radioQusModel.dart';
import 'package:auroim/radioQusTemplate.dart';
import 'package:auroim/resources/radioQusTemplateData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class EmpStatus extends StatefulWidget {

  final String parentFrom;

  const EmpStatus({Key key, @required this.parentFrom}) : super(key: key);

  @override
  _EmpStatusState createState() => _EmpStatusState();
}

class _EmpStatusState extends State<EmpStatus> {
  bool _isEmpStatusInProgress = false;
  bool _visibleEmpStatus = false;
  ApiProvider request = new ApiProvider();


  TextEditingController empStatusNameController = new TextEditingController();
  TextEditingController empStatusOccpController = new TextEditingController();

  animation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visibleEmpStatus = true;
    });
  }

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
    super.initState();
    animation();
  }

  final _empStatusFormKey = new GlobalKey<FormState>();

  Widget getEmpStatusDropDownList()
  {
    if (empStatusList != null && empStatusList.length != 0)
    {
      return new DropdownButtonHideUnderline(
        child: new DropdownButton(
          value: selectedEmpStatus,
          dropdownColor: AllCoustomTheme.getThemeData().primaryColor,
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedEmpStatus = newValue;
            });
          },
          items: empStatusList.map((String value) {
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


  Widget getEmpStatusField()
  {
    return new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: 'Employment Status',
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE20,
                color: AllCoustomTheme.getTextThemeColors()
            ),
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


  Widget getEmpBussDropDownList()
  {
    if (empNatureBuss != null && empNatureBuss.length != 0)
    {
      return new DropdownButtonHideUnderline(
        child: new DropdownButton(
          value: selectedEmpBuss,
          dropdownColor: AllCoustomTheme.getThemeData().primaryColor,
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedEmpBuss = newValue;
            });
          },
          items: empNatureBuss.map((String value) {
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



  Widget getEmpBusinessField()
  {
    return new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: 'Nature of employer business',
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE20,
                color: AllCoustomTheme.getTextThemeColors()
            ),

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
            inAsyncCall: _isEmpStatusInProgress,
            opacity: 0,
            progressIndicator: SizedBox(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height *1.02,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            margin: EdgeInsets.only(bottom: 10.0),
                            child: Center(
                              child: new Image(
                                  width: 270.0,
                                  fit: BoxFit.fill,
                                  image: new AssetImage('assets/logo.png')
                              ),
                            )
                        ),
                        _visibleEmpStatus
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                                  color: AllCoustomTheme.boxColor(),
                                ),
                                child: Form(
                                  key: _empStatusFormKey,
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
                                              padding: EdgeInsets.only(left: 14, bottom: 10),
                                              child: getEmpStatusField(),
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
                                              padding: EdgeInsets.only(left: 14, bottom: 10),
                                              child: getEmpBusinessField(),
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
                                              padding: EdgeInsets.only(left: 14, bottom: 10),
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
                                                  hintText: 'Enter Occupation here...',
                                                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                                  labelText: 'Occupation',
                                                  labelStyle: TextStyle(
                                                    fontSize: ConstanceData.SIZE_TITLE16,
                                                    color: AllCoustomTheme.getTextThemeColors(),
                                                  ),
                                                ),
                                                controller: empStatusOccpController,
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
                                              padding: EdgeInsets.only(left: 14, bottom: 10),
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
                                                  hintText: 'Enter Name here...',
                                                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                                  labelText: 'Name',
                                                  labelStyle: TextStyle(
                                                    fontSize: ConstanceData.SIZE_TITLE16,
                                                    color: AllCoustomTheme.getTextThemeColors(),
                                                  ),
                                                ),
                                                validator: _validateName,
                                                controller: empStatusNameController,
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
                                              child: GestureDetector(
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
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox()
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

  var myScreenFocusNode = FocusNode();

  _submit() async
  {
    setState(() {
      _isEmpStatusInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    FocusScope.of(context).requestFocus(myScreenFocusNode);
    if (_empStatusFormKey.currentState.validate() == false) {
      setState(() {
        _isEmpStatusInProgress = false;
      });
      return;
    }

    var name = empStatusNameController.text.trim();
    var occupation = empStatusOccpController.text.trim();

    String jsonReq = "users/add_employment?emp_status=$selectedEmpBuss&emp_business=$selectedEmpBuss&occupation=$occupation&emp_name=$name";

    var response = await request.postSubmitWithParams(jsonReq);
    print("emp status response: $response");

    // && response.containsKey('auth') && response['auth']==true

    if (response!=null)
    {
      _empStatusFormKey.currentState.save();

      Toast.show("$response", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);

      List<RadioQusModel> questions = await getRadioQusTempData(widget.parentFrom,'empStatus');

      Navigator.of(context, rootNavigator: true).push(
        CupertinoPageRoute<void>(
          builder: (BuildContext context) =>
              RadioQusTemplate(optionData: questions),
        ),
      ).then((onValue) {
        setState(() {
          _isEmpStatusInProgress = false;
        });
      });
    }
    else{
      setState(() {
        _isEmpStatusInProgress = false;
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
