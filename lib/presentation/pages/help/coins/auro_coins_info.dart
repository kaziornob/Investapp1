import 'package:auroim/presentation/common/auro_scaffold.dart';
import 'package:auroim/presentation/pages/help/coins/widget/coins_info_button.dart';
import 'package:auroim/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuroCoins extends StatefulWidget {
  @override
  _AuroCoinsState createState() => _AuroCoinsState();
}

class _AuroCoinsState extends State<AuroCoins> {
  @override
  Widget build(BuildContext context) {
    return AuroScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      'AURO COINS',
                      style: TextStyle(
                        fontSize: 30.sp,
                        color: Color(0xffD8AF4F),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image(
                            height: 100.h,
                            fit: BoxFit.cover,
                            image: new AssetImage(Assets.headerImg)),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'We know what differentiates a good investor from a great investor, so we reward you differently:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.sp,
                          height: 1.5,
                          color: Colors.brown[300]),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CoinsInfoButton(
                          image: Assets.portfolioInvest,
                          onTap: () {},
                          text: 'PORTFOLIO INVEST',
                        ),
                        CoinsInfoButton(
                          image: Assets.securityInvest,
                          onTap: () {},
                          text: 'SECURITY INVEST',
                        ),
                        CoinsInfoButton(
                          image: Assets.wikiInvest,
                          onTap: () {},
                          text: 'WIKI INVEST',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(children: <Widget>[
                          new Image(
                              height: 100.h,
                              fit: BoxFit.cover,
                              image: new AssetImage(Assets.eduInvest)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'EDU INVEST',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                        // SizedBox(
                        //     width: 10
                        // ),
                        Column(children: <Widget>[
                          new Image(
                              height: 100.h,
                              fit: BoxFit.cover,
                              image: new AssetImage(Assets.socialInvest)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'SOCIAL INVEST',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    SizedBox(
                      width: 400.w,
                      child: Text(
                        'See above to learn how to earn coins from investment activities and spend them on and off Auro',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            height: 1.5,
                            color: Colors.brown[300]),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
