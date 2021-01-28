import 'package:bldrs/view_brains/localization/countries_list.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/appbar/buttons/bx_flagbox.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:flutter/material.dart';

String flagFileNameSelectedFromPGLanguageList = Flagz.egy;
String currentSelectedCountry = 'Egypt';

class PGCountryList extends StatefulWidget {
final Function tappingFlag;

PGCountryList({
  @required this.tappingFlag
});

  @override
  _PGCountryListState createState() => _PGCountryListState();
}

class _PGCountryListState extends State<PGCountryList> {

void tappingBTCountry(int index){
  widget.tappingFlag();
  setState(() {
    flagFileNameSelectedFromPGLanguageList = flagsMaps[index]["flag"];
    currentSelectedCountry = translate(context, flagsMaps[index]["iso3"]);
  });
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
            itemCount: flagsMaps.length,
            itemBuilder: (ctx, index) {

              // --- COUNTRY BUTTON
              return BTMain(
                splashColor: Colorz.White,
                buttonIcon: FlagBox(flag: flagsMaps[index]["flag"],),
                buttonColor: Colorz.WhiteZircon,
                buttonVerse: translate(context, flagsMaps[index]["iso3"]),
                function: (){
                    tappingBTCountry(index);
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
