import 'dart:ui' as ui;
import 'package:basics/components/super_box/super_box.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/a_left_spacer/static_slate_spacer.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/d_labels/ff_header_labels.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/e_follow_and_call/gg_call_button.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/e_follow_and_call/gg_follow_button.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/b_header_box.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class StaticHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticHeader({
    required this.flyerBoxWidth,
    required this.bzModel,
    required this.authorID,
    required this.flyerShowsAuthor,
    this.onTap,
    this.showHeaderLabels = false,
    this.bzImageLogo,
    this.authorImage,
    this.onFollowTap,
    this.onCallTap,
    this.disabledButtons = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel? bzModel;
  final String? authorID;
  final Function? onTap;
  final bool? flyerShowsAuthor;
  final bool showHeaderLabels;
  final ui.Image? bzImageLogo;
  final ui.Image? authorImage;
  final Function? onFollowTap;
  final Function? onCallTap;
  final bool disabledButtons;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final bool _flyerShowsAuthor = flyerShowsAuthor ?? false;
    // --------------------
    // final bool _isTinyMode = FlyerDim.isTinyMode(
    //   flyerBoxWidth: flyerBoxWidth,
    //   gridWidth: Scale.screenWidth(context),
    //   gridHeight: Scale.screenHeight(context),
    // );
    // --------------------
    return HeaderBox(
      key: const ValueKey<String>('StaticHeader'),
      flyerBoxWidth: flyerBoxWidth,
      headerHeightTween: FlyerDim.headerSlateHeight(flyerBoxWidth),
      headerBorders: FlyerDim.headerSlateCorners(
        flyerBoxWidth: flyerBoxWidth,
      ),
      headerColor: FlyerColors.headerColor,
      onHeaderTap: onTap == null ? null : () => onTap?.call(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// LEFT SPACER
          StaticHeaderSlateSpacer(
            flyerBoxWidth: flyerBoxWidth,
          ),

          /// BZ LOGO
          BzLogo(
            width: FlyerDim.logoWidth(flyerBoxWidth),
            image: bzImageLogo ?? bzModel?.logoPath,
            isVerified: bzModel?.isVerified,
            corners: FlyerDim.logoCornersByFlyerBoxWidth(
              context: context,
              flyerBoxWidth: flyerBoxWidth,
              zeroCornerIsOn: _flyerShowsAuthor && showHeaderLabels == true,
            ),
            zeroCornerIsOn: _flyerShowsAuthor,
            margins: EdgeInsets.zero,
          ),

          /// HEADER LABELS
          HeaderLabels(
            flyerBoxWidth: flyerBoxWidth,
            authorID: authorID,
            bzModel: bzModel,
            headerIsExpanded: false,
            flyerShowsAuthor: _flyerShowsAuthor,
            showHeaderLabels: showHeaderLabels,
            authorImage: authorImage,
          ),

          /// FOLLOW AND CALL BUTTONS
          Container(
            width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
            height: FlyerDim.logoWidth(flyerBoxWidth),
            alignment: Alignment.topCenter,
            // margin: EdgeInsets.symmetric(horizontal: _paddings),
            // color: Colorz.BloodTest,
            child: SizedBox(
              height: FlyerDim.followAndCallBoxHeight(flyerBoxWidth),
              width: FlyerDim.followAndCallBoxWidth(flyerBoxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// FOLLOW BUTTON
                  if (showHeaderLabels == true)
                    Disabler(
                      isDisabled: disabledButtons,
                      disabledOpacity: 0.2,
                      child: FollowButton(
                        flyerBoxWidth: flyerBoxWidth,
                        onFollowTap: onFollowTap,
                      ),
                    ),

                  /// FAKE SPACE PADDING BETWEEN FOLLOW & GALLERY BUTTONS
                  if (showHeaderLabels == true)
                    StaticHeaderSlateSpacer(
                      flyerBoxWidth: flyerBoxWidth,
                    ),

                  /// Call BUTTON
                  if (showHeaderLabels == true)
                    Disabler(
                      isDisabled: disabledButtons,
                      disabledOpacity: 0.2,
                      child: CallButton(
                        flyerBoxWidth: flyerBoxWidth,
                        onCallTap: onCallTap,
                      ),
                    ),

                ],
              ),
            ),
          ),

          /// RIGHT SPACER
            StaticHeaderSlateSpacer(
            flyerBoxWidth: flyerBoxWidth,
          ),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
