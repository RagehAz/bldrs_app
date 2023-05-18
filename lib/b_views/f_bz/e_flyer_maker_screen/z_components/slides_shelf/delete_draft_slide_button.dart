import 'package:bldrs/b_views/j_flyer/z_components/c_groups/draft_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class DeleteDraftSlideButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DeleteDraftSlideButton({
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _boxHeight = FlyerDim.footerBoxHeight(
      context: context,
      flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
      infoButtonExpanded: false,
      hasLink: false,
    );

    return SuperPositioned(
      enAlignment: Alignment.bottomCenter,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      child: Container(
        width: DraftShelfSlide.flyerBoxWidth,
        height: _boxHeight,
        // color: Colorz.bloodTest,
        alignment: Alignment.center,
        child: BldrsBox(
          height: _boxHeight,
          width: _boxHeight,
          icon: Iconz.xLarge,
          iconSizeFactor: 0.6,
          onTap: onTap,
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
