import 'package:auroim/presentation/common/auro_text.dart';
import 'package:auroim/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinsTablePage extends StatelessWidget {
  final String title;
  final Map<String, List<Map<String, String>>> data;
  const CoinsTablePage({Key key, @required this.data, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuroText(
                    'AUR',
                    fontSize: 50.sp,
                    color: Color(0xffD8AF4F),
                  ),
                  Image.asset(
                    Assets.appIcon,
                    width: 50.w,
                  ),
                ],
              ),
            ),
            Center(
              child: AuroText(
                title,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                textType: TextType.headLine6,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              AuroText(
                'Activity',
                textType: TextType.headLine6,
                color: Color(0xffD8AF4F),
              ),
              AuroText(
                'Coins Earned',
                textType: TextType.headLine6,
                color: Color(0xffD8AF4F),
              ),
            ]),
            SizedBox(
              height: 10.h,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data['data'].length,
              itemBuilder: (context, index) {
                TextType textType = TextType.body1;
                return Container(
                  color: Colors.grey[100],
                  margin: EdgeInsets.symmetric(
                    vertical: 2.h,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AuroText(
                          data['data'][index]['title'],
                          textType: textType,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                          width: 100.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (data['data'][index]['sign'].isNotEmpty)
                                AuroText(
                                  data['data'][index]['sign'],
                                  textType: textType,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffD8AF4F),
                                )
                              else
                                SizedBox.shrink(),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: AuroText(
                                    data['data'][index]['coins'],
                                    textType: textType,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 30.h,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data['note'].length,
              itemBuilder: (context, index) {
                TextType textType = TextType.body1;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40.w,
                      child: AuroText(
                        data['note'][index]['sign'],
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        textType: textType,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffD8AF4F),
                      ),
                    ),
                    Expanded(
                      child: AuroText(
                        data['note'][index]['note'],
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        textType: textType,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
