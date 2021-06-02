import 'package:auroim/constance/constance.dart';
import 'package:flutter/material.dart';

class AddAboutInfo extends StatefulWidget {
  const AddAboutInfo({Key key}) : super(key: key);

  @override
  _AddAboutInfoState createState() => _AddAboutInfoState();
}

class _AddAboutInfoState extends State<AddAboutInfo> {
  TextEditingController _textEditingController = TextEditingController();

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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "All Summary",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 40,
                            fontFamily: "Roboto",
                            package: "Roboto-Regular",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  description(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: RaisedButton(
                      color: Colors.white,
                      elevation: 10,
                      onPressed: () {},
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Description"),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            child: TextFormField(
              maxLength: 500,
              controller: _textEditingController,
              maxLines: 20,
              decoration:
                  textFieldInputDecoration("Tell about yourself ...", '', null),
              style: TextStyle(
                color: Colors.black,
                fontSize: ConstanceData.SIZE_TITLE16,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "This Field Cannot be empty";
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  textFieldInputDecoration(hintText, labelText, suffixText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: ConstanceData.SIZE_TITLE14,
        color: Colors.black,
      ),
      labelStyle: TextStyle(
        fontSize: ConstanceData.SIZE_TITLE16,
        color: Colors.black,
      ),
      suffixIcon: null,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
    );
  }
}
