import 'package:auro/serverConfigRequest/config.dart';
import 'package:auro/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auro/shared/globalInstance.dart';

void main() {
  GlobalInstance.apiBaseUrl = 'https://prod.api.edu-collab.com/';
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var configuredApp = new AppConfig(
      appName: 'Auro',
      envName: 'production',
      apiBaseUrl: 'https://prod.api.edu-collab.com/',
      child: new MyApp(prefs: prefs),
    );
    runApp(configuredApp);
  });
}
