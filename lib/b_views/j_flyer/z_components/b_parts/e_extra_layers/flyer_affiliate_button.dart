import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class FlyerAffiliateButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FlyerAffiliateButton({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  // --------------------
  final double flyerBoxWidth;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperPositioned(
      enAlignment: Alignment.bottomLeft,
      verticalOffset: FlyerDim.footerBoxHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        infoButtonExpanded: false,
      ),
      horizontalOffset: FlyerDim.footerButtonMarginValue(flyerBoxWidth),
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
      child: BldrsBox(
        height: FlyerDim.footerBoxHeight(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
          infoButtonExpanded: false,
        ),
        width: flyerBoxWidth * 0.9,
        verse: const Verse(
          id: 'phid_buy_on_amazon',
          translate: true,
        ),
        secondLine: Verse.plain('text'),
        verseMaxLines: 3,
        icon: Iconz.amazon,
        iconSizeFactor: 0.7,
        verseScaleFactor: 0.7,
        verseCentered: false,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
