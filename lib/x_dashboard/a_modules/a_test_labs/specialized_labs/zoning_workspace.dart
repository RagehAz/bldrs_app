import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/a_select_country_screen.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';

class ZoningWorkSpace extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZoningWorkSpace({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<ZoningWorkSpace> createState() => _ZoningWorkSpaceState();
/// --------------------------------------------------------------------------
}

class _ZoningWorkSpaceState extends State<ZoningWorkSpace> {

  ZoneModel _bubbleZone;

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      sectionButtonIsOn: false,
      pageTitle: 'Zoning work space',
      pyramidType: PyramidType.crystalYellow,
      layoutWidget: FloatingCenteredList(
        columnChildren: <Widget>[

          AppBarButton(
            verse:  'Zone by one button',
            onTap: () async {

              final ZoneModel _zone = await Nav.goToNewScreen(
                  context: context,
                  screen: const SelectCountryScreen(),
              );

              _zone?.blogZone(methodName: 'ZONE BY ONE BUTTON');

              if (_zone == null){
                blog('ZONE IS NULL');
              }

            },
          ),

          ZoneSelectionBubble(
            currentZone: _bubbleZone,
            title: 'Zoning test',
            notes: const <String>[
              'Fuck you',
              'Bitch',
            ],
            onZoneChanged: (ZoneModel zone){

              zone.blogZone(methodName: 'ZONE Received from bubble');

              if (zone != null){
                _bubbleZone = zone;
              }

            },
          ),

          AppBarButton(
            verse:  'blog current zone',
            onTap: (){

              _bubbleZone?.blogZone();

            },
          ),

        ],
      ),
    );

  }
}
