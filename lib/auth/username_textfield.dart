import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/provider_abhinav/username_functionality_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsernameTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function validation;

  const UsernameTextField({Key key, this.controller, this.validation})
      : super(key: key);

  @override
  _UsernameTextFieldState createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField> {
  @override
  void initState() {
    widget.controller.addListener(checkUsername);
    super.initState();
  }

  checkUsername() async {
    if (widget.controller.text.length > 3) {
      await Provider.of<UsernameFunctionalityProvider>(context)
          .checkUniqueUsername(widget.controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setUsernameFieldState) {
        return Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 14, top: 4, right: 20),
                child: TextFormField(
                  validator: widget.validation,
                  controller: widget.controller,
                  cursorColor: AllCoustomTheme.getTextThemeColor(),
                  style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      focusColor: AllCoustomTheme.getTextThemeColor(),
                      fillColor: AllCoustomTheme.getTextThemeColor(),
                      hintText: 'Enter First name here...',
                      hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: ConstanceData.SIZE_TITLE14),
                      labelText: 'First Name',
                      labelStyle:
                          AllCoustomTheme.getTextFormFieldLabelStyleTheme()),
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
        );
      },
    );
  }
}
