import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/balloons/user_balloon.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/a_review_button_structure/a_review_page_starter.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timerz;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditableReviewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EditableReviewBubble({
    @required this.pageWidth,
    @required this.flyerBoxWidth,
    @required this.pageHeight,
    @required this.isEditingReview,
    @required this.onEditReview,
    @required this.onSubmitReview,
    @required this.reviewTextController,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double flyerBoxWidth;
  final double pageHeight;
  final ValueNotifier<bool> isEditingReview;
  final Function onEditReview;
  final Function onSubmitReview;
  final TextEditingController reviewTextController;
  /// --------------------------------------------------------------------------
  static double bubbleMarginValue(){
    return Ratioz.appBarMargin;
  }
// -----------------------------------------------------------------------------
  static double reviewBubbleCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _expandedPageCornerValue = ReviewPageStarter.expandedCornerValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );

    final double _reviewPageMargin = bubbleMarginValue();
    final double _reviewBubbleCornerValue = _expandedPageCornerValue - _reviewPageMargin;
    return _reviewBubbleCornerValue;
  }
// -----------------------------------------------------------------------------
  static BorderRadius reviewBubbleBorders({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){
    final double _reviewBubbleCornerValue = reviewBubbleCornerValue(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
    return Borderers.superBorderAll(context, _reviewBubbleCornerValue);
  }
// -----------------------------------------------------------------------------
  static double height({
    @required double pageHeight,
    @required double flyerBoxWidth,
}){
    final double _editableReviewBubbleHeight = pageHeight - (flyerBoxWidth * 0.7);
    return _editableReviewBubbleHeight;
}
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _usersProvider.myUserModel;

    final double _imageBoxWidth = FooterButton.buttonSize(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: false
    );

    final double _reviewBoxWidth = pageWidth - _imageBoxWidth;

    final BorderRadius _reviewBubbleBorders = reviewBubbleBorders(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _bubbleMargin = bubbleMarginValue();

    final DateTime _reviewTime = Timerz.createDate(year: 1987, month: 6, day: 10);

    final double _editableReviewBubbleHeight = height(
      flyerBoxWidth: flyerBoxWidth,
      pageHeight: pageHeight,
    );

    final double _reviewBalloonWidth = _reviewBoxWidth - _bubbleMargin;

    return ValueListenableBuilder<bool>(
        valueListenable: isEditingReview,
        builder: (_, bool _isEditingReview, Widget child){

          blog('BUILDING EDITABLE REVIEW BUBBLE _isEditingReview : $_isEditingReview');

          return AnimatedContainer(
            key: const ValueKey<String>('review_bubble_key'),
            width: pageWidth,
            height: _isEditingReview ? _editableReviewBubbleHeight : 100,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            // margin: EdgeInsets.only(bottom: _bubbleMargin, top: _bubbleMargin),
            color: Colorz.blackSemi255,
            padding: EdgeInsets.only(bottom: _bubbleMargin, top: _bubbleMargin),
            child: Row(

              children: <Widget>[

                /// USER IMAGE BALLOON PART
                Container(
                  width: _imageBoxWidth,
                  alignment: Alignment.topCenter,
                  child: UserBalloon(
                    userModel: _myUserModel,
                    balloonWidth: _imageBoxWidth - (_bubbleMargin * 2),
                    loading: false,
                    onTap: (){blog('tapping user balloon in reviews');},
                    // balloonColor: ,
                    balloonType: UserStatus.planning,
                    shadowIsOn: false,
                  ),
                ),

                /// REVIEW BALLOON PART
                GestureDetector(
                  onTap: _isEditingReview ? null : onEditReview,
                  child: Container(
                    width: _reviewBalloonWidth,
                    // margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colorz.white20,
                      borderRadius: _reviewBubbleBorders,
                    ),
                    padding: EdgeInsets.all(_bubbleMargin),
                    alignment: superTopAlignment(context),
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      padding: EdgeInsets.zero,
                      children: <Widget>[

                        SuperVerse(
                          verse: _myUserModel.name,
                          centered: false,
                        ),

                        if (_isEditingReview == false)
                        const SuperVerse(
                          verse: 'Add your review',
                          margin: 5,
                          weight: VerseWeight.thin,
                          color: Colorz.white125,
                        ),

                        // SuperVerse(
                        //   verse: Timerz.getSuperTimeDifferenceString(
                        //     from: _reviewTime,
                        //     to: DateTime.now(),
                        //   ),
                        //   weight: VerseWeight.thin,
                        //   italic: true,
                        //   color: Colorz.white200,
                        //   scaleFactor: 0.9,
                        // ),

                        if (_isEditingReview == true)
                        SuperTextField(
                          height: _editableReviewBubbleHeight - 20,
                          width: _reviewBalloonWidth,
                          textController: reviewTextController,
                          maxLines: 4,
                          keyboardTextInputType: TextInputType.multiline,
                          counterIsOn: false,
                          maxLength: 1000,
                          minLines: 4,
                          inputSize: 3,
                          margin: const EdgeInsets.all(5),
                          onTap: onEditReview,
                          autofocus: true,
                        ),

                        if (_isEditingReview == true)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                              DreamBox(
                                height: 40,
                                verse: 'CANCEL',
                                verseScaleFactor: 0.8,
                                onTap: onEditReview,
                              ),

                              DreamBox(
                                verse: 'SUBMIT',
                                height: 40,
                                color: Colorz.yellow255,
                                verseColor: Colorz.black255,
                                verseScaleFactor: 0.8,
                                onTap: onSubmitReview,
                              ),

                            ],
                          ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          );

        }
    );
  }
}
