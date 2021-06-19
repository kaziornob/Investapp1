import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuroAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final TextEditingController controller;
  final String hintText;
  final Color iconColor;
  AuroAppbar(
      {Key key,
      this.backgroundColor,
      @required this.controller,
      this.iconColor = Colors.white,
      this.hintText = "Search Investors"})
      : super(key: key);
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Size get preferredSize => Size.fromHeight(65.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? Color(0xFF7499C6),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          FontAwesomeIcons.bars,
          size: 28,
          color: iconColor,
        ),
        onPressed: Scaffold.of(context).openDrawer,
      ),
      title: Container(
        width: 300.w,
        margin: EdgeInsets.only(top: 10.0, left: 13.0),
        decoration: new BoxDecoration(
          color: Color(0xFFFFFFFF),
          border: Border.all(
            color: Color(0xff696969),
            width: 1.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.58,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextFormField(
                controller: controller,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ConstanceData.SIZE_TITLE14,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    FontAwesomeIcons.search,
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    size: 15,
                  ),
                  hintText: "Search Investors",
                  hintStyle: TextStyle(
                    color: AllCoustomTheme.getNewSecondTextThemeColor(),
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 3.0),
              child: Image(
                  height: 40,
                  width: 40,
                  image: new AssetImage('assets/appIcon.png')),
            ),
            FractionalTranslation(
              translation: Offset(-0.5, 0.0),
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 6.0,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
