import 'package:auroim/modules/home/auro_ai_portfolio.dart';
import 'package:auroim/modules/home/auro_portfolio_mix.dart';
import 'package:auroim/modules/home/auro_portfolio_return.dart';
import 'package:auroim/modules/home/widgets/auroai_portfolio_values.dart';
import 'package:auroim/modules/investRelatedPages/riskOnboardingPages/golive_screen.dart';
import 'package:auroim/paypal/paypal_payment.dart';
import 'package:auroim/provider_abhinav/user_details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewMainHomeTab extends StatefulWidget {
  const NewMainHomeTab({Key key}) : super(key: key);

  @override
  _NewMainHomeTabState createState() => _NewMainHomeTabState();
}

class _NewMainHomeTabState extends State<NewMainHomeTab> {
  CarouselController _carouselController = CarouselController();
  int carouselIndex = 0;

  Map sliderItems = {
    0: {
      "asset": "assets/portfolio_mix.png",
      "text": "AURO PORTFOLIO MIX",
    },
    1: {
      "asset": "assets/portfolio_return.png",
      "text": "AURO PORTFOLIO RETURN",
    },
    2: {
      "asset": "assets/auro_portfolio.png",
      "text": "VIEW AURO PORTFOLIO",
    },
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                bottom: 10.0,
              ),
              child: CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: 3,
                itemBuilder: (context, int index) {
                  return sliderItem(index);
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 3.5,
                  autoPlay: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      carouselIndex = index;
                    });
                  },
                ),
              ),
            ),
            carouselIndexIndicator(),
            AuroAiPortfolioValues(),
            bottomWidget(),
          ],
        ),
      ),
    );
  }

  bottomWidget() {
    var userName = Provider.of<UserDetails>(context).userDetails["f_name"];
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$userName's Portfolio",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: RaisedButton(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xFFD8AF4F),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => PaypalPayment(
                            onFinish: (number) async {

                              // payment done
                              print('order id: '+number);

                            },
                          ),
                        ),
                      );
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) => GoLiveScreen(
                      //       callingFrom: "",
                      //     ),
                      //   ),
                      // );
                    },
                    color: Color(0xFFD8AF4F),
                    child: Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: RaisedButton(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => AuroAiPortfolio(),
                        ),
                      );
                    },
                    color: Colors.black,
                    child: Text(
                      "PAPER",
                      style: TextStyle(
                        color: Color(0xFFD8AF4F),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  carouselIndexIndicator() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _carouselController.animateToPage(0);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 5,
                backgroundColor:
                    carouselIndex == 0 ? Color(0xFFD8AF4F) : Colors.grey,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _carouselController.animateToPage(1);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 5,
                backgroundColor:
                    carouselIndex == 1 ? Color(0xFFD8AF4F) : Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _carouselController.animateToPage(2);
              },
              child: CircleAvatar(
                radius: 5,
                backgroundColor:
                    carouselIndex == 2 ? Color(0xFFD8AF4F) : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  sliderItem(index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AuroPortfolioMix(),
            ),
          );
        } else if (index == 1) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AuroPortfolioReturn(),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AuroAiPortfolio(),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 1.5,
              color: Color(0xFFD8AF4F),
            ),
          ),
          elevation: 5,
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: Color(0xFFD8AF4F),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Image.asset(
                  sliderItems[carouselIndex]["asset"],
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.height / 5,
                ),
                Image.asset(
                  "assets/bottom_shadow.png",
                  width: MediaQuery.of(context).size.height / 8,
                ),
                Text(
                  sliderItems[carouselIndex]["text"],
                  style: TextStyle(
                    color: Color(0xFFD8AF4F),
                    fontFamily: "Roboto",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
