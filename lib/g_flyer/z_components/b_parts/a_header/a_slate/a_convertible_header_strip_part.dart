import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header//a_slate/f_right_spacer/h_header_right_spacer_part.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/a_left_spacer/animated_header_left_spacer.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/b_mini_header_strip_box_part.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/c_middle_spacer/e_header_middle_spacer_part.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/d_labels/f_header_labels_tree.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/e_follow_and_call/g_follow_and_call_buttons.dart';
import 'package:flutter/material.dart';

class ConvertibleHeaderStripPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ConvertibleHeaderStripPart({
    required this.flyerBoxWidth,
    required this.minHeaderHeight,
    required this.logoSizeRatioTween,
    required this.headerLeftSpacerTween,
    required this.tinyMode,
    required this.headerBorders,
    required this.logoMinWidth,
    required this.logoCorners,
    required this.headerIsExpanded,
    required this.headerMiddleSpacerWidthTween,
    required this.headerLabelsWidthTween,
    required this.followCallButtonsScaleTween,
    required this.followIsOn,
    required this.onFollowTap,
    required this.onCallTap,
    required this.headerRightSpacerTween,
    required this.flyerModel,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double minHeaderHeight;
  final Animation<double>? logoSizeRatioTween;
  final Animation<double>? headerLeftSpacerTween;
  final bool tinyMode;
  final BorderRadius? headerBorders;
  final double logoMinWidth;
  final BorderRadius? logoCorners;
  final ValueNotifier<bool> headerIsExpanded;
  final Animation<double>? headerMiddleSpacerWidthTween;
  final Animation<double>? headerLabelsWidthTween;
  final Animation<double>? followCallButtonsScaleTween;
  final ValueNotifier<bool> followIsOn;
  final Function onFollowTap;
  final Function onCallTap;
  final Animation<double>? headerRightSpacerTween;
  final FlyerModel? flyerModel;
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
        AnimatedHeaderLeftSpacer(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_HeaderLeftSpacerPart'),
          headerLeftSpacerTween: headerLeftSpacerTween,
          logoMinWidth: logoMinWidth,
          logoSizeRationTween: logoSizeRatioTween,
        ),

        /// LOGO
        BzLogo(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_BzLogo'),
          width: logoMinWidth * (logoSizeRatioTween?.value ?? 1),
          image: flyerModel?.bzLogoImage ?? flyerModel?.bzModel?.logoPath,
          isVerified: flyerModel?.bzModel?.isVerified,
          corners: logoCorners,
          zeroCornerIsOn: flyerModel?.showsAuthor,
        ),

        /// MIDDLE SPACER
        HeaderMiddleSpacerPart(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_HeaderMiddleSpacerPart'),
          logoMinWidth: logoMinWidth,
          headerMiddleSpacerWidthTween: headerMiddleSpacerWidthTween,
          logoSizeRatioTween: logoSizeRatioTween,
        ),

        /// HEADER LABELS
        HeaderLabelsTree(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_HeaderLabelsPart'),
          headerLabelsWidthTween: headerLabelsWidthTween,
          logoMinWidth: logoMinWidth,
          logoSizeRatioTween: logoSizeRatioTween,
          flyerBoxWidth: flyerBoxWidth,
          flyerModel: flyerModel,
          bzModel: flyerModel?.bzModel,
          tinyMode: tinyMode,
          headerIsExpanded: headerIsExpanded,
        ),

        /// FOLLOW AND CALL
        FollowAndCallButtons(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_FollowAndCallPart'),
          tinyMode: tinyMode,
          logoSizeRatioTween: logoSizeRatioTween,
          flyerBoxWidth: flyerBoxWidth * (followCallButtonsScaleTween?.value ?? 1),
          followCallButtonsScaleTween: followCallButtonsScaleTween,
          followIsOn: followIsOn,
          onCallTap: onCallTap,
          onFollowTap: onFollowTap,
          logoMinWidth: logoMinWidth,
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
/// --------------------------------------------------------------------------
}
