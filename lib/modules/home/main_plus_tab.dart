import 'dart:io';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/modules/home/add_comment_bottom_sheet_widget.dart';
import 'package:auroim/provider_abhinav/progress.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/provider_abhinav/user_posts_provider.dart';
import 'package:auroim/reusable_widgets/progress_bar.dart';
import 'package:auroim/reusables/local_pick_file.dart';
import 'package:auroim/widgets/aws/aws_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:provider/provider.dart';

class MainPlusTab extends StatefulWidget {
  @override
  _MainPlusTabState createState() => _MainPlusTabState();
}

class _MainPlusTabState extends State<MainPlusTab> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  final _captionFormKey = new GlobalKey<FormState>();
  String videoUrl;
  String docUrl;
  String imageUrl;
  AWSClient _awsClient = AWSClient();

  @override
  void initState() {
    super.initState();
    onInitDisplayBootomSheet();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              displayModalBottomSheet(context);
            },
            child: Icon(
              Icons.more_vert_outlined,
              color: Color(0xFFD8AF4F),
              size: 40.0,
            ),
            backgroundColor: Colors.white,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            // decoration: BoxDecoration(border: Border.all()),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () => _focusNode.unfocus(),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 15.0,
                                      ),
                                      child: Image.asset(
                                        "assets/speaker_gold.png",
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                    Text(
                                      'Start a Conversation',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "RosarioSemiBold",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width / 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: globals.isGoldBlack
                                        ? Color(0xFFD8AF4F)
                                        : Color(0xFF1D6177),
                                  ),
                                  child: MaterialButton(
                                    shape: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: globals.isGoldBlack
                                            ? Color(0xFFD8AF4F)
                                            : Color(0xFF1D6177),
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      "Post",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: _submit,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            (videoUrl != null ||
                                    docUrl != null ||
                                    imageUrl != null)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Contains Attachments",
                                          style: TextStyle(
                                            color: globals.isGoldBlack
                                                ? Color(0xFFD8AF4F)
                                                : Color(0xFF1D6177),
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                        Icon(
                                          FontAwesomeIcons.paperclip,
                                          size: 18,
                                          color: globals.isGoldBlack
                                              ? Color(0xFFD8AF4F)
                                              : Color(0xFF1D6177),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            Consumer<UploadDownloadProgress>(
                              builder: (context, awsProgressProvider, _) {
                                // print("${awsProgressProvider.percentage}" + "%");
                                return awsProgressProvider.percentage ==
                                            100.0 ||
                                        awsProgressProvider.percentage == 0.0
                                    ? SizedBox()
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CustomProgressBar(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                80,
                                            percentage:
                                                awsProgressProvider.percentage,
                                          ),
                                        ),
                                      );
                              },
                            ),
                            Form(
                              key: _captionFormKey,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: TextFormField(
                                  maxLines: 10,
                                  controller: _textEditingController,
                                  focusNode: _focusNode,
                                  decoration: InputDecoration(
                                    hintText:
                                        'You can talk anything on your mind. Could be investment or non- investment related',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                    ),
                                    labelStyle: AllCoustomTheme
                                        .getTextFormFieldLabelStyleTheme(),
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusColor:
                                        AllCoustomTheme.getTextThemeColor(),
                                  ),
                                  cursorColor:
                                      AllCoustomTheme.getTextThemeColor(),
                                  style: AllCoustomTheme
                                      .getTextFormFieldBaseStyleTheme(),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "This Field Cannot be Empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _focusNode.hasFocus
                    ? Positioned(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
                        left: 8.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            circleWidget(
                                FontAwesomeIcons.filePdf, FileType.any),
                            circleWidget(Icons.video_call, FileType.video),
                            circleWidget(
                                FontAwesomeIcons.image, FileType.image),
                          ],
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        )
      ],
    );
  }

  _submit() async {
    if (_captionFormKey.currentState.validate() == false) {
      return;
    }

    var body = {
      "email":
          Provider.of<UserDetails>(context, listen: false).userDetails["email"],
      "videoUrl": videoUrl == null ? "" : videoUrl,
      "docUrl": docUrl == null ? "" : docUrl,
      "photoUrl": imageUrl == null ? "" : imageUrl,
      "caption": _textEditingController.text.trim(),
    };

    await Provider.of<UserPostsProvider>(context, listen: false)
        .uploadPost(body, context);

    _textEditingController.clear();
    _focusNode.unfocus();
    imageUrl = null;
    videoUrl = null;
    docUrl = null;
  }

  _attachFileCallback(fileType) async {
    String path = await LocalPickFile.openFileExplorer(fileType);
    if (path != "" && path != null) {
      File file = File(path);
      if (await file.length() == 0) {
        return false;
      }
      String extension =
          path.split("/")[path.split("/").length - 1].split(".")[1];
      if (fileType == FileType.image) {
        imageUrl = await _awsClient.uploadFile(file, "." + extension, context);
      } else if (fileType == FileType.video) {
        videoUrl = await _awsClient.uploadFile(file, "." + extension, context);
      } else {
        docUrl = await _awsClient.uploadFile(file, "." + extension, context);
      }
      setState(() {});
    }
  }

  circleWidget(icon, FileType fileType) {
    return GestureDetector(
      onTap: () async {
        await _attachFileCallback(fileType);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: CircleAvatar(
          backgroundColor: Color(0xFFD8AF4F),
          radius: 20,
          child: CircleAvatar(
            radius: 19,
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: Color(0xFFD8AF4F),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  displayModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
      builder: (builder) {
        return AddCommentBottomSheetWidget(
          attackFileCallback: _attachFileCallback,
        );
      },
    );
  }

  onInitDisplayBootomSheet() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        context: context,
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        builder: (builder) {
          return AddCommentBottomSheetWidget(
            attackFileCallback: _attachFileCallback,
          );
        },
      );
    });
  }
}
