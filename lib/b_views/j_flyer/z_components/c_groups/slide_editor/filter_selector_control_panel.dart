import 'package:bldrs/a_models/f_flyer/mutables/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_control_panel.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/preset_filters.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FiltersSelectorControlPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FiltersSelectorControlPanel({
    @required this.height,
    @required this.onSelectFilter,
    @required this.onBack,
    @required this.slide,
    @required this.opacity,
    @required this.onOpacityChanged,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double height;
  final ValueChanged<ImageFilterModel> onSelectFilter;
  final Function onBack;
  final ValueNotifier<DraftSlide> slide;
  final ValueNotifier<double> opacity;
  final Function onOpacityChanged;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _controlPanelHeight = height;
    // --------------------
    final double _sliderZoneHeight = _controlPanelHeight * 0.15;
    final double _buttonsZoneHeight = _controlPanelHeight - _sliderZoneHeight;
    // --------------------
    final double _buttonSize = SlideEditorControlPanel.getButtonSize(context, _buttonsZoneHeight);
    final double _boxHeight = SlideEditorButton.getBoxHeight(buttonSize: _buttonSize);
    final double _boxWidth = FlyerDim.flyerWidthByFlyerHeight(_boxHeight);
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
              builder: (_, double _opacity, Widget child){

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

                final ImageFilterModel _filter = isBackButton ? null : presetFiltersList[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
                  child: GestureDetector(
                    onTap: () => onSelectFilter(_filter),
                    child: FlyerBox(
                      flyerBoxWidth: _boxWidth,
                      stackWidgets: <Widget>[

                        if (isBackButton == true)
                          Center(
                            child: DreamBox(
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
                              builder: (_, DraftSlide _slide, Widget child){

                                return SuperFilteredImage(
                                  filterModel: _filter,
                                  width: _boxWidth,
                                  height: _boxHeight,
                                  bytes: _slide.picModel.bytes,
                                  // boxFit: BoxFit.cover,
                                );

                              }),

                        if (isBackButton == false)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SuperVerse(
                              verse: Verse(
                                text: _filter.id,
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
