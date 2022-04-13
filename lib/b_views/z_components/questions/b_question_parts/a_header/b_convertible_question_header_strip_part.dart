import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/user_balloon.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/follow_and_call_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_left_spacer_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_middle_spacer_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_right_spacer_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/mini_header_strip_box_part.dart';
import 'package:bldrs/b_views/z_components/questions/b_question_parts/a_header/c_question_header_labels_tree.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/question_model.dart';
import 'package:flutter/material.dart';

class ConvertibleQuestionHeaderStripPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ConvertibleQuestionHeaderStripPart({
    @required this.flyerBoxWidth,
    @required this.minHeaderHeight,
    @required this.logoSizeRatioTween,
    @required this.headerLeftSpacerTween,
    @required this.tinyMode,
    @required this.headerBorders,
    @required this.logoMinWidth,
    @required this.logoBorders,
    @required this.headerIsExpanded,
    @required this.headerMiddleSpacerWidthTween,
    @required this.headerLabelsWidthTween,
    @required this.followCallButtonsScaleTween,
    @required this.followIsOn,
    @required this.headerRightSpacerTween,
    @required this.questionModel,
    @required this.userModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double minHeaderHeight;
  final Animation<double> logoSizeRatioTween;
  final Animation<double> headerLeftSpacerTween;
  final bool tinyMode;
  final BorderRadius headerBorders;
  final double logoMinWidth;
  final BorderRadius logoBorders;
  final ValueNotifier<bool> headerIsExpanded;
  final Animation<double> headerMiddleSpacerWidthTween;
  final Animation<double> headerLabelsWidthTween;
  final Animation<double> followCallButtonsScaleTween;
  final ValueNotifier<bool> followIsOn;
  final Animation<double> headerRightSpacerTween;
  final QuestionModel questionModel;
  final UserModel userModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MiniHeaderStripBoxPart(
      key: const ValueKey<String>('ConvertibleHeaderStripPart_MiniHeaderStripBoxPart'),
      flyerBoxWidth: flyerBoxWidth,
      minHeaderHeight: minHeaderHeight,
      logoSizeRatioTween: logoSizeRatioTween,
      headerLeftSpacerTween: headerLeftSpacerTween,
      tinyMode: tinyMode,
      headerBorders: headerBorders,
      children: <Widget>[

        /// HEADER LEFT SPACER
        HeaderLeftSpacerPart(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_HeaderLeftSpacerPart'),
          headerLeftSpacerTween: headerLeftSpacerTween,
          logoMinWidth: logoMinWidth,
          logoSizeRationTween: logoSizeRatioTween,
        ),

        /// LOGO
        UserBalloon(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_UserBalloon'),
          balloonWidth: minHeaderHeight * logoSizeRatioTween.value,
          userModel: userModel,
          loading: false,
          shadowIsOn: false,
          balloonType: userModel.status,
        ),

        /// MIDDLE SPACER
        HeaderMiddleSpacerPart(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_HeaderMiddleSpacerPart'),
          logoMinWidth: logoMinWidth,
          headerMiddleSpacerWidthTween: headerMiddleSpacerWidthTween,
          logoSizeRatioTween: logoSizeRatioTween,
        ),

        /// HEADER LABELS
        QuestionHeaderLabelsTree(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_HeaderLabelsPart'),
          headerLabelsWidthTween: headerLabelsWidthTween,
          logoMinWidth: logoMinWidth,
          logoSizeRatioTween: logoSizeRatioTween,
          flyerBoxWidth: flyerBoxWidth,
          tinyMode: tinyMode,
          headerIsExpanded: headerIsExpanded,
          userModel: userModel,
          questionModel: questionModel,
        ),

        /// FOLLOW AND CALL
        FollowAndCallPart(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_FollowAndCallPart'),
          tinyMode: tinyMode,
          logoSizeRatioTween: logoSizeRatioTween,
          flyerBoxWidth: flyerBoxWidth,
          followCallButtonsScaleTween: followCallButtonsScaleTween,
          followIsOn: followIsOn,
          onCallTap: null,
          onFollowTap: null,
          logoMinWidth: logoMinWidth,
          showButtons: false,
        ),

        /// HEADER RIGHT SPACER
        HeaderRightSpacerPart(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_HeaderRightSpacerPart'),
          logoMinWidth: logoMinWidth,
          logoSizeRatioTween: logoSizeRatioTween,
          headerRightSpacerTween: headerRightSpacerTween,
        ),

      ],
    );

  }
}
