import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RelatedTags extends StatelessWidget {
  final tags;

  const RelatedTags({Key key, this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StaggeredGridView.countBuilder(
        itemCount: tags != null ? tags.length : 0,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 5.0,
        shrinkWrap: true,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AllCoustomTheme.getThemeData().textSelectionColor,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                  color: AllCoustomTheme.getThemeData().textSelectionColor,
                  width: 1.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${tags[index].tag}',
                    style: TextStyle(
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
