
import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/widgets/general/loading/loading.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/y_views/d_zoning/d_2a_all_cities_buttons.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCityScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectCityScreenView({
    @required this.cities,
    @required this.country,
    @required this.onItemTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<CityModel> cities;
  final CountryModel country;
  final ValueChanged<String> onItemTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    final double _verseHeight = SuperVerse.superVerseRealHeight(context, 2, 1, Colorz.white10);
    final double _bubbleHeight = _screenHeight - Ratioz.stratosphere - Ratioz.appBarSmallHeight - _verseHeight -
        (Ratioz.appBarMargin * 4);
// -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    final String _countryName = Name.getNameByCurrentLingoFromNames(context, country?.names);
    final List<MapModel> _citiesMapModels = CityModel.getCitiesNamesMapModels(context: context, cities: cities);
    final String _countryFlag = Flag.getFlagIconByCountryID(country.id);
// -----------------------------------------------------------------------------


    /// WHEN LOADING
    if (_uiProvider.loading){

      return const LoadingFullScreenLayer();

    }

    /// WHEN SHOWING ALL COUNTRY CITIES
    else {

      return AllCitiesButtons(
        mapModels: _citiesMapModels,
        onItemTap: onItemTap,
        pageIconVerse: _countryName,
        icons: const <String>[],
        pageIcon: _countryFlag,
      );

    }
  }
}
