import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/g_flyer/c_flyer_reviews_screen/z_components/review_bubble/a_review_box.dart';
import 'package:bldrs/g_flyer/c_flyer_reviews_screen/z_components/review_bubble/review_bubble_box.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/bldrs_text_field/bldrs_text_field.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class ReviewCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewCreatorBubble({
    required this.globalKey,
    required this.pageWidth,
    required this.reviewTextController,
    required this.onReviewSubmit,
    required this.onReviewUserBalloonTap,
    required this.isUploading,
    super.key
  });
  /// --------------------------------------------------------------------------
  final GlobalKey globalKey;
  final double pageWidth;
  final TextEditingController reviewTextController;
  final ValueChanged<UserModel?>? onReviewUserBalloonTap;
  final Function onReviewSubmit;
  final ValueNotifier<bool> isUploading;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _textBubbleWidth = ReviewBox.getTextBubbleWidth(
      pageWidth: pageWidth,
    );
    // --------------------
    return ReviewBox(
        pageWidth: pageWidth,
        userID: Authing.getUserID(),
        onReviewUserBalloonTap: onReviewUserBalloonTap == null ?
          null
            :
            (UserModel? user) => onReviewUserBalloonTap?.call(user),
        builder: (UserModel? userModel){

          return ReviewBubbleBox(
            width: _textBubbleWidth,
            isSpecialReview: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// USER NAME
                BldrsText(
                  verse: Verse(
                    id: userModel?.name,
                    translate: false,
                  ),
                ),

                /// TEXT FIELD
                BldrsTextField(
                  appBarType: AppBarType.basic,
                  globalKey: globalKey,
                  // titleVerse: const Verse(
                  //   id: 'phid_edit_review',
                  //   translate: true,
                  // ),
                  width: _textBubbleWidth,
                  textController: reviewTextController,
                  maxLines: 5,
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  maxLength: 1000,
                  // minLines: 1,
                  textSize: 3,
                  margins: const EdgeInsets.all(5),
                  // onTap: onEditReview,
                  // autofocus: false,
                  autoCorrect: Keyboard.autoCorrectIsOn(),
                  enableSuggestions: Keyboard.suggestionsEnabled(),
                  onChanged: (String? x){blog(x);},
                ),

                /// SUBMIT BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    ValueListenableBuilder(
                        valueListenable: isUploading,
                        builder: (_, bool _isUploading, Widget? child){

                          return BldrsBox(
                            verse: const Verse(
                              id: 'phid_submit',
                              translate: true,
                              casing: Casing.upperCase,
                            ),
                            isDisabled: _isUploading,
                            icon: Iconz.share,
                            iconColor: Colorz.black255,
                            loading: _isUploading,
                            iconSizeFactor: 0.6,
                            height: 40,
                            color: Colorz.yellow255,
                            verseColor: Colorz.black255,
                            verseWeight: VerseWeight.black,
                            verseItalic: true,
                            onTap: onReviewSubmit,
                          );

                        },
                    ),

                  ],
                ),

                /// SPACER
                const SizedBox(
                  width: ReviewBox.spacer,
                  height: ReviewBox.spacer * 0.25,
                ),

              ],
            ),
          );

        },
    );
    // --------------------
  }

}
