import 'package:auro/serverConfigRequest/config.dart';
import 'package:auro/main.dart';
import 'package:auro/shared/globalInstance.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {

  GlobalInstance.apiBaseUrl = 'https://stage.api.edu-collab.com/';
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var configuredApp = new AppConfig(
      appName: 'Auro-Stage',
      envName: 'stage',
      apiBaseUrl: 'https://stage.api.edu-collab.com/',
      child: new MyApp(prefs: prefs),
    );
    runApp(configuredApp);
  });
}