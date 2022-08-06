import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/f_footer_button_spacer.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/c_controllers/x_flyer_controllers/footer_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class FlyerFooterButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerFooterButtons({
    @required this.flyerModel,
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    @required this.onSaveFlyer,
    @required this.inFlight,
    @required this.infoButtonType,
    @required this.flyerIsSaved,
    @required this.flyerCounter,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final bool tinyMode;
  final Function onSaveFlyer;
  final bool inFlight;
  final InfoButtonType infoButtonType;
  final ValueNotifier<bool> flyerIsSaved;
  final ValueNotifier<FlyerCounterModel> flyerCounter;
  /// --------------------------------------------------------------------------
  bool _canShowElement(){
    bool _canShow = true;
    if (tinyMode == true){
        if (infoButtonType == InfoButtonType.info){
          _canShow = false;
        }
    }
    return _canShow;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _canShow = _canShowElement();

    return Positioned(
      right: Aligners.rightPositionInRightAlignmentEn(context, 0),
      left: Aligners.leftPositionInRightAlignmentEn(context, 0),
      bottom: 0,
      child: ValueListenableBuilder(
        valueListenable: flyerCounter,
        child: FooterButtonSpacer(
            flyerBoxWidth: flyerBoxWidth,
            tinyMode: tinyMode
        ),
        builder: (_, FlyerCounterModel counter, Widget spacer){

          counter?.blogCounter();

          return Row(
            children: <Widget>[

              if (_canShow == true)
                spacer,

              /// SHARE
              if (_canShow == true)
                FooterButton(
                  count: counter?.shares,
                  flyerBoxWidth: flyerBoxWidth,
                  icon: Iconz.share,
                  verse: superPhrase(context, 'phid_send'),
                  isOn: false,
                  canTap: !tinyMode,
                  onTap: () => onShareFlyer(
                    context: context,
                    flyerModel: flyerModel,
                  ),
                ),

              if (_canShow == true)
                spacer,

              /// REVIEWS
              if (_canShow == true)
                FooterButton(
                  count: counter?.reviews,
                  flyerBoxWidth: flyerBoxWidth,
                  icon: Iconz.utPlanning,
                  verse: 'Review',//superPhrase(context, 'phid_review'),
                  isOn: false,
                  canTap: !tinyMode,
                  onTap: () => onReviewButtonTap(
                    context: context,
                    flyerModel: flyerModel,
                  ),
                ),

              if (_canShow == true)
                spacer,

              /// SAVE BUTTON
              ValueListenableBuilder(
                valueListenable: flyerIsSaved,
                builder: (_, bool isSaved, Widget child){

                  return FooterButton(
                    count: counter?.saves,
                    flyerBoxWidth: flyerBoxWidth,
                    icon: Iconz.save,
                    verse: isSaved == true ? superPhrase(context, 'phid_saved') : superPhrase(context, 'phid_save'),
                    isOn: isSaved,
                    canTap: true,
                    onTap: onSaveFlyer,
                  );

                },
              ),

              spacer,

            ],
          );

        },
      ),
    );
  }
}
