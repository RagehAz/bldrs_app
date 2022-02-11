import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class CollapsedReviewButtonTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CollapsedReviewButtonTree({
    @required this.reviewButtonExpanded,
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> reviewButtonExpanded;
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  static double reviewBoxHeight(){
    return 100;
  }

  @override
  Widget build(BuildContext context) {

    final double _buttonSize = FooterButton.buttonSize(context: context, flyerBoxWidth: flyerBoxWidth, tinyMode: false);
    final double _margin = FooterButton.buttonMargin(context: context, flyerBoxWidth: flyerBoxWidth, tinyMode: false);
    final double _reviewBoxWidth = flyerBoxWidth - _buttonSize - (_margin * 2);

    final double _reviewBoxHeight = reviewBoxHeight();

    return ValueListenableBuilder(
      key: const ValueKey<String>('COLLAPSED_REVIEW_BUTTON_CONTENT'),
      valueListenable: reviewButtonExpanded,
      builder: (_, bool _reviewButtonExpanded, Widget collapsedReviewButtonContent){

        final double _paddingValue = _reviewButtonExpanded ? 0 : 0;

        return AnimatedAlign(
            alignment: _reviewButtonExpanded ? Aligners.superTopAlignment(context) : Aligners.superCenterAlignment(context),
            duration: const Duration(milliseconds: 100),
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 100),
              padding: EdgeInsets.only(top: _paddingValue),
              child: _reviewButtonExpanded ?
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  collapsedReviewButtonContent,

                  Container(
                    width: _reviewBoxWidth,
                    height: _reviewBoxHeight,
                    color: Colorz.red255,
                  ),

                ],
              )
                  :
              collapsedReviewButtonContent,
            )
        );
      },

      child: FooterButton(
        flyerBoxWidth: flyerBoxWidth,
        icon: Iconz.utPlanning,
        verse: 'Review',
        isOn: false,
        tinyMode: false,
        onTap: null,
      ),

    );
  }
}
