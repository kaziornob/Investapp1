import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;

  const SearchBar({Key key, this.controller}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.866,
      child: Center(
        child: TextField(
          controller: widget.controller,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF2F2F2),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            // hintText: "",
            // hintStyle: TextStyle(
            //   color: Colors.green[900],
            //   fontWeight: FontWeight.bold,
            // ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.all(16),
            focusColor: Color(0xFFF2F2F2),
            suffix: widget.controller.text.isEmpty
                ? null
                : IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      widget.controller.clear();
                      FocusScope.of(context).unfocus();
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
