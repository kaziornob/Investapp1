import 'dart:convert';
import 'dart:io';
import 'package:auroim/api/featured_companies_provider.dart';
import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:auroim/dialog_widgets/dialog1.dart';
import 'package:auroim/model/tagAndChartData.dart';
import 'package:auroim/provider_abhinav/currency_rate_provider.dart';
import 'package:auroim/provider_abhinav/progress.dart';
import 'package:auroim/provider_abhinav/stock_pitch_provider.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:auroim/reusable_widgets/screen_title_appbar.dart';
import 'package:auroim/widgets/aws/aws_client.dart';
import 'package:auroim/widgets/stock_and_portfolio_pitch/pitch_templates.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;
import 'package:path/path.dart' as exten;
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../reusable_widgets/customButton.dart';

class StockPitch extends StatefulWidget {
  @override
  _StockPitchState createState() => _StockPitchState();
}

class _StockPitchState extends State<StockPitch> {
  bool _isInProgress = false;
  List tagList = List();
  bool tagListVisible = false;
  List<TagData> itemList = List();
  bool _isInit = true;
  FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  AWSClient awsClient = AWSClient();
  TextEditingController _searchTopicController = TextEditingController();
  TextEditingController _priceBaseController = TextEditingController();
  TextEditingController _priceBearController = TextEditingController();
  TextEditingController _revenueController = TextEditingController();
  TextEditingController _epsController = TextEditingController();
  TextEditingController _searchStockNameController = TextEditingController();
  TextEditingController _stockPitchTitleController = TextEditingController();
  TextEditingController _investmentThesisController = TextEditingController();
  List<String> listOfFxs = [];
  String selectedFx = "USD";
  List<String> pollDurationList = <String>['7 days', '14 days', '21 days'];
  LinearGradient progressGradient;
  final _stockPitchFormKey = new GlobalKey<FormState>();

  // List<String> stockNameList = <String>["Listed", "Unlisted", "Crypto"];

  List<String> longShortList = <String>['Long', 'Short'];

  String selectedStockId;
  String selectedStockName;
  String selectedLongShort;
  String docUrl;
  String videoUrl;
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
    // getTagList();
    progressGradient = LinearGradient(
      colors: [
        Color(0xFF235E77),
        Color(0xFF1A3263),
      ],
    );
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

