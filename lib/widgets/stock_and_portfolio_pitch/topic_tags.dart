import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TopicTags extends StatelessWidget {
  final listOfTags;

  const TopicTags({Key key, this.listOfTags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(),
      // ),
      child: StaggeredGridView.countBuilder(
        itemCount: listOfTags != null ? listOfTags.length : 0,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        shrinkWrap: true,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.grey, width: 1.0)),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${listOfTags[index]}',
                    style: TextStyle(
                        color: AllCoustomTheme.getTextThemeColor(),
                        fontSize: ConstanceData.SIZE_TITLE16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        height: 1.3),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      width: MediaQuery.of(context).size.width - 30,
    );
  }
}
