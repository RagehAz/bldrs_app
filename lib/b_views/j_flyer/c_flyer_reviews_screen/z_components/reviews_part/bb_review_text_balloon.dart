import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/b_review_bubble.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/bba_review_bubble_balloon.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/bbb_reply_bubble.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/c_review_text_column.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/d_review_bubble_button.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/paginator_notifiers.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/a_super_text_field.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/x_reviews_controller.dart';
import 'package:bldrs/c_protocols/review_protocols/a_reviews_protocols.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class ReviewTextBalloon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewTextBalloon({
    @required this.isCreatorMode,
    @required this.userModel,
    @required this.reviewModel,
    @required this.pageWidth,
    @required this.flyerModel,
    @required this.reviewTextController,
    @required this.paginatorNotifiers,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isCreatorMode;
  final UserModel userModel;
  final ReviewModel reviewModel;
  final double pageWidth;
  final TextEditingController reviewTextController;
  final FlyerModel flyerModel;
  final PaginatorNotifiers paginatorNotifiers;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _imReviewCreator = reviewModel?.userID == AuthFireOps.superUserID();

    final bool _imAuthorInFlyerBz = AuthorModel.checkImAuthorInBzOfThisFlyer(
      context: context,
      flyerModel: flyerModel,
    );

    final double _textBubbleWidth = ReviewBubble.getTextBubbleWidth(
        pageWidth: pageWidth,
    );

    final double _clearWidth = ReviewBubbleBox.clearWidth(
        balloonWidth: _textBubbleWidth,
    );

    return Column(
      children: <Widget>[

        /// REVIEW TEXT
        ReviewBubbleBox(
          width: _textBubbleWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              ReviewTextsColumn(
                name: userModel?.name,
                timeStamp: reviewModel?.time,
                text: reviewModel?.text,
                isCreatorMode: isCreatorMode,
              ),

              /// TEXT FIELD
              if (isCreatorMode == true)
                  SuperTextField(
                    titleVerse: '##Edit Review',
                    width: _textBubbleWidth,
                    textController: reviewTextController,
                    maxLines: 8,
                    textInputType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLength: 1000,
                    minLines: 4,
                    textSize: 3,
                    margins: const EdgeInsets.all(5),
                    // onTap: onEditReview,
                    // autofocus: false,
                    onChanged: (String x){blog(x);},
                  ),

              /// SUBMIT BUTTON
              if (isCreatorMode == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    DreamBox(
                      verse: '##SUBMIT',
                      height: 40,
                      color: Colorz.yellow255,
                      verseColor: Colorz.black255,
                      verseScaleFactor: 0.6,
                      verseWeight: VerseWeight.black,
                      verseItalic: true,
                      onTap: () => onSubmitReview(
                        context: context,
                        textController: reviewTextController,
                        flyerModel: flyerModel,
                        addMap: paginatorNotifiers.addMap,
                      ),
                    ),

                  ],
                ),

              /// SEPARATOR LINE
              if (isCreatorMode == false)
                SeparatorLine(
                  width: _clearWidth,
                  color: Colorz.white50,
                ),

              /// ( REPLY - AGREE ) BUTTONS
              if (isCreatorMode == false)
                SizedBox(
                  width: _clearWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      /// MORE BUTTON
                      if (_imReviewCreator == true)
                      ReviewBubbleButton(
                        count: null,
                        isOn: false,
                        verse: null,
                        icon: Iconz.more,
                        onTap: () => onReviewOptions(
                          context: context,
                          reviewModel: reviewModel,
                          deleteMapNotifier: paginatorNotifiers.deleteMap,
                          replaceMapNotifier: paginatorNotifiers.replaceMap,
                          bzID: flyerModel.bzID,
                        ),
                      ),

                      /// EXPANDER
                      if (_imReviewCreator == true)
                      const Expander(),

                      /// REPLY
                      if (_imAuthorInFlyerBz == true)
                        ReviewBubbleButton(
                          icon: Iconz.utPlanning,
                          verse: '##Reply',
                          count: null,
                          isOn: false,
                          onTap: () => onBzReply(
                            context: context,
                            reviewModel: reviewModel,
                            replaceMapNotifier: paginatorNotifiers.replaceMap,
                          ),
                        ),

                      /// SPACER
                      if (_imAuthorInFlyerBz == true)
                        const SizedBox(width: ReviewBubble.spacer,),

                      /// LIKE
                      FutureBuilder<bool>(
                          future: ReviewProtocols.fetchIsAgreed(
                            context: context,
                            reviewID: reviewModel.id,
                          ),
                          builder: (_, AsyncSnapshot<Object> snapshot){

                            final bool _isAlreadyAgreed = snapshot.data;

                            return ReviewBubbleButton(
                              icon: Iconz.sexyStar,
                              count: reviewModel.agrees,
                              isOn: _isAlreadyAgreed,
                              verse: _isAlreadyAgreed == true ? 'Agreed' : 'Agree',
                              onTap: () => onReviewAgree(
                                isAlreadyAgreed: _isAlreadyAgreed,
                                context: context,
                                reviewModel: reviewModel,
                                replaceMap: paginatorNotifiers.replaceMap,
                              ),
                            );

                          }
                          ),

                    ],
                  ),
                ),

            ],
          ),
        ),

        /// SPACER
        const SizedBox(
          width: ReviewBubble.spacer,
          height: ReviewBubble.spacer * 0.5,
        ),

        /// BZ REPLY BUBBLE
        if (isCreatorMode == false && Stringer.checkStringIsNotEmpty(reviewModel?.reply) == true)
        BzReplyBubble(
          boxWidth: _textBubbleWidth,
          reviewModel: reviewModel,
          paginatorNotifiers: paginatorNotifiers,
          flyerModel: flyerModel,
        ),

      ],
    );
  }
}
