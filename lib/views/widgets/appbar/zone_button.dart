import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/localization/localization_constants.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/screens/s61_select_province_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZoneButton extends StatelessWidget {
  final Function onTap;
  final bool isOn;

  ZoneButton({
    this.onTap,
    this.isOn = false,
  });
// -----------------------------------------------------------------------------
  void _zoneButtonOnTap(BuildContext context){
    // print('zone tapped');
    Nav.goToNewScreen(context, SelectProvinceScreen());
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _lastCountryID = _countryPro.currentCountryID;
    String _lastProvinceID = _countryPro.currentProvinceID;
    String _lastDistrictID = _countryPro.currentDistrictsID;
    String _lastCountryName = translate(context, _lastCountryID);
    String _lastCountryFlag = Flagz.getFlagByIso3(_lastCountryID);
    String _lastProvinceName = _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, _lastProvinceID);
    String _lastDistrictName = _countryPro.getDistrictNameWithCurrentLanguageIfPossible(context, _lastDistrictID);

    // print('country ID : $_lastCountryID, provinceID : $_lastProvinceID, '
    //     'districtID : $_lastDistrictID, CountryName : $_lastCountryName,'
    //     ' ProvinceName : $_lastProvinceName, DistrictName : $_lastDistrictName');

    String _countryAndProvinceNames =
        appIsLeftToRight(context) ? '$_lastProvinceName - $_lastCountryName'
    : '$_lastCountryName - $_lastProvinceName';

    const double _flagHorizontalMargins = 2;

    return GestureDetector(
      onTap: () => _zoneButtonOnTap(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              // width: 40,
              height: 40,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(Ratioz.appBarMargin * 0.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Ratioz.appBarButtonCorner)),
                  color: isOn ? Colorz.Yellow : Colorz.WhiteAir
              ),
              child: ChangeNotifierProvider.value(
                value: _countryPro,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    /// --- COUNTRY & DISTRICTS NAMES
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.5),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SuperVerse(
                              verse: _countryAndProvinceNames,
                              size: 1,
                              color: isOn? Colorz.BlackBlack : Colorz.White,
                            ),
                            SuperVerse(
                              verse: _lastDistrictName,
                              size: 1,
                              scaleFactor: 0.8,
                              color: isOn? Colorz.BlackBlack : Colorz.White,
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// --- FLAG
                    Stack(
                      children: <Widget>[

                        // --- FAKE FOOTPRINT to occupy space for flag while loading
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.symmetric(horizontal: _flagHorizontalMargins),
                        ),

                        DreamBox(
                          height: 30,
                          icon: _lastCountryFlag,
                          corners: Ratioz.boxCorner8,
                          margins: const EdgeInsets.symmetric(horizontal: _flagHorizontalMargins),
                          onTap: onTap,
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
