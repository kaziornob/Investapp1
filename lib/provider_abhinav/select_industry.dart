import 'package:flutter/cupertino.dart';

class SelectIndustry with ChangeNotifier {
  List<String> industriesSelected = [];

  addIndustryItem(String industry) {
    industriesSelected.add(industry);
    notifyListeners();
  }

  clearList(){
    industriesSelected.clear();
    notifyListeners();
  }
}
