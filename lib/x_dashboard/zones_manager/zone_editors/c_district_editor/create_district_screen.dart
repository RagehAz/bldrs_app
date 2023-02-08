import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/c_district_editor/district_editor_bubble.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:stringer/stringer.dart';

class CreateDistrictScreen extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const CreateDistrictScreen({
    @required this.districtName,
    @required this.cityID,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String districtName;
  final String cityID;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _districtNameIdified = TextMod.idifyString(districtName);
    final String _districtID = '$cityID+$_districtNameIdified'.toLowerCase();

    final DistrictModel _initialDistrict = DistrictModel(
      id:  _districtID,
      phrases: <Phrase>[
        Phrase(
          id: _districtID,
          value: districtName,
          langCode: 'en',
        ),
      ],
      // position: null,
    );

    return MainLayout(
      title: Verse.plain('Create a new city ($districtName)'),
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        children: <Widget>[

          /// DISTRICT EDITOR BUBBLE
          DistrictEditorBubble(
              districtModel: _initialDistrict,
              onSync: (DistrictModel newDistrict) async {

                final bool _go = await Dialogs.confirmProceed(
                  context: context,
                  invertButtons: true,
                );

                if (_go == true){

                  await ZoneProtocols.composeDistrict(
                    context: context,
                    districtModel: newDistrict,
                  );

                }

              }
          ),

          const DotSeparator(),

        ],
      ),
    );

  }
// -----------------------------------------------------------------------------
}
