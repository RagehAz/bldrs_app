import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/all_flags_list.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/a_cities_screen.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/country_preview_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/a_country_editor/country_stage_switcher.dart';
import 'package:flutter/material.dart';

class CountryEditorScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountryEditorScreen({
    @required this.countryID,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String countryID;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Flag _flag = Flag.getFlagFromFlagsByCountryID(
        flags: allFlags,
        countryID: countryID,
    );

    final double _bubbleWidth = BldrsAppBar.width(context);

    return MainLayout(
      pageTitleVerse: Verse.plain(countryID),
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        children: <Widget>[

          /// COUNTRY PREVIEW BUBBLE
          CountryPreviewBubble(
            countryID: countryID,
          ),

          const DotSeparator(),

          /// STAGE
          CountryStageSwitcher(
            countryID: countryID,
          ),

          const DotSeparator(),

          /// CITIES
          FutureBuilder(
              future: ZoneProtocols.fetchCountry(countryID: countryID),
              builder: (_, AsyncSnapshot<CountryModel> snap){

                final CountryModel _countryModel = snap.data;
                final int _citiesCount = _countryModel?.citiesIDs?.getAllIDs()?.length ?? 0;

                return DreamBox(
                  height: 50,
                  width: _bubbleWidth,
                  verse: Verse(
                    text: '$_citiesCount Cities',
                    translate: false,
                    casing: Casing.upperCase,
                  ),
                  verseItalic: true,
                  onTap: () async {

                    final ZoneModel _zone = await Nav.goToNewScreen(
                      context: context,
                      screen: CitiesScreen(
                        country: _countryModel,
                      ),
                    );

                    _zone?.blogZone();

                  },
                );


              }
          ),

          const DotSeparator(),

          /// IDs
          DataStrip(
            width: _bubbleWidth,
            color: Colorz.black50,
            dataKey: 'IDs',
            dataValue: 'ISO3 : $countryID : ISO2 : ${_flag.iso2}',
          ),

          /// REGION - CONTINENT
          DataStrip(
            width: _bubbleWidth,
            color: Colorz.black50,
            dataKey: 'Cont.',
            dataValue: '${_flag.region} - ${_flag.continent}',
          ),

          /// LANGUAGE
          DataStrip(
            width: _bubbleWidth,
            color: Colorz.black50,
            dataKey: 'Langs',
            dataValue: 'Main : [${_flag.language}] . Other : [${_flag.langCodes}]',
          ),

          /// PHONE CODE
          DataStrip(
            width: _bubbleWidth,
            color: Colorz.black50,
            dataKey: 'Phone code',
            dataValue: _flag.phoneCode,
          ),

          const DotSeparator(),

        ],
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
