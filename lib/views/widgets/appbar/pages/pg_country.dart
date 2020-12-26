import 'package:bldrs/view_brains/localization/countries_list.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/appbar/buttons/bx_flagbox.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:flutter/material.dart';

String flagFileNameSelectedFromPGLanguageList = Flagz.Egypt;
String currentSelectedCountry = 'Egypt';

class PGCountryList extends StatelessWidget {
final Function tappingFlag;

PGCountryList({
  @required this.tappingFlag
});

void tappingBTCountry(){
  tappingFlag();
}

  @override
  Widget build(BuildContext context) {
//    final flagData = Provider.of<Flags>(context);
//    final flags = flagData.
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
            color: Colorz.WhiteGlass
        ),

        // --- OFFSET CONTAINER OF COUNTRIES BUTTONS
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarButtonCorner)),
          child: ListView.builder(
            itemCount: countriesList.length,
            itemBuilder: (ctx, index) {

              // --- COUNTRY BUTTON
              return BTMain(
                splashColor: Colorz.White,
                buttonIcon: FlagBox(flag: countriesList[index]["countryFlag"],),
                buttonColor: Colorz.WhiteZircon,
                buttonVerse: countriesList[index]["countryName"],
                function: (){
                    flagFileNameSelectedFromPGLanguageList = countriesList[index]["countryFlag"];
                    currentSelectedCountry = countriesList[index]["countryName"];
                    tappingBTCountry();
                    // abMainFlagSwitch();
                },
                buttonVerseShadow: true,
                stretched: true,
              );

            },
          ),
        ),
      ),
    );
  }

}
