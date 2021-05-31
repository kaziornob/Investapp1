import 'package:auroim/constance/constance.dart';
import 'package:auroim/reusable_widgets/customButton.dart';
import 'package:auroim/reusable_widgets/screen_title_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auroim/constance/global.dart' as globals;

class CreateAPoll extends StatefulWidget {
  const CreateAPoll({Key key}) : super(key: key);

  @override
  _CreateAPollState createState() => _CreateAPollState();
}

class _CreateAPollState extends State<CreateAPoll> {
  TextEditingController _questionController = TextEditingController();
  TextEditingController _option1Controller = TextEditingController();
  TextEditingController _option2Controller = TextEditingController();
  Map<String, Duration> longShortList = {
    '1 Day': Duration(days: 1),
    '2 Days': Duration(days: 2),
    "1 Week": Duration(days: 7),
    "2 Weeks": Duration(days: 14),
  };
  var selectedPollDuration;

  @override
  void dispose() {
    _questionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_back_sharp,
          color: Colors.white,
          size: 40,
        ),
        backgroundColor: Color(0xFF8A8A8A),
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                ScreenTitleAppbar(
                  title: "CREATE A POLL",
                ),
                investmentThesis(),
                option1(),
                option2(),
                longShortSection(),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: CustomButton(
                    textColor: Colors.white,
                    borderColor: globals.isGoldBlack
                        ? Color(0xFFD8AF4F)
                        : Color(0xFF1D6177),
                    color: globals.isGoldBlack
                        ? Color(0xFFD8AF4F)
                        : Color(0xFF1D6177),
                    text: "Submit",
                    callback: _submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _submit(){}

  option1() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
            child: Text("Option 1"),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            child: Container(
              height: 60,
              child: TextFormField(
                controller: _questionController,
                maxLines: 1,
                decoration: textFieldInputDecoration(
                  "",
                  'Enter option 1',
                  "",
                  5.0,
                  EdgeInsets.only(left: 16.0, right: 16.0),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ConstanceData.SIZE_TITLE16,
                ),
                validator: _validateQuestion,
              ),
            ),
          ),
        ],
      ),
    );
  }

  option2() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
            child: Text("Option 2"),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            child: Container(
              height: 60,
              child: TextFormField(
                controller: _questionController,
                maxLines: 1,
                decoration: textFieldInputDecoration(
                  "",
                  'Enter option 2',
                  "",
                  5.0,
                  EdgeInsets.only(left: 16.0, right: 16.0),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ConstanceData.SIZE_TITLE16,
                ),
                validator: _validateQuestion,
              ),
            ),
          ),
        ],
      ),
    );
  }

  longShortSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 12,
          ),
          child: Text(
            "Poll Duration",
            style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              color: Colors.black,
              fontSize: 16.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          width: MediaQuery.of(context).size.width - 30,
          child: FormField(
            builder: (FormFieldState state) {
              return InputDecorator(
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: ConstanceData.SIZE_TITLE14,
                    color: Colors.black,
                  ),
                  errorText: state.hasError ? state.errorText : null,
                ),
                isEmpty: selectedPollDuration == '',
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      value: selectedPollDuration,
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          selectedPollDuration = value;
                        });
                      },
                      items: longShortList.keys.toList().map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontFamily: "Roboto",
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
            validator: (val) {
              return ((val != null && val != '') ||
                      (selectedPollDuration != null &&
                          selectedPollDuration != ''))
                  ? null
                  : 'choose one';
            },
          ),
        ),
      ],
    );
  }

  investmentThesis() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Question"),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            child: Container(
              height: 60,
              child: TextFormField(
                controller: _questionController,
                maxLines: 1,
                decoration: textFieldInputDecoration(
                  "",
                  'Enter title of your question',
                  null,
                  5.0,
                  EdgeInsets.only(left: 16.0, right: 16.0),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ConstanceData.SIZE_TITLE16,
                ),
                validator: _validateQuestion,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _validateQuestion(value) {
    if (value.isEmpty) {
      return "This Field cannot be empty";
    }
    return null;
  }

  textFieldInputDecoration(
      hintText, labelText, suffixText, radius, contentPadding) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: ConstanceData.SIZE_TITLE14,
        color: Colors.grey,
      ),
      // helperText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      alignLabelWithHint: true,
      labelStyle: TextStyle(
        fontSize: ConstanceData.SIZE_TITLE16,
        color: Colors.grey,
        fontFamily: "Roboto",
      ),
      suffixIcon: suffixText == null ? null : Icon(FontAwesomeIcons.trashAlt),
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      contentPadding: contentPadding,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
