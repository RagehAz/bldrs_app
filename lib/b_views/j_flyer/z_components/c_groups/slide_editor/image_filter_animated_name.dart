import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class ImageFilterAnimatedName extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ImageFilterAnimatedName({
    @required this.filterModel,
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<ImageFilterModel> filterModel;
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        key: const ValueKey<String>('ImageFilterAnimatedName'),
        valueListenable: filterModel,
        builder: (_, ImageFilterModel _filterModel, Widget child){

          return WidgetFader(
            fadeType: FadeType.fadeOut,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: FlyerDim.footerBoxHeight(
                      context: context,
                      flyerBoxWidth: flyerBoxWidth,
                      infoButtonExpanded: false,
                    )
                ),
                child: SuperVerse(
                  verse: Verse(
                    text: _filterModel.id,
                    casing: Casing.upperCase,
                    translate: true,
                  ),
                  maxLines: 3,
                  weight: VerseWeight.black,
                  italic: true,
                  size: 4,
                  shadow: true,
                  color: Colorz.black255,
                  scaleFactor: flyerBoxWidth * 0.005,
                ),
              ),
            ),
          );

        }
    );

  }
/// --------------------------------------------------------------------------
}
