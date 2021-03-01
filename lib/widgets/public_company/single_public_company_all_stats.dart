import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SinglePublicCompanyAllStatsList extends StatefulWidget {
  @override
  _SinglePublicCompanyAllStatsListState createState() =>
      _SinglePublicCompanyAllStatsListState();
}

class _SinglePublicCompanyAllStatsListState
    extends State<SinglePublicCompanyAllStatsList> {
  int slideIndex = 0;
  List slideArray;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      slideArray = [
        listItem1(),
        listItem1(),
        listItem1(),
        listItem1(),
        listItem1(),
      ];
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.5, right: 7.5),
      child: Container(
        height: 180,
        // color: Colors.blue,
        width: MediaQuery.of(context).size.width - 15,
        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width - 15,
              child: CarouselSlider.builder(
                itemCount: slideArray.length,
                options: CarouselOptions(
                    autoPlay: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        slideIndex = index;
                      });
                    }),
                itemBuilder: (context, index) {
                  return Container(
                    // margin: EdgeInsets.only(
                    //     left: MediaQuery.of(context).size.width * 0.048,
                    //     right: MediaQuery.of(context).size.width * 0.048),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        right: 8.0,
                        left: 8.0,
                      ),
                      child: Material(
                        elevation: 10,
                        child: Container(
                          width: 350,
                          // color: Colors.green,
                          child: slideArray[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: slideArray.map((url) {
                  int index = slideArray.indexOf(url);
                  return Container(
                    width: 10.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          slideIndex == index ? Color(0xff5A56B9) : Colors.grey,
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
        // Center(
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(
        //           top: 8.0,
        //           bottom: 8.0,
        //           right: 8.0,
        //           left: 8.0,
        //         ),
        //         child: Material(
        //           elevation: 10,
        //           child: Container(
        //             width: 300,
        //             // color: Colors.green,
        //             child: Center(
        //               child: Text("Stats"),
        //             ),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Material(
        //           elevation: 10,
        //           child: Container(
        //             width: 300,
        //             // height: 160,
        //             // color: Colors.green,
        //             child: Center(
        //               child: Text("Stats"),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  listItem2(){

  }


  listItem1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        singleRow(context, "Industry", Colors.indigo[50], "Computer Hardware"),
        singleRow(
            context, "Institutional Ownership", Colors.indigo[100], "58.78"),
        singleRow(context, "Market Cap", Colors.indigo[50], "2184.8B"),
        singleRow(context, "Sector", Colors.indigo[100], "Technology"),
        singleRow(context, "Shares Outstanding", Colors.indigo[50], "16.8B"),
      ],
    );
  }

  singleRow(context, text, color, value) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          color: color,
        ),
        height: 25,
        width: 340,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(child: Text(text)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(child: Text(value)),
            ),
          ],
        ),
      ),
    );
  }
}
