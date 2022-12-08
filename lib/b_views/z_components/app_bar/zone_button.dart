import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ZoneButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoneButton({
    this.onTap,
    this.isOn = false,
    this.zoneOverride,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final bool isOn;
  final ZoneModel zoneOverride;
  // -----------------------------------------------------------------------------
  ZoneModel _buttonZone(BuildContext context){
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final ZoneModel _currentZone = _zoneProvider.currentZone;
    return zoneOverride ?? _currentZone;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final ZoneModel _currentZone = _buttonZone(context);
    // --------------------
    final String _countryName = _currentZone?.countryName;
    final String _countryFlag = _currentZone?.icon;
    final String _cityName = _currentZone?.cityName;
    final String _districtName = _currentZone?.districtName;
    // --------------------
    final String _countryAndCityNames = TextDir.checkAppIsLeftToRight(context) ?
    '$_cityName - $_countryName'
        :
    '$_countryName - $_cityName';
    // --------------------
    final String _firstRow = _currentZone == null ? ' '
        :
    _currentZone?.districtID == null ? _countryName
        :
    _countryAndCityNames;
    // --------------------
    final String _secondRow = _currentZone == null ? ' '
        :
    _currentZone?.districtID == null ? _cityName
        :
    _districtName;
    // --------------------
    const double _flagHorizontalMargins = 2;
    // --------------------
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 40,
        height: 40,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(Ratioz.appBarButtonCorner),
            ),
            color: isOn ? Colorz.yellow255 : Colorz.white10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            /// --- COUNTRY & DISTRICTS NAMES
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.5),
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SuperVerse(
                      verse: Verse(
                        text: _firstRow ?? '',
                        translate: false,
                      ),
                      size: 1,
                      color: isOn ? Colorz.black230 : Colorz.white255,
                    ),
                    SuperVerse(
                      verse: Verse(
                        text: _secondRow ?? '',
                        translate: false,
                      ),
                      size: 1,
                      scaleFactor: 0.8,
                      color: isOn ? Colorz.black230 : Colorz.white255,
                    ),
                  ],
                ),
              ),
            ),

            /// --- FLAG
            Stack(
              alignment: Alignment.center,
              children: <Widget>[

                /// --- FAKE FOOTPRINT to occupy space for flag while loading
                Container(
                  width: 30,
                  height: 30,
                  margin: const EdgeInsets.symmetric(
                      horizontal: _flagHorizontalMargins
                  ),
                ),

                Center(
                  child: DreamBox(
                    width: 30,
                    height: 30,
                    icon: _countryFlag,
                    corners: Ratioz.boxCorner8,
                    margins: const EdgeInsets.symmetric(
                        horizontal: _flagHorizontalMargins
                    ),
                    onTap: onTap,
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
  // -----------------------------------------------------------------------------
}
