import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/material.dart';

class SinglePublicCompanyAppBar extends StatefulWidget {
  final companyName;
  final companyImageUrl;

  SinglePublicCompanyAppBar({this.companyName,this.companyImageUrl,});

  @override
  _SinglePublicCompanyAppBarState createState() =>
      _SinglePublicCompanyAppBarState();
}

class _SinglePublicCompanyAppBarState extends State<SinglePublicCompanyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: <Widget>[
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Animator(
              tween: Tween<Offset>(
                begin: Offset(0, 0),
                end: Offset(0.2, 0),
              ),
              duration: Duration(milliseconds: 500),
              cycles: 0,
              builder: (anim) => FractionalTranslation(
                translation: anim.value,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 40,
                      decoration: new BoxDecoration(
                        // border: Border.all(color: Colors.black),
                        // color: Color(0xFFfec20f),
                        shape: BoxShape.rectangle,
                      ),
                      child: Image.network(widget.companyImageUrl),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      widget.companyName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
