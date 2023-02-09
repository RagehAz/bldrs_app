import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/b_city_editor/city_editor_bubble.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:stringer/stringer.dart';

class CreateCityScreen extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const CreateCityScreen({
    @required this.cityName,
    @required this.countryID,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String cityName;
  final String countryID;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _cityNameIdified = TextMod.idifyString(cityName);
    final String _cityID = '$countryID+$_cityNameIdified';

    final CityModel _initialCity = CityModel(
      cityID: _cityID,
      population: 0,
      phrases: [
        Phrase(
          id: _cityID,
          value: cityName,
          langCode: 'en',
        ),
      ],
      // position: null,
    );

    return MainLayout(
      title: Verse.plain('Create a new city ($cityName)'),
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        children: <Widget>[

          /// CITY EDITOR BUBBLE
          CityEditorBubble(
            cityModel: _initialCity,
            onSync: (CityModel newCity) async {

              final bool _go = await Dialogs.confirmProceed(
                context: context,
                invertButtons: true,
              );

              if (_go == true){

                await ZoneProtocols.composeCity(
                  cityModel: newCity,
                );

              }

            }
          ),

          const DotSeparator(),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
