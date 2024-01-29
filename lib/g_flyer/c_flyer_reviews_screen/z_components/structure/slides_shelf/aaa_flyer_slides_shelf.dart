import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/c_slides/a_single_slide.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class FlyerSlidesShelf extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerSlidesShelf({
    required this.flyerModel,
    required this.slidePicType,
    this.shelfHeight = 120,
    this.shelfWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final FlyerModel? flyerModel;
  final SlidePicType slidePicType;
  final double shelfHeight;
  final double? shelfWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = shelfWidth ?? Scale.screenWidth(context);
    final double _flyerBoxHeight = shelfHeight;
    final double _flyerBoxWidth = FlyerDim.flyerWidthByFlyerHeight(
      flyerBoxHeight: _flyerBoxHeight,
    );
    // --------------------
    return FloatingList(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      scrollDirection: Axis.horizontal,
      width: _screenWidth,
      height: shelfHeight,
      mainAxisAlignment: MainAxisAlignment.center,
      columnChildren: <Widget>[

        if (Lister.checkCanLoop(flyerModel?.slides) == true)
          ...List.generate(flyerModel!.slides!.length, (index){

            return Container(
              margin: Scale.superInsets(
                context: context,
                appIsLTR: UiProvider.checkAppIsLeftToRight(),
                enRight: 5,
              ),
              alignment: Alignment.center,
              child: SingleSlide(
                flyerBoxWidth: _flyerBoxWidth,
                flyerBoxHeight: _flyerBoxHeight,
                slideModel: flyerModel!.slides![index],
                slidePicType: slidePicType,
                loading: false,
                tinyMode: false,
                onSlideNextTap: null,
                onSlideBackTap: null,
                onDoubleTap: null,
                canTapSlide: false,
                // canAnimateMatrix: true,
                slideShadowIsOn: true,
                canPinch: false,
              ),
            );

          }),
      ],
    );

    // return SingleChildScrollView(
    //   physics: const BouncingScrollPhysics(),
    //   scrollDirection: Axis.horizontal,
    //   child: Container(
    //     height: shelfHeight,
    //     constraints: BoxConstraints(
    //       minWidth: _screenWidth + 10,
    //     ),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //
    //         if (Lister.checkCanLoop(flyerModel?.slides) == true)
    //         ...List.generate(flyerModel!.slides!.length, (index){
    //
    //           return Container(
    //             margin: Scale.superInsets(
    //               context: context,
    //               appIsLTR: UiProvider.checkAppIsLeftToRight(),
    //               enRight: 5,
    //             ),
    //             alignment: Alignment.center,
    //             child: SingleSlide(
    //               flyerBoxWidth: _flyerBoxWidth,
    //               flyerBoxHeight: _flyerBoxHeight,
    //               slideModel: flyerModel!.slides![index],
    //               tinyMode: false,
    //               onSlideNextTap: null,
    //               onSlideBackTap: null,
    //               onDoubleTap: null,
    //               canTapSlide: false,
    //               // canAnimateMatrix: true,
    //               slideShadowIsOn: true,
    //               blurLayerIsOn: true,
    //               canUseFilter: false,
    //               canPinch: false,
    //             ),
    //           );
    //
    //         }),
    //
    //
    //       ],
    //     ),
    //   ),
    // );
  }
/// --------------------------------------------------------------------------
}
