import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/slide_editor_screen/z_components/buttons/slide_editor_button.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/slide_editor_screen/z_components/control_panels/slide_editor_main_control_panel.dart';
import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';
import 'package:basics/components/super_image/super_image.dart';

class FiltersSelectorControlPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FiltersSelectorControlPanel({
    required this.height,
    required this.onSelectFilter,
    required this.onBack,
    required this.slide,
    required this.opacity,
    required this.onOpacityChanged,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double height;
  final ValueChanged<ImageFilterModel?> onSelectFilter;
  final Function onBack;
  final ValueNotifier<DraftSlide> slide;
  final ValueNotifier<double> opacity;
  final Function onOpacityChanged;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _controlPanelHeight = height;
    // --------------------
    final double _sliderZoneHeight = _controlPanelHeight * 0.15;
    final double _buttonsZoneHeight = _controlPanelHeight - _sliderZoneHeight;
    // --------------------
    final double _buttonSize = SlideEditorMainControlPanel.getButtonSize(_buttonsZoneHeight);
    final double _boxHeight = SlideEditorButton.getBoxHeight(buttonSize: _buttonSize);
    final double _boxWidth = FlyerDim.flyerWidthByFlyerHeight(
      flyerBoxHeight: _boxHeight,
    );
    // --------------------
    return SizedBox(
      width: _screenWidth,
      height: _controlPanelHeight,
      // color: Colorz.white10,
      child: Column(
        children: <Widget>[

          SizedBox(
            width: _screenWidth,
            height: _sliderZoneHeight,
            child: ValueListenableBuilder(
              valueListenable: opacity,
              builder: (_, double _opacity, Widget? child){

                return Slider(
                  activeColor: Colorz.yellow255,
                  inactiveColor: Colorz.white20,
                  divisions: 100,
                  value: _opacity,
                  onChanged: (value) => onOpacityChanged(value),
                );

              },
            ),
          ),

          SizedBox(
            width: _screenWidth,
            height: _buttonsZoneHeight,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: presetFiltersList.length + 1,
              // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
              itemBuilder: (_, i){

                final int index = i - 1;
                final bool isBackButton = i == 0;

                final ImageFilterModel? _filter = isBackButton ? null : presetFiltersList[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                  child: GestureDetector(
                    onTap: () => onSelectFilter(_filter),
                    child: FlyerBox(
                      flyerBoxWidth: _boxWidth,
                      stackWidgets: <Widget>[

                        if (isBackButton == true)
                          Center(
                            child: BldrsBox(
                              width: _boxWidth,
                              height: _boxWidth,
                              icon: Iconizer.superBackIcon(context),
                              bubble: false,
                              onTap: onBack,
                              iconSizeFactor: 0.6,
                            ),
                          ),

                        if (isBackButton == false)
                          ValueListenableBuilder(
                              valueListenable: slide,
                              builder: (_, DraftSlide _slide, Widget? child){

                                return SuperFilteredImage(
                                  filterModel: _filter,
                                  width: _boxWidth,
                                  height: _boxHeight,
                                  pic: _slide.bigPic?.bytes,
                                  loading: false,
                                  // boxFit: BoxFit.cover,
                                );

                              }),

                        if (isBackButton == false)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: BldrsText(
                              verse: Verse(
                                id: _filter?.id,
                                translate: true,
                              ),
                              maxLines: 2,
                            ),
                          ),

                      ],
                    ),
                  ),
                );

              },

            ),
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
