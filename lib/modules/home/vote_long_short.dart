import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/reusable_widgets/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:auroim/constance/global.dart' as globals;

class VoteLongShort extends StatefulWidget {
  const VoteLongShort({Key key}) : super(key: key);

  @override
  _VoteLongShortState createState() => _VoteLongShortState();
}

class _VoteLongShortState extends State<VoteLongShort> {
  TextEditingController _searchCompanyController = TextEditingController();
  TextEditingController _longShortController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  var selectedLongShort;
  var selectedStockId;
  var selectedStockName;
  List<String> longShortList = <String>['Long', 'Short'];

  @override
  void dispose() {
    _commentController.dispose();
    _longShortController.dispose();
    _searchCompanyController.dispose();
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 15.0,
                        ),
                        child: Image.asset(
                          "assets/vote_box.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Text(
                        'Vote Long/Short',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "RosarioSemiBold",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                searchStockName(),
                longShortSection(),
                commentSection(),
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

  _submit() {}

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
      ),
      suffixIcon: suffixText == null ? null : Icon(Icons.search_sharp),
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

  longShortSection() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              // left: 12.0,
              bottom: 12,
            ),
            child: Text(
              "Buy or Sell(short-term view)?",
              style: TextStyle(
                fontFamily: "WorkSansSemiBold",
                color: Colors.black,
                fontSize: 16.0,
                letterSpacing: 0.1,
              ),
            ),
          ),
          Container(
            height: 60,
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
                  isEmpty: selectedLongShort == '',
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        value: selectedLongShort,
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            selectedLongShort = value;
                          });
                        },
                        items: longShortList.map((String value) {
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
                        (selectedLongShort != null && selectedLongShort != ''))
                    ? null
                    : 'choose one';
              },
            ),
          ),
        ],
      ),
    );
  }

  searchStockName() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: Container(
              child: TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _searchCompanyController,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  decoration: textFieldInputDecoration(
                    "Search Stock Name",
                    "Search Company/Token",
                    "",
                    30.0,
                    EdgeInsets.only(left: 16.0, right: 16.0),
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  print("pattern : $pattern");
                  return await _featuredCompaniesProvider
                      .searchPublicCompanyList(pattern);
                },
                validator: _validateStockName,
                itemBuilder: (context, suggestion) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      suggestion["company_name"],
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    _searchCompanyController.text = suggestion['company_name'];
                    selectedStockId = suggestion['ticker'];
                    selectedStockName = suggestion['company_name'];
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  commentSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Comment"),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: Container(
              height: 120,
              child: TextFormField(
                controller: _commentController,
                maxLines: 10,
                decoration: textFieldInputDecoration(
                  "",
                  "Tell us why you think this security will go \nup or down in this current quarter?",
                  null,
                  5.0,
                  EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ConstanceData.SIZE_TITLE16,
                ),
                validator: _validateComment,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _validateComment(value) {
    if (value.isEmpty) {
      return "This Field cannot be empty";
    }
    return null;
  }

  String _validateStockName(value) {
    if (value.isEmpty || selectedStockId == null) {
      return "Please Select Stock";
    }
    return null;
  }
}
