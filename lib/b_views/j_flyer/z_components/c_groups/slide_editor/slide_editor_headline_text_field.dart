import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/xxx_slide_editor_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/e_slide_headline.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class EditorSlideHeadlineTextField extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EditorSlideHeadlineTextField({
    @required this.isTransforming,
    @required this.flyerBoxWidth,
    @required this.appBarType,
    @required this.globalKey,
    @required this.mounted,
    @required this.draftSlide,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<DraftSlide> draftSlide;
  final ValueNotifier<bool> isTransforming;
  final double flyerBoxWidth;
  final AppBarType appBarType;
  final GlobalKey globalKey;
  final bool mounted;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('EditorSlideHeadlineTextField'),
        valueListenable: isTransforming,
        builder: (_, bool transforming, Widget child){

          return AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeInOut,
            opacity: transforming == true ? 0.4 : 1,
            child: IgnorePointer(
              ignoring: transforming,
              child: Column(
                children: <Widget>[

                  Container(
                    width: flyerBoxWidth,
                    margin: EdgeInsets.only(
                        top: flyerBoxWidth * 0.3,
                        left: 5,
                        right: 5
                    ),
                    alignment: Alignment.topCenter,
                    child: SuperTextField(
                      appBarType: appBarType,
                      globalKey: globalKey,
                      titleVerse: const Verse(
                        text: 'phid_flyer_slide_headline',
                        translate: true,
                      ),
                      // key: ValueKey<String>('slide$slideIndex'),
                      hintVerse: const Verse(
                        text: 'phid_t_i_t_l_e',
                        translate: true,
                        pseudo: 'T i t l e',
                      ),
                      width: flyerBoxWidth,
                      // height: flyerBoxWidth * 0.15,
                      fieldColor: Colorz.black80,
                      maxLines: 4,
                      maxLength: 55,
                      // counterIsOn: true,
                      textSize: SlideHeadline.headlineSize,
                      textSizeFactor: flyerBoxWidth * SlideHeadline.headlineScaleFactor,
                      centered: true,
                      // autoValidate: true,
                      onChanged: (String text) => onSlideHeadlineChanged(
                        draftSlide: draftSlide,
                        text: text,
                        mounted: mounted,
                      ),
                      textWeight: VerseWeight.bold,
                      textShadow: true,
                      initialValue: draftSlide.value.headline,
                      // autofocus: false,
                      // fieldIsFormField: true,
                      // onSubmitted: null,
                      // keyboardTextInputAction: TextInputAction.done,
                    ),
                  ),

                ],
              ),
            ),
          );

        });

  }
  /// --------------------------------------------------------------------------
}
