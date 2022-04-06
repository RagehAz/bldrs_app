import 'dart:async';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/y_views/d_zoning/d_1_select_country_screen_view.dart';
import 'package:bldrs/c_controllers/d_zoning_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:flutter/material.dart';

class SelectCountryScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SelectCountryScreen({
    this.selectCountryIDOnly = false,
    this.selectCountryAndCityOnly = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool selectCountryIDOnly;
  final bool selectCountryAndCityOnly;
  /// --------------------------------------------------------------------------
  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
  /// --------------------------------------------------------------------------
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
// -----------------------------------------------------------------------------
  Future<void> _onCountryTap(String countryID) async {

    await controlCountryOnTap(
      context: context,
      countryID: countryID,
      selectCountryIDOnly: widget.selectCountryIDOnly,
      selectCountryAndCityOnly: widget.selectCountryAndCityOnly,
    );

  }
// -----------------------------------------------------------------------------
  Future<void> _onSearchCountry(String val) async {

    await controlCountrySearch(
        context: context,
        searchText: val
    );

  }
// -----------------------------------------------------------------------------
  void _onBack(){
    controlCountryScreenOnBack(context);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      historyButtonIsOn: false,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      onSearchSubmit: _onSearchCountry,
      onSearchChanged: _onSearchCountry,
      pageTitle: superPhrase(context, 'phid_select_a_country'),
      pyramidsAreOn: true,
      onBack: _onBack,
      searchHint: superPhrase(context, 'phid_search_countries'),
      layoutWidget: SelectCountryScreenView(
        onCountryTap: _onCountryTap,
      ),

    );

  }

}
