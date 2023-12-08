import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:basics/helpers/widgets/drawing/super_positioned.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

class MiniUserBanner extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MiniUserBanner({
    required this.userModel,
    required this.width,
    super.key
  });
  // --------------------------------------------------------------------------
  final UserModel? userModel;
  final double width;
  // -----------------------
  static double getWidthByPageWidth({
    required double pageWidth,
  }){
    return pageWidth * 0.13;
  }
  // -----------------------
  static double getHeightByPageWidth({
    required double pageWidth,
  }){
    final double _width = getWidthByPageWidth(
      pageWidth: pageWidth,
    );
    return getHeight(
      width: _width,
    );
  }
  // -----------------------
  static double getHeight({
    required double width,
  }){

    final double _textHeight = getTextHeight(
      width: width,
    );

    return width + _textHeight;
  }
  // -----------------------
  static double getTextHeight({
    required double width,
  }){
    return width * 0.6;
  }
  // -----------------------
  static const double spacing = 5;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _height = getHeight(
      width: width,
    );
    final double _textHeight = getTextHeight(
      width: width,
    );

    final double _microIconSize = width * 0.28;

    return Container(
      width: width,
      height: _height,
      margin: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enRight: spacing,
      ),
      child: Column(
        children: <Widget>[

          /// USER PIC
          Stack(
            children: [

              /// PIC
              BldrsBox(
                height: width,
                width: width,
                icon: userModel?.picPath ?? Iconz.anonymousUser,
                // margins: Scale.constantHorizontal5,
                onTap: () => BldrsNav.jumpToUserPreviewScreen(
                  userID: userModel?.id,
                ),
              ),

              /// FLAG
              if (userModel?.zone?.countryID != null)
              SuperPositioned(
                verticalOffset: _microIconSize * 0.01,
                horizontalOffset: _microIconSize * 0.01,
                enAlignment: Alignment.topRight,
                appIsLTR: UiProvider.checkAppIsLeftToRight(),
                child: BldrsBox(
                  height: _microIconSize,
                  width: _microIconSize,
                  icon: Flag.getCountryIcon(userModel?.zone?.countryID),
                  bubble: false,
                  color: Colorz.black255,
                ),
              ),

            ],
          ),

          /// USER NAME
          BldrsText(
            width: width,
            height: _textHeight,
            verse: Verse(
              id: userModel?.name ?? getWord('phid_person'),
              translate: false,
            ),
            size: 1,
            weight: VerseWeight.thin,
            maxLines: 2,
            scaleFactor: width * 0.016,
          ),

        ],
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
