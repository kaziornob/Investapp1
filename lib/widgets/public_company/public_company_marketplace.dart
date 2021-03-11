import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/widgets/private_deals_marketplace/appbar_widget.dart';
import 'package:auroim/widgets/public_companies_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PublicCompanyMarketPlace extends StatefulWidget {
  @override
  _PublicCompanyMarketPlaceState createState() =>
      _PublicCompanyMarketPlaceState();
}

class _PublicCompanyMarketPlaceState extends State<PublicCompanyMarketPlace> {
  TextEditingController _appbarTextController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(3),
            child: Container(
              height: 4,
              color: Colors.grey[400],
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff7499C6),
          title: AppbarWidget(
            textEditingController: _appbarTextController,
            focusNode: _focusNode,
            hintText: "Search Listed Companies",
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 100,
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: Center(
                  child: Text(
                    "Listed Companies",
                    style: TextStyle(
                        color: AllCoustomTheme.getHeadingThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE20,
                        fontFamily: "Rosarivo",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.1),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AllCoustomTheme.getHeadingThemeColors(),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PublicCompaniesList(
              scrollDirection: Axis.vertical,
            ),
          ),
        ],
      ),
    );
  }
}
