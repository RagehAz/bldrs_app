import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/views/screens/i_flyer/flyer_maker_screen.dart/flyer_maker_screen.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_header.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';

class AddFlyerButton extends StatelessWidget {
  final double flyerBoxWidth;
  final BzModel bzModel;
  final CountryModel bzCountry;
  final CityModel bzCity;
  final Function addPublishedFlyerToGallery;

  const AddFlyerButton({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.bzCountry,
    @required this.bzCity,
    @required this.addPublishedFlyerToGallery,
    Key key,
  }) : super(key: key);

// -----------------------------------------------------------------------------
  Future<void> _goToFlyerEditor(BuildContext context) async {

    print('going to create new flyer keda');

    await Future.delayed(Ratioz.durationFading200, () async {
      dynamic _result = await Nav.goToNewScreen(context,
          new FlyerMakerScreen(
            firstTimer: true,
            bzModel: bzModel,
            flyerModel: null,

          )
      );

      if (_result.runtimeType == FlyerModel){
        print('_goToFlyerEditor : adding published flyer model to bzPage screen gallery');
        addPublishedFlyerToGallery(_result);
      }
      else {
        print('_goToFlyerEditor : did not publish the new draft flyer');
      }

    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _flyerSizeFactor = FlyerBox.sizeFactorByWidth(context, flyerBoxWidth);

    final SuperFlyer _bzHeaderSuperFlyer = SuperFlyer.getSuperFlyerFromBzModelOnly(
      onHeaderTap: () async { await _goToFlyerEditor(context); },
      bzModel: bzModel,
      bzCountry: bzCountry,
      bzCity: bzCity,
    );

    return FlyerBox(
      flyerBoxWidth: flyerBoxWidth,
      superFlyer: _bzHeaderSuperFlyer,
      onFlyerZoneTap: () async { await _goToFlyerEditor(context); },
      stackWidgets: <Widget>[

        FlyerHeader(superFlyer: _bzHeaderSuperFlyer, flyerBoxWidth: flyerBoxWidth,),

        /// ADD FLYER BUTTON
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              /// --- FAKE HEADER FOOTPRINT
              SizedBox(
                height: FlyerBox.headerBoxHeight(false, flyerBoxWidth),
              ),

              DreamBox(
                height: flyerBoxWidth * 0.4,
                width: flyerBoxWidth * 0.4,
                icon: Iconz.Plus,
                iconColor: Colorz.white200,
                iconSizeFactor: 0.6,
                bubble: false,
                onTap: () async {await _goToFlyerEditor(context);},
              ),

              SuperVerse(
                verse: 'Add\nNew\nFlyer',
                maxLines: 5,
                size: 2,
                scaleFactor: _flyerSizeFactor * 5,
                color: Colorz.white200,
              ),

            ],
          ),

      ],
    );
  }
}
