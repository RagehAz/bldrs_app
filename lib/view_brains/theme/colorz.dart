import 'package:flutter/material.dart';

class Colorz {
// -------------------------------------------------------------------------
// BLDRS COLORS
  static const int NoOpacity = 0;
  static const int airOpacity = 10;
  static const int glassOpacity = 20;
  static const int _30 = 30;
  static const int zirconOpacity = 50;
  static const int smokeOpacity = 80;
  static const int plasticOpacity = 125;
  static const int lingerieOpacity = 200;
  static const int solid = 255; // out of range,, should be 255 max

  static const BloodTest = Color.fromARGB(100, 255, 0, 0); // used to visualize containers on emulator
  static const DrugTest = Color.fromARGB(100, 170, 50, 111); // used to visualize containers on emulator
  static const WaterTest = Color.fromARGB(100, 120, 195, 210);
  static const Nothing = Color.fromARGB(0, 255, 255, 255);

  static const BlackBlack = Color.fromARGB(solid, 0, 0, 0);
  static const DarkBlack = Color.fromARGB(solid, 6, 6, 15);
  static const BlackNothing = Color.fromARGB(NoOpacity, 0, 0, 0);
  static const BlackAir = Color.fromARGB(airOpacity, 0, 0, 0);
  static const BlackGlass = Color.fromARGB(glassOpacity, 0, 0, 0 );
  static const BlackZircon = Color.fromARGB(zirconOpacity, 0, 0, 0);
  static const BlackSmoke = Color.fromARGB(smokeOpacity, 0, 0, 0);
  static const BlackPlastic = Color.fromARGB(plasticOpacity, 0, 0, 0);
  static const BlackLingerie = Color.fromARGB(lingerieOpacity, 0, 0, 0);

  static const DarkBlue = Color.fromARGB(solid, 20, 20, 80);
  static const BabyBlue = Color.fromARGB(solid, 133, 203, 218);
  static const BabyBlueAir = Color.fromARGB(airOpacity, 133, 203, 218);
  static const BabyBlueGlass = Color.fromARGB(glassOpacity, 133, 203, 218);
  static const BabyBlueSmoke = Color.fromARGB(smokeOpacity, 133, 203, 218);
  static const BabyBluePlastic = Color.fromARGB(plasticOpacity, 133, 203, 218);
  static const LightBlue = Color.fromARGB(solid, 201, 232, 239);
  static const LightBlueAir = Color.fromARGB(airOpacity, 201, 232, 239);
  static const LightBlueZircon = Color.fromARGB(zirconOpacity, 201, 232, 239);

  static const SkyDarkBlue = Color.fromARGB(solid,19, 36, 75);
  static const SkyLightBlue = Color.fromARGB(solid, 0, 71, 123);

  static const Yellow = Color.fromARGB(solid, 255, 192, 0); // #ffc000
  static const YellowSmoke = Color.fromARGB(smokeOpacity, 255, 192, 0);
  static const YellowAir = Color.fromARGB(airOpacity, 255, 192, 0);
  static const YellowGlass = Color.fromARGB(glassOpacity, 255, 192, 0);
  static const YellowZircon = Color.fromARGB(zirconOpacity, 255, 192, 0);
  static const YellowPlastic = Color.fromARGB(plasticOpacity, 255, 192, 0);
  static const YellowLingerie = Color.fromARGB(lingerieOpacity, 255, 192, 0);

  static const BloodRed = Color.fromARGB(solid, 233, 0, 0);
  static const BloodRedZircon = Color.fromARGB(zirconOpacity, 233, 0, 0);
  static const BloodRedPlastic = Color.fromARGB(plasticOpacity, 233, 0, 0);
  static const DarkRed = Color.fromARGB(solid, 118, 33, 33);
  static const DarkRedPlastic = Color.fromARGB(plasticOpacity, 118, 33, 33);

  static const Green = Color.fromARGB(solid, 24, 157, 14);
  static const GreenSmoke = Color.fromARGB(smokeOpacity, 24, 157, 14);
  static const GreenPlastic = Color.fromARGB(plasticOpacity, 24, 157, 14);
  static const GreenZircon = Color.fromARGB(zirconOpacity, 24, 157, 14);
  static const GreenGlass = Color.fromARGB(glassOpacity, 24, 157, 14);

  static const DarkGreen = Color.fromARGB(solid, 10, 80, 20);

  static const White = Color.fromARGB(solid, 255, 255, 255);
  static const WhiteSilver = Color.fromARGB(700, 255, 255, 255);
  static const WhiteAir = Color.fromARGB(airOpacity, 255, 255, 255);
  static const WhiteGlass = Color.fromARGB(glassOpacity, 255, 255, 255);
  static const White30 = Color.fromARGB(_30, 255, 255, 255);
  static const WhiteZircon = Color.fromARGB(zirconOpacity, 255, 255, 255);
  static const WhiteSmoke = Color.fromARGB(smokeOpacity, 255, 255, 255);
  static const WhitePlastic = Color.fromARGB(plasticOpacity, 255, 255, 255);
  static const WhiteLingerie = Color.fromARGB(lingerieOpacity, 255, 255, 255);

  static const ModalGrey = Color.fromARGB(solid, 180, 180, 180);
  static const Grey = Color.fromARGB(solid, 200, 200, 200);
  static const GreyZircon = Color.fromARGB(zirconOpacity, 121, 121, 121);
  static const GreySmoke = Color.fromARGB(smokeOpacity, 121, 121, 121);
  static const LightGrey = Color.fromARGB(solid, 220, 220, 220);

  static const Facebook = Color.fromARGB(solid, 59, 89, 152);
  static const LinkedIn = Color.fromARGB(solid, 0, 115, 176);
  static const GoogleRed = Color.fromARGB(solid, 234, 67, 53);

  static const AppBarColor = WhiteGlass;
  static const bzPageBGColor = Colorz.BlackSmoke;

// -------------------------------------------------------------------------}
}