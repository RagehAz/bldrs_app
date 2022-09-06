import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/follow_and_call_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_labels_tree.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_left_spacer_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_middle_spacer_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/header_right_spacer_part.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/mini_header_strip_box_part.dart';
import 'package:flutter/material.dart';

class ConvertibleHeaderStripPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ConvertibleHeaderStripPart({
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
    @required this.onFollowTap,
    @required this.onCallTap,
    @required this.headerRightSpacerTween,
    @required this.flyerModel,
    @required this.bzModel,
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
  final ValueNotifier<bool> headerIsExpanded; /// p
  final Animation<double> headerMiddleSpacerWidthTween;
  final Animation<double> headerLabelsWidthTween;
  final Animation<double> followCallButtonsScaleTween;
  final ValueNotifier<bool> followIsOn; /// p
  final Function onFollowTap;
  final Function onCallTap;
  final Animation<double> headerRightSpacerTween;
  final FlyerModel flyerModel;
  final BzModel bzModel;
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
        BzLogo(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_BzLogo'),
          width: logoMinWidth * logoSizeRatioTween.value,
          image: bzModel?.logo,
          tinyMode: FlyerBox.isTinyMode(context, flyerBoxWidth),
          corners: logoBorders,
          zeroCornerIsOn: flyerModel.showsAuthor,
          // onTap:
          //superFlyer.onHeaderTap,
          // (){
          //   setState(() {
          //     _statelessFadeMaxHeader();
          //   });
          // }
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
          bzModel: bzModel,
          tinyMode: tinyMode,
          headerIsExpanded: headerIsExpanded,
        ),

        /// FOLLOW AND CALL
        FollowAndCallPart(
          key: const ValueKey<String>('ConvertibleHeaderStripPart_FollowAndCallPart'),
          tinyMode: tinyMode,
          logoSizeRatioTween: logoSizeRatioTween,
          flyerBoxWidth: flyerBoxWidth,
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
