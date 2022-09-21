import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/mini_follow_and_call_bts.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/follow_button.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FollowAndCallBTs extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FollowAndCallBTs({
    @required this.flyerBoxWidth,
    @required this.headerIsExpanded,
    @required this.onFollowTap,
    @required this.followIsOn,
    @required this.onCallTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool headerIsExpanded;
  final Function onFollowTap;
  final Function onCallTap;
  final ValueNotifier<bool> followIsOn; /// p
  /// --------------------------------------------------------------------------
  static double getPaddings({double flyerBoxWidth}) {
    return flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
  }
  // --------------------
  static double getBoxHeight({
    @required double flyerBoxWidth,
    @required bool headerIsExpanded,
  }) {
    final double _headerMainHeight = FlyerBox.headerStripHeight(
        headerIsExpanded: headerIsExpanded,
        flyerBoxWidth: flyerBoxWidth,
    );
    final double _headerMainPadding = flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
    final double _followGalleryHeight = _headerMainHeight - (2 * _headerMainPadding);
    return _followGalleryHeight;
  }
  // --------------------
  static double getBoxWidth({double flyerBoxWidth}) {
    return (flyerBoxWidth * Ratioz.xxflyerFollowBtWidth) - 1;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _paddings = getPaddings(
        flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    /// --- FOLLOWERS & GALLERY
    final double followGalleryHeight = getBoxHeight(
        flyerBoxWidth: flyerBoxWidth,
        headerIsExpanded: headerIsExpanded,
    );
    // --------------------
    final double followGalleryWidth = getBoxWidth(
        flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    return SizedBox(
      height: followGalleryHeight,
      width: followGalleryWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// FOLLOW BUTTON
          FollowBT(
            flyerBoxWidth: flyerBoxWidth,
            onFollowTap: onFollowTap,
            tappingUnfollow: () {},
            followIsOn: followIsOn,
          ),

          /// FAKE SPACE PADDING BETWEEN FOLLOW & GALLERY BUTTONS
          SizedBox(
            height: _paddings,
          ),

          /// Call BUTTON
          OldCallBT(
            flyerBoxWidth: flyerBoxWidth,
            onCallTap: onCallTap,
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
