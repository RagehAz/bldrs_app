import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ImageFilterAnimatedName extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ImageFilterAnimatedName({
    @required this.filterModel,
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<ImageFilterModel> filterModel; /// p
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
                    bottom: FooterBox.collapsedHeight(
                      context: context,
                      flyerBoxWidth: flyerBoxWidth,
                      tinyMode: false,
                    )
                ),
                child: SuperVerse(
                  verse: xPhrase(context, _filterModel.id).toUpperCase(),
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

}
