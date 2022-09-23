import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_structure/b_header_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/d_bz_logo.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/ff_header_labels.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/g_follow_and_call_buttons.dart';
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
    final double _paddings = FollowAndCallButtons.getPaddings(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    /// --- FOLLOWERS & GALLERY
    final double followGalleryHeight = FollowAndCallButtons.getBoxHeight(
      flyerBoxWidth: flyerBoxWidth,
      headerIsExpanded: false,
    );
    // --------------------
    final double followGalleryWidth = FollowAndCallButtons.getBoxWidth(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------

    return HeaderBox(
      onHeaderTap: onTap,
      headerBorders: FlyerBox.superHeaderCorners(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        bzPageIsOn: false,
      ),
      flyerBoxWidth: flyerBoxWidth,
      headerColor:  Colorz.blackSemi125,
      headerHeightTween: FlyerBox.headerBoxHeight(flyerBoxWidth: flyerBoxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// BZ LOGO
          Container(
            color: Colorz.bloodTest,
            child: BzLogo(
              width: FlyerBox.logoWidth(bzPageIsOn: false, flyerBoxWidth: flyerBoxWidth),
              image: bzModel?.logo,
              tinyMode: FlyerBox.isTinyMode(context, flyerBoxWidth),
              corners: FlyerBox.superLogoCorner(context: context, flyerBoxWidth: flyerBoxWidth),
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
                width: FollowAndCallButtons.getBoxWidth(flyerBoxWidth: flyerBoxWidth),
                height: FlyerBox.logoWidth(bzPageIsOn: false, flyerBoxWidth: flyerBoxWidth),
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(horizontal: _paddings),
                // color: Colorz.BloodTest,
                child: SizedBox(
                  height: followGalleryHeight,
                  width: followGalleryWidth,
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
