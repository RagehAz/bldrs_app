import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_promotion.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/a_flyer.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';

import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
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
  final ValueNotifier<ZoneModel> _selectedZone = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  @override
  void dispose() {
    _selectedZone.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onSelectCityTap() async {

    final ZoneModel _zone = await ZoneSelection.goBringAZone(
      context: context,
      depth: ZoneDepth.district,
      zoneViewingEvent: ViewingEvent.flyerPromotion,
      settingCurrentZone: false,
    );

    if (_zone?.countryID != null && _zone?.cityID != null){

      final CountryModel _country = await ZoneProtocols.fetchCountry(
          countryID: _zone.countryID,
      );

      final CityModel _city = await ZoneProtocols.fetchCity(
        cityID: _zone.cityID,
      );

      setNotifier(
          notifier: _selectedZone,
          mounted: mounted,
          value: ZoneModel(
            countryID: _zone.countryID,
            cityID: _zone.cityID,
            countryName: xPhrase( context, _country.id),
            cityName: xPhrase( context, _city.cityID),
          ),
      );

    }

  }
  // -----------------------------------------------------------------------------
  Future<void> _onPromoteFlyer() async {

    final ZoneModel _zone = _selectedZone.value;

    if (_zone == null || _zone.countryID == null || _zone.cityID == null){

      await TopDialog.showTopDialog(
        context: context,
        firstVerse: const Verse(
          text: 'phid_select_promotion_target_city',
          translate: true,
        ),
        color: Colorz.red255,
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
        flyerPromotion: _flyerPromotion,
      );

      await TopDialog.showTopDialog(
        context: context,
        firstVerse: const Verse(
          pseudo: 'Flyer is successfully promoted',
          text: 'phid_flyer_has_been_promoted',
          translate: true,
        ),
        secondVerse: Verse(
          text: 'in ${_zone.cityName}, ${_zone.countryName}',
          translate: true,
          variables: [_zone.cityName, _zone.countryName],
        ),
        color: Colorz.green255,
        textColor: Colorz.white255,
      );

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.screenWidth(context);
    // final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    return MainLayout(
      title: const Verse(
        text: 'phid_flyer-promotion',
        translate: true,
      ),
      appBarType: AppBarType.basic,
      child: Column(
        children: <Widget>[

          const Stratosphere(),

          Flyer(
            flyerBoxWidth: _screenWidth * 0.7,
            flyerModel: widget.flyer,
            screenName: 'flyerPromotionScreen',
          ),

          const Expander(),

          ValueListenableBuilder(
              valueListenable: _selectedZone,
              builder: (_, ZoneModel zoneModel, Widget child) {

                final String _cityName = zoneModel?.cityName;
                final String _countryName = zoneModel?.countryName;
                final String _flag = zoneModel?.icon;

                final Verse _verse = zoneModel == null ?
                const Verse(
                  text: 'phid_select_a_city',
                  translate: true,
                )
                    :
                Verse(
                  text: '#!#Promoting Flyer in\n$_cityName, $_countryName',
                  translate: true,
                  variables: [_cityName, _countryName],
                );

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
              verse:  const Verse(
                text: 'phid_promote',
                translate: true,
                casing: Casing.upperCase,
              ),
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
  // -----------------------------------------------------------------------------
}
