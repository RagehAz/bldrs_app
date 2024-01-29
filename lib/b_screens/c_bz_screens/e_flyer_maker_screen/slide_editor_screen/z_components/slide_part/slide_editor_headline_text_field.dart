import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/c_slides/components/e_slide_headline.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/bldrs_text_field/bldrs_text_field.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:flutter/material.dart';

class EditorSlideHeadlineTextField extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EditorSlideHeadlineTextField({
    required this.isTransforming,
    required this.flyerBoxWidth,
    required this.appBarType,
    required this.globalKey,
    required this.draftSlide,
    required this.onSlideHeadlineChanged,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<DraftSlide?> draftSlide;
  final ValueNotifier<bool> isTransforming;
  final double flyerBoxWidth;
  final AppBarType appBarType;
  final GlobalKey globalKey;
  final Function(String? text) onSlideHeadlineChanged;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('EditorSlideHeadlineTextField'),
        valueListenable: isTransforming,
        builder: (_, bool transforming, Widget? child){

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
                    child: BldrsTextField(
                      appBarType: appBarType,
                      globalKey: globalKey,
                      // titleVerse: const Verse(
                      //   id: 'phid_flyer_slide_headline',
                      //   translate: true,
                      // ),
                      hintVerse: const Verse(
                        id: 'phid_t_i_t_l_e',
                        translate: true,
                      ),
                      width: flyerBoxWidth,
                      // height: flyerBoxWidth * 0.15,
                      fieldColor: Colorz.black80,
                      maxLines: 4,
                      maxLength: 55,
                      // counterIsOn: true,
                      // textSize: SlideHeadline.headlineSize,
                      textScaleFactor: flyerBoxWidth * SlideHeadline.headlineScaleFactor * 1.3,
                      centered: true,
                      onChanged: onSlideHeadlineChanged,
                      textWeight: VerseWeight.bold,
                      initialValue: draftSlide.value?.headline,
                      autoCorrect: Keyboard.autoCorrectIsOn(),
                      enableSuggestions: Keyboard.suggestionsEnabled(),

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
