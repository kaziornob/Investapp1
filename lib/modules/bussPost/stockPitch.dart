import 'package:animator/animator.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class StockPitch extends StatefulWidget {
  @override
  _StockPitchState createState() => _StockPitchState();
}

class _StockPitchState extends State<StockPitch> {
  bool _isInProgress = false;
  List tagList = List();
  bool tagListVisible = false;
  List<TagData> itemList = List();
  TextEditingController _searchController = TextEditingController();


  List<String> pollDurationList = <String>['7 days','14 days','21 days'];
  List<String> longShortList = <String>['Long','Short'];


  String selectedStock;
  String selectedLongShort;

  String fileName;
  String path;
  Map<String, String> paths;
  List<String> extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;
  FileType fileType;


  @override
  void initState() {
    super.initState();
    loadUserDetails();
    getTagList();
    fileType = FileType.any;
  }

  loadUserDetails() async {
    setState(() {
      _isInProgress = true;
    });
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      _isInProgress = false;
    });
  }

  void _openFileExplorer() async {
    setState(() => isLoadingPath = true);
    try {
      if (isMultiPick) {
        path = null;
        paths = await FilePicker.getMultiFilePath(type: true? fileType: FileType.any, allowedExtensions: extensions);
      }
      else {
        path = await FilePicker.getFilePath(type: true? fileType: FileType.any, allowedExtensions: extensions);
        paths = null;
      }
    }
    on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      isLoadingPath = false;
      fileName = path != null ? path.split('/').last : paths != null
          ? paths.keys.toString() : '...';
    });
  }

  Future<List> searchItems(query) async {
    List resultList = List();
    for(var i = 0; i<tagList.length; i++){
      if(tagList[i]['tag'].toString().toLowerCase().contains(query)) {
        resultList.add(tagList[i]);
      }
    }

    return resultList;
  }

  Future getTagList() async {
/*    var response = await request.getRequest("get_tags");
    setState(() {
      tagList = response['message'];
    });
    return response['message'];*/


    var resp = [
      {"tage":"Math","_id":"1"},{"tage":"Science","_id":"2"},{"tage":"Physics","_id":"3"}
    ];

    setState(() {
      tagList = resp;
    });

    return resp;
  }


  Widget getStockDropDownList()
  {
    if (pollDurationList != null && pollDurationList.length != 0)
    {
      return new DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: Container(
            height: 16.0,
            child: new DropdownButton(
              value: selectedStock,
              dropdownColor: AllCoustomTheme.getThemeData().primaryColor,
              isExpanded: true,
              onChanged: (String newValue) {
                setState(() {
                  selectedStock = newValue;
                });
              },
              items: pollDurationList.map((String value) {
                return new DropdownMenuItem(
                  value: value,
                  child: new Text(
                    value,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ConstanceData.SIZE_TITLE14,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        )
      );
    }
    else
    {
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar();
    double appBarheight = appBar.preferredSize.height;
    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
              ],
            ),
          ),
        ),
        SafeArea(
            bottom: true,
            child: Scaffold(
              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              body: ModalProgressHUD(
                inAsyncCall: _isInProgress,
                opacity: 0,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 12,
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: !_isInProgress
                        ? Column(
                      children: <Widget>[
                        SizedBox(
                          height: appBarheight,
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Animator(
                                tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(0.2, 0)),
                                duration: Duration(milliseconds: 500),
                                cycles: 0,
                                builder: (anim) => FractionalTranslation(
                                  translation: anim.value,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AllCoustomTheme.getTextThemeColors(),
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
                                    'Stock Pitch',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: ConstanceData.SIZE_TITLE20,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: new FormField(
                                  builder: (FormFieldState state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        labelText: 'Stock Name',
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: ConstanceData.SIZE_TITLE20,
                                            color: AllCoustomTheme.getTextThemeColors()
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                                        ),

                                        errorText: state.hasError ? state.errorText : null,
                                      ),
                                      isEmpty: selectedStock == '',
                                      child: getStockDropDownList(),
                                    );
                                  },
                                  validator: (val) {
                                    return ((val != null && val!='') || (selectedStock!=null && selectedStock!='')) ? null : 'choose one';
                                  },
                                )
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Expanded(
                                child: new FormField(
                                  builder: (FormFieldState state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        labelText: 'Long/Short',
                                        labelStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: ConstanceData.SIZE_TITLE20,
                                            color: AllCoustomTheme.getTextThemeColors()
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                                        ),

                                        errorText: state.hasError ? state.errorText : null,
                                      ),
                                      isEmpty: selectedLongShort == '',
                                      child: new DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                              alignedDropdown: true,
                                              child: Container(
                                                height: 16.0,
                                                child: new DropdownButton(
                                                  value: selectedLongShort,
                                                  dropdownColor: AllCoustomTheme.getThemeData().primaryColor,
                                                  isExpanded: true,
                                                  onChanged: (String newValue) {
                                                    setState(() {
                                                      selectedLongShort = newValue;
                                                    });
                                                  },
                                                  items: longShortList.map((String value) {
                                                    return new DropdownMenuItem(
                                                      value: value,
                                                      child: new Text(
                                                        value,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: ConstanceData.SIZE_TITLE14,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                          )
                                      ),
                                    );
                                  },
                                  validator: (val) {
                                    return ((val != null && val!='') || (selectedLongShort!=null && selectedLongShort!='')) ? null : 'choose one';
                                  },
                                )
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 60,
                          child: TextField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Stock Pitch Title',
                              hintText: 'Stock Pitch Title: ',
                              hintStyle: TextStyle(
                                  fontSize: ConstanceData.SIZE_TITLE10,
                                  color: AllCoustomTheme.getTextThemeColors()
                              ),
                              labelStyle: TextStyle(
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                  color: AllCoustomTheme.getTextThemeColors()
                              ),
                              fillColor: Colors.white,
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 1.0),
                              ),
                            ),
                            style: TextStyle(
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE16,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top:0),
                                  child: Text(
                                    '1-year target',
                                    style: TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE18,
                                        color: AllCoustomTheme.getTextThemeColors()
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
/*                                  height: 60,
                                  width: 150,*/
                                  height: MediaQuery.of(context).size.height * 0.11,
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  child: TextField(
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      labelText: 'Price-Base',
                                      hintText: 'Price-Base',
                                      hintStyle: TextStyle(
                                          fontSize: ConstanceData.SIZE_TITLE10,
                                          color: AllCoustomTheme.getTextThemeColors()
                                      ),
                                      labelStyle: TextStyle(
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          color: AllCoustomTheme.getTextThemeColors()
                                      ),
                                      fillColor: Colors.white,
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
/*                                  height: 60,
                                  width: 150,*/
                                  height: MediaQuery.of(context).size.height * 0.11,
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  child: TextField(
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      labelText: 'Price-Bear',
                                      hintText: 'Price-Bear',
                                      hintStyle: TextStyle(
                                          fontSize: ConstanceData.SIZE_TITLE10,
                                          color: AllCoustomTheme.getTextThemeColors()
                                      ),
                                      labelStyle: TextStyle(
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          color: AllCoustomTheme.getTextThemeColors()
                                      ),
                                      fillColor: Colors.white,
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                    ),
                                  ),
                                )



                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top:0),
                                  child: Text(
                                    '1-year fwd',
                                    style: TextStyle(
                                        fontSize: ConstanceData.SIZE_TITLE18,
                                        color: AllCoustomTheme.getTextThemeColors()
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.11,
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  child: TextField(
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      labelText: 'Revenue',
                                      hintText: 'Revenue',
                                      hintStyle: TextStyle(
                                          fontSize: ConstanceData.SIZE_TITLE10,
                                          color: AllCoustomTheme.getTextThemeColors()
                                      ),
                                      labelStyle: TextStyle(
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          color: AllCoustomTheme.getTextThemeColors()
                                      ),
                                      fillColor: Colors.white,
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.11,
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  child: TextField(
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      labelText: 'Eps',
                                      hintText: 'Eps',
                                      hintStyle: TextStyle(
                                          fontSize: ConstanceData.SIZE_TITLE10,
                                          color: AllCoustomTheme.getTextThemeColors()
                                      ),
                                      labelStyle: TextStyle(
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                          color: AllCoustomTheme.getTextThemeColors()
                                      ),
                                      fillColor: Colors.white,
                                      focusedBorder:OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                    ),
                                  ),
                                )
                              ],
                            )

                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 120,
                          child: TextField(
                            maxLines: 10,
                            decoration: InputDecoration(
                              labelText: 'Investment Thesis',
                              hintText: 'Investment Thesis: ',
                              hintStyle: TextStyle(
                                  fontSize: ConstanceData.SIZE_TITLE10,
                                  color: AllCoustomTheme.getTextThemeColors()
                              ),
                              labelStyle: TextStyle(
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                  color: AllCoustomTheme.getTextThemeColors()
                              ),
                              fillColor: Colors.white,
                              focusedBorder:OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 1.0),
                              ),
                            ),
                            style: TextStyle(
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //search Tags
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Search Topic Tags',
                              style: TextStyle(
                                color: AllCoustomTheme.getTextThemeColors(),
                                fontSize: ConstanceData.SIZE_TITLE16,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child: TypeAheadFormField(
                                textFieldConfiguration: TextFieldConfiguration(
                                    controller: _searchController,
                                    textInputAction: TextInputAction.done,
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.text,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 16.0
                                    ),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(30)
                                    ],
                                    decoration: InputDecoration(
                                      hintText: 'Search Topic Tags',
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.0,
                                              color: AllCoustomTheme.getTextThemeColors()
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(0.0))),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    onSubmitted: (value){
                                      setState(() {
                                        itemList.add(TagData(_searchController.text, _searchController.text));
                                        tagListVisible = itemList.length == 0 ? false : true;
                                      });
                                      _searchController.text = '';
                                    }
                                ),
                                suggestionsCallback: (pattern) {
                                  if (pattern.toString().trim().length < 2) {
                                    return null;
                                  } else {
                                    return searchItems(pattern);
                                  }
                                },
                                itemBuilder: (context, suggestion) {
                                  if (_searchController.text.isNotEmpty) {
                                    return ListTile(
                                      title: Text(suggestion['tag']),
                                    );
                                  } else
                                    return Container();
                                },
                                transitionBuilder: (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                onSuggestionSelected: (suggestion) {
                                  _searchController.text = '';
                                  setState(() {
                                    itemList.add(TagData(suggestion['_id'], suggestion['tag']));
                                    tagListVisible = itemList.length == 0 ? false : true;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        /////////////Topic Tag list////////
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                                visible: tagListVisible,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    'Topic Tags',
                                    style: TextStyle(
                                      color: AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                    ),
                                  ),
                                )
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.0, bottom: tagListVisible ? 24.0 : 0.0),
                              child: StaggeredGridView.countBuilder(
                                itemCount: itemList != null ? itemList.length : 0,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                shrinkWrap: true,
                                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                                itemBuilder: (context, index){
                                  return Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4.0),
                                          border: Border.all(color: Colors.grey, width: 1.0)),
                                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              '${itemList[index].tag}',
                                              style: TextStyle(
                                                  color: AllCoustomTheme.getTextThemeColors(),
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.3
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                setState(() {
                                                  itemList.removeAt(index);
                                                  tagListVisible = itemList.length == 0 ? false : true;
                                                });

                                              },
                                              child: Icon(
                                                Icons.close,
                                                color: AllCoustomTheme.getTextThemeColors(),
                                                size: 15.0,
                                              ))
                                        ],
                                      ));
                                },
                              ),
                            ),
                          ],
                        ),

                        ////upload doc//
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
/*                              new Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: new DropdownButton(
                                    hint: new Text('Select file type'),
                                    value: fileType,
                                    items: <DropdownMenuItem>[
                                      new DropdownMenuItem(
                                        child: new Text('Audio'),
                                        value: FileType.audio,
                                      ),
                                      new DropdownMenuItem(
                                        child: new Text('Image'),
                                        value: FileType.image,
                                      ),
                                      new DropdownMenuItem(
                                        child: new Text('Video'),
                                        value: FileType.video,
                                      ),
                                      new DropdownMenuItem(
                                        child: new Text('Any'),
                                        value: FileType.any,
                                      ),
                                    ],
                                    onChanged: (value) => setState(() {
                                      fileType = value;
                                    })
                                ),
                              ),
                              new ConstrainedBox(
                                constraints: BoxConstraints.tightFor(width: 200.0),
                                child: new SwitchListTile.adaptive(
                                  title: new Text('Pick multiple files', textAlign: TextAlign.right),
                                  onChanged: (bool value) => setState(() => isMultiPick = value),
                                  value: isMultiPick,
                                ),
                              ),*/
                            new Padding(
                              padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                              child: new RaisedButton(
                                onPressed: () => _openFileExplorer(),
                                child: new Text(
                                  "Upload doc",
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                  ),
                                ),
                              ),
                            ),
                            new Builder(
                              builder: (BuildContext context) => isLoadingPath ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: const CircularProgressIndicator()
                              )
                                  : path != null || paths != null ? new Container(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                height: MediaQuery.of(context).size.height * 0.50,
                                child: new Scrollbar(
                                    child: new ListView.separated(
                                      itemCount: paths != null && paths.isNotEmpty ? paths.length : 1,
                                      itemBuilder: (BuildContext context, int index) {
                                        final bool isMultiPath = paths != null && paths.isNotEmpty;
                                        final int fileNo = index + 1;
                                        final String name = 'File $fileNo : ' +
                                            (isMultiPath ? paths.keys.toList()[index] : fileName ?? '...');
                                        final filePath = isMultiPath
                                            ? paths.values.toList()[index].toString() : path;
                                        return new ListTile(
                                          title: new Text(
                                            name,
                                            style: TextStyle(
                                              color: AllCoustomTheme.getTextThemeColors(),
                                              fontSize: ConstanceData.SIZE_TITLE14,
                                            ),
                                          ),
                                          subtitle: new Text(
                                            filePath,
                                            style: TextStyle(
                                              color: AllCoustomTheme.getTextThemeColors(),
                                              fontSize: ConstanceData.SIZE_TITLE14,
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) => new Divider(),
                                    )),
                              )
                                  : new Container(),
                            ),
                          ],
                        ),
/*                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "Upload doc",
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                              MaterialButton(
                                splashColor: Colors.grey,
                                child: Text(
                                  "Upload model",
                                  style: TextStyle(
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontSize: ConstanceData.SIZE_TITLE18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),*/

                        SizedBox(height: 24.0,),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 14, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 50,
                                child: Animator(
                                  tween: Tween<double>(begin: 0.8, end: 1.1),
                                  curve: Curves.easeInToLinear,
                                  cycles: 0,
                                  builder: (anim) => Transform.scale(
                                    scale: anim.value,
                                    child: Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        border: new Border.all(color: Colors.white, width: 1.5),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            globals.buttoncolor1,
                                            globals.buttoncolor2,
                                          ],
                                        ),
                                      ),
                                      child: MaterialButton(
                                        splashColor: Colors.grey,
                                        child: Text(
                                          "Done",
                                          style: TextStyle(
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                        : SizedBox(),
                  ),
                ),
              ),
            )
        )
      ],
    );
  }
}
