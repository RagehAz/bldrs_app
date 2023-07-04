import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class GalleryHeader extends StatelessWidget {
  // -----------------------------------------------------------------------
  const GalleryHeader({
    required this.flyerBoxWidth,
    required this.bzModel,
    required this.progressBarModel,
    required this.flyerModel,
    required this.showGallerySlide,
    super.key
  });
  //--------------------------------
  final double flyerBoxWidth;
  final BzModel? bzModel;
  final ValueNotifier<ProgressBarModel?> progressBarModel;
  final bool showGallerySlide;
  final FlyerModel? flyerModel;
  // -----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: progressBarModel,
      builder: (_, ProgressBarModel? progressBarModel, Widget? child){

        final bool _isAtGallerySlide = isAtGallerySlide(
          showGallerySlide: showGallerySlide,
          flyerModel: flyerModel,
          bzModel: bzModel,
          progressBarModel: progressBarModel,
        );

        if (_isAtGallerySlide == true){
          return child!;
        }

        else {
          return const SizedBox();
        }

      },
      child: WidgetFader(
        fadeType: FadeType.fadeIn,
        duration: const Duration(milliseconds: 250),
        builder: (double val, Widget? child) {
          return Transform.scale(
            alignment: Alignment.topCenter,
            scaleY: val,
            child: child,
          );
        },
        child: Container(
              width: flyerBoxWidth,
              height: FlyerDim.headerSlateHeight(flyerBoxWidth),
              decoration: BoxDecoration(
                color: Colorz.black255,
                borderRadius: FlyerDim.headerSlateCorners(
                  flyerBoxWidth: flyerBoxWidth,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  /// ANOTHER FLYERS BY
                  BldrsText(
                    width: flyerBoxWidth * 0.8,
                    // maxLines: 1,
                    verse: const Verse(
                      id: 'phid_another_flyers_by',
                      translate: true,
                    ),
                    // size: 2,
                    weight: VerseWeight.thin,
                    italic: true,
                    color: Colorz.yellow200,
                  ),

                  /// BZ NAME
                  BldrsText(
                    width: flyerBoxWidth * 0.8,
                    maxLines: 2,
                    verse: Verse.plain(
                      bzModel?.name ?? '',
                    ),
                    size: 3,
                    margin: 5,
                  ),

                ],
              ),
            ),
      ),
    );

  }
  // -----------------------------------------------------------------------
}
