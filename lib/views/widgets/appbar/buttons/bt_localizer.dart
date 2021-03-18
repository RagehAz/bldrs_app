import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/localization/localization_constants.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocalizerButton extends StatelessWidget {
  final Function onTap;
  final bool isOn;

  LocalizerButton({
    this.onTap,
    this.isOn = false,
  });


  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _lastCountryID = _countryPro.currentCountryID;
    String _lastProvinceID = _countryPro.currentProvinceID;
    String _lastAreaID = _countryPro.currentAreaID;
    String _lastCountryName = translate(context, _lastCountryID);
    String _lastCountryFlag = getFlagByIso3(_lastCountryID);
    String _lastProvinceName = _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, _lastProvinceID);
    String _lastAreaName = _countryPro.getAreaNameWithCurrentLanguageIfPossible(context, _lastAreaID);

    // print('country ID : $_lastCountryID, provinceID : $_lastProvinceID, '
    //     'areaID : $_lastAreaID, CountryName : $_lastCountryName,'
    //     ' ProvinceName : $_lastProvinceName, AreaName : $_lastAreaName');

    String _countryAndProvinceNames =
        appIsLeftToRight(context) ? '$_lastProvinceName - $_lastCountryName'
    : '$_lastCountryName - $_lastProvinceName';

    double _flagHorizontalMargins = 2;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              // width: 40,
              height: 40,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Ratioz.ddAppBarButtonCorner)),
                  color: isOn ? Colorz.Yellow : Colorz.WhiteAir
              ),
              child: ChangeNotifierProvider.value(
                value: _countryPro,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    // --- COUNTRY & AREA NAMES
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
                              verse: _lastAreaName,
                              size: 1,
                              scaleFactor: 0.8,
                              color: isOn? Colorz.BlackBlack : Colorz.White,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // --- FLAG
                    Stack(
                      children: <Widget>[

                        // --- FAKE FOOTPRINT to occupy space for flag while loading
                        Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.symmetric(horizontal: _flagHorizontalMargins),
                        ),

                        DreamBox(
                          height: 30,
                          icon: _lastCountryFlag,
                          corners: Ratioz.ddBoxCorner8,
                          boxMargins: EdgeInsets.symmetric(horizontal: _flagHorizontalMargins),
                          boxFunction: onTap,
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
