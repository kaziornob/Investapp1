import 'package:file_picker/file_picker.dart';

class LocalPickFile {
  static Future<String> openFileExplorer(FileType fileType) async {
    String path = "";
    try {
      path = await FilePicker.platform
          .pickFiles(
            type: fileType,
          )
          .then((value) => value.files.first.path);
      return path;
    } catch (e) {
      print("Unsupported operation" + e.toString());
      return path;
    }
  }
}
