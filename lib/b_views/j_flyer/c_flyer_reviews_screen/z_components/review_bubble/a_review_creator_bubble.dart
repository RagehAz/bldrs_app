import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/review_bubble/a_review_box.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/review_bubble/review_bubble_box.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class ReviewCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewCreatorBubble({
    @required this.globalKey,
    @required this.pageWidth,
    @required this.reviewTextController,
    @required this.onReviewSubmit,
    @required this.onReviewUserBalloonTap,
    @required this.isUploading,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final GlobalKey globalKey;
  final double pageWidth;
  final TextEditingController reviewTextController;
  final ValueChanged<UserModel> onReviewUserBalloonTap;
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
        userID: AuthFireOps.superUserID(),
        onReviewUserBalloonTap: onReviewUserBalloonTap,
        builder: (UserModel userModel){

          return ReviewBubbleBox(
            width: _textBubbleWidth,
            isSpecialReview: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// USER NAME
                SuperVerse(
                  verse: Verse(
                    text: userModel?.name,
                    translate: false,
                  ),
                ),

                /// TEXT FIELD
                SuperTextField(
                  appBarType: AppBarType.basic,
                  globalKey: globalKey,
                  titleVerse: const Verse(
                    text: 'phid_edit_review',
                    translate: true,
                  ),
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
                  onChanged: (String x){blog(x);},
                ),

                /// SUBMIT BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    ValueListenableBuilder(
                        valueListenable: isUploading,
                        builder: (_, bool _isUploading, Widget child){

                          return DreamBox(
                            verse: const Verse(
                              text: 'phid_submit',
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
