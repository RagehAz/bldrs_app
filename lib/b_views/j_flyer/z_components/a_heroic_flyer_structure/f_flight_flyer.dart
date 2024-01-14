import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/components/drawing/super_positioned.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/top_button/top_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/static_flyer/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightFlyer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlightFlyer({
    required this.renderedFlyer,
    required this.flyerBoxWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel? renderedFlyer;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BorderRadius flyerBorders = FlyerDim.flyerCorners(flyerBoxWidth);
    final double flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
    );
    final List<SlideModel> _slides = renderedFlyer?.slides ?? <SlideModel>[];
    final SlideModel? slideModel = Lister.checkCanLoop(_slides) == true ? _slides.first : null;
    final double aspectRatio = FlyerDim.flyerAspectRatio();
    final EdgeInsets _saveButtonPadding = FlyerDim.footerButtonEnRightMargin(
      buttonNumber: 1,
      flightTweenValue: 1,
      flyerBoxWidth: flyerBoxWidth,
    );

    return Material(
      key: const ValueKey<String>('FlightFlyer_xxx'),
      borderRadius: flyerBorders,
      type: MaterialType.transparency,
      child: Center(
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Container(
            width: flyerBoxWidth,
            height: flyerBoxHeight,
            alignment: Alignment.center,
            // decoration: BoxDecoration(
            //   borderRadius: flyerBorders,
            // ),
            child: ClipRRect(
              borderRadius: flyerBorders,
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[

                  /// SLIDE
                  SingleSlide(
                    flyerBoxWidth: flyerBoxWidth,
                    flyerBoxHeight: flyerBoxHeight,
                    slideModel: slideModel,
                    slidePicType: SlidePicType.small,
                    loading: false,
                    tinyMode: false,
                    onSlideNextTap: null,
                    onSlideBackTap: null,
                    onDoubleTap: null,
                    canTapSlide: false,
                    slideShadowIsOn: false,
                    // canAnimateMatrix: canAnimateMatrix,
                    canPinch: false,
                  ),

                  /// STATIC HEADER
                  StaticHeader(
                    flyerBoxWidth: flyerBoxWidth,
                    bzModel: renderedFlyer?.bzModel,
                    bzImageLogo: renderedFlyer?.bzLogoImage,
                    authorID: renderedFlyer?.authorID,
                    flyerShowsAuthor: renderedFlyer?.showsAuthor,
                  ),

                  /// STATIC FOOTER
                  SuperPositioned(
                    key: const ValueKey<String>('flight_footer'),
                    appIsLTR: UiProvider.checkAppIsLeftToRight(),
                    enAlignment: Alignment.bottomRight,
                    horizontalOffset: _saveButtonPadding.right,
                    verticalOffset: _saveButtonPadding.bottom,
                    child: Selector<UsersProvider, UserModel?>(
                      selector: (_, UsersProvider userProvider) => userProvider.myUserModel,
                      builder: (_, UserModel? userModel, Widget? child) {

                        final bool _isOn = UserModel.checkFlyerIsSaved(
                            userModel: userModel,
                            flyerID: renderedFlyer?.id,
                          );

                        if (_isOn == false){
                          return const SizedBox();
                        }
                        else {
                          return FooterButton(
                            flyerBoxWidth: flyerBoxWidth,
                            icon: Iconz.loveBlack,
                            phid: 'phid_save',
                            isOn: true,
                            onTap: null,
                            count: null,
                            canTap: false,
                          );
                        }



                        },
                    ),
                  ),

                  /// AFFILIATE BUTTON
                  TopButton(
                    flyerBoxWidth: flyerBoxWidth,
                    flyerModel: renderedFlyer,
                    inStack: true,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
