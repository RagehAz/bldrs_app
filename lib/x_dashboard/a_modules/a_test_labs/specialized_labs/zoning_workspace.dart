import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/h_new_zoning/a_new_select_country_screen.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/profile_editors/new_zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;

class ZoningWorkSpace extends StatelessWidget {

  const ZoningWorkSpace({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      pageTitle: 'Zoning work space',
      pyramidType: PyramidType.crystalYellow,
      layoutWidget: FloatingCenteredList(
        columnChildren: <Widget>[

          AppBarButton(
            verse: 'Zone by one button',
            onTap: () async {

              final ZoneModel _zone = await Nav.goToNewScreen(
                  context: context,
                  screen: const NewSelectCountryScreen(),
              );

              _zone?.blogZone(methodName: 'ZONE BY ONE BUTTON');

              if (_zone == null){
                blog('ZONE IS NULL');
              }

            },
          ),

          NewZoneSelectionBubble(
            currentZone: null,
            title: 'Zoning test',
            notes: const <String>[
              'Fuck you',
              'Bitch',
            ],
            onZoneChanged: (ZoneModel zone){

              zone.blogZone(methodName: 'ZONE Received from bubble');

            },
          ),

        ],
      ),
    );

  }
}
