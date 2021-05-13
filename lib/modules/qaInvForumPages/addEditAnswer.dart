import 'dart:convert';

import 'package:animator/animator.dart';
import 'package:auroim/api/apiProvider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/modules/qaInvForumPages/ansView.dart';
import 'package:auroim/modules/qaInvForumPages/qusView.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter/services.dart';

// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import 'package:keyboard_actions/keyboard_actions.dart';
// import 'package:keyboard_actions/keyboard_actions_config.dart';
// import 'package:keyboard_actions/keyboard_actions_item.dart';
// import 'package:html_editor/html_editor.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

// const String _markdownData = "*pooja* **pooja** # this is H1 http:github.com";

class AddEditAnswer extends StatefulWidget {
  final allParams;

  const AddEditAnswer({Key key, @required this.allParams}) : super(key: key);

  @override
  _AddEditAnswerState createState() => _AddEditAnswerState();
}

class _AddEditAnswerState extends State<AddEditAnswer> {
  bool _isAddAnsInProgress = false;
  bool _isAddAnsClickOnSubmit = false;

  // bool italicActive = false;
  // bool boldActive = false;

/*  final controller = ScrollController();

  @override
  Future<String> get data => Future<String>.value(_markdownData);*/

  final _addEditAnsFormKey = new GlobalKey<FormState>();

  List tagList = List();
  bool tagListVisible = false;
  List<TagData> itemList = List();
  TextEditingController _ansBodyController = TextEditingController();

  final FocusNode ansBodyFocusNode = FocusNode();

