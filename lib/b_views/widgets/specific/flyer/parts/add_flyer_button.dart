import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_header.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/flyer_maker_screen.dart/flyer_maker_screen.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AddFlyerButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddFlyerButton({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.bzCountry,
    @required this.bzCity,
    @required this.addPublishedFlyerToGallery,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  final CountryModel bzCountry;
  final CityModel bzCity;
  final Function addPublishedFlyerToGallery;

  /// --------------------------------------------------------------------------
  Future<void> _goToFlyerEditor(BuildContext context) async {
    blog('going to create new flyer keda');

    await Future<void>.delayed(Ratioz.durationFading200, () async {
      final dynamic _result = await Nav.goToNewScreen(
          context,
          FlyerMakerScreen(
            firstTimer: true,
            bzModel: bzModel,
            flyerModel: null,
          ));

      if (_result.runtimeType == FlyerModel) {
        blog(
            '_goToFlyerEditor : adding published flyer model to bzPage screen gallery');
        addPublishedFlyerToGallery(_result);
      } else {
        blog('_goToFlyerEditor : did not publish the new draft flyer');
      }
    });
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _flyerSizeFactor =
        FlyerBox.sizeFactorByWidth(context, flyerBoxWidth);

    final SuperFlyer _bzHeaderSuperFlyer =
        SuperFlyer.getSuperFlyerFromBzModelOnly(
      onHeaderTap: () async {
        await _goToFlyerEditor(context);
      },
      bzModel: bzModel,
      bzCountry: bzCountry,
      bzCity: bzCity,
    );

    return FlyerBox(
      flyerBoxWidth: flyerBoxWidth,
      superFlyer: _bzHeaderSuperFlyer,
      onFlyerZoneTap: () async {
        await _goToFlyerEditor(context);
      },
      stackWidgets: <Widget>[
        FlyerHeader(
          superFlyer: _bzHeaderSuperFlyer,
          flyerBoxWidth: flyerBoxWidth,
        ),

        /// ADD FLYER BUTTON
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /// --- FAKE HEADER FOOTPRINT
            SizedBox(
              height: FlyerBox.headerBoxHeight(
                  bzPageIsOn: false, flyerBoxWidth: flyerBoxWidth),
            ),

            DreamBox(
              height: flyerBoxWidth * 0.4,
              width: flyerBoxWidth * 0.4,
              icon: Iconz.plus,
              iconColor: Colorz.white200,
              iconSizeFactor: 0.6,
              bubble: false,
              onTap: () async {
                await _goToFlyerEditor(context);
              },
            ),

            SuperVerse(
              verse: 'Add\nNew\nFlyer',
              maxLines: 5,
              scaleFactor: _flyerSizeFactor * 5,
              color: Colorz.white200,
            ),
          ],
        ),
      ],
    );
  }
}
