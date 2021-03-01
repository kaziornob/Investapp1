import 'package:flutter/material.dart';

class SingleNotificationTile extends StatelessWidget {
  final trailingText;

  SingleNotificationTile({this.trailingText});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width / 6,
            decoration: BoxDecoration(
              // border: Border.all(),
            ),
            margin: EdgeInsets.all(0),
          ),
          Positioned(
            top: 10,
            left: 0,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.green,
            ),
          ),
          Positioned(
            top: 10,
            left: 20,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
      title: Text(
        "Stephan & 7 other connections",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: "Roboto",
          fontSize: 12,
        ),
      ),
      trailing: Text(
        trailingText,
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Roboto",
          fontSize: 12,
        ),
      ),
    );
  }
}
