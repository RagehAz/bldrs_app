import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/widgets/general/loading/loading.dart';
import 'package:bldrs/b_views/y_views/d_zoning/d_2a_all_cities_buttons.dart';
import 'package:bldrs/b_views/y_views/d_zoning/d_2b_searched_cities_buttons.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCityScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectCityScreenView({
    @required this.cities,
    @required this.onCityTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<CityModel> cities;
  final ValueChanged<String> onCityTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);

    /// WHEN LOADING
    if (_uiProvider.isLoading){

      return const LoadingFullScreenLayer();

    }

    /// WHEN SHOWING ALL COUNTRY CITIES
    else {

      return OldMaxBounceNavigator(
        child: Scroller(
          child: Selector<SearchProvider, bool>(
            selector: (_, SearchProvider searchProvider) => searchProvider.isSearchingCity,
            builder: (BuildContext context, bool isSearchingCity, Widget child){

              if (isSearchingCity == true){

                return

                  SearchedCitiesButtons(
                    onCityTap: (String cityID) => onCityTap(cityID),
                  );

              }

              else {

                return
                  AllCitiesButtons(
                    onCityChanged: onCityTap,
                    cities: cities,
                  );

              }

            },
          ),
        ),
      );


    }
  }
}
