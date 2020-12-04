import 'package:auro/models/radioQusModel.dart';
import 'package:auro/resources/radioQusTemplateData.dart';
import 'package:auro/signUpPages/piVersion.dart';
import 'package:flutter/material.dart';
import 'package:auro/style/theme.dart' as Theme;


class RadioQusTemplate extends StatefulWidget {

  final List<RadioQusModel> optionData;

  const RadioQusTemplate({Key key, @required this.optionData}) : super(key: key);

  @override
  _RadioQusTemplateState createState() => _RadioQusTemplateState();
}

class _RadioQusTemplateState extends State<RadioQusTemplate> {

  String selectedValue;

  Widget getOptionList(options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ...options.map((option) => RadioListTile(
            title: Text(
              "${option['title']}",
              style: TextStyle(
                  fontSize: 16.5,
                  color: Color(0xFFFFFFFF),
                  fontFamily: "Poppins"),
            ),
            subtitle: Visibility(
              visible: option['subTitle']!='' ? true :false,
              child: Text(
                "${option['subTitle']}",
                style: TextStyle(
                    fontSize: 15.0,
                    color: Color(0xFFFFFFFF),
                    fontFamily: "Poppins"),
              ),
            ),
            value: option["option_value"],
            groupValue: selectedValue,
            activeColor: Color(0xFFffffff),
            onChanged: (value) {
              print("Radio Tile pressed $value");
              setState(() => selectedValue = value);
            },
        )),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    RadioQusModel question = widget.optionData[0];
    final List<dynamic> options = question.qusOptions;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*1.1,
              decoration: new BoxDecoration(
                color: Theme.Colors.backgroundColor,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 35.0),
                    child: new Image(
                        width: 290.0,
                        fit: BoxFit.fill,
                        image: new AssetImage('assets/${widget.optionData[0].logo}')),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: Text(
                      '${widget.optionData[0].logoBottomLine}',
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFFFFFFF), fontSize: 17.0,
                          letterSpacing: 0.1
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35.0,bottom: 14.0,left: 25.0,right: 3.0),
                    child: Text(
                      '${widget.optionData[0].qusHeadline}',
                      style: new TextStyle(
                          fontFamily: "WorkSansSemiBold",
                          color: Color(0xFFFFFFFF), fontSize: 18.0,
                          letterSpacing: 0.1
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: getOptionList(options),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    decoration: new BoxDecoration(
                      color: Color(0xFFfec20f),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: MaterialButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 30.0),
                        child: Text(
                          "NEXT",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontFamily: "WorkSansBold"),
                        ),
                      ),
                      onPressed: () async {
                        submit();
                      },
                    ),
                  ),

                ],
              ),
            ),
          ],

        ),
      )
    );
  }

  Future submit() async {

    var childFrom = widget.optionData[0].childFrom=='empStatus' ? 'piVersion' : '';

    List<RadioQusModel> questions = await getRadioQusTempData(widget.optionData[0].parentFrom,childFrom);
    /*if (questions.length < 1) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ErrorPage(
            message:
            "There are not enough questions yet.",
          )));
      return;
    }*/
    Navigator.of(context).pop();
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) =>
            RadioQusTemplate(optionData: questions)));
  }
}
