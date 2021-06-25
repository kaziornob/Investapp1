import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/listingsModel.dart';
import 'package:flutter/material.dart';

class QuickPercentChangeBar extends StatelessWidget {
  QuickPercentChangeBar({this.snapshot});
  // final Map snapshot;
  final USD snapshot;
  @override
  Widget build(BuildContext context) {
    // snapshot.forEach((K, V) {
    //   if (V == null) {
    //     snapshot[K] = 0;
    //   }
    // });
    return new Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10.0),
      color: AllCoustomTheme.getThemeData().primaryColor,
      // decoration: new BoxDecoration(
      //     border: new Border(
      //       top: new BorderSide(color: Theme.of(context).bottomAppBarColor),
      //     ),
      //     color: Theme.of(context).primaryColor),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                "1h",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(color: Colors.white),
              ),
              new Padding(
                padding: const EdgeInsets.only(right: 3.0),
              ),
              new Text(
                snapshot.percentChange1h >= 0
                    ? "+" + snapshot.percentChange1h.toString() + "%"
                    : snapshot.percentChange1h.toString() + "%",
                style: Theme.of(context).primaryTextTheme.bodyText1.apply(
                      color: snapshot.percentChange1h >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
              )
            ],
          ),
          new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                "24h",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(color: Colors.white),
              ),
              new Padding(padding: const EdgeInsets.only(right: 3.0)),
              new Text(
                  snapshot.percentChange24h >= 0
                      ? "+" + snapshot.percentChange24h.toString() + "%"
                      : snapshot.percentChange24h.toString() + "%",
                  style: Theme.of(context).primaryTextTheme.bodyText1.apply(
                      color: snapshot.percentChange24h >= 0
                          ? Colors.green
                          : Colors.red))
            ],
          ),
          new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text(
                "7D",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .apply(color: Colors.white),
              ),
              new Padding(padding: const EdgeInsets.only(right: 3.0)),
              new Text(
                snapshot.percentChange7d >= 0
                    ? "+" + snapshot.percentChange7d.toString() + "%"
                    : snapshot.percentChange7d.toString() + "%",
                style: Theme.of(context).primaryTextTheme.bodyText1.apply(
                      color: snapshot.percentChange7d >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
