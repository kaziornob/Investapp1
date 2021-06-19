import 'package:flutter/material.dart';

import 'auro_appbar.dart';
import 'auro_sidebar.dart';

class AuroScaffold extends StatelessWidget {
  final Widget body;
  AuroScaffold({Key key, this.body}) : super(key: key);

  final TextEditingController _appbarTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AuroSidebar(),
      backgroundColor: Colors.white,
      appBar: AuroAppbar(
        controller: _appbarTextController,
      ),
      body: body,
    );
  }
}
