import 'package:auroim/constance/constance.dart';
import 'package:auroim/constance/themes.dart';
import 'package:flutter/material.dart';

class GoToMarketplaceButton extends StatelessWidget {
  final VoidCallback callback;
  final Color buttonColor;
  final Color textColor;

  GoToMarketplaceButton({
    this.callback,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width - 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: buttonColor,
          ),
          child: Center(
            child: Text(
              "Go to Marketplace",
              style: TextStyle(
                  color: textColor,
                  fontSize: ConstanceData.SIZE_TITLE20,
                  fontFamily: "Roboto",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1),
            ),
          ),
        ),
      ),
    );
  }
}
