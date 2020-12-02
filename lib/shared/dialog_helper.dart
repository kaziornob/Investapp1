import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class DialogHelper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }


  Future<void> ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wrong Credentials'),
          content: const Text('Wrong email or password'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getCongratsPopup(BuildContext context,coins) {
    return showDialog<void>(
      context: context,
        builder: (BuildContext context) {

          Future.delayed(Duration(seconds: 15), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: Colors.orange[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            ),
            title: SizedBox(
              width: 200.0,
              child: ColorizeAnimatedTextKit(
                  text: [
                    "Congratulations"
                  ],
                  textStyle: TextStyle(
                    fontSize: 25.0,
                    fontFamily: "Horizon",
                    fontStyle: FontStyle.italic,
                  ),
                  colors: [
                    Colors.red[800],
                    Colors.orange,
                    Colors.yellow[700],
                    Colors.orange[800],
                  ],
                  textAlign: TextAlign.center,
                  alignment: AlignmentDirectional.topStart // or Alignment.topLeft
              ),
            ),
            content:

            new Container(
                constraints: new BoxConstraints.expand(
                  height: 230.0,
                ),
                padding: new EdgeInsets.only(left: 14.0, bottom: 4.0, right: 14.0),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/star1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new Stack(
                  children: <Widget>[
                    new Positioned(
                      left: 88.0,
                      bottom: 0.0,
                      top: 100.0,
                      child: ScaleAnimatedTextKit(
                          text: [
                            coins,
                            coins,
                            coins,
                          ],
                          textStyle: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Canterbury",
                            fontStyle: FontStyle.italic,
                            color: Colors.red[800],
                          ),
                          textAlign: TextAlign.center,
                          alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                      ),
                    ),
                  ],
                )
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 100.0),
                child: SizedBox(
                  height: 30,
                  width: 50,
                  child: new MaterialButton(
                    child: new Text(
                      "OK",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.yellow[900],
                  ),
                ),
              )
            ],);
        }
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> otherUserCongrats(BuildContext context,coins) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Each approved answer got $coins coins'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> MandotryField(BuildContext context,String value) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mandatory Fields'),
          content: Text('$value'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> AllMandotryField(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('All Are Mandatory Fields'),
//          content: const Text('Fields'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> PasswordNotMatched(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Incorrect Password'),
//          content: const Text('password,confirmPassword'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


