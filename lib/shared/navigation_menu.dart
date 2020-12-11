import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:auro/login.dart';
import 'package:auro/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auro/serverConfigRequest/AllRequest.dart';
import 'package:toast/toast.dart';
import 'package:auro/style/theme.dart' as AppThemeData;
import 'globalInstance.dart';


class NavigationMenu extends StatefulWidget {
  @override
  NavigationMenuState createState() => NavigationMenuState();
}

class NavigationMenuState extends State<NavigationMenu> {
  final GlobalKey<AsyncLoaderState> asyncLoaderState = new GlobalKey<AsyncLoaderState>();

  AllHttpRequest request = new AllHttpRequest();


  @override
  void initState() {
    super.initState();
  }

  Future getLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    final String UserName = prefs.getString('User_name');
    // ignore: non_constant_identifier_names
    final String EmailID = prefs.getString('Email_ID');

    final _loggedInDetail = [
      {
        'username': UserName,
        'email': EmailID,
      }
    ];

    return _loggedInDetail;
  }

  Future getLogOut() async {
    String jsonReq = '{"deviceToken":"${GlobalInstance.deviceToken}"}';

/*    var response = await request.getPostRequestWithParam('logout', jsonReq);
    return response;*/
   return null;
  }

  Widget getListView(data) {

    if (data.length != 0) {
      return new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountEmail: new Text(
              // '${data[0]['email']}',
              'poojasen@tatrasdata.com',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  fontFamily: 'sans-serif-light',
                  color: Colors.white),
            ),
            accountName: new Text(
              // '${data[0]['username']}',
              'poojasen',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  fontFamily: 'sans-serif-light',
                  color: Colors.white),
            ),
            currentAccountPicture:
            new Stack(fit: StackFit.loose, children: <Widget>[
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Container(
                      width: 72.0,
                      height: 72.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          image: new ExactAssetImage('assets/download.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      )),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 45.0, right: 20.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                          },
                          child: new CircleAvatar(
                            backgroundColor:
                            AppThemeData.Colors.loginGradientEnd,
                            radius: 25.0,
                            child: new Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 20,
                            ),
                          )),
                    ],
                  )),
            ]),

            decoration: BoxDecoration(
              color: const Color(0xFF000000),
              border: Border.all(
                color: Colors.white30,
                width: 2.0,
              ),
            ),
          ),
          new ListTile(
              title: new Text("Home"),
              trailing: new Icon(
                Icons.arrow_right,
                color: AppThemeData.Colors.drawerIconColor,
                size: 30.0,
              ),
              onTap: () {
                Navigator.of(context).pop();

                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new MyHomePage(index: 1)));
              }),

          new ListTile(
              title: new Text("Logout"),
              trailing: new Icon(
                Icons.power_settings_new,
                color: AppThemeData.Colors.drawerIconColor,
              ),
              onTap: () {
                showLoading('logout');
              }),
          new Divider(),
        ],
      );
    } else {
      return Container(width: 0.0, height: 0.0);
    }
  }


  void showLoading(from) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          margin: EdgeInsets.only(top: 50, bottom: 30),
          child: Dialog(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 8.0),
                      child: new CircularProgressIndicator(),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 110.0, bottom: 10.0, top: 5.0),
                  child: new Text(
                    "Loading...",
                    style: TextStyle(color: const Color(0xff161946)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 2), () async {

      if(from=='logout')
      {
        var value = await getLogOut();
        if (value != false) {
          Navigator.of(context).pop();

//                    if(value['message'] == 'You successfully logged out')
//                      {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('user_id', null);
          prefs.setString('Email_ID', null);
          prefs.setString('User_name', null);
          prefs.setString('First_name', null);
          prefs.setString('Last_name', null);
          prefs.setString('Session_token', null);
          prefs.setString('DateTime', null);

          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => Login()));
        } else {
          Navigator.of(context).pop();

          Toast.show("Something went wrong!", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        }
      }

    });
  }

  Widget getNoConnectionWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 60.0,
          child: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/no-wifi.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        new Text(
          "No data available yet",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: const Color(0xff161946),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = new AsyncLoader(
      key: asyncLoaderState,
      initState: () async => await getLocalStorage(),
      renderLoad: () => Center(
          child: new CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF000000)),
          )),
      renderError: ([error]) => getNoConnectionWidget(),
      renderSuccess: ({data}) => getListView(data),
    );

    return new SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: new Drawer(
          child: _asyncLoader,
        ));
  }
}