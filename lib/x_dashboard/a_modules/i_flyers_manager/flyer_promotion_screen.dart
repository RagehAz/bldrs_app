import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/flyer_promotion.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/a_flyer_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/h_zoning_controllers/zoning_controllers.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/e_db/fire/ops/flyer_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerPromotionScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerPromotionScreen({
    @required this.flyer,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyer;
  /// --------------------------------------------------------------------------
  @override
  State<FlyerPromotionScreen> createState() => _FlyerPromotionScreenState();
  /// --------------------------------------------------------------------------
}

class _FlyerPromotionScreenState extends State<FlyerPromotionScreen> {
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _selectedZone.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<ZoneModel> _selectedZone = ValueNotifier(null);
  Future<void> _onSelectCityTap() async {

    final ZoneModel _zone = await controlSelectCountryAndCityOnly(context);

    if (_zone?.countryID != null && _zone?.cityID != null){

      final CountryModel _country = await ZoneProtocols.fetchCountry(context: context, countryID: _zone.countryID);
      final CityModel _city = await ZoneProtocols.fetchCity(context: context, cityID: _zone.cityID);

      _selectedZone.value = ZoneModel(
        countryID: _zone.countryID,
        cityID: _zone.cityID,
        countryName: xPhrase(context, _country.id),
        cityName: xPhrase(context, _city.cityID),
      );

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onPromoteFlyer() async {

    final ZoneModel _zone = _selectedZone.value;

    if (_zone == null || _zone.countryID == null || _zone.cityID == null){

      TopDialog.showUnawaitedTopDialog(
        context: context,
        firstLine: 'Select promotion zone man !',
        color: Colorz.red255,
        secondLine: 'WTF !',
      );

    }

    else {

      // final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
      // final CityModel _cityModel = await _zoneProvider.fetchCityByID(context: context, cityID: _zone.cityID);

      final DateTime _now = DateTime.now();

      final FlyerPromotion _flyerPromotion = FlyerPromotion(
        flyerID: widget.flyer.id,
        cityID: _zone.cityID,
        from: _now,
        to: Timers.createDateTimeAfterNumberOfDays(
          days: 11,
        ),
        districtsIDs: const <String>[],
      );

      await FlyerFireOps.promoteFlyerInCity(
        context: context,
        flyerPromotion: _flyerPromotion,
      );

      await TopDialog.showTopDialog(
        context: context,
        firstLine: 'Flyer is successfully promoted',
        secondLine: 'in ${_zone.cityName}, ${_zone.countryName}',
        color: Colorz.green255,
        textColor: Colorz.white255,
      );

    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    return MainLayout(
      pageTitle: 'Flyer promotion',
      appBarType: AppBarType.basic,
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          FlyerStarter(
            minWidthFactor: FlyerBox.sizeFactorByWidth(context, _screenWidth * 0.7),
            flyerModel: widget.flyer,
          ),

          const Expander(),

          ValueListenableBuilder(
              valueListenable: _selectedZone,
              builder: (_, ZoneModel zoneModel, Widget child) {

                final String _cityName = zoneModel?.cityName;
                final String _countryName = zoneModel?.countryName;
                final String _flag = zoneModel?.flag;
                final String _verse = zoneModel == null ? 'Select a City' : 'Promoting Flyer in\n$_cityName, $_countryName';

                return
                  DreamBox(
                    height: 80,
                    width: _screenWidth * 0.9,
                    verse: _verse,
                    onTap: _onSelectCityTap,
                    icon: _flag,
                    iconSizeFactor: 0.8,
                    verseMaxLines: 3,
                    verseScaleFactor: 0.8,
                    verseWeight: VerseWeight.thin,
                    verseItalic: true,
                    verseCentered: false,
                    bubble: false,
                    color: Colorz.white20,
                  );

              }
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: DreamBox(
              height: 50,
              verse: 'PROMOTE',
              verseItalic: true,
              verseWeight: VerseWeight.black,
              verseColor: Colorz.black255,
              color: Colorz.yellow255,
              margins: Ratioz.appBarMargin,
              onTap: _onPromoteFlyer,
            ),
          ),

        ],
      ),
    );
  }
}
