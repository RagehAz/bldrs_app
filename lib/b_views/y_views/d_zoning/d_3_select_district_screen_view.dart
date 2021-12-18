import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/widgets/general/loading/loading.dart';
import 'package:bldrs/b_views/y_views/d_zoning/d_3a_all_districts_buttons.dart';
import 'package:bldrs/b_views/y_views/d_zoning/d_3b_searched_districts_buttons.dart';
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

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);

    /// WHEN LOADING
    if (_uiProvider.loading){

      return const LoadingFullScreenLayer();

    }

    /// WHEN SHOWING ALL CITY DISTRICTS
    else {

      return MaxBounceNavigator(
        child: Scroller(
          child: Selector<UiProvider, bool>(
            selector: (_, UiProvider uiProvider) => uiProvider.isSearchingDistrict,
            builder: (BuildContext context, bool isSearchingDistrict, Widget child){

              if (isSearchingDistrict == true){

                return

                  SearchedDistrictsButtons(
                    onDistrictTap: onDistrictTap,
                  );

              }

              else {

                return
                  AllDistrictsButtons(
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