  // GlobalKey<HtmlEditorState> keyEditor = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  loadDetails() async {
    setState(() {
      _isAddAnsInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isAddAnsInProgress = false;
    });
    // var txt = await keyEditor.currentState.getText();  to get editor text value
  }

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  /* KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      actions: [
        KeyboardActionsItem(
            focusNode: qusBodyFocusNode,
            toolbarButtons: [
            (node){
              return InkWell(
                onTap: ()
                {
                    setState(() {
                      italicActive = !italicActive;
                    });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 13.0),
                  child: Icon(
                    FontAwesomeIcons.italic,
                    color: italicActive ? AllCoustomTheme.boxColor() : Colors.grey,
                    size: 20,
                  ),
                ),
              );
            }, (node){
                return InkWell(
                  onTap: ()
                  {
                    setState(() {
                      boldActive = !boldActive;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 13.0),
                    child: Icon(
                      FontAwesomeIcons.bold,
                      color: boldActive ? AllCoustomTheme.boxColor() : Colors.grey,
                      size: 20,
                    ),
                  ),
                );
            },(node){
              return InkWell(
                onTap: () {

                },
                child: Container(
                  margin: EdgeInsets.only(left: 13.0),
                  child: Icon(
                    FontAwesomeIcons.link,
                    color: AllCoustomTheme.boxColor(),
                    size: 20,
                  ),
                ),
              );
            },(node){
              return Container(
                margin: EdgeInsets.only(left: 13.0),
                child: Icon(
                  FontAwesomeIcons.virus,
                  color: AllCoustomTheme.boxColor(),
                  size: 20,
                ),
              );
              }, (node){
                return Container(
                  margin: EdgeInsets.only(left: 13.0),
                  child: Icon(
                    FontAwesomeIcons.book,
                    color: AllCoustomTheme.boxColor(),
                    size: 20,
                  ),
                );
              },(node){
                return Container(
                  margin: EdgeInsets.only(left: 13.0),
                  child: Icon(
                    FontAwesomeIcons.fileVideo,
                    color: AllCoustomTheme.boxColor(),
                    size: 20,
                  ),
                );
              }, (node){
                return Container(
                  margin: EdgeInsets.only(left: 13.0),
                  child: Icon(
                    FontAwesomeIcons.image,
                    color: AllCoustomTheme.boxColor(),
                    size: 20,
                  ),
                );
              }
          ]

        ),
      ],
    );
  }*/

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        SafeArea(
            bottom: true,
            child: Scaffold(
              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              body: ModalProgressHUD(
                inAsyncCall: _isAddAnsInProgress,
                opacity: 0,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 12,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: !_isAddAnsInProgress
                        ? Container(
                            child: Form(
                              key: _addEditAnsFormKey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: appBarheight,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Animator(
                                          tween: Tween<Offset>(
                                              begin: Offset(0, 0),
                                              end: Offset(0.2, 0)),
                                          duration: Duration(milliseconds: 500),
                                          cycles: 0,
                                          builder: (anim) =>
                                              FractionalTranslation(
                                            translation: anim.value,
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: AllCoustomTheme
                                                  .getTextThemeColors(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Animator(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.decelerate,
                                          cycles: 1,
                                          builder: (anim) => Transform.scale(
                                            scale: anim.value,
                                            child: Text(
                                              'Add Answer',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AllCoustomTheme
                                                    .getTextThemeColors(),
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    ConstanceData.SIZE_TITLE20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 25,
                                        width: 95,
                                        decoration: BoxDecoration(
                                          color: AllCoustomTheme.getThemeData()
                                              .textSelectionColor,
                                          border: new Border.all(
                                              color: Colors.white, width: 1.0),
                                        ),
                                        child: _isAddAnsClickOnSubmit
                                            ? Container(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 14),
                                                  child:
                                                      CupertinoActivityIndicator(
                                                    radius: 12,
                                                  ),
                                                ),
                                              )
                                            : MaterialButton(
                                                splashColor: Colors.grey,
                                                child: Text(
                                                  "Preview",
                                                  style: TextStyle(
                                                    color: AllCoustomTheme
                                                        .getTextThemeColors(),
                                                    fontSize: ConstanceData
                                                        .SIZE_TITLE12,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _submit();
                                                },
                                              ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // bottom fomatting section
/*                        Container(
                          height: 200,
                          child: ChangeNotifierProvider<EditorProvider>(
                              create: (context) => EditorProvider(),
                              builder: (context, child) {
                                return SafeArea(
                                  child: Scaffold(
                                      body: Container(
                                        decoration: BoxDecoration(
                                          color: AllCoustomTheme.boxColor(),
                                        ),
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                                top: 16,
                                                left: 0,
                                                right: 0,
                                                bottom: 56,
                                                child: Consumer<EditorProvider>(
                                                    builder: (context, state, _) {
                                                      return ListView.builder(
                                                          itemCount: state.length,
                                                          itemBuilder: (context, index) {
                                                            return Focus(
                                                                onFocusChange: (hasFocus) {
                                                                  if (hasFocus) state.setFocus(state.typeAt(index));
                                                                },
                                                                child: Container(
                                                                  child: SmartTextField(
                                                                    type: state.typeAt(index),
                                                                    controller: state.textAt(index),
                                                                    focusNode: state.nodeAt(index),
                                                                  ),
                                                                )
                                                            );
                                                          }
                                                      );
                                                    }
                                                )
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Selector<EditorProvider, SmartTextType>(
                                                selector: (buildContext, state) => state.selectedType,
                                                builder: (context, selectedType, _) {
                                                  return Toolbar(
                                                    selectedType: selectedType,
                                                    onSelected: Provider.of<EditorProvider>(context,
                                                        listen: false).setType,
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                );
                              }
                          ),
                        ),*/

/*                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              color: AllCoustomTheme.boxColor(),
                            ),
                            child: Markdown(
                              controller: controller,
                              selectable: true,
                              data: _markdownData,
                            ),
                          ),*/
                                  // ans body section
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.70,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: AllCoustomTheme.boxColor(),
                                    ),
                                    child: TextFormField(
                                      validator: _validateBody,
                                      maxLines: null,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _ansBodyController,
                                      focusNode: ansBodyFocusNode,
                                      style: TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE14,
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Write your answer here…',
                                        hintStyle: TextStyle(
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                            color: AllCoustomTheme
                                                .getTextThemeColors()),
                                        labelStyle: TextStyle(
                                            fontSize:
                                                ConstanceData.SIZE_TITLE14,
                                            color: AllCoustomTheme
                                                .getTextThemeColors()),
                                      ),
                                    ),
                                  ),
/*                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                              color: AllCoustomTheme.boxColor(),
                            ),
                            child: KeyboardActions(
                              config: _buildConfig(context),
                              child: TextField(
                                maxLines: null,
                                keyboardType: TextInputType.emailAddress,
                                controller: _qusBodyController,
                                focusNode: qusBodyFocusNode,
                                style: TextStyle(
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontStyle: italicActive ? FontStyle.italic : FontStyle.normal,
                                    fontWeight: boldActive ? FontWeight.bold : FontWeight.normal,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Type your question here..',
                                  hintStyle: TextStyle(
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      color:
                                      AllCoustomTheme.getTextThemeColors()),
                                  labelStyle: TextStyle(
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                      color: AllCoustomTheme.getTextThemeColors()),
                                ),
                              ),
                            ),
                          ),*/
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
                ),
              ),
            ))
      ],
    );
  }

  _submit() async {
    setState(() {
      _isAddAnsClickOnSubmit = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    if (_addEditAnsFormKey.currentState.validate() == false) {
      setState(() {
        _isAddAnsClickOnSubmit = false;
      });
      return;
    }

    var tempField = {
      "callingFrom": "add",
      "answer_body": _ansBodyController.text,
      ...widget.allParams
    };
    print("ghghghghh");
    print(tempField);

    setState(() {
      _isAddAnsClickOnSubmit = false;
    });

    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (BuildContext context) => AnsView(allParams: tempField),
      ),
    );
  }

  String _validateBody(value) {
    if (value.isEmpty) {
      return "Body cannot be empty";
    }
    return null;
  }
}

