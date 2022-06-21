import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/ccc_select_district_screen_all_districts_view.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/ccc_select_district_screen_search_view.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectDistrictScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectDistrictScreenView({
    @required this.districts,
    @required this.onDistrictTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<DistrictModel> districts;
  final ValueChanged<String> onDistrictTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    districts.sort((DistrictModel a, DistrictModel b){

      final String _nameA = superPhrase(context, a.districtID);
      final String _nameB = superPhrase(context, b.districtID);

      return _nameA.compareTo(_nameB);
    });


    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);

    /// WHEN LOADING
    if (_uiProvider.isLoading){
      return const LoadingFullScreenLayer();
    }

    /// WHEN SHOWING ALL CITY DISTRICTS
    else {

      return OldMaxBounceNavigator(
        child: Scroller(
          child: Selector<SearchProvider, bool>(
            selector: (_, SearchProvider searchProvder) => searchProvder.isSearchingDistrict,
            builder: (BuildContext context, bool isSearchingDistrict, Widget child){

              if (isSearchingDistrict == true){

                return

                  SearchedDistrictsButtons(
                    onDistrictTap: onDistrictTap,
                  );

              }

              else {

                return
                  SelectDistrictScreenAllDistrictsView(
                    onDistrictChanged: onDistrictTap,
                    districts: districts,
                  );

              }

            },
          ),
        ),
      );


    }
  }
}
