import 'package:flutter/material.dart';

class AppColors{
  static const Color mainBackgroundColor = Color.fromARGB(255, 254, 255, 255);
  static const Color primaryColor = Color.fromRGBO(65, 204, 183, 1);
  static const Color secondaryColor = Color(0xfff3d3bd);
  static const Color mainBlackColor = Color(0xFF332d2b);
  static const Color lightGrayColor = Color(0xFF5E5E5E);
  static const Color mediumGrayColor = Color(0xFF333333);

  static const Color blueSecondaryColor = Color(0x2ea3f2FF);
  static const Color darkBlueColor = Color(0x000066FF);

  //views
  static const Color shadowColor = Color.fromRGBO(187, 183, 208, 1);
  static const Color navBgColor = Color.fromARGB(255, 76, 69, 175);
  static const Color navTextColor = Color.fromARGB(255, 255, 255, 255);
  static const Color tabBarUnselectedColor = Color.fromRGBO(175, 187, 199, 1);
  static const Color tabBarSelectedColor = Color.fromRGBO(65, 204, 183, 1);
  static const Color menuBgColor = Color.fromARGB(100, 76, 69, 175);

  //text
  static const Color secondaryTextColor = Color.fromRGBO(111, 105, 179, 1);
  static const Color mainTextColor = Color.fromRGBO(112, 116, 108, 1);
//rgb(175,187,199)
}

class AppFolderColors {
  static List<Color> colors = [folderColor1, folderColor2, folderColor3, folderColor4, folderColor5];

  static const Color folderColor1 = Color.fromRGBO(112, 135, 149, 1);
  static const Color folderColor2 = Color.fromRGBO(69, 111, 22, 1);
  static const Color folderColor3 = Color.fromRGBO(56, 115, 170, 1);
  static const Color folderColor4 = Color.fromRGBO(100, 105, 179, 1);
  static const Color folderColor5 = Color.fromRGBO(155, 122, 33, 1);
}

class AppResponseStrings {
  static const String SOMETHING_WRONG = "Something went wrong...";
  static const String NO_INTERNET = "Fail internet connection";
  static const String UNAUTHORIZED = "Authorization failed";
  static const String BAD_RESPONSE = "Bad response";
}

class AppErrorsString {
  static const String INVALID_LOGIN_OR_PASSWORD = "Invalid login or password";
  static const String FIELD_IS_EMPTY = "Field is empty";
}

class AppGlobalKeys {
  static GlobalKey topNavBar = _globalKey("top_nav_bar");
  static GlobalKey bottomNavBar = _globalKey("btm_app_bar");
  static GlobalKey<NavigatorState> materialKey = _navigatorKey("app_main_key");

  static GlobalKey _globalKey(String key) {
    return new GlobalKey(debugLabel: key);
  }

  static GlobalKey<NavigatorState> _navigatorKey(String key) {
    return new GlobalKey<NavigatorState>(debugLabel: key);
  }
}