import 'package:flutter/material.dart';

abstract class Colorz {
// -----------------------------------------------------------------------------
  static const int _0 = 0;
  static const int _10 = 10;
  static const int _20 = 20;
  static const int _30 = 30;
  static const int _50 = 50;
  static const int _80 = 80;
  static const int _125 = 125;
  static const int _200 = 200;
  static const int _225 = 225;
// -----------------------------------------------------------------------------
  static const Color bloodTest = Color.fromARGB(100, 255, 0, 0);
  static const Color nothing = Color.fromARGB(0, 255, 255, 255);
// -----------------------------------------------------------------------------
  static const Color black0 = Color.fromARGB(_0, 0, 0, 0);
  static const Color black10 = Color.fromARGB(_10, 0, 0, 0);
  static const Color black20 = Color.fromARGB(_20, 0, 0, 0 );
  static const Color black50 = Color.fromARGB(_50, 0, 0, 0);
  static const Color black80 = Color.fromARGB(_80, 0, 0, 0);
  static const Color black125 = Color.fromARGB(_125, 0, 0, 0);
  static const Color black150 = Color.fromARGB(150, 0, 0, 0);
  static const Color black200 = Color.fromARGB(_200, 0, 0, 0);
  static const Color black230 = Color.fromARGB(230, 0, 0, 0);
  static const Color black255 = Color.fromARGB(255, 0, 0, 0);
// -----------------------------------------------------------------------------
  static const Color blackSemi20 = Color.fromARGB(20, 20, 20, 35);
  static const Color blackSemi125 = Color.fromARGB(125, 20, 20, 35);
  static const Color blackSemi230 = Color.fromARGB(230, 20, 20, 35);
  static const Color blackSemi255 = Color.fromARGB(255, 20, 20, 35);
// -----------------------------------------------------------------------------
  static const Color cyan10 = Color.fromARGB(_10, 201, 232, 239);
  static const Color cyan50 = Color.fromARGB(_50, 201, 232, 239);
  static const Color cyan225 = Color.fromARGB(_225, 201, 232, 239);
// -----------------------------------------------------------------------------
  static const Color blue10 = Color.fromARGB(_10, 133, 203, 218);
  static const Color blue20 = Color.fromARGB(_20, 133, 203, 218);
  static const Color blue80 = Color.fromARGB(_80, 133, 203, 218);
  static const Color blue125 = Color.fromARGB(_125, 133, 203, 218);
  static const Color blue225 = Color.fromARGB(_225, 133, 203, 218);
// -----------------------------------------------------------------------------
  static const Color darkBlue = Color.fromARGB(255, 20, 20, 80);
// -----------------------------------------------------------------------------
  static const Color skyDarkBlue = Color.fromARGB(255,19, 36, 75); // #13244b
// -----------------------------------------------------------------------------
  static const Color skyLightBlue = Color.fromARGB(255, 0, 71, 123);
// -----------------------------------------------------------------------------
  static const Color yellow10 = Color.fromARGB(_10, 255, 192, 0);
  static const Color yellow20 = Color.fromARGB(_20, 255, 192, 0);
  static const Color yellow50 = Color.fromARGB(_50, 255, 192, 0);
  static const Color yellow80 = Color.fromARGB(_80, 255, 192, 0);
  static const Color yellow125 = Color.fromARGB(_125, 255, 192, 0);
  static const Color yellow200 = Color.fromARGB(_200, 255, 192, 0);
  static const Color yellow255 = Color.fromARGB(255, 255, 192, 0); // #ffc000
// -----------------------------------------------------------------------------
  static const Color red50 = Color.fromARGB(_50, 233, 0, 0);
  static const Color red125 = Color.fromARGB(_125, 233, 0, 0);
  static const Color red230 = Color.fromARGB(230, 233, 0, 0);
  static const Color red255 = Color.fromARGB(255, 233, 0, 0);
// -----------------------------------------------------------------------------
  static const Color darkRed125 = Color.fromARGB(_125, 97, 5, 5);
  static const Color darkRed230 = Color.fromARGB(230, 97, 5, 5);
  static const Color darkRed255 = Color.fromARGB(255, 97, 5, 5);
// -----------------------------------------------------------------------------
  static const Color green20 = Color.fromARGB(_20, 24, 157, 14);
  static const Color green50 = Color.fromARGB(_50, 24, 157, 14);
  static const Color green80 = Color.fromARGB(_80, 24, 157, 14);
  static const Color green125 = Color.fromARGB(_125, 24, 157, 14);
  static const Color green230 = Color.fromARGB(230, 24, 157, 14);
  static const Color green255 = Color.fromARGB(255, 24, 157, 14);
// -----------------------------------------------------------------------------
  static const Color darkGreen225 = Color.fromARGB(_225, 10, 80, 20);
// -----------------------------------------------------------------------------
  static const Color white10 = Color.fromARGB(_10, 255, 255, 255);
  static const Color white20 = Color.fromARGB(_20, 255, 255, 255);
  static const Color white30 = Color.fromARGB(_30, 255, 255, 255);
  static const Color white50 = Color.fromARGB(_50, 255, 255, 255);
  static const Color white80 = Color.fromARGB(_80, 255, 255, 255);
  static const Color white125 = Color.fromARGB(_125, 255, 255, 255);
  static const Color white200 = Color.fromARGB(_200, 255, 255, 255);
  static const Color white230 = Color.fromARGB(230, 255, 255, 255);
  static const Color white255 = Color.fromARGB(255, 255, 255, 255);
// -----------------------------------------------------------------------------
  static const Color grey50 = Color.fromARGB(_50, 121, 121, 121);
  static const Color grey80 = Color.fromARGB(_80, 121, 121, 121);
  static const Color grey225 = Color.fromARGB(_225, 200, 200, 200);
// -----------------------------------------------------------------------------
  static const Color lightGrey225 = Color.fromARGB(_225, 220, 220, 220);
// -----------------------------------------------------------------------------
  static const Color darkGrey225 = Color.fromARGB(_225, 180, 180, 180);
// -----------------------------------------------------------------------------
  static const Color facebook = Color.fromARGB(_225, 59, 89, 152);
  static const Color linkedIn = Color.fromARGB(_225, 0, 115, 176);
  static const Color googleRed = Color.fromARGB(_225, 234, 67, 53);
// -----------------------------------------------------------------------------
  static const Color appBarColor = white20;
  static const Color bzPageBGColor = Colorz.black80;
// -------------------------------------------------------------------------
  static const List<Color> allColorz = const <Color>[
        bloodTest,
        nothing,
        black0,
        black10,
        black20,
        black50,
        black80,
        black125,
        black150,
        black200,
        black230,
        black255,
        blackSemi20,
        blackSemi125,
        blackSemi230,
        blackSemi255,
        cyan10,
        cyan50,
        cyan225,
        blue10,
        blue20,
        blue80,
        blue125,
        blue225,
        darkBlue,
        skyDarkBlue,
        skyLightBlue,
        yellow10,
        yellow20,
        yellow50,
        yellow80,
        yellow125,
        yellow200,
        yellow255,
        red50,
        red125,
        red230,
        red255,
        darkRed125,
        darkRed230,
        darkRed255,
        green20,
        green50,
        green80,
        green125,
        green230,
        green255,
        darkGreen225,
        white10,
        white20,
        white30,
        white50,
        white80,
        white125,
        white200,
        white230 ,
        white255 ,
        grey50 ,
        grey80 ,
        grey225,
        lightGrey225,
        darkGrey225,
        facebook,
        linkedIn,
        googleRed,
        appBarColor,
        bzPageBGColor,
    ];


}