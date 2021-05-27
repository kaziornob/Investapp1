import 'package:flutter/material.dart';

class UploadDownloadProgress with ChangeNotifier {
  double percentage = 0.0;

  changeProgress(perc) {
    percentage = perc;
    notifyListeners();
  }
}
