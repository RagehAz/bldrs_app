import 'package:basics/components/animators/widget_waiter.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/components/animators/widget_fader.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:flutter/material.dart';

class ImageFilterAnimatedName extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ImageFilterAnimatedName({
    required this.filterModel,
    required this.flyerBoxWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<ImageFilterModel> filterModel;
  final double flyerBoxWidth;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        key: const ValueKey<String>('ImageFilterAnimatedName'),
        valueListenable: filterModel,
        builder: (_, ImageFilterModel _filterModel, Widget? child){

          return WidgetWaiter(
            child: WidgetFader(
              fadeType: FadeType.fadeOut,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: FlyerDim.footerBoxHeight(
                        flyerBoxWidth: flyerBoxWidth,
                        infoButtonExpanded: false,
                        showTopButton: false,
                      )
                  ),
                  child: BldrsText(
                    verse: Verse(
                      id: _filterModel.id,
                      casing: Casing.upperCase,
                      translate: true,
                    ),
                    maxLines: 3,
                    weight: VerseWeight.black,
                    italic: true,
                    size: 4,
                    // shadow: true,
                    color: Colorz.white200,
                    scaleFactor: flyerBoxWidth * 0.005,
                  ),
                ),
              ),
            ),
          );

        }
    );

  }
/// --------------------------------------------------------------------------
}
