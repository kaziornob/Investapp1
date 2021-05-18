import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/material.dart';

class TextFieldWithTitle extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool isMust;
  final int maxLines;
  final double height;
  final Function validator;

  const TextFieldWithTitle({
    Key key,
    this.title,
    this.controller,
    this.hintText,
    this.labelText,
    this.isMust,
    this.maxLines,
    this.height,
    this.validator,
  }) : super(key: key);

  @override
  _TextFieldWithTitleState createState() => _TextFieldWithTitleState();
}

class _TextFieldWithTitleState extends State<TextFieldWithTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            widget.isMust ? '${widget.title}*' : '${widget.title}',
            style: TextStyle(
              color: Colors.black,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: Container(
            height: widget.height,
            child: TextFormField(
              controller: widget.controller,
              maxLines: widget.maxLines,
              decoration: textFieldInputDecoration(
                widget.hintText,
                widget.labelText,
              ),
              cursorColor: Colors.black,
              style: AllCoustomTheme.getTextFormFieldBaseStyleTheme(),
              validator: widget.validator,
            ),
          ),
        )
      ],
    );
  }

  textFieldInputDecoration(hintText, labelText) {
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
