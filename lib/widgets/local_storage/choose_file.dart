// import 'package:file_picker/file_picker.dart';
//
// class ChooseFileFromLocal{
//   var path;
//
//   Future<bool> _openFileExplorer(FileType fileType) async {
//     // setState(() => isLoadingPath = true);
//     try {
//       // if (isMultiPick) {
//       //   path = null;
//       //   paths = await FilePicker.getMultiFilePath(
//       //     type: fileType,
//       //     allowedExtensions: extensions,
//       //   );
//       // } else {
//       path = await FilePicker.getFilePath(
//         type: fileType,
//         // allowedExtensions: extensions,
//       );
//       if (path != null) {
//         print(path);
//         setState(() {
//           isLoadingPath = true;
//         });
//         Toast.show(
//           "Uploading Doc...",
//           context,
//         );
//         // get file from path and convert to byteData to send to aws
//         File file = File(path);
//         if (await file.length() == 0) {
//           return false;
//         }
//         // Uint8List bytesData = file.readAsBytesSync();
//         String extension =
//         path.split("/")[path.split("/").length - 1].split(".")[1];
//         docUrl = await awsClient.uploadFile(file, "." + extension, context);
//         // docUrl = await awsClient.uploadData(
//         //   "Stock-Security Pitch",
//         //   DateTime.now().toIso8601String(),
//         //   bytesData,
//         // );
//         //return true only when url is got
//         if (docUrl != null && docUrl != "") {
//           Toast.show(
//             "Doc Uploaded !! ",
//             context,
//             duration: 3,
//           );
//           setState(() {
//             isLoadingPath = false;
//             fileName = path;
//           });
//           return true;
//         } else {
//           return false;
//         }
//       } else {
//         return false;
//       }
//       // paths = null;
//       // }
//     } on PlatformException catch (e) {
//       //on error return false
//       print("Unsupported operation" + e.toString());
//       return false;
//     }
//     // if (!mounted) return false;
//     // setState(() {
//     //   isLoadingPath = false;
//     //   fileName = path != null
//     //       ? path.split('/').last
//     //       : paths != null
//     //           ? paths.keys.toString()
//     //           : '...';
//     // });
//   }
// }