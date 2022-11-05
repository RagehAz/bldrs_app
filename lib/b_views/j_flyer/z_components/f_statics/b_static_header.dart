import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/b_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/a_left_spacer/static_slate_spacer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_header_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/d_labels/ff_header_labels.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/e_follow_and_call/gg_call_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/e_follow_and_call/gg_follow_button.dart';
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
    return HeaderBox(
      flyerBoxWidth: flyerBoxWidth,
      headerHeightTween: FlyerDim.headerSlateHeight(flyerBoxWidth),
      headerBorders: FlyerDim.headerSlateCorners(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      ),
      headerColor: FlyerColors.headerColor,
      onHeaderTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// LEFT SPACER
          StaticHeaderSlateSpacer(
            flyerBoxWidth: flyerBoxWidth,
          ),

          /// BZ LOGO
          BzLogo(
            width: FlyerDim.logoWidth(flyerBoxWidth),
            image: bzModel?.logoPath,
            isVerified: bzModel?.isVerified,
            corners: FlyerDim.logoCornersByFlyerBoxWidth(
              context: context,
              flyerBoxWidth: flyerBoxWidth,
              zeroCornerIsOn: flyerShowsAuthor && FlyerDim.isTinyMode(context, flyerBoxWidth) == false,
            ),
            zeroCornerIsOn: flyerShowsAuthor,
            margins: EdgeInsets.zero,
          ),

          /// HEADER LABELS
          Opacity(
            opacity: flightTweenValue,
            child: HeaderLabels(
              flyerBoxWidth: flyerBoxWidth,
              authorID: authorID,
              bzModel: bzModel,
              headerIsExpanded: false,
              flyerShowsAuthor: flyerShowsAuthor,
              showHeaderLabels: showHeaderLabels,
            ),
          ),

          /// FOLLOW AND CALL BUTTONS
          Opacity(
            opacity: flightTweenValue,
            child: Container(
              width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
              height: FlyerDim.logoWidth(flyerBoxWidth),
              alignment: Alignment.topCenter,
              // margin: EdgeInsets.symmetric(horizontal: _paddings),
              // color: Colorz.BloodTest,
              child: SizedBox(
                height: FlyerDim.followAndCallBoxHeight(flyerBoxWidth),
                width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// FOLLOW BUTTON
                    if (showHeaderLabels == true)
                    FollowButton(
                      flyerBoxWidth: flyerBoxWidth,
                      onFollowTap: null,
                      tappingUnfollow: null,
                      followIsOn: ValueNotifier(false),
                    ),

                    /// FAKE SPACE PADDING BETWEEN FOLLOW & GALLERY BUTTONS
                    if (showHeaderLabels == true)
                      StaticHeaderSlateSpacer(
                      flyerBoxWidth: flyerBoxWidth,
                    ),

                    /// Call BUTTON
                    if (showHeaderLabels == true)
                      CallButton(
                      flyerBoxWidth: flyerBoxWidth,
                      onCallTap: null,
                    ),

                  ],
                ),
              ),
            ),
          ),


          /// RIGHT SPACER
            StaticHeaderSlateSpacer(
            flyerBoxWidth: flyerBoxWidth,
          ),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
