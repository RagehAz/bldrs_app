import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_button_spacer.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

class FooterButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterButtons({
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    @required this.onSaveFlyer,
    @required this.onReviewFlyer,
    @required this.onShareFlyer,
    @required this.flyerIsSaved,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  final Function onSaveFlyer;
  final Function onReviewFlyer;
  final Function onShareFlyer;
  final ValueNotifier<bool> flyerIsSaved;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Widget _spacer = FooterButtonSpacer(
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: tinyMode
    );

    return Positioned(
      right: Aligners.rightPositionInRightAlignmentEn(context, 0),
      left: Aligners.leftPositionInRightAlignmentEn(context, 0),
      bottom: 0,
      child: Row(
        children: <Widget>[

          _spacer,

          /// SHARE
          FooterButton(
            flyerBoxWidth: flyerBoxWidth,
            icon: Iconz.share,
            verse: Wordz.send(context),
            isOn: false,
            tinyMode: tinyMode,
            onTap: onShareFlyer,
          ),

          _spacer,

          /// COMMENT
          FooterButton(
            flyerBoxWidth: flyerBoxWidth,
            icon: Iconz.utPlanning,
            verse: 'Review',
            isOn: false,
            tinyMode: tinyMode,
            onTap: onReviewFlyer,
          ),

          _spacer,

          /// SAVE BUTTON
          ValueListenableBuilder(
            valueListenable: flyerIsSaved,
            builder: (_, bool isSaved, Widget child){

              return FooterButton(
                flyerBoxWidth: flyerBoxWidth,
                icon: Iconz.save,
                verse: isSaved == true ? Wordz.saved(context) : Wordz.save(context),
                isOn: isSaved,
                tinyMode: tinyMode,
                onTap: onSaveFlyer,
              );

            },
          ),

          _spacer,

        ],
      ),
    );
  }
}
