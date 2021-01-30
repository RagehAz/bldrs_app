import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/appbar/buttons/bx_flagbox.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// below link shows how to create clickable countries on google maps
// https://stackoverflow.com/questions/60545216/can-we-fill-color-for-countries-in-google-maps-flutter

class PGCountryList extends StatefulWidget {
// final Function tappingFlag;
//
// PGCountryList({
//   @required this.tappingFlag
// });

  @override
  _PGCountryListState createState() => _PGCountryListState();
}

class _PGCountryListState extends State<PGCountryList> {

  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _lastCountry = _countryPro.currentCountry;
    List<Map<String,String>> _flags = _countryPro.flagsMaps;

    return Column(
      children: <Widget>[

        Container(
          width: superScreenWidth(context),
          height: 300,
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
              itemCount: _flags.length,
              itemBuilder: (ctx, index) {

                // --- COUNTRY BUTTON
                return ChangeNotifierProvider.value(
                  value: _countryPro,
                  child: BTMain(
                    splashColor: Colorz.White,
                    buttonIcon: FlagBox(flag: _flags[index]["flag"],),
                    buttonColor: Colorz.WhiteZircon,
                    buttonVerse: translate(context, _flags[index]["iso3"]),
                    function: (){
                      print('country was : $_lastCountry');
                      String _newCountry = _flags[index]["iso3"];
                      _countryPro.changeCountry(_flags[index]["iso3"]);
                      print('country is : $_newCountry');

                    },
                    buttonVerseShadow: true,
                    stretched: true,
                  ),
                );

              },
            ),
          ),
        ),

      ],
    );
  }
}
