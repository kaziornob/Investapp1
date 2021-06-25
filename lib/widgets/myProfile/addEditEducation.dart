import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class AddEditEducation extends StatefulWidget {
  @override
  _AddEditEducationState createState() => _AddEditEducationState();
}

class _AddEditEducationState extends State<AddEditEducation> {
  final _addEditEduFormKey = new GlobalKey<FormState>();
  bool _isAddEditEduProgress = false;
  bool _visibleEdu = false;
  ApiProvider request = new ApiProvider();

  String selectedStartYear;
  String selectedEndYear;

  List<String> monthList = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  List<String> yearList = <String>[
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026'
  ];

  bool currentlyWorking = false;
  TextEditingController schoolController = new TextEditingController();
  TextEditingController degreeController = new TextEditingController();
  TextEditingController studyController = new TextEditingController();
  TextEditingController gradeController = new TextEditingController();

  TextEditingController companyController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();

  bool startDateFound = true;
  bool endDateFound = true;

  Widget getEndYearField() {
    return new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            hintText: "Year",
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE20,
                color: AllCoustomTheme.getTextThemeColor()),
            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: selectedEndYear == '',
          child: getEndYearDropDownList(),
        );
      },
      validator: (val) {
        return ((val != null && val != '') ||
                (selectedEndYear != null && selectedEndYear != ''))
            ? null
            : 'choose One';
      },
    );
  }

  Widget getEndYearDropDownList() {
    if (yearList != null && yearList.length != 0) {
      return new DropdownButtonHideUnderline(
        child: ButtonTheme(
            alignedDropdown: true,
            child: Container(
              height: 20.0,
              child: new DropdownButton(
                value: selectedEndYear,
                dropdownColor: Colors.white,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    selectedEndYear = newValue;
                  });
                },
                items: yearList.map((String value) {
                  return new DropdownMenuItem(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColor(),
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontFamily: "Roboto",
                      ),
                    ),
                  );
                }).toList(),
              ),
            )),
      );
    } else {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }

  Widget getStartYearField() {
    return new FormField(
      builder: (FormFieldState state) {
        return InputDecorator(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),
            hintText: "Year",
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ConstanceData.SIZE_TITLE20,
                color: AllCoustomTheme.getTextThemeColor()),
            errorText: state.hasError ? state.errorText : null,
          ),
          isEmpty: selectedStartYear == '',
          child: getStartYearDropDownList(),
        );
      },
      validator: (val) {
        return ((val != null && val != '') ||
                (selectedStartYear != null && selectedStartYear != ''))
            ? null
            : 'choose One';
      },
    );
  }

  Widget getStartYearDropDownList() {
    if (yearList != null && yearList.length != 0) {
      return new DropdownButtonHideUnderline(
        child: ButtonTheme(
            alignedDropdown: true,
            child: Container(
              height: 20.0,
              child: new DropdownButton(
                value: selectedStartYear,
                dropdownColor: Colors.white,
                isExpanded: true,
                onChanged: (String newValue) {
                  setState(() {
                    selectedStartYear = newValue;
                  });
                },
                items: yearList.map((String value) {
                  return new DropdownMenuItem(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColor(),
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontFamily: "Roboto",
                      ),
                    ),
                  );
                }).toList(),
              ),
            )),
      );
    } else {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }

  animation() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visibleEdu = true;
    });
  }

  List<String> employmentList = <String>[
    'Employed',
    'Retired',
    'Self-Employed',
    'At home trader (no other occupation)',
    'Student/ Intern',
    'Unemployed',
    'Homemaker'
  ];

  String selectedEmpType;

  @override
  void initState() {
    super.initState();
    loadDetails();
    animation();
  }

  loadDetails() async {
    setState(() {
      _isAddEditEduProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isAddEditEduProgress = false;
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

  Widget getEmpStatusDropDownList() {
    if (employmentList != null && employmentList.length != 0) {
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
              child: new Text(value,
                  style: AllCoustomTheme.getDropDownMenuItemStyleTheme()),
            );
          }).toList(),
        ),
      );
    } else {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }

  Widget getEmpStatusField() {
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
        return ((val != null && val != '') ||
                (selectedEmpType != null && selectedEmpType != ''))
            ? null
            : 'Please select employment status';
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
            inAsyncCall: _isAddEditEduProgress,
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
                                tween: Tween<Offset>(
                                    begin: Offset(0, 0), end: Offset(0.2, 0)),
                                duration: Duration(milliseconds: 500),
                                cycles: 0,
                                builder: (_, anim, __) => FractionalTranslation(
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
                                builder: (_, anim, __) => Transform.scale(
                                  scale: anim.value,
                                  child: Text(
                                    'Edit Education Detail',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          AllCoustomTheme.getTextThemeColor(),
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
                        _visibleEdu
                            ? Container(
                                child: Form(
                                  key: _addEditEduFormKey,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 14, top: 4, right: 20),
                                              child: TextFormField(
                                                validator: _validateName,
                                                controller: schoolController,
                                                cursorColor: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                style: AllCoustomTheme
                                                    .getTextFormFieldBaseStyleTheme(),
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: new InputDecoration(
                                                    focusColor: AllCoustomTheme
                                                        .getTextThemeColor(),
                                                    fillColor: AllCoustomTheme
                                                        .getTextThemeColor(),
                                                    hintText: 'School',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE14),
                                                    labelText: 'School',
                                                    labelStyle: AllCoustomTheme
                                                        .getTextFormFieldLabelStyleTheme()),
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
                                              padding: EdgeInsets.only(
                                                  left: 14, top: 4, right: 20),
                                              child: TextFormField(
                                                validator: _validateName,
                                                controller: degreeController,
                                                cursorColor: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                style: AllCoustomTheme
                                                    .getTextFormFieldBaseStyleTheme(),
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: new InputDecoration(
                                                    focusColor: AllCoustomTheme
                                                        .getTextThemeColor(),
                                                    fillColor: AllCoustomTheme
                                                        .getTextThemeColor(),
                                                    hintText: 'Degree',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE14),
                                                    labelText: 'Degree',
                                                    labelStyle: AllCoustomTheme
                                                        .getTextFormFieldLabelStyleTheme()),
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
                                              padding: EdgeInsets.only(
                                                  left: 14, top: 4, right: 20),
                                              child: TextFormField(
                                                validator: _validateName,
                                                controller: studyController,
                                                cursorColor: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                style: AllCoustomTheme
                                                    .getTextFormFieldBaseStyleTheme(),
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: new InputDecoration(
                                                    focusColor: AllCoustomTheme
                                                        .getTextThemeColor(),
                                                    fillColor: AllCoustomTheme
                                                        .getTextThemeColor(),
                                                    hintText: 'Field of study',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE14),
                                                    labelText: 'Field of study',
                                                    labelStyle: AllCoustomTheme
                                                        .getTextFormFieldLabelStyleTheme()),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 14, top: 4),
                                            child: Text("Start Date:",
                                                style: AllCoustomTheme
                                                    .getTextFormFieldLabelStyleTheme()),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                              child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 4, right: 10.0),
                                            child: getStartYearField(),
                                          )),
                                        ],
                                      ),
                                      Visibility(
                                        visible: startDateFound == false
                                            ? true
                                            : false,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 14, top: 4),
                                                child: Text(
                                                  "Please Fill Start Date",
                                                  style: TextStyle(
                                                    fontSize: ConstanceData
                                                        .SIZE_TITLE12,
                                                    color: Color(0xFFC70039),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 14, top: 4),
                                            child: Text("End Date:",
                                                style: AllCoustomTheme
                                                    .getTextFormFieldLabelStyleTheme()),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                              child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 4, right: 10.0),
                                            child: getEndYearField(),
                                            // child: _selectDate,
                                          )),
                                        ],
                                      ),
                                      Visibility(
                                        visible: endDateFound == false
                                            ? true
                                            : false,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 14, top: 4),
                                                child: Text(
                                                  "Please Fill End Date",
                                                  style: TextStyle(
                                                    fontSize: ConstanceData
                                                        .SIZE_TITLE12,
                                                    color: Color(0xFFC70039),
                                                  ),
                                                )),
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
                                              padding: EdgeInsets.only(
                                                  left: 14, top: 4, right: 20),
                                              child: TextFormField(
                                                validator: _validateName,
                                                controller: gradeController,
                                                cursorColor: AllCoustomTheme
                                                    .getTextThemeColor(),
                                                style: AllCoustomTheme
                                                    .getTextFormFieldBaseStyleTheme(),
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: new InputDecoration(
                                                    focusColor: AllCoustomTheme
                                                        .getTextThemeColor(),
                                                    fillColor: AllCoustomTheme
                                                        .getTextThemeColor(),
                                                    hintText: 'Grade',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE14),
                                                    labelText: 'Grade',
                                                    labelStyle: AllCoustomTheme
                                                        .getTextFormFieldLabelStyleTheme()),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 14, top: 4, right: 20),
                                        child: Container(
                                          height: 120,
                                          child: TextField(
                                            maxLines: 10,
                                            decoration: InputDecoration(
                                              labelText:
                                                  'Activities and Societies',
                                              hintText:
                                                  'Activities and Societies',
                                              hintStyle: TextStyle(
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14,
                                                color: AllCoustomTheme
                                                    .getTextThemeColor(),
                                              ),
                                              labelStyle: TextStyle(
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE16,
                                                  color: AllCoustomTheme
                                                      .getTextThemeColor()),
                                              fillColor: Colors.white,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0),
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 15.0,
                                          ),
                                          Container(
                                            child: Text(
                                              "Ex: Alpha",
                                              style: new TextStyle(
                                                  color: Colors.black,
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE14,
                                                  fontFamily: "Rasa",
                                                  letterSpacing: 0.1),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 14, top: 4, right: 20),
                                        child: Container(
                                          height: 120,
                                          child: TextField(
                                            maxLines: 10,
                                            decoration: InputDecoration(
                                              labelText: 'Description',
                                              hintText: 'Description',
                                              hintStyle: TextStyle(
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE14,
                                                color: AllCoustomTheme
                                                    .getTextThemeColor(),
                                              ),
                                              labelStyle: TextStyle(
                                                  fontSize: ConstanceData
                                                      .SIZE_TITLE16,
                                                  color: AllCoustomTheme
                                                      .getTextThemeColor()),
                                              fillColor: Colors.white,
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0),
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: AllCoustomTheme
                                                  .getTextThemeColor(),
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 20, left: 14, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.06,
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.27,
                                                decoration: BoxDecoration(
                                                  color: AllCoustomTheme
                                                      .getSeeMoreThemeColor(),
                                                  border: new Border.all(
                                                      color: AllCoustomTheme
                                                          .getSeeMoreThemeColor(),
                                                      width: 1.5),
                                                ),
                                                child: MaterialButton(
                                                  splashColor: Colors.grey,
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: ConstanceData
                                                          .SIZE_TITLE18,
                                                      fontWeight:
                                                          FontWeight.bold,
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

  _submit() async {
    setState(() {
      _isAddEditEduProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    FocusScope.of(context).requestFocus(myScreenFocusNode);
    if (_addEditEduFormKey.currentState.validate() == false) {
      setState(() {
        _isAddEditEduProgress = false;
      });
      return;
    }

    var tempJsonReq = {"emp_status": "$selectedEmpType"};

    String jsonReq = json.encode(tempJsonReq);

    var jsonReqResp =
        await request.postSubmitResponse('users/add_employment', jsonReq);

    var result = json.decode(jsonReqResp.body);
    print("post submit response: $result");

    if (jsonReqResp.statusCode == 200 || jsonReqResp.statusCode == 201) {
      if (result != null &&
          result.containsKey('auth') &&
          result['auth'] == true) {
        _addEditEduFormKey.currentState.save();

        Toast.show("${result['message']}", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
      Toast.show("${result['message']}", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      setState(() {
        _isAddEditEduProgress = false;
      });
    } else {
      setState(() {
        _isAddEditEduProgress = false;
      });
      Toast.show("Something went wrong!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  // ignore: missing_return
  String _validateName(String value) {
    Pattern pattern = r'^[A-Za-z _]*[A-Za-z][A-Za-z _]*$';
    RegExp regex = new RegExp(pattern);
    if (value != '' && value != null) {
      if (!regex.hasMatch(value))
        return 'Name Consist Only Alphabets';
      else
        return null;
    }
  }

  // ignore: missing_return
  String _validateOccupation(String value) {
    if (value.isEmpty) {
      return "Occupation Cannot Be Empty";
    }
  }
}
