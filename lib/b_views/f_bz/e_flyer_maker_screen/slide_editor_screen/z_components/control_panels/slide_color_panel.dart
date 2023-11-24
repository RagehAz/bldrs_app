import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/widgets/drawing/expander.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/buttons/panel_circle_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class SlideColorPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideColorPanel({
    required this.flyerBoxWidth,
    required this.mounted,
    required this.draftSlideNotifier,
    required this.matrixNotifier,
    required this.matrixFromNotifier,
    required this.onResetMatrix,
    required this.canResetMatrix,
    required this.onTriggerSlideIsAnimated,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool mounted;
  final ValueNotifier<DraftSlide?> draftSlideNotifier;
  final ValueNotifier<Matrix4?> matrixNotifier;
  final ValueNotifier<Matrix4?> matrixFromNotifier;
  final Function onResetMatrix;
  final ValueNotifier<bool> canResetMatrix;
  final Function onTriggerSlideIsAnimated;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _size = FlyerDim.footerButtonSize(
        flyerBoxWidth: flyerBoxWidth,
      );

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: flyerBoxWidth,
        height: FlyerDim.footerBoxHeight(
          flyerBoxWidth: flyerBoxWidth,
          infoButtonExpanded: false,
          showTopButton: false,
        ),
        child: Row(
          children: <Widget>[

            const Expander(),

            /// SPACING
            Spacing(size: FlyerDim.footerButtonMarginValue(flyerBoxWidth) * 2,),

            /// PLAY
            PanelCircleButton(
              verse: const Verse(
                id: 'boom',
                translate: true,
              ),
              icon: Iconz.dollar,
              size: _size,
              isSelected: false,
              onTap: (){},
            ),

            /// SPACING
            Spacing(size: FlyerDim.footerButtonMarginValue(flyerBoxWidth) * 2,),

            const Expander(),

          ],
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
