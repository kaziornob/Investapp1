import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

final GoogleSignIn googleSignIn = GoogleSignIn();

Future signInWithGoogle() async {
  try {
    print("in try google");
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final url = "https://www.googleapis.com/oauth2/v2/userinfo";
    final header = {
      'Authorization': 'Bearer ${googleSignInAuthentication.accessToken}'
    };
    final response =
        await http.get(Uri.parse(url), headers: header).catchError((e) {
      print(e.toString());
    });
    var userDetail = jsonDecode(response.body);
    print(userDetail);
    print(googleSignInAuthentication.accessToken);
    return [googleSignInAuthentication.accessToken, userDetail];
  } catch (e, stackTrace) {
    print("error google signin");
    print(e.toString());
    print(stackTrace.toString());
  }
}
