import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/b_expanded_review_page_contents/c_review_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_button.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuestionReplyButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionReplyButtons({
    @required this.questionModel,
    @required this.askerUserModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final QuestionModel questionModel;
  final UserModel askerUserModel;
  /// --------------------------------------------------------------------------
  static const double buttonHeight = 40;
  static const double middleSpacerWidth = 5;
// -----------------------------------------------------------------------------
  static double getButtonWidth(BuildContext context){
    final double _bubbleClearWidth = Bubble.clearWidth(context);
    const int _numberOfButtons = 3;
    const int _numberOfSpacers = _numberOfButtons - 1;
    const double _spacerWidth = 5;
    final double _buttonWidth = (_bubbleClearWidth - (_spacerWidth * _numberOfSpacers)) / _numberOfButtons;
    return _buttonWidth;
  }
// -----------------------------------------------------------------------------
  Future<void> onReplyTap() async {
    blog('tapping on question reply');
  }
// -----------------------------------------------------------------------------
  Future<void> onNiceTap() async {
    blog('tapping on nice question');
  }
// -----------------------------------------------------------------------------
  Future<void> onRedirectTap(BuildContext context) async {
    blog('tapping on redirect question');

    final double _dialogHeight = superScreenHeight(context) * 0.75;
    final String _bzTypeString = BzModel.translateBzType(
      context: context,
      bzType: questionModel.directedTo,
    );

    final String _askerName = askerUserModel.name;

    final List<BzType> _restBzTypes = BzModel.getBzTypesListWithoutOneType(questionModel.directedTo);

    await BottomDialog.showBottomDialog(
        context: context,
        draggable: true,
        height: _dialogHeight,
        child: SizedBox(
          width: BottomDialog.clearWidth(context),
          height: BottomDialog.clearHeight(context: context, draggable: true, overridingDialogHeight: _dialogHeight),
          child: Column(
            children: <Widget>[

              const SuperVerse(
                verse: 'Redirect Question to',
                margin: 10,
                size: 3,
              ),

              /// NOTE
              SuperVerse(
                verse: 'You can suggest to $_askerName to redirect this question to other types of businesses instead of $_bzTypeString',
                maxLines: 3,
                // size: 2,
                weight: VerseWeight.thin,
                margin: 5,
              ),

              /// BZ TYPES BUTTONS
              ...List.generate(_restBzTypes.length, (index){

                final BzType _bzType = _restBzTypes[index];

                return
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: BottomDialog.wideButton(
                        context: context,
                        icon: Iconizer.bzTypeIconOff(_bzType),
                        verse: BzModel.translateBzType(
                          context: context,
                          bzType: _bzType,
                        ),
                        onTap: () => onChooseBzTypeToRedirectTo(
                          context: context,
                          bzType: _bzType,
                        ),
                      ),
                    );

              }),

            ],
          ),
        ),
    );

  }
// -----------------------------------------------------------------------------
  Future<void> onChooseBzTypeToRedirectTo({
    @required BuildContext context ,
    @required BzType bzType
  }) async {

    blog('bzType : $bzType has been chosen');

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _usersProvider.myUserModel;

    /// CLOSE PREVIOUS DIALOG
    Nav.goBack(context);

    final String _bzTypeString = BzModel.translateBzType(
        context: context,
        bzType: bzType,
    );

    final double _dialogClearWidth = BottomDialog.clearWidth(context);
    final double _overridingHeight = _dialogClearWidth * 0.7;
    final double _dialogClearHeight = BottomDialog.clearHeight(
        context: context,
        draggable: true,
        overridingDialogHeight: _overridingHeight,
    );

    final double _userImageBoxWidth = FooterButton.buttonSize(
        context: context,
        flyerBoxWidth: _dialogClearWidth,
        tinyMode: false
    );

    await BottomDialog.showBottomDialog(
        context: context,
        draggable: true,
        height: _overridingHeight,
        child: SizedBox(
          width: _dialogClearWidth,
          height: _dialogClearHeight,
          child: Column(
            children: <Widget>[

              /// PADDING
              const SizedBox(
                width: 10,
                height: 10,
              ),

              /// REVIEW BUBBLE
              ReviewBubble(
                userModel: _myUserModel,
                flyerBoxWidth: BottomDialog.clearWidth(context),
                pageWidth: BottomDialog.clearWidth(context),
                reviewText: '"This question should be directed to the $_bzTypeString instead"',
                reviewTimeStamp: DateTime.now(),
                specialReview: true,
              ),

              /// CONFIRM AND CANCEL BUTTONS
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  /// FAKE SPACE UNDER USER IMAGE
                  SizedBox(
                    width: _userImageBoxWidth,
                    height: 40,
                  ),

                  /// CANCEL BUTTON
                  DreamBox(
                    height: 40,
                    width: 100,
                    verse: 'Cancel',
                    verseScaleFactor: 0.8,
                    verseWeight: VerseWeight.thin,
                    onTap: (){Nav.goBack(context);},
                  ),

                  /// EXPANDER
                  const Expander(),

                  /// POST BUTTON
                  DreamBox(
                    height: 40,
                    width: 100,
                    verse: 'Post',
                    verseWeight: VerseWeight.thin,
                    verseScaleFactor: 0.8,
                    margins: 10,
                    onTap: () => onConfirmRedirectQuestionTo(
                      context: context,
                      bzType: bzType,
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),
    );

  }
// -----------------------------------------------------------------------------
  Future<void> onConfirmRedirectQuestionTo({
    @required BuildContext context,
    @required BzType bzType,
  }) async {
    blog('CONFIRMING DIRECTING THE QUESTION TO $bzType');

    Nav.goBack(context);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleClearWidth = Bubble.clearWidth(context);
    final double _buttonWidth = QuestionReplyButtons.getButtonWidth(context);

    return SizedBox(
      width: _bubbleClearWidth,
      height: QuestionReplyButtons.buttonHeight,
      child: Row(
        children: <Widget>[

          QuestionButton(
            buttonWidth: _buttonWidth,
            buttonHeight: QuestionReplyButtons.buttonHeight,
            verse: 'Nice',
            count: questionModel.niceCount,
            icon: Iconz.star,
            iconColor: Colorz.yellow255,
            onTap: onNiceTap,
          ),

          const SizedBox(
            width: QuestionReplyButtons.middleSpacerWidth,
            height: QuestionReplyButtons.middleSpacerWidth,
          ),

          QuestionButton(
            buttonWidth: _buttonWidth,
            buttonHeight: QuestionReplyButtons.buttonHeight,
            verse: 'Reply',
            count: questionModel.repliesCount,
            icon: Iconz.utPlanning,
            onTap: onReplyTap,
          ),

          const SizedBox(
            width: QuestionReplyButtons.middleSpacerWidth,
            height: QuestionReplyButtons.middleSpacerWidth,
          ),

          QuestionButton(
            buttonWidth: _buttonWidth,
            buttonHeight: QuestionReplyButtons.buttonHeight,
            verse: 'Redirect',
            count: questionModel.redirectCount,
            icon: Iconz.arrowRight,
            onTap: () => onRedirectTap(context),
          ),

        ],
      ),
    );
  }
}
