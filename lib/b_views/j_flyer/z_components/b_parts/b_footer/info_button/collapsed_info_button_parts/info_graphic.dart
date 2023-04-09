import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/collapsed_info_button_parts/collapsed_info_button_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/z_components/images/bldrs_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';


class InfoGraphic extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoGraphic({
    @required this.flyerBoxWidth,
    @required this.buttonIsExpanded,
    @required this.tinyMode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final ValueNotifier<bool> buttonIsExpanded;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _size = FlyerDim.infoButtonHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      isExpanded: false,
      tinyMode: tinyMode,
    );
    // --------------------
    /*
//     final double _width = InfoButtonStarter.collapsedWidth(
//         context: context,
//         flyerBoxWidth: flyerBoxWidth
//     );
     */
    // --------------------
    return CollapsedInfoButtonBox(
      flyerBoxWidth: flyerBoxWidth,
      infoButtonType: InfoButtonType.info,
      tinyMode: tinyMode,
      horizontalListViewChildren: <Widget>[

        BldrsImage(
          pic: Iconz.info,
          width: _size,
          height: _size,
          scale: 0.4,
        ),

        // if (buttonIsExpanded.value  = true)
        ValueListenableBuilder(
            valueListenable: buttonIsExpanded,
            builder: (_, bool _buttonIsExpanded, Widget child){

              return AnimatedOpacity(
                opacity: _buttonIsExpanded ? 1 : 0,
                duration: const Duration(milliseconds: 100),
                child: const BldrsText(
                  verse: Verse(
                    id: 'phid_flyer_info',
                    translate: true,
                    casing: Casing.capitalizeFirstChar,
                  ),
                ),
              );

            }
        ),

      ],

      // child: Container(
      //   key: const ValueKey<String>('InfoGraphic'),
      //   // width: _size,
      //   // height: _size,
      //   alignment: Alignment.topLeft,
      //   child: SuperImage(
      //     pic: Iconz.info,
      //     width: _size,
      //     height: _size,
      //     scale: 0.4,
      //   ),
      // ),

    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
