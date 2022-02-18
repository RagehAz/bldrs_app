import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart' as Colorizer;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class MiniHeaderStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MiniHeaderStrip({
    @required this.flyerBoxWidth,
    @required this.bzPageIsOn,
    @required this.bzModel,
    @required this.flyerShowsAuthor,
    @required this.bzCountry,
    @required this.bzCity,
    @required this.authorID,
    @required this.onFollowTap,
    @required this.onCallTap,
    @required this.followIsOn,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool bzPageIsOn;
  final BzModel bzModel;
  final bool flyerShowsAuthor;
  final CountryModel bzCountry;
  final CityModel bzCity;
  final String authorID;
  final Function onFollowTap;
  final Function onCallTap;
  final bool followIsOn;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _stripHeight = FlyerBox.headerStripHeight(
        headerIsExpanded: bzPageIsOn,
        flyerBoxWidth: flyerBoxWidth,
    );

    final BorderRadius _stripBorders = FlyerBox.superHeaderStripCorners(
      context: context,
      bzPageIsOn: bzPageIsOn,
      flyerBoxWidth: flyerBoxWidth,
    );
// -----------------------------------------------------------------------------
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        // there was Align(Alignment: Alignment.topCenter above this container ,, delete this comment if you see me again
        height: _stripHeight,
        width: flyerBoxWidth,
        padding: EdgeInsets.all(flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding),
        decoration: BoxDecoration(
          borderRadius: _stripBorders,
          gradient: Colorizer.superHeaderStripGradient(Colorz.white50),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// --- BzLogo
            BzLogo(
              width: FlyerBox.logoWidth(
                  bzPageIsOn: bzPageIsOn,
                  flyerBoxWidth: flyerBoxWidth),
              image: bzModel.logo,
              tinyMode: FlyerBox.isTinyMode(context, flyerBoxWidth),
              corners: FlyerBox.superLogoCorner(
                  context: context,
                  flyerBoxWidth: flyerBoxWidth,
                  zeroCornerIsOn: flyerShowsAuthor
              ),
              zeroCornerIsOn: flyerShowsAuthor,
              // onTap: superFlyer.onHeaderTap,
            ),

            /// --- B.NAME, B.LOCALE, AUTHOR PICTURE, AUTHOR NAME, AUTHOR TITLE, FOLLOWERS COUNT
            OldHeaderLabels(
              flyerBoxWidth: flyerBoxWidth,
              authorID: authorID,
              bzCity: bzCity,
              bzCountry: bzCountry,
              bzModel: bzModel,
              headerIsExpanded: bzPageIsOn,
              flyerShowsAuthor: flyerShowsAuthor,
            ),

            /// --- FOLLOW & Call
            OldFollowAndCallBTs(
              flyerBoxWidth: flyerBoxWidth,
              onFollowTap: onFollowTap,
              onCallTap: onCallTap,
              followIsOn: followIsOn,
              headerIsExpanded: bzPageIsOn,
            ),

          ],
        ),
      ),
    );
  }
}
