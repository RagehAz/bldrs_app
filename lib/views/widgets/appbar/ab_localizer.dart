import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/screens/s04_sc_localizer_screen.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bldrs_appbar.dart';
import 'buttons/bt_localizer.dart';

class ABLocalizer extends StatefulWidget {
  final LocalizerPage currentPage;
  final Function tappingLocalizer;

  ABLocalizer({
    this.currentPage,
    this.tappingLocalizer,
  });

  @override
  _ABLocalizerState createState() => _ABLocalizerState();
}

class _ABLocalizerState extends State<ABLocalizer> {
  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _lastCountry = _countryPro.currentCountry;
    double _abPadding = Ratioz.ddAppBarMargin * 0.5;
    double _inBarClearWidth = superScreenWidth(context)
        - (Ratioz.ddAppBarMargin * 2)
        - (_abPadding * 2);
    /// standard is Ratioz.ddAppBarHeight;
    double _abHeight = superScreenHeight(context) - Ratioz.ddPyramidsHeight;
    double _listHeight = _abHeight - Ratioz.ddAppBarHeight - (_abPadding) ;
    double _listCorner = Ratioz.ddAppBarCorner - _abPadding;

    return ABStrip(
      abHeight: _abHeight,
      scrollable: false,
      appBarType: AppBarType.Localizer,
      rowWidgets: <Widget>[
        Container(
          // width: superScreenWidth(context) - (Ratioz.ddAppBarMargin * 2),
          // height: 100,
          // color: Colorz.WhiteAir,
          padding: EdgeInsets.all(_abPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              LocalizerButton(
                onTap: widget.tappingLocalizer,
              ),

              // --- COUNTRIES, CITIES & LANGUAGES LISTS
              ClipRRect(
                borderRadius: superBorderAll(context, _listCorner),
                child: Container(
                  height: _listHeight,
                  width: _inBarClearWidth,
                  margin: EdgeInsets.only(top: _abPadding),
                  decoration: BoxDecoration(
                  color: Colorz.WhiteAir,
                    borderRadius: superBorderAll(context, _listCorner),
                  ),
                ),
              )

            ],
          ),
        ),
      ],
    );
}
}

// return Container(
// width: double.infinity,
// height: 50,
// alignment: Alignment.center,
// padding: EdgeInsets.all(5),
// margin: EdgeInsets.all(10),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(
// Radius.circular(Ratioz.ddAppBarCorner)
// ),
// color: Colorz.WhiteAir),
//
// // --- CONTENTS INSIDE THE APP BAR
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
//
// // ---  COUNTRY BUTTON
// // ABLocalizerBT(
// //   buttonVerse: Wordz.country(context),
// //   buttonIcon: currentFlag,
// //   buttonTap: tappingBTLanguage,
// //   buttonOn: currentPage == LocalizerPage.Country ? true : false,
// // ),
//
// // BTLocalizerCountry(
// //   buttonFlag: currentFlag,
// //   buttonTap: tappingBTLanguage,
// //   buttonON: countryPageIsOn == true ? true : false
// // ),
//
// SizedBox(
// width: 5,
// ),
//
// // --- LANGUAGE BUTTON
// // ABLocalizerBT(
// //   buttonVerse: Wordz.language(context),
// //   buttonIcon: '',
// //   buttonTap: tappingBTLanguage,
// //   buttonOn: currentPage == LocalizerPage.Language ? true : false,
// // ),
//
// //  BTLocalizerLanguage(
// //   buttonTap: tappingBTLanguage,
// //   buttonON: countryPageIsOn == true ? false : true
// // ),
//
// ],
// ),
// );

