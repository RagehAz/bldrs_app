import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/a_flyer_preview_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/small_flyer.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/future_model_builders/flyer_builder.dart';
import 'package:flutter/material.dart';

class FlyersShelfListBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const FlyersShelfListBuilder({
    required this.flyersIDs,
    required this.flyerBoxWidth,
    required this.gridWidth,
    required this.gridHeight,
    required this.shelfTitleVerse,
    this.lastSlideWidget,
    this.flyerOnTap,
    super.key
  });
  // --------------------
  final Verse? shelfTitleVerse;
  final List<String> flyersIDs;
  final double flyerBoxWidth;
  final double gridWidth;
  final double gridHeight;
  final Widget? lastSlideWidget;
  final Function(FlyerModel? flyerModel)? flyerOnTap;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Lister.checkCanLoop(flyersIDs) == true){

      return SizedBox(
        width: gridWidth,
        height: gridHeight,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: flyersIDs.length + 1,
          scrollDirection: Axis.horizontal,
          padding: Scale.superInsets(
            context: context,
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
            // enLeft: Ratioz.appBarMargin,
            enRight: flyerBoxWidth * 0.5,
          ),

          separatorBuilder: (BuildContext context, int _y) => const SizedBox(
            height: 1,
            width: Ratioz.appBarMargin,
          ),

          itemBuilder: (BuildContext context, int _x) {

            if (_x == flyersIDs.length){
              return lastSlideWidget ?? const SizedBox();
            }

            else {

              return FlyerBuilder(
                  flyerID: flyersIDs[_x],
                  flyerBoxWidth: flyerBoxWidth,
                  onlyFirstSlide: true,
                  slidePicType: SlidePicType.small,
                  renderFlyer: RenderFlyer.firstSlide,
                  builder: (bool loading, FlyerModel? flyerModel) {

                    if (loading == true){
                      return FlyerLoading(
                        flyerBoxWidth: flyerBoxWidth,
                        animate: true,
                      );
                    }

                    else {
                      return SmallFlyer(
                        flyerBoxWidth: flyerBoxWidth,
                        flyerModel: flyerModel,
                        showTopButton: true,
                        // canAnimateMatrix: true,
                        // flyerShadowIsOn: true,
                        // isRendering: false,
                        // slideShadowIsOn: true,
                        onTap: () async {

                          if (flyerOnTap == null){
                            await   FlyerPreviewScreen.openFlyer(
                              flyerModel: flyerModel,
                            );
                          }
                          else {
                            flyerOnTap!(flyerModel);
                          }

                        },
                      );
                    }

                  }
                  );
            }

            },

        ),
      );

    }

    else {
      return const SizedBox();
    }

  }
  // -----------------------------------------------------------------------------
}
