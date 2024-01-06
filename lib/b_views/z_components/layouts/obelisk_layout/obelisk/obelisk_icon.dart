import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/layouts/separators/separator_line.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/red_dot_badge.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class ObeliskIcon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskIcon({
    required this.navModel,
    required this.progressBarModel,
    required this.navModelIndex,
    required this.onTap,
    required this.badge,
    super.key
  });
  /// --------------------------------------------------------------------------
  final NavModel? navModel;
  final ValueNotifier<ProgressBarModel?> progressBarModel;
  final int navModelIndex;
  final Function onTap;
  final MapModel? badge;
  // --------------------------------------------------------------------------
  static int? getCount({
    required MapModel? badge,
  }){
    final int? count = badge == null ? null
        :
    badge.value is int ? badge.value
        :
    null;

    return count;
  }
  // --------------------
  static bool checkHasCount({
    required MapModel? badge,
  }){
    final int? count = getCount(badge: badge);
    return count != null && count > 0;
  }
  // --------------------
  static Verse? getRedDotVerse({
    required MapModel? badge,
  }){
    final Verse? verse = badge == null ? null
        :
    badge.value is String ? Verse.plain(badge.value)
        :
    null;

    return verse;
  }
  // --------------------
  static bool checkHasDot({
    required MapModel? badge,
  }){
    final bool _hasCount = checkHasCount(badge: badge);
    final Verse? verse = getRedDotVerse(badge: badge);
    final bool _hasVerse = verse != null;
    return badge != null && (_hasCount || _hasVerse);
  }
  // --------------------
  static bool checkRedDotIsOn({
    required bool? forceRedDot,
    required MapModel? badge,
  }){
    final bool _hasDot = checkHasDot(badge: badge);
    return Mapper.boolIsTrue(forceRedDot) == true || _hasDot;
  }
  // --------------------
  static Color? getIconColor({
    required bool isSelected,
    required NavModel? navModel,
  }){
    return navModel?.iconColor == Colorz.nothing ? null : isSelected ? Colorz.black255 : Colorz.white255;
  }
  // --------------------
  static double getIconSizeFactor({
    required NavModel? navModel,
  }){
    return navModel?.iconSizeFactor ?? 0.45;
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        key: const ValueKey<String>('ObeliskIconz'),
        valueListenable: progressBarModel,
        builder: (_, ProgressBarModel? progressBarModel, Widget? child){

          final bool _isSelected = progressBarModel?.index == navModelIndex;

          /// BUTTON CIRCLE
          if (Mapper.boolIsTrue(navModel?.canShow) == true){
            // ---->
            final int? count = getCount(badge: badge);
            final Verse? verse = getRedDotVerse(badge: badge);
            final bool _hasVerse = verse != null;
            // ---->
            return GestureDetector(
              onTap: () => onTap.call(),
              child: Container(
                height: Obelisk.circleWidth,
                width: Obelisk.circleWidth,
                color: Colorz.nothing,
                alignment: Alignment.centerLeft,
                child: RedDotBadge(
                  redDotIsOn: checkRedDotIsOn(forceRedDot: navModel?.forceRedDot, badge: badge),
                  count: count,
                  verse: verse,
                  childWidth: Obelisk.circleWidth,
                  shrinkChild: true,
                  isNano: _hasVerse,
                  child: BldrsBox(
                    width: Obelisk.circleWidth,
                    height: Obelisk.circleWidth,
                    corners: Obelisk.circleWidth * 0.5,
                    color: _isSelected ? Colorz.yellow255 : Colorz.black255,
                    icon: navModel?.icon,
                    iconColor: getIconColor(navModel: navModel, isSelected: _isSelected),
                    iconSizeFactor: getIconSizeFactor(navModel: navModel),
                    // margins: const EdgeInsets.only(bottom: 5),
                  ),
                ),
              ),
            );
          }

          /// NOTHING
          else if (navModel?.canShow == false){
            return const SizedBox();
          }

          /// SEPARATOR
          else {

            // final double rightShrinkage = NoteRedDotWrapper.getShrinkageDX(
            //     childWidth: Obelisk.circleWidth,
            //     isNano: false
            // );

            return AbsorbPointer(
              child: SizedBox(
                width: Obelisk.circleWidth,
                height: SeparatorLine.standardThickness + 10,
                // color: Colorz.bloodTest,
                // padding: EdgeInsets.only(right: rightShrinkage),
                // alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: Transform.scale(
                    scale: RedDotBadge.getShrinkageScale(
                      isNano: false,
                      childWidth: Obelisk.circleWidth,
                    ),
                    alignment: BldrsAligners.superBottomAlignment(context),
                    child: const SeparatorLine(
                      width: Obelisk.circleWidth * 0.4,
                      color: Colorz.yellow200,
                    ),
                  ),
                ),
              ),
            );

          }

        }
    );

  }
  /// --------------------------------------------------------------------------
}
