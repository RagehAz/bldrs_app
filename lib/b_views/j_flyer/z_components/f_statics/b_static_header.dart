import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_structure/b_header_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/d_bz_logo.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/ff_header_labels.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/gg_call_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/gg_follow_button.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class StaticHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticHeader({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.authorID,
    @required this.flyerShowsAuthor,
    this.flightTweenValue = 1,
    this.onTap,
    this.showHeaderLabels = false,
    this.flightDirection = FlightDirection.non,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flightTweenValue;
  final BzModel bzModel;
  final String authorID;
  final Function onTap;
  final bool flyerShowsAuthor;
  final bool showHeaderLabels;
  final FlightDirection flightDirection;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _paddings = FlyerDim.followAndCallPaddingValue(flyerBoxWidth);
    // --------------------
    return HeaderBox(
      onHeaderTap: onTap,
      headerBorders: FlyerDim.headerBoxCorners(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      ),
      flyerBoxWidth: flyerBoxWidth,
      headerColor:  Colorz.blackSemi125,
      headerHeightTween: FlyerDim.headerBoxHeight(flyerBoxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// BZ LOGO
          Container(
            color: Colorz.bloodTest,
            child: BzLogo(
              width: FlyerDim.logoWidth(flyerBoxWidth),
              image: bzModel?.logo,
              tinyMode: FlyerDim.isTinyMode(context, flyerBoxWidth),
              corners: FlyerDim.logoCorners(context: context, flyerBoxWidth: flyerBoxWidth),
              zeroCornerIsOn: flyerShowsAuthor,
              margins: EdgeInsets.zero,
            ),
          ),

          /// HEADER LABELS
          Container(
            color: Colorz.yellow20,
            child: Opacity(
              opacity: flightTweenValue,
              child: HeaderLabels(
                flyerBoxWidth: flyerBoxWidth,
                authorID: authorID,
                bzModel: bzModel,
                headerIsExpanded: false,
                flyerShowsAuthor: flyerShowsAuthor,
              ),
            ),
          ),

          /// FOLLOW AND CALL BUTTONS
          Container(
            color: Colorz.bloodTest,
            child: Opacity(
              opacity: flightTweenValue,
              child: Container(
                width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
                height: FlyerDim.logoWidth(flyerBoxWidth),
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(horizontal: _paddings),
                // color: Colorz.BloodTest,
                child: SizedBox(
                  height: FlyerDim.followAndCallBoxHeight(
                    flyerBoxWidth: flyerBoxWidth,
                    headerIsExpanded: false,
                  ),
                  width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      /// FOLLOW BUTTON
                      FollowButton(
                        flyerBoxWidth: flyerBoxWidth,
                        onFollowTap: null,
                        tappingUnfollow: null,
                        followIsOn: ValueNotifier(false),
                      ),

                      /// FAKE SPACE PADDING BETWEEN FOLLOW & GALLERY BUTTONS
                      SizedBox(
                        height: _paddings,
                      ),

                      /// Call BUTTON
                      CallButton(
                        flyerBoxWidth: flyerBoxWidth,
                        onCallTap: null,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
