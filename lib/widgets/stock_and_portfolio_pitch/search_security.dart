import 'package:auroim/api/featured_companies_provider.dart';
import 'package:flutter/material.dart';

class SearchSecurity extends StatefulWidget {
  final callBack;

  const SearchSecurity({Key key, this.callBack}) : super(key: key);

  @override
  _SearchSecurityState createState() => _SearchSecurityState();
}

class _SearchSecurityState extends State<SearchSecurity> {
  final FeaturedCompaniesProvider _featuredCompaniesProvider =
      FeaturedCompaniesProvider();
  TextEditingController _filterBySecurityController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  bool searching = false;

  @override
  void initState() {
    _filterBySecurityController.addListener(() {
      if (_filterBySecurityController.text.length > 0) {
        setState(() {
          searching = true;
        });
      } else {
        setState(() {
          searching = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _filterBySecurityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("SEARCH SECURITY PAGE");
    return StatefulBuilder(builder: (context, setSheetState) {
      return Container(
        height: MediaQuery.of(context).size.height - 65,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  cursorColor: Colors.blue,
                  controller: _filterBySecurityController,
                  focusNode: _focusNode,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color(0xff5A56B9),
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xff5A56B9),
                        width: 1,
                      ),
                    ),

                    hintText: "Search Listed Company",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color(0xff5A56B9),
                      fontSize: 17,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Color(0xff5A56B9),
                    ),
                    // prefix: Padding(
                    //   padding: const EdgeInsets.only(
                    //       left: 8.0, right: 8.0, bottom: 8.0, top: 8.0),
                    //   child: ,
                    // ),
                    contentPadding: EdgeInsets.all(16.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(
                        color: Color(0xff5A56B9),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: _featuredCompaniesProvider
                  .searchPublicCompanyList(_filterBySecurityController.text),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.data.length == 0) {
                    return ListTile(
                      onTap: () {
                        setSheetState(() {
                          _filterBySecurityController.clear();
                        });
                      },
                      title: Text(
                        "No Results",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.close_rounded),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                widget.callBack(snapshot.data[index]);
                              },
                              title: Text(
                                snapshot.data[index]["company_name"],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
