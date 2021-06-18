import 'package:flutter/material.dart';

class OopsScreen extends StatelessWidget {
  final String classTitle;

  const OopsScreen({Key key, this.classTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Image.asset(
            'assets/wrong.png',
            height: 80,
            width: 80,
          ),
          Text(
            "OOPS!",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 40),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "You failed the chapter quiz. It’s very important to master the prior content in order to proceed to next chapter. ",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 17),
          ),
          SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
              text:
                  "In order to see the answer-sheet for this Chapter Quiz and lots of additional practice Questions with explanations on this module, we highly recommend you buy the deep dive Q & A package for ",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 17),
              children: <TextSpan>[
                TextSpan(
                  text: "\"$classTitle\"",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/career.png',
                height: 70,
                width: 70,
              ),
              SizedBox(
                width: 8,
              ),
              Flexible(
                child: Text(
                  "Investement workout, Unlimited questions on investing to hone your skills.",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          buyButton(price: "15", onPressed: () {}, context: context)
        ],
      ),
    );
  }

  buyButton({String price, Function onPressed, BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {},
          child: Card(
            child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff000000).withOpacity(0.15),
                      offset: const Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(7)),
              width: MediaQuery.of(context).size.width * 0.70,
              child: Text(
                "Pay  \$$price",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
