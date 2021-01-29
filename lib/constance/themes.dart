import 'package:flutter/material.dart';
import 'package:auroim/constance/global.dart' as globals;

class AllCoustomTheme {
  static ThemeData getThemeData() {
    if (globals.isLight) {
      return buildLightTheme();
    } else {
      return buildDarkTheme();
    }
  }

  static ThemeData getInternalThemeData() {
    if (globals.isGoldBlack) {
      return buildGoldBlackTheme();
    } else {
      return buildBlueTheme();
    }
  }

  static Color getTextThemeColors() {
    if (globals.isLight) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  static Color getsecoundTextThemeColor() {
    return Color(0xFF525a6d);
  }

  static Color getNewTextThemeColors() {
    if (globals.isGoldBlack) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  static Color getNewSecondTextThemeColor() {
    return Color(0xFF525a6d);
  }

  static Color getButtonTextThemeColors() {
    if (globals.isGoldBlack) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  static Color getHeadingThemeColors() {
    if (globals.isGoldBlack) {
      return Color(0xFFD8AF4F);
    } else {
      return Colors.black;
    }
  }

  static Color getSecondHeadingThemeColor() {
    return Color(0xFF525a6d);
  }

  static Color getSubHeadingThemeColors() {
    if (globals.isGoldBlack) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  static Color getSecondSubHeadingThemeColor() {
    return Colors.white;
  }

  static Color getSeeMoreThemeColor() {
    return Color(0xFF5CA2F4);
  }

  static Color getChartBoxThemeColor() {
    if (globals.isGoldBlack) {
      return Color(0xFFF5564E);
    } else {
      return Color(0xFF7499C6);
    }
  }

  static Color getChartBoxTextThemeColor() {
    if (globals.isGoldBlack) {
      return Color(0xFFF5564E);
    } else {
      return Color(0xFF7499C6);
    }
  }

  static Color getButtonBoxColor() {
    if (globals.isGoldBlack) {
      return Color(0xFFD8AF4F);
    } else {
      return Color(0xFF7499C6);
    }
  }


  static Color getIconThemeColors() {
    if (globals.isGoldBlack) {
      return Color(0xFFD8AF4F);
    } else {
      return Color(0xFF7499C6);
    }
  }

  static Color getSecondIconThemeColor() {
    return Colors.grey;
  }



  static Color boxColor() {
    return Color(0xFF1a202f);
  }

  static Color qusBoxColor() {
    return Colors.black;
  }

  static Color getBlackAndWhiteThemeColors() {
    if (globals.isLight) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  static Color getReBlackAndWhiteThemeColors() {
    if (globals.isLight) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    final txtName = 'Ubuntu';
    return base.copyWith(
      body1: base.title.copyWith(
        fontFamily: txtName,
        fontSize: 16,
        color: getBlackAndWhiteThemeColors(),
      ),
      body2: base.title.copyWith(
        fontFamily: txtName,
        fontSize: 14,
        color: getTextThemeColors(),
      ),
      caption: base.title.copyWith(
        fontFamily: txtName,
        fontSize: 12,
        color: getTextThemeColors(),
      ),
      headline: base.title.copyWith(
        fontFamily: txtName,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: getBlackAndWhiteThemeColors(),
      ),
      subhead: base.title.copyWith(
        fontFamily: txtName,
        fontSize: 22,
        color: getTextThemeColors(),
      ),
      title: base.title.copyWith(
        fontFamily: txtName,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: getBlackAndWhiteThemeColors(),
      ),
      subtitle: base.title.copyWith(
        fontFamily: txtName,
        fontSize: 16,
        color: getTextThemeColors(),
      ),
    );
  }

  static IconThemeData iconTheme() {
    return IconThemeData(color: getThemeData().primaryColor, opacity: 1.0);
  }

  static ThemeData buildDarkTheme() {
    return buildLightTheme();
  }

  static ThemeData buildLightTheme() {
    Color primaryColor = HexColor(globals.primaryColorString);
    Color secondaryColor = Colors.white;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: const Color(0xFFEFF1F4),
      backgroundColor: const Color(0x101622),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
    );
  }

  static ThemeData buildBlueTheme() {
    Color primaryColor = HexColor(globals.primaryColorString);
    Color secondaryColor = Colors.white;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: const Color(0xFFEFF1F4),
      backgroundColor: const Color(0x101622),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
    );
  }


  static ThemeData buildGoldBlackTheme() {
    Color primaryColor = HexColor(globals.primaryColorString);
    Color secondaryColor = Colors.black;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: const Color(0xFFEFF1F4),
      backgroundColor: const Color(0x101622),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
    );
  }

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