  Future<bool> _openVideoExplorer() async {
    try {
      path = await FilePicker.getFilePath(
        type: FileType.video,
      );
      if (path != null) {
        print(path);
        setState(() {
          isLoadingPath = true;
        });
        Toast.show(
          "Uploading Video...",
          context,
        );
        // get file from path and convert to byteData to send to aws
        File file = File(path);
        if (await file.length() == 0) {
          return false;
        }
        // Uint8List bytesData = file.readAsBytesSync();
        // videoUrl = await awsClient.fileUploadMultipart(
        //  file: file,
        // );
        // var videoUrl = await awsClient.getUploadUrl();
        // String extension =
        //     path.split("/")[path.split("/").length - 1].split(".")[1];
        print(exten.extension(path));
        videoUrl =
            await awsClient.uploadFile(file, exten.extension(path), context);
        // videoUrl = await awsClient.uploadData(
        //   "Stock-Security Pitch",
        //   DateTime.now().toIso8601String(),
        //   bytesData,
        // );
        //return true only when url is got
        if (videoUrl != null && videoUrl != "") {
          Toast.show(
            "Video Uploaded !! ",
            context,
            duration: 3,
          );
          setState(() {
            isLoadingPath = false;
            fileName = path;
          });
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on PlatformException catch (err) {
      //on error return false
      print("Unsupported operation" + err.toString());
      return false;
    }
  }

  Future<bool> _openFileExplorer() async {
    // setState(() => isLoadingPath = true);
    try {
      // if (isMultiPick) {
      //   path = null;
      //   paths = await FilePicker.getMultiFilePath(
      //     type: fileType,
      //     allowedExtensions: extensions,
      //   );
      // } else {
      path = await FilePicker.getFilePath(
        type: fileType,
        allowedExtensions: extensions,
      );
      if (path != null) {
        print(path);
        setState(() {
          isLoadingPath = true;
        });
        Toast.show(
          "Uploading Doc...",
          context,
        );
        // get file from path and convert to byteData to send to aws
        File file = File(path);
        if (await file.length() == 0) {
          return false;
        }
        // Uint8List bytesData = file.readAsBytesSync();
        // String extension =
        //     path.split("/")[path.split("/").length - 1].split(".")[1];
        docUrl =
            await awsClient.uploadFile(file, exten.extension(path), context);
        // docUrl = await awsClient.uploadData(
        //   "Stock-Security Pitch",
        //   DateTime.now().toIso8601String(),
        //   bytesData,
        // );
        //return true only when url is got
        if (docUrl != null && docUrl != "") {
          Toast.show(
            "Doc Uploaded !! ",
            context,
            duration: 3,
          );
          setState(() {
            isLoadingPath = false;
            fileName = path;
          });
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
      // paths = null;
      // }
    } on PlatformException catch (e) {
      //on error return false
      print("Unsupported operation" + e.toString());
      return false;
    }
    // if (!mounted) return false;
    // setState(() {
    //   isLoadingPath = false;
    //   fileName = path != null
    //       ? path.split('/').last
    //       : paths != null
    //           ? paths.keys.toString()
    //           : '...';
    // });
  }

  Future<List> searchItems(query) async {
    List resultList = List();
    for (var i = 0; i < tagList.length; i++) {
      if (tagList[i]['tag'].toString().toLowerCase().contains(query)) {
        resultList.add(tagList[i]);
      }
    }

    return resultList;
  }

  @override
  void dispose() {
    _epsController.dispose();
    _priceBaseController.dispose();
    _priceBearController.dispose();
    _revenueController.dispose();
    _searchStockNameController.dispose();
    _searchTopicController.dispose();
    _stockPitchTitleController.dispose();
    _investmentThesisController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<CurrencyRateProvider>(context, listen: false)
          .getListOfAllFx();
      Provider.of<CurrencyRateProvider>(context, listen: false)
          .listOfAllFxs
          .forEach((element) {
        listOfFxs.add(element["ccy_symbol"]);
      });
      setState(() {});
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  textFieldInputDecoration(hintText, labelText, suffixText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: ConstanceData.SIZE_TITLE14,
        color: Colors.black,
      ),
      labelStyle: TextStyle(
        fontSize: ConstanceData.SIZE_TITLE16,
        color: Colors.black,
      ),
      suffixIcon: suffixText == null ? null : questionMark(suffixText),
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
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
    );
  }

  searchStockName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Stock Name*',
            style: TextStyle(
              color: Colors.black,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: Container(
            child: TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _searchStockNameController,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                maxLines: 1,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                decoration:
                    textFieldInputDecoration("Search Stock Name", "", null),
              ),
              suggestionsCallback: (pattern) async {
                print("pattern : $pattern");
                return await _featuredCompaniesProvider
                    .searchPublicCompanyList(pattern);
              },
              validator: _validateStockName,
              itemBuilder: (context, suggestion) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    suggestion["company_name"],
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                setState(() {
                  _searchStockNameController.text = suggestion['company_name'];
                  selectedStockId = suggestion['ticker'];
                  selectedStockName = suggestion['company_name'];
                });
              },
            ),
          ),
        )
      ],
    );
  }

  longShortSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            bottom: 12,
          ),
          child: Text(
            "Strategy*",
            style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              color: Colors.black,
              fontSize: 16.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            width: (MediaQuery.of(context).size.width / 2) - 20,
            child: FormField(
              builder: (FormFieldState state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: ConstanceData.SIZE_TITLE14,
                      color: Colors.black,
                    ),
                    errorText: state.hasError ? state.errorText : null,
                  ),
                  isEmpty: selectedLongShort == '',
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        value: selectedLongShort,
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        onChanged: (String newValue) {
                          setState(() {
                            selectedLongShort = newValue;
                          });
                        },
                        items: longShortList.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontFamily: "Roboto",
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
              validator: (val) {
                return ((val != null && val != '') ||
                        (selectedLongShort != null && selectedLongShort != ''))
                    ? null
                    : 'choose one';
              },
            ),
          ),
        ),
      ],
    );
  }

  String _validateStockName(value) {
    if (value.isEmpty || selectedStockId == null) {
      return "Please Select Stock";
    }
    return null;
  }

  String _validateStockTitle(value) {
    if (value.isEmpty) {
      return "This Field cannot be empty";
    }
    return null;
  }

  String _validateBaseCase(value) {
    if (value.isEmpty) {
      return "This Field cannot be empty";
    }
    return null;
  }

  String _validateBearCase(value) {
    if (value.isEmpty) {
      return "This Field cannot be empty";
    }
    return null;
  }

  String _validateInvestmentThesis(value) {
    if (value.isEmpty) {
      return "This Field cannot be empty";
    }
    return null;
  }

  String _validateTags(value) {
    if (tagList.length == 0) {
      return "Add Tags to proceed";
    }
    return null;
  }

  selectCurrencySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            bottom: 12,
          ),
          child: Text(
            "Select Currency*",
            style: TextStyle(
              fontFamily: "WorkSansSemiBold",
              color: Colors.black,
              fontSize: 16.0,
              letterSpacing: 0.1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            width: (MediaQuery.of(context).size.width / 2) - 20,
            child: FormField(
              builder: (FormFieldState state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: ConstanceData.SIZE_TITLE14,
                      color: Colors.black,
                    ),
                    errorText: state.hasError ? state.errorText : null,
                  ),
                  isEmpty: selectedFx == '',
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        value: selectedFx,
                        dropdownColor: Colors.white,
                        // isExpanded: true,
                        onChanged: (String newValue) {
                          setState(() {
                            selectedFx = newValue;
                          });
                        },
                        items: listOfFxs.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: AllCoustomTheme.getTextThemeColor(),
                                fontSize: ConstanceData.SIZE_TITLE16,
                                fontFamily: "Roboto",
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
              // validator: _validateCurrency,
            ),
          ),
        ),
      ],
    );
  }

  stockPitchTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Stock Pitch Title*',
            style: TextStyle(
              color: Colors.black,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: Container(
            height: 60,
            child: TextFormField(
              controller: _stockPitchTitleController,
              decoration: textFieldInputDecoration(
                "Enter title",
                "",
                "Can be a listed stock,private company or a crypto coin that you think will go up (Long Pitch) or go down (Short Pitch) on value?",
              ),
              cursorColor: Colors.black,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              validator: _validateStockTitle,
            ),
          ),
        )
      ],
    );
  }

  smallTextField(title, controller, isMust, suffixText, validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 12.0,
            top: 12.0,
          ),
          child: Text(
            isMust ? "$title*" : "$title",
            style: TextStyle(
              color: Colors.black,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
        Container(
          height: 60,
          width: (MediaQuery.of(context).size.width / 2) - 20,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: textFieldInputDecoration("", "", suffixText),
            cursorColor: Colors.black,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
            validator: validator,
          ),
        )
      ],
    );
  }

  investmentThesis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Investment thesis*"),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: Container(
            height: 120,
            child: TextFormField(
              controller: _investmentThesisController,
              maxLines: 10,
              decoration: textFieldInputDecoration("", '', null),
              style: TextStyle(
                color: Colors.black,
                fontSize: ConstanceData.SIZE_TITLE16,
              ),
              validator: _validateInvestmentThesis,
            ),
          ),
        ),
      ],
    );
  }

  topicTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Tags*',
            style: TextStyle(
              color: Colors.black,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: Container(
            child: TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _searchTopicController,
                textInputAction: TextInputAction.done,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                decoration: textFieldInputDecoration("Input tags", "", null),
              ),
              suggestionsCallback: (pattern) async {
                print("pattern : $pattern");
                return await _featuredCompaniesProvider
                    .searchPublicCompanyList(pattern);
              },
              itemBuilder: (context, suggestion) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    suggestion["company_name"],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              // validator: _validateTags,
              onSuggestionSelected: (suggestion) {
                print("suggestion: ${suggestion['ticker']}");
                print("suggestion name: ${suggestion['company_name']}");

                _searchTopicController.text = '';
                setState(
                  () {
                    itemList.add(
                      TagData(suggestion['ticker'], suggestion['company_name']),
                    );
                    tagListVisible = itemList.length == 0 ? false : true;
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  showAllSelectedTags() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: tagListVisible,
            child: Padding(
              padding: EdgeInsets.only(
                top: 20.0,
                bottom: 8.0,
              ),
              child: Text(
                'Topic Tags',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ConstanceData.SIZE_TITLE16,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 8.0,
              bottom: tagListVisible ? 24.0 : 0.0,
            ),
            child: StaggeredGridView.countBuilder(
              itemCount: itemList != null ? itemList.length : 0,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              shrinkWrap: true,
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: globals.isGoldBlack
                          ? Color(0xFFD8AF4F)
                          : Color(0xFF1D6177),
                      width: 1.0,
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${itemList[index].tag}',
                          style: TextStyle(
                            color: globals.isGoldBlack
                                ? Color(0xFFD8AF4F)
                                : Color(0xFF1D6177),
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            height: 1.3,
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
                            tagListVisible =
                                itemList.length == 0 ? false : true;
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: globals.isGoldBlack
                              ? Color(0xFFD8AF4F)
                              : Color(0xFF1D6177),
                          size: 15.0,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  uploadButton(text) {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: globals.isGoldBlack ? Color(0xFFD8AF4F) : Color(0xFF1D6177),
          width: 1.0,
        ),
      ),
      padding: EdgeInsets.all(
        8.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color:
                    globals.isGoldBlack ? Color(0xFFD8AF4F) : Color(0xFF1D6177),
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  progressBar(width, percent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LinearPercentIndicator(
          // restartAnimation: false,
          // animation: true,
          percent: percent / 100,
          linearGradient: progressGradient,
          lineHeight: 9,
          width: width,
          trailing: Text("${percent.toString().split(".")[0]}%"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllCoustomTheme.getBodyContainerThemeColor(),
      body: SafeArea(
        bottom: true,
        child: ModalProgressHUD(
          inAsyncCall: _isInProgress,
          opacity: 0,
          progressIndicator: CupertinoActivityIndicator(
            radius: 12,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: !_isInProgress
                ? Form(
                    key: _stockPitchFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        ScreenTitleAppbar(
                          title: 'STOCK PITCH',
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        searchStockName(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            longShortSection(),
                            selectCurrencySection(),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        stockPitchTitle(),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                            children: [
                              Text(
                                "1-year target price",
                                style: TextStyle(
                                  color: globals.isGoldBlack
                                      ? Color(0xFFD8AF4F)
                                      : Color(0xFF7499C6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            smallTextField(
                              "Base Case",
                              _priceBaseController,
                              true,
                              "This is you target price in 1-year's time for this security.For a \'long\' pitch should be higher than current value of security, and lower if this is \'short\' pitch",
                              _validateBaseCase,
                            ),
                            smallTextField(
                              "Bear Case",
                              _priceBearController,
                              true,
                              "This is your target price in 1-years's time if your investment thesis didn't work and the security goes in the opposite direction of your prediction",
                              _validateBearCase,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                            children: [
                              Text(
                                "1-year forward estimate",
                                style: TextStyle(
                                  color: globals.isGoldBlack
                                      ? Color(0xFFD8AF4F)
                                      : Color(0xFF7499C6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            smallTextField(
                              "Revenue forecast",
                              _revenueController,
                              false,
                              "This is your estimate of this security's Revenue in 1 years's time.",
                              (value) {
                                return null;
                              },
                            ),
                            smallTextField(
                              "Earning per share forecast",
                              _epsController,
                              false,
                              "This is your estimate of this security's Earnings Per Share in 1 years's time.",
                              (value) {
                                return null;
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        investmentThesis(),
                        SizedBox(
                          height: 20,
                        ),
                        topicTags(),
                        showAllSelectedTags(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: _openFileExplorer,
                              child: uploadButton("Upload pitch document"),
                            ),
                            GestureDetector(
                              onTap: _openVideoExplorer,
                              child: uploadButton("Upload pitch video"),
                            ),
                          ],
                        ),
                        docUrl != null && docUrl != ""
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Pitch Doc Attached",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: globals.isGoldBlack
                                            ? Color(0xFFD8AF4F)
                                            : Color(0xFF1D6177),
                                      ),
                                    ),
                                    Icon(
                                      Icons.attach_file_rounded,
                                      color: globals.isGoldBlack
                                          ? Color(0xFFD8AF4F)
                                          : Color(0xFF1D6177),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        videoUrl != null && videoUrl != ""
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Pitch Video Attached",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: globals.isGoldBlack
                                            ? Color(0xFFD8AF4F)
                                            : Color(0xFF1D6177),
                                      ),
                                    ),
                                    Icon(
                                      Icons.attach_file_rounded,
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
                            return awsProgressProvider.percentage == 100.0 ||
                                    awsProgressProvider.percentage == 0.0
                                ? SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: progressBar(
                                        MediaQuery.of(context).size.width - 80,
                                        awsProgressProvider.percentage,
                                      ),
                                    ),
                                  );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PitchTemplates(),
                                ),
                              );
                            },
                            child: Text(
                              "See Auro stock pitch templates here",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        CustomButton(
                          text: "Done",
                          callback: onPressedDone,
                          color: globals.isGoldBlack
                              ? Color(0xFFD8AF4F)
                              : Color(0xFF1D6177),
                          textColor: Colors.white,
                          borderColor: globals.isGoldBlack
                              ? Color(0xFFD8AF4F)
                              : Color(0xFF1D6177),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ),
        ),
      ),
    );
  }

  onPressedDone() async {
    print("done pressed");
    if (_stockPitchFormKey.currentState.validate() == false) {
      print("hghsgdhsgdhs");
      return;
    }
    print("done pressed2");
    try {
      List allTags = [];
      itemList.forEach((element) {
        allTags.add(element.tag);
      });
      print(allTags);
      var currencyRate =
          Provider.of<CurrencyRateProvider>(context, listen: false)
              .listOfAllFxs
              .firstWhere((element) => element["ccy_symbol"] == selectedFx);

      print(double.parse(_priceBaseController.text));
      print(double.parse(_priceBearController.text));
      var body = {
        "email": Provider.of<UserDetails>(context, listen: false)
            .userDetails["email"],
        "stock_name": "Listed",
        "isLong": selectedLongShort == "Short" ? 0 : 1,
        "price_base": double.parse(_priceBaseController.text) /
            currencyRate["last_price"],
        "price_bear": double.parse(_priceBearController.text) /
            currencyRate["last_price"],
        "revenue": _revenueController.text.isEmpty
            ? 0.0
            : double.parse(_revenueController.text),
        "eps": _epsController.text.isEmpty
            ? 0.0
            : double.parse(_epsController.text),
        "investment_thesis": _investmentThesisController.text,
        "topic_tags": jsonEncode(allTags),
        "stock_id": selectedStockId,
        "title": _stockPitchTitleController.text,
        "docUrl": docUrl == null ? "" : docUrl,
        "videoUrl": videoUrl == null ? "" : videoUrl,
        "currencySelected": selectedFx,
        "company_name": selectedStockName,
      };

      print(body);

      bool done = await Provider.of<StockPitchProvider>(context, listen: false)
          .uploadStockPitch(body);
      if (done) {
        getDialog("Stock Pitch Uploaded", true);
      } else {
        getDialog("Some Error Occurred", true);
      }
    } catch (err, stackTrace) {
      FirebaseCrashlytics.instance.recordError(
        err,
        stackTrace,
        reason: 'Stock Pitch upload',
      );
      print(err.toString());
      Toast.show("Some Error Occurred", context);
    }
    // if (_priceBaseController.text.isNotEmpty &&
    //     _priceBearController.text.isNotEmpty) {
    //
    // } else {
    //   getDialog("Price-Bear/Price-Base cannot be empty", false);
    // }
  }

  void getDialog(text, cancel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog1(
          text: text,
          doublePop: cancel,
        );
      },
    );
  }

  questionMark(text) {
    return Tooltip(
      child: Icon(
        Icons.help,
        color: Colors.grey,
      ),
      message: text,
    );
  }
}
