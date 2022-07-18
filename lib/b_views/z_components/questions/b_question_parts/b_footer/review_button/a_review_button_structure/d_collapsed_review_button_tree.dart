import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class QuestionCollapsedReviewButtonTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionCollapsedReviewButtonTree({
    @required this.reviewButtonExpanded,
    @required this.flyerBoxWidth,
    @required this.onReviewButtonTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> reviewButtonExpanded;
  final double flyerBoxWidth;
  final Function onReviewButtonTap;
  /// --------------------------------------------------------------------------
  static double reviewBoxHeight(){
    return 100;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('QuestionCollapsedReviewButtonTree'),
      valueListenable: reviewButtonExpanded,
      builder: (_, bool _reviewButtonExpanded, Widget footerButton){
        final double _paddingValue = _reviewButtonExpanded ? 0 : 0;
        return AnimatedAlign(
            alignment: _reviewButtonExpanded ? Aligners.superTopAlignment(context) : Aligners.superCenterAlignment(context),
            duration: const Duration(milliseconds: 100),
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 100),
              padding: EdgeInsets.only(top: _paddingValue),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeOut,
                opacity: _reviewButtonExpanded ? 0 : 1,
                child: footerButton,
              ),
            )
        );
      },

      child: FooterButton(
        flyerBoxWidth: flyerBoxWidth,
        icon: Iconz.utPlanning,
        verse: 'Review',
        isOn: false,
        canTap: true,
        onTap: onReviewButtonTap,
      ),

    );
  }
}
