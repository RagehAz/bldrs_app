import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/widgets/drawing/super_positioned.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class DeleteDraftSlideButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DeleteDraftSlideButton({
    required this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _boxHeight = FlyerDim.footerBoxHeight(
      flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
      infoButtonExpanded: false,
      showTopButton: false,
    );

    return SuperPositioned(
      enAlignment: Alignment.bottomLeft,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      child: BldrsBox(
        height: _boxHeight * 1.5,
        width: _boxHeight * 1.5,
        corners: FlyerDim.flyerCorners(DraftShelfSlide.flyerBoxWidth).bottomRight.x,
        icon: Iconz.xLarge,
        iconSizeFactor: 0.6,
        color: Colorz.black50,
        onTap: onTap,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
