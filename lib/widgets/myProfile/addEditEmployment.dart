import 'dart:convert';
import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';
import 'package:auroim/constance/global.dart' as globals;


class AddEditEmployment extends StatefulWidget {
  @override
  _AddEditEmploymentState createState() => _AddEditEmploymentState();
}

class _AddEditEmploymentState extends State<AddEditEmployment> {

  final _addEditEmpFormKey = new GlobalKey<FormState>();
  bool _isEmpInProgress = false;
  bool _visibleEmployment = false;
  ApiProvider request = new ApiProvider();


  bool currentlyWorking = false;
  TextEditingController titleController = new TextEditingController();
  TextEditingController companyController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();


  bool startDateFound = true;
  bool endDateFound = true;

  static final now = DateTime.now();
  final datePicker = DropdownDatePicker(
    dateFormat: DateFormat.ymd,
    firstDate: ValidDate(year: now.year - 100, month: 1, day: 1),
    lastDate: ValidDate(year: now.year, month: now.month, day: now.day),
    textStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme(),
    dropdownColor: Colors.white,
    dateHint: DateHint(year: 'Year', month: 'Month', day: 'Day'),
    ascending: false,
  );

  final endDatePicker = DropdownDatePicker(
    dateFormat: DateFormat.ymd,
    firstDate: ValidDate(year: now.year - 100, month: 1, day: 1),
    lastDate: ValidDate(year: now.year, month: now.month, day: now.day),
    textStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme(),
    dropdownColor: Colors.white,
    dateHint: DateHint(year: 'Year', month: 'Month', day: 'Day'),
    ascending: false,
  );


  animation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visibleEmployment = true;
    });
  }

  List<String> employmentList = <String>['Employed','Retired','Self-Employed','At home trader (no other occupation)','Student/ Intern','Unemployed','Homemaker'];

  String selectedEmpType;


  @override
  void initState() {
    super.initState();
    loadDetails();
    animation();
  }

  loadDetails() async {
    setState(() {
      _isEmpInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isEmpInProgress = false;
    });
  }