enum SmartTextType { BOLD, T, ITALIC, BULLET }

extension SmartTextStyle on SmartTextType {
  TextStyle get textStyle {
    switch (this) {
      case SmartTextType.ITALIC:
        return TextStyle(
          fontSize: ConstanceData.SIZE_TITLE14,
          fontStyle: FontStyle.italic,
          color: AllCoustomTheme.getTextThemeColors(),
        );
      case SmartTextType.BOLD:
        return TextStyle(
            fontSize: ConstanceData.SIZE_TITLE14,
            color: AllCoustomTheme.getTextThemeColors(),
            fontWeight: FontWeight.bold);
        break;
      default:
        return TextStyle(
            fontSize: ConstanceData.SIZE_TITLE14,
            color: AllCoustomTheme.getTextThemeColors());
    }
  }

  EdgeInsets get padding {
    switch (this) {
/*      case SmartTextType.BOLD:
        return EdgeInsets.fromLTRB(16, 24, 16, 8);
        break;*/
      case SmartTextType.BULLET:
        return EdgeInsets.fromLTRB(24, 8, 16, 8);
      default:
        return EdgeInsets.fromLTRB(16, 8, 16, 8);
    }
  }

  TextAlign get align {
    switch (this) {
/*      case SmartTextType.ITALIC:
        return TextAlign.center;
        break;*/
      default:
        return TextAlign.start;
    }
  }

  String get prefix {
    switch (this) {
      case SmartTextType.BULLET:
        return '\u2022 ';
        break;
      default:
    }
  }
}

class SmartTextField extends StatelessWidget {
  const SmartTextField({Key key, this.type, this.controller, this.focusNode})
      : super(key: key);

  final SmartTextType type;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        cursorColor: Colors.teal,
        textAlign: type.align,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixText: type.prefix,
            prefixStyle: type.textStyle,
            isDense: true,
            contentPadding: type.padding),
        style: type.textStyle);
  }
}

