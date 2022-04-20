import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_button.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_control_panel.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/preset_filters.dart';
import 'package:bldrs/b_views/z_components/images/unfinished_super_image.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

import '../../buttons/dream_box/dream_box.dart';

class FiltersSelectorControlPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FiltersSelectorControlPanel({
    @required this.height,
    @required this.onSelectFilter,
    @required this.onBack,
    @required this.slide,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double height;
  final ValueChanged<ColorFilterModel> onSelectFilter;
  final Function onBack;
  final ValueNotifier<MutableSlide> slide;
  /// --------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _controlPanelHeight = height;
    final double _buttonSize = SlideEditorControlPanel.getButtonSize(context, _controlPanelHeight);
    final double _boxHeight = SlideEditorButton.getBoxHeight(buttonSize: _buttonSize);
    final double _boxWidth = FlyerBox.widthByHeight(context, _boxHeight);


    return SizedBox(
      width: _screenWidth,
      height: _controlPanelHeight,
      // color: Colorz.white10,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: presetFiltersList.length,
        itemBuilder: (_, index){

          final ColorFilterModel _filter = presetFiltersList[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
            child: GestureDetector(
              onTap: () => onSelectFilter(_filter),
              child: FlyerBox(
                flyerBoxWidth: _boxWidth,
                stackWidgets: <Widget>[

                  ValueListenableBuilder(
                      valueListenable: slide,
                      builder: (_, MutableSlide _slide, Widget child){

                        return SuperImage(
                          width: _boxWidth,
                          height: _boxHeight,
                          fit: BoxFit.cover,
                          pic: _slide.picFile,
                        );

                      }),



                Align(
                  alignment: Alignment.bottomCenter,
                  child: SuperVerse(
                    verse: _filter.name,
                    maxLines: 2,
                  ),
                ),

                ],
              ),
            ),
          );

        },

      ),
    );
  }
}
