import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/x_0_flyer_editor_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFlyerButton extends StatelessWidget {
  final double flyerZoneWidth;
  final BzModel bzModel;

  const AddFlyerButton({
    @required this.flyerZoneWidth,
    @required this.bzModel,
  });

// -----------------------------------------------------------------------------
  Future<void> _goToFlyerEditor(BuildContext context) async {

    FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
    _prof.setCurrentBzModel(bzModel);

    dynamic _result = await Nav.goToNewScreen(context,
        FlyerEditorScreen(
          firstTimer: true,
          bzModel: bzModel,
          flyerModel: null,
        )
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _flyerSizeFactor = Scale.superFlyerSizeFactorByWidth(context, flyerZoneWidth);

    return FlyerZoneBox(
      flyerSizeFactor: _flyerSizeFactor,
      onFlyerZoneTap: () async { await _goToFlyerEditor(context); },
      stackWidgets: <Widget>[

        // FlyerHeader(
        //   tinyBz: TinyBz.getTinyBzFromBzModel(widget.bz),
        //   tinyAuthor: TinyUser.getTinyAuthorFromAuthorModel(widget.author),
        //   flyerShowsAuthor: true,
        //   followIsOn: false,
        //   flyerZoneWidth: Scale.superFlyerZoneWidth(context, widget.flyerSizeFactor),
        //   bzPageIsOn: _bzPageIsOn,
        //   tappingHeader: () async {
        //     await _triggerMaxHeader();
        //   },
        //   onFollowTap: (){},
        //   onCallTap: (){},
        // ),

        // --- ADD FLYER BUTTON
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              // --- FAKE HEADER FOOTPRINT
              SizedBox(
                height: Scale.superHeaderHeight(false, flyerZoneWidth),
              ),

              DreamBox(
                height: flyerZoneWidth * 0.4,
                width: flyerZoneWidth * 0.4,
                icon: Iconz.Plus,
                iconColor: Colorz.White200,
                iconSizeFactor: 0.6,
                bubble: false,
                onTap: () async {await _goToFlyerEditor(context);},
              ),

              SuperVerse(
                verse: 'Add\nNew\nFlyer',
                maxLines: 5,
                size: 2,
                scaleFactor: _flyerSizeFactor * 5,
                color: Colorz.White200,
              ),

            ],
          ),

      ],
    );
  }
}
