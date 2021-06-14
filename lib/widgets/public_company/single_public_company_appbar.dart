import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class SinglePublicCompanyAppBar extends StatefulWidget {
  final companyName;
  final companyImageUrl;

  SinglePublicCompanyAppBar({
    this.companyName,
    this.companyImageUrl,
  });

  @override
  _SinglePublicCompanyAppBarState createState() =>
      _SinglePublicCompanyAppBarState();
}

class _SinglePublicCompanyAppBarState extends State<SinglePublicCompanyAppBar> {
  @override
  void initState() {
    print("single company appbar : ${widget.companyImageUrl}");
    super.initState();
  }

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
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
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
                      child: Image.network(
                          "https://auro-invest.s3-us-west-2.amazonaws.com/" +
                              widget.companyImageUrl),
                    ),
                    SizedBox(
                      width: 5,
                    ),
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