class Toolbar extends StatelessWidget {
  const Toolbar({Key key, this.onSelected, this.selectedType})
      : super(key: key);

  final SmartTextType selectedType;
  final ValueChanged<SmartTextType> onSelected;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: Material(
          elevation: 4.0,
          color: AllCoustomTheme.boxColor(),
          child: Row(children: <Widget>[
            InkWell(
              onTap: () {
                onSelected(SmartTextType.ITALIC);
              },
              child: Container(
                child: Icon(
                  FontAwesomeIcons.italic,
                  color: selectedType == SmartTextType.ITALIC
                      ? Colors.teal
                      : Colors.grey,
                  size: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.bold,
                  color: selectedType == SmartTextType.BOLD
                      ? Colors.teal
                      : Colors.grey,
                  size: MediaQuery.of(context).size.width * 0.05,
                ),
                onPressed: () => onSelected(SmartTextType.BOLD)),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.link,
                color: Colors.grey,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.virus,
                color: Colors.grey,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.book,
                color: Colors.grey,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.fileVideo,
                color: Colors.grey,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.image,
                color: Colors.grey,
                size: MediaQuery.of(context).size.width * 0.05,
              ),
            )
          ])),
    );
  }
}

class EditorProvider extends ChangeNotifier {
  List<FocusNode> _nodes = [];
  List<TextEditingController> _text = [];
  List<SmartTextType> _types = [];
  SmartTextType selectedType;

  EditorProvider({SmartTextType defaultType = SmartTextType.T}) {
    selectedType = defaultType;
    insert(index: 0);
  }

  int get length => _text.length;

  int get focus => _nodes.indexWhere((node) => node.hasFocus);

  FocusNode nodeAt(int index) => _nodes.elementAt(index);

  TextEditingController textAt(int index) => _text.elementAt(index);

  SmartTextType typeAt(int index) => _types.elementAt(index);

  void setType(SmartTextType type) {
    if (selectedType == type) {
      selectedType = SmartTextType.T;
    } else {
      selectedType = type;
    }
    _types.removeAt(focus);
    _types.insert(focus, selectedType);
    notifyListeners();
  }

  void setFocus(SmartTextType type) {
    selectedType = type;
    notifyListeners();
  }

  void insert({int index, String text, SmartTextType type = SmartTextType.T}) {
    /*final TextEditingController controller = TextEditingController(
        text: text?? ''
    );
    controller.addListener(() {
      // TODO
    });
    _text.insert(index, controller);
    _types.insert(index, type);
    _nodes.insert(index, FocusNode());*/

    final TextEditingController controller =
        TextEditingController(text: '\u200B' + (text ?? ''));
    controller.addListener(() {
      if (!controller.text.startsWith('\u200B')) {
        final int index = _text.indexOf(controller);
        if (index > 0) {
          textAt(index - 1).text += controller.text;
          textAt(index - 1).selection = TextSelection.fromPosition(TextPosition(
              offset: textAt(index - 1).text.length - controller.text.length));
          nodeAt(index - 1).requestFocus();
          _text.removeAt(index);
          _nodes.removeAt(index);
          _types.removeAt(index);
          notifyListeners();
        }
      }
      if (controller.text.contains('\n')) {
        final int index = _text.indexOf(controller);
        List<String> _split = controller.text.split('\n');
        controller.text = _split.first;
        insert(
            index: index + 1,
            text: _split.last,
            type: typeAt(index) == SmartTextType.BULLET
                ? SmartTextType.BULLET
                : SmartTextType.T);
        textAt(index + 1).selection =
            TextSelection.fromPosition(TextPosition(offset: 1));
        nodeAt(index + 1).requestFocus();
        notifyListeners();
      }
    });

    _text.insert(index, controller);
    _types.insert(index, type);
    _nodes.insert(index, FocusNode());
  }
}
