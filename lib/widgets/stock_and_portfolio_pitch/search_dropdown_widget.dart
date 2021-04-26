// import 'package:auroim/api/featured_companies_provider.dart';
// import 'package:auroim/constance/themes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
//
// class SearchDropdownWidget extends StatefulWidget {
//   final Function suggestionCallback;
//   final Function suggestionSelectedCallback;
//
//   const SearchDropdownWidget({
//     Key key,
//     this.suggestionCallback,
//     this.suggestionSelectedCallback,
//   }) : super(key: key);
//
//   @override
//   _SearchDropdownWidgetState createState() => _SearchDropdownWidgetState();
// }
//
// class _SearchDropdownWidgetState extends State<SearchDropdownWidget> {
//   TextEditingController _searchTopicController = TextEditingController();
//   FeaturedCompaniesProvider _featuredCompaniesProvider =
//       FeaturedCompaniesProvider();
//
//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadFormField(
//       textFieldConfiguration: TextFieldConfiguration(
//         controller: _searchTopicController,
//         textInputAction: TextInputAction.done,
//         textAlign: TextAlign.start,
//         keyboardType: TextInputType.text,
//         maxLines: 1,
//         style: TextStyle(fontSize: 16.0, color: Colors.black),
//         inputFormatters: [LengthLimitingTextInputFormatter(30)],
//         decoration: InputDecoration(
//           hintText: 'Search Topic Tags',
//           border: OutlineInputBorder(
//               borderSide: BorderSide(
//                 width: 1.0,
//                 color: AllCoustomTheme.getTextThemeColor(),
//               ),
//               borderRadius: BorderRadius.all(Radius.circular(0.0))),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey, width: 1.0),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.black, width: 1.0),
//           ),
//           hintStyle: TextStyle(
//             color: Colors.grey,
//             fontSize: 15.0,
//           ),
//         ),
//         onSubmitted: (value) {
//           // setState(() {
//           //   itemList.add(TagData(
//           //       _searchTopicController.text,
//           //       _searchTopicController.text));
//           //   tagListVisible =
//           //       itemList.length == 0
//           //           ? false
//           //           : true;
//           // });
//           // _searchTopicController.text = '';
//         },
//       ),
//       suggestionsCallback: (pattern) async {
//         print("pattern : $pattern");
//         return await _featuredCompaniesProvider
//             .searchPublicCompanyList(pattern);
//       },
//       itemBuilder: (context, suggestion) {
//         return ListTile(
//           title: Text(
//             suggestion["company_name"],
//             style: TextStyle(
//               color: Colors.black,
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (context, suggestionsBox, controller) {
//         return suggestionsBox;
//       },
//       onSuggestionSelected: (suggestion) {
//         print("suggestion: ${suggestion['ticker']}");
//         print("suggestion name: ${suggestion['company_name']}");
//
//         _searchTopicController.text = '';
//         setState(
//           () {
//             itemList.add(
//               TagData(suggestion['ticker'], suggestion['company_name']),
//             );
//             tagListVisible = itemList.length == 0 ? false : true;
//           },
//         );
//       },
//     );
//   }
// }
