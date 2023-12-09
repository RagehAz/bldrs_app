import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/flyer_counter_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_footer_controller.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/f_footer_button_spacer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/top_button/top_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class FlyerFooterButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerFooterButtons({
    required this.flyerModel,
    required this.flyerBoxWidth,
    required this.tinyMode,
    required this.onSaveFlyer,
    required this.inFlight,
    required this.infoButtonType,
    required this.flyerIsSaved,
    required this.isSharing,
    required this.flyerCounter,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel? flyerModel;
  final bool tinyMode;
  final Function onSaveFlyer;
  final bool inFlight;
  final InfoButtonType infoButtonType;
  final ValueNotifier<bool> flyerIsSaved;
  final ValueNotifier<bool> isSharing;
  final ValueNotifier<FlyerCounterModel?> flyerCounter;
  /// --------------------------------------------------------------------------
  bool _canShowElement(){
    // bool _canShow = true;
    // if (tinyMode == true){
    //     if (infoButtonType == InfoButtonType.info){
    //       _canShow = false;
    //     }
    // }

    bool _canShow = false;

    if (tinyMode == false && inFlight == false){
      _canShow = true;
    }

    return _canShow;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _canShow = _canShowElement();

    return Positioned(
      right: BldrsAligners.rightPositionInRightAlignmentEn(0),
      left: BldrsAligners.leftPositionInRightAlignmentEn(0),
      bottom: 0,
      child: ValueListenableBuilder(
        valueListenable: flyerCounter,
        builder: (_, FlyerCounterModel? counter, Widget? footerButtonSpacer){

          return SizedBox(
            width: flyerBoxWidth,
            height: FlyerDim.footerBoxHeight(
              flyerBoxWidth: flyerBoxWidth,
              infoButtonExpanded: false,
              showTopButton: checkCanShowTopButton(
                flyerModel: flyerModel,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                /// TOP BUTTON : AMAZON / PRICE / DISCOUNT
                Align(
                  alignment: BldrsAligners.superTopAlignment(context),
                  child: TopButton(
                    flyerBoxWidth: flyerBoxWidth,
                    flyerModel: flyerModel,
                    inStack: false,
                  ),
                ),

                /// SAVE - REVIEW - SHARE
                Align(
                  alignment: BldrsAligners.superInverseBottomAlignment(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      /// SPACING
                      if (_canShow == true)
                        footerButtonSpacer!,

                      /// SHARE
                      if (_canShow == true)
                        ValueListenableBuilder(
                            valueListenable: isSharing,
                            builder: (_, bool _isSharing, Widget? child) {
                              return FooterButton(
                                count: counter?.shares,
                                flyerBoxWidth: flyerBoxWidth,
                                icon: Iconz.share,
                                phid: 'phid_share',
                                isOn: false,
                                canTap: !tinyMode,
                                isLoading: _isSharing,
                                onTap: () => onShareFlyer(
                                  flyerModel: flyerModel,
                                  isSharing: isSharing,
                                  slideIndex: 0,
                                ),
                              );
                            }),

                      /// SPACING
                      if (_canShow == true)
                        footerButtonSpacer!,

                      /// REVIEWS
                      if (_canShow == true)
                        FooterButton(
                          count: counter?.reviews,
                          flyerBoxWidth: flyerBoxWidth,
                          icon: Iconz.balloonSpeaking,
                          phid: 'phid_review',
                          isOn: false,
                          canTap: !tinyMode,
                          onTap: () => onReviewButtonTap(
                            flyerModel: flyerModel,
                          ),
                        ),

                      /// SPACING
                      if (_canShow == true)
                        footerButtonSpacer!,

                      /// SAVE BUTTON
                      ValueListenableBuilder(
                        valueListenable: flyerIsSaved,
                        builder: (_, bool isSaved, Widget? child) {
                          return FooterButton(
                            count: counter?.saves,
                            flyerBoxWidth: flyerBoxWidth,
                            icon: isSaved == true ? Iconz.loveBlack : Iconz.love,
                            phid: isSaved == true ? 'phid_saved' : 'phid_save',
                            isOn: isSaved,
                            canTap: true,
                            onTap: onSaveFlyer,
                          );
                        },
                      ),

                      /// SPACING
                      footerButtonSpacer!,

                    ],
                  ),
                ),

              ],
            ),
          );
        },
        child: FooterButtonSpacer(
            flyerBoxWidth: flyerBoxWidth,
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
