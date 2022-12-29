import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/b_views/z_components/app_bar/zone_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramid_floating_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';


import 'package:bldrs/x_dashboard/zones_manager/location_test/locations_test_screen.dart';
import 'package:bldrs/x_dashboard/zones_manager/staging_test/staging_test_screen.dart';
import 'package:bldrs/x_dashboard/zones_manager/x_zones_manager_controller.dart';
import 'package:bldrs/x_dashboard/zones_manager/zoning_lab/b_zoning_lab.dart';
import 'package:bldrs/x_dashboard/zones_manager/zoning_lab/zone_searching_test_screen.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class ZonesManagerScreen extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ZonesManagerScreen({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// ZONE BUTTON
        ZoneButton(
          onTap: () => goToCountrySelectionScreen(
            zoneViewingEvent: ViewingEvent.admin,
            context: context,
          ),
        ),

      ],
      pyramidButtons: <Widget>[

        /// ZONE SEARCH TEST
        PyramidFloatingButton(
          icon: Iconz.search,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const ZoneSearchingTestScreen(),
            );
          },
        ),


        /// LOCATION TEST
        PyramidFloatingButton(
          icon: Iconz.locationPin,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const LocationsTestScreen(),
            );
          },
        ),

        /// LAB
        PyramidFloatingButton(
          icon: Iconz.lab,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const ZoningLab(),
            );
          },
        ),

        /// STAGING TEST
        PyramidFloatingButton(
          icon: Iconz.dotPyramid,
          onTap: () async {
            await Nav.goToNewScreen(
              context: context,
              screen: const StagingTestScreen(),
            );
          },
        ),

      ],
      child: Center(
        child: SuperVerse(
          verse: Verse.plain('Select a Zone'),
          size: 4,
          italic: true,
          color: Colorz.white50,
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
