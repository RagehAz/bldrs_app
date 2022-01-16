import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/loading/loading.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/gallery.dart';
import 'package:bldrs/b_views/x_screens/f_bz/f_2_deactivated_flyers_screen.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';

class BzFlyersTab extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzFlyersTab({
    @required this.bzModel,
    @required this.flyers,
    @required this.bzCountry,
    @required this.bzCity,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final List<FlyerModel> flyers;
  final CountryModel bzCountry;
  final CityModel bzCity;
  /// --------------------------------------------------------------------------
  void _showOldFlyersOnTap(BuildContext context, BzModel bzModel) {
    Nav.goToNewScreen(context, DeactivatedFlyerScreen(bz: bzModel));
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[

        if (Mapper.canLoopList(flyers))
          Gallery(
            galleryBoxWidth: Bubble.clearWidth(context),
            superFlyer: SuperFlyer.getSuperFlyerFromBzModelOnly(
              bzModel: bzModel,
              onHeaderTap: () => blog('on header tap in f 0 my bz Screen'),
              bzCity: bzCity,
              bzCountry: bzCountry,
            ),
            showFlyers: true,
            // tinyFlyers: tinyFlyers,
          ),

        if (flyers == null)
          Container(
              width: Bubble.clearWidth(context),
              alignment: Alignment.center,
              child: const Loading(
                loading: true,
              )
          ),


        // /// --- PUBLISHED FLYERS
        // if (bzModel.flyersIDs != null)
        //   Bubble(
        //     title: 'Published Flyers',
        //     actionBtIcon: Iconz.clock,
        //     actionBtFunction: () => _showOldFlyersOnTap(context, bzModel),
        //     columnChildren: <Widget>[
        //
        //
        //     ],
        //   ),

        const Horizon(),

      ],
    );
  }
}
