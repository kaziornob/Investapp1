class GlobalInstance {
  static final GlobalInstance _singleton = GlobalInstance._internal();
  static String apiBaseUrl;
  static String deviceToken;
  static String assessmentTotalTime;
  static String assessmentEndTime;

  static int fileChunkSize = 50000; //in bytes i.e 50kb

  factory GlobalInstance() {
    return _singleton;
  }

  GlobalInstance._internal();
}