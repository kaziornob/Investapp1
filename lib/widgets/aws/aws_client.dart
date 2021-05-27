import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auroim/constance/global.dart';
import 'package:auroim/provider_abhinav/progress.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

// import 'package:path/path.dart' as fileUtil;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef void OnUploadProgressCallback(int sentBytes, int totalBytes);

class AWSClient {
  String accessKeyId =
      'AKIASMPBGR6TT2D2CN2G'; // replace with your own access key
  String secretKeyId =
      'MHLS+aLNm8QB+uhdOZjk3+fj6khScMw6l7GoC0Ca'; // replace with your own secret key

  //US West (Oregon) us-west-2
  String region = 'us-west-2'; // replace with your account's region name
  String bucketname = "auro-invest"; // replace with your S3's bucket name
  String s3Endpoint =
      'https://auro-invest.s3-us-west-2.amazonaws.com/'; // update the endpoint url for your bucket
  static var httpClient = HttpClient();
  double percentage = 0.0;
  http.StreamedResponse response;

  // Future<String> uploadData(
  //     String folderName, String fileName, Uint8List data) async {
  //   final length = data.length;
  //   print(length);
  //   final Uri uri = Uri.parse(s3Endpoint);
  //   print(uri.path);
  //
  //   final http.MultipartRequest req = http.MultipartRequest("POST", uri);
  //   final multipartFile = http.MultipartFile(
  //     'file',
  //     http.ByteStream.fromBytes(data),
  //     length,
  //     filename: fileName,
  //   );
  //
  //   final policy = Policy.fromS3PresignedPost(
  //       folderName + '/' + fileName, bucketname, accessKeyId, 15, length,
  //       region: region);
  //   final key =
  //       SigV4.calculateSigningKey(secretKeyId, policy.datetime, region, 's3');
  //   final signature = SigV4.calculateSignature(key, policy.encode());
  //
  //   req.files.add(multipartFile);
  //   req.fields['key'] = policy.key;
  //   req.fields['acl'] = 'public-read';
  //   req.fields['X-Amz-Credential'] = policy.credential;
  //   req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
  //   req.fields['X-Amz-Date'] = policy.datetime;
  //   req.fields['Policy'] = policy.encode();
  //   req.fields['X-Amz-Signature'] = signature;
  //
  //   try {
  //     print("sending file");
  //
  //     response = await req.send();
  //
  //     response.stream.listen((value) {
  //       print("${value.toString()}");
  //     });
  //     print(response.statusCode);
  //     print(response.headers);
  //     return response.headers["location"];
  //
  //     // HOW RESPONSE HEADERS FORMAT LOOKS LIKE
  //     // {etag: "8aecd69c16644b3cb6317e7b6aa358a7", x-amz-request-id: 5JH6J8EJTZZKP9YP,
  //     // location: https://auro-invest.s3-us-west-2.amazonaws.com/Stock-Security+Pitch%2F2021-05-13T13%3A56%3A39.817807,
  //     // date: Thu, 13 May 2021 08:26:42 GMT,
  //     // x-amz-id-2: Wg43oNy89vrrjnEsgFNnhPNcs/DGdg+SO7YuzSfzylDgFhC9iKawTiIxliKpseB2p6KEVz1A/Fw=,
  //     // server: AmazonS3}
  //
  //     // await for (var value in res.stream.transform(utf8.decoder)) {
  //     //   print(value);
  //     //
  //     //   return value;
  //     // }
  //   } catch (e) {
  //     print(e.toString());
  //
  //     return "";
  //   }
  // }

  getUploadUrl(filetype) async {
    Map body = {"fileType": filetype};
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sessionToken = prefs.getString('Session_token');

    Map<String, String> headers = {
      "Content-type": "application/json",
      'Authorization': 'Token $sessionToken',
    };

    var response = await http.post(
      GlobalInstance.apiBaseUrl + 'aws_client/generatePresignedUrl',
      body: jsonEncode(body),
      headers: headers,
    );

    var result = jsonDecode(response.body);
    print("${result["uploadUrl"]}");
    return result;
  }

  uploadFile(File file, fileType, BuildContext context) async {
    var result = await getUploadUrl(fileType);

    String downloadUrl = result["downloadUrl"];
    String uploadUrl = result["uploadUrl"];

    var response = await Dio().put(
      uploadUrl,
      data: file.openRead(),
      options: Options(
        contentType: "application/octet-stream",
        headers: {
          "Content-Length": file.lengthSync(),
        },
      ),
      onSendProgress: (int sentBytes, int totalBytes) {
        double progressPercent = sentBytes / totalBytes * 100;
        Provider.of<UploadDownloadProgress>(context, listen: false)
            .changeProgress(progressPercent);
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      return downloadUrl;
    }
  }

  Future<File> downloadFile(String url1, String filename) async {
    // String url =
    //     "https://auro-invest.s3-us-west-2.amazonaws.com/Stock-Security+Pitch%2F2021-05-13T11%3A10%3A00.822912";
    var request = await httpClient.getUrl(Uri.parse(url1));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}

// class Policy {
//   String expiration;
//   String region;
//   String bucket;
//   String key;
//   String credential;
//   String datetime;
//   int maxFileSize;
//
//   Policy(this.key, this.bucket, this.datetime, this.expiration, this.credential,
//       this.maxFileSize,
//       {this.region = 'us-east-1'});
//
//   factory Policy.fromS3PresignedPost(
//     String key,
//     String bucket,
//     String accessKeyId,
//     int expiryMinutes,
//     int maxFileSize, {
//     String region,
//   }) {
//     final datetime = SigV4.generateDatetime();
//     final expiration = (DateTime.now())
//         .add(Duration(minutes: expiryMinutes))
//         .toUtc()
//         .toString()
//         .split(' ')
//         .join('T');
//     final cred =
//         '$accessKeyId/${SigV4.buildCredentialScope(datetime, region, 's3')}';
//     final p = Policy(key, bucket, datetime, expiration, cred, maxFileSize,
//         region: region);
//     return p;
//   }
//
//   String encode() {
//     final bytes = utf8.encode(toString());
//     return base64.encode(bytes);
//   }
//
//   @override
//   String toString() {
//     return '''
// { "expiration": "${this.expiration}",
//   "conditions": [
//     {"bucket": "${this.bucket}"},
//     ["starts-with", "\$key", "${this.key}"],
//     {"acl": "public-read"},
//     ["content-length-range", 1, ${this.maxFileSize}],
//     {"x-amz-credential": "${this.credential}"},
//     {"x-amz-algorithm": "AWS4-HMAC-SHA256"},
//     {"x-amz-date": "${this.datetime}" }
//   ]
// }
// ''';
//   }
// }
