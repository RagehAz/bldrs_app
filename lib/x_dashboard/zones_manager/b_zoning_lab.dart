import 'dart:convert';

import 'package:bldrs/a_models/d_zone/country_model.dart';
import 'package:bldrs/a_models/d_zone/flag_model.dart';
import 'package:bldrs/a_models/d_zone/real_models/country_fix.dart';
import 'package:bldrs/a_models/d_zone/real_models/iso3.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/h_money/big_mac.dart';
import 'package:bldrs/a_models/h_money/currency_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/c_protocols/zone_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:bldrs/x_dashboard/zzz_exotic_methods/exotic_methods.dart';
import 'package:flutter/material.dart';

class ZoningLab extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZoningLab({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<ZoningLab> createState() => _ZoningLabState();
/// --------------------------------------------------------------------------
}

class _ZoningLabState extends State<ZoningLab> {

  ZoneModel _bubbleZone;

  // -----------------------------------------------------------------------------
  /// DONE : KEEP FOR REFERENCE
  Future<void> _createISO3JSONBlog() async {
    blog('CREATE ISO3 MAP : START');

    final int _totalLength = CountryModel.getAllCountriesIDs().length;
    final List<ISO3> _iso3s = [];

    // final List<CountryModel> _allCountries =
    await ExoticMethods.fetchAllCountryModels(
      onRead: (int index, CountryModel countryModel) async {

        ISO3 _iso3;

        if (countryModel != null){
          _iso3 = ISO3(
            id: countryModel.id,
            iso2: countryModel.iso2 ?? xGetIso2(countryModel.id),
            flag: Flag.getFlagIcon(countryModel.id),
            region: countryModel.region,
            continent: countryModel.continent,
            language: countryModel.language,
            currencyID: countryModel.currency ?? BigMac.getCurrencyByCountryIdFromBigMacs(
              countryID: countryModel.id,
            ),
            phoneCode: countryModel.phoneCode ?? CountryModel.getCountryPhoneCode(countryModel.id),
            capital: countryModel.capital ?? xGetCapital(countryModel.id),
            langCodes: countryModel.langCodes ?? xGetLangs(countryModel.id),
            areaSqKm: countryModel.areaSqKm ?? xGetAreaKM(countryModel.id),
            phrases: countryModel.phrases,
          );

        }

        if (_iso3 != null && _iso3.iso2 != null){
          _iso3s.add(_iso3);
          blog('DONE : #${index + 1} / $_totalLength');
        }
        else {
          blog('SKIP : #${index + 1} / $_totalLength');
        }

      },
    );

    blog('done with ${_iso3s.length} iso3s');


    ISO3.blogISO3sToJSON(_iso3s);

    blog('CREATE ISO3 MAP : END : already done and kept for reference');
  }
  // --------------------
  ///
  Future<void> _createCurrenciesJSON() async {

    final List<CurrencyModel> _currencies = ZoneProvider.proGetAllCurrencies(context: context, listen: false);
    // CurrencyModel.blogCurrencies(_currencies);

    final Map<String, dynamic> _map = CurrencyModel.cipherCurrencies(_currencies);

    final String _json = json.encode(_map, );

    blog(_json);

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitleVerse: Verse.plain('Zoning Lab'),
      pyramidType: PyramidType.crystalYellow,
      layoutWidget: FloatingCenteredList(
        columnChildren: <Widget>[

          // -----------------------------------

          /// ZONE BY ONE BUTTON
          WideButton(
            verse: Verse.plain('Zone by one button'),
            onTap: () async {

              final ZoneModel _zone = await Nav.goToNewScreen(
                  context: context,
                  screen: const CountriesScreen(),
              );

              _zone?.blogZone(invoker: 'ZONE BY ONE BUTTON');

              if (_zone == null){
                blog('ZONE IS NULL');
              }

            },
          ),

          /// BLOG BUBBLE ZONE
          WideButton(
            verse: Verse.plain('blog current zone'),
            onTap: (){

              _bubbleZone?.blogZone();

            },
          ),

          /// ZONE BUBBLE
          ZoneSelectionBubble(
            currentZone: _bubbleZone,
            titleVerse:  const Verse(
              text: 'Zoning test',
              translate: false,
            ),
            bulletPoints:  const <Verse>[
              Verse(text: 'Fuck you', translate: false,),
              Verse(text: 'Bitch', translate: false,),
            ],
            onZoneChanged: (ZoneModel zone){

              zone.blogZone(invoker: 'ZONE Received from bubble');

              if (zone != null){
                _bubbleZone = zone;
              }

            },
          ),

          // -----------------------------------

          /// SEPARATOR
          const SeparatorLine(),

          /// CREATE ISO3 JSON
          WideButton(
            verse: Verse.plain('Create ISO3 map'),
            onTap: _createISO3JSONBlog,
          ),

          /// GET ISO3 JSON
          WideButton(
            verse: Verse.plain('Get ISO3 JSON map'),
            onTap: () async {

              final List<ISO3> _iso3s = await ISO3.readAllISO3s();
              ISO3.blogISO3s(_iso3s);

            },
          ),

          // -----------------------------------

          /// SEPARATOR
          const SeparatorLine(),

          /// CREATE CURRENCIES JSON
          WideButton(
            verse: Verse.plain('Create Currencies JSON'),
            onTap: _createCurrenciesJSON,
          ),

        ],
      ),
    );

  }
}