/*  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.year,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }*/


  Widget getEmpStatusDropDownList()
  {
    if (employmentList != null && employmentList.length != 0)
    {
      return new DropdownButtonHideUnderline(
        child: new DropdownButton(
          value: selectedEmpType,
          dropdownColor: Colors.white,
          isExpanded: true,
          onChanged: (String newValue) {
            setState(() {
              selectedEmpType = newValue;
            });
          },
          items: employmentList.map((String value) {
            return new DropdownMenuItem(
              value: value,
              child: new Text(
                  value,
                  style: AllCoustomTheme.getDropDownMenuItemStyleTheme()
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
            labelText: 'Employment Type',
            labelStyle: AllCoustomTheme.getDropDownFieldLabelStyleTheme(),
            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: selectedEmpType == '',
          child: getEmpStatusDropDownList(),
        );
      },
      validator: (val) {
        return ((val != null && val!='') || (selectedEmpType!=null && selectedEmpType!='')) ? null : 'Please select employment status';
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
          body: ModalProgressHUD(
            inAsyncCall: _isEmpInProgress,
            opacity: 0,
            progressIndicator: CupertinoActivityIndicator(
              radius: 12,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
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
                                    color: AllCoustomTheme.getTextThemeColor(),
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
                                    'Edit Employment Detail',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColor(),
                                      fontSize: ConstanceData.SIZE_TITLE18,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        _visibleEmployment
                            ? Container(
                          child: Form(
                            key: _addEditEmpFormKey,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 14, top: 4,right: 20),
                                        child: TextFormField(
                                          validator: _validateName,
                                          controller: titleController,
                                          cursorColor: AllCoustomTheme.getTextThemeColor(),
                                          style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                                          keyboardType: TextInputType.text,
                                          decoration: new InputDecoration(
                                              focusColor: AllCoustomTheme.getTextThemeColor(),
                                              fillColor: AllCoustomTheme.getTextThemeColor(),
                                              hintText: 'Title',
                                              hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                              labelText: 'Title',
                                              labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme()
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 14, bottom: 10,right: 20),
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
                                        padding: EdgeInsets.only(left: 14, top: 4,right: 20),
                                        child: TextFormField(
                                          validator: _validateName,
                                          controller: companyController,
                                          cursorColor: AllCoustomTheme.getTextThemeColor(),
                                          style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                                          keyboardType: TextInputType.text,
                                          decoration: new InputDecoration(
                                              focusColor: AllCoustomTheme.getTextThemeColor(),
                                              fillColor: AllCoustomTheme.getTextThemeColor(),
                                              hintText: 'Company',
                                              hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                              labelText: 'Company',
                                              labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme()
                                          ),
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
                                          controller: locationController,
                                          cursorColor: AllCoustomTheme.getTextThemeColor(),
                                          style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                                          keyboardType: TextInputType.text,
                                          decoration: new InputDecoration(
                                              focusColor: AllCoustomTheme.getTextThemeColor(),
                                              fillColor: AllCoustomTheme.getTextThemeColor(),
                                              hintText: 'Location',
                                              hintStyle: TextStyle(color: Colors.grey[600], fontSize: ConstanceData.SIZE_TITLE14),
                                              labelText: 'Location',
                                              labelStyle: AllCoustomTheme.getTextFormFieldLabelStyleTheme()
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0, right: 8.0,top:3.0),
                                      child: SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: Checkbox(
                                          activeColor: Color(0xff5A56B9),
                                          value: currentlyWorking,
                                          onChanged: (value) {
                                            setState(() {
                                              currentlyWorking = !currentlyWorking;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "I am currently working in this role",
                                      style: TextStyle(
                                        color: AllCoustomTheme.getNewSecondTextThemeColor(),
                                        fontSize: 14,
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
                                          "Start Date:",
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
                                  visible: startDateFound==false ? true : false,
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(left: 14, top: 4),
                                          child: Text(
                                            "Please Fill Start Date",
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
                                    Padding(
                                      padding: EdgeInsets.only(left: 14, top: 4),
                                      child: Text(
                                          "End Date:",
                                          style: AllCoustomTheme.getTextFormFieldLabelStyleTheme()
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: endDatePicker,
                                          // child: _selectDate,
                                        )
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: endDateFound==false ? true : false,
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(left: 14, top: 4),
                                          child: Text(
                                            "Please Fill End Date",
                                            style: TextStyle(
                                              fontSize: ConstanceData.SIZE_TITLE12,
                                              color: Color(0xFFC70039),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.0,),
                                Padding(
                                  padding: EdgeInsets.only(left: 14, top: 4,right: 20),
                                  child: Container(
                                    height: 120,
                                    child: TextField(
                                      maxLines: 10,
                                      decoration: InputDecoration(
                                        labelText: 'Description',
                                        hintText: 'Description',
                                        hintStyle: TextStyle(
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                          color: AllCoustomTheme.getTextThemeColor(),
                                        ),
                                        labelStyle: TextStyle(
                                            fontSize: ConstanceData.SIZE_TITLE16,
                                            color: AllCoustomTheme.getTextThemeColor()
                                        ),
                                        fillColor: Colors.white,
                                        focusedBorder:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.black, width: 1.0),
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: AllCoustomTheme.getTextThemeColor(),
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 40.0,),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20, left: 14, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.06,
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.06,
                                          width: MediaQuery.of(context).size.width * 0.27,
                                          decoration: BoxDecoration(
                                            color: AllCoustomTheme.getSeeMoreThemeColor(),
                                            border: new Border.all(color: AllCoustomTheme.getSeeMoreThemeColor(), width: 1.5),
                                          ),
                                          child: MaterialButton(
                                            splashColor: Colors.grey,
                                            child: Text(
                                              "Save",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ConstanceData.SIZE_TITLE18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onPressed: () async {
                                              _submit();
                                            },
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
      _isEmpInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    FocusScope.of(context).requestFocus(myScreenFocusNode);
    if (_addEditEmpFormKey.currentState.validate() == false) {
      setState(() {
        _isEmpInProgress = false;
      });
      return;
    }

    var tempJsonReq = {"emp_status":"$selectedEmpType"};

    String jsonReq = json.encode(tempJsonReq);

    var jsonReqResp = await request.postSubmit('users/add_details', jsonReq);

    var result = json.decode(jsonReqResp.body);
    print("post submit response: $result");


    if(jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201)
    {

      if (result!=null && result.containsKey('auth') && result['auth']==true)
      {
        _addEditEmpFormKey.currentState.save();

        Toast.show("${result['message']}", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM);
      }
    }

    else if(result!=null && result.containsKey('auth') && result['auth']!=true)
    {

      Toast.show("${result['message']}", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);

      setState(() {
        _isEmpInProgress = false;
      });
    }
    else{
      setState(() {
        _isEmpInProgress = false;
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
    if(value!='' && value!=null)
    {
      if (!regex.hasMatch(value))
        return 'Name Consist Only Alphabets';
      else
        return null;
    }
  }

  // ignore: missing_return
  String _validateOccupation(String value)
  {
    if (value.isEmpty) {
      return "Occupation Cannot Be Empty";
    }
  }
}
