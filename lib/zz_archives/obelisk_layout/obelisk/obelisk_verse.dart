import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/components/drawing/separator_line.dart';
import 'package:bldrs/zz_archives/nav_model.dart';
import 'package:bldrs/zz_archives/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class ObeliskVerse extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskVerse({
    required this.navModel,
    required this.progressBarModel,
    required this.navModelIndex,
    required this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final NavModel? navModel;
  final ValueNotifier<ProgressBarModel?> progressBarModel;
  final int navModelIndex;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isWideScreen = Obelisk.isWideScreenObelisk(context);

    return ValueListenableBuilder(
      key: const ValueKey<String>('ObeliskVerse'),
      valueListenable: progressBarModel,
      builder: (_, ProgressBarModel? _progressBarModel, Widget? child){

        final bool _isSelected = _progressBarModel?.index == navModelIndex;

        /// TEXT
        if (Mapper.boolIsTrue(navModel?.canShow) == true){
          return GestureDetector(
            onTap: () => onTap.call(),
            child: Container(
              height: Obelisk.circleWidth,
              alignment: _isWideScreen == true ? Alignment.centerRight : Alignment.centerLeft,
              color: Colorz.nothing,
              child: BldrsText(
                verse: Verse(
                  id: navModel?.titleVerse?.id,
                  translate: navModel?.titleVerse?.translate,
                  casing: _isSelected ? Casing.upperCase : Casing.non,
                ),
                margin: Scale.constantHorizontal5,
                italic: true,
                weight: _isSelected ? VerseWeight.black : VerseWeight.thin,
                labelColor: Colorz.black50,
                color: _isSelected ? Colorz.yellow255 : Colorz.white255,
                shadow: true,
                shadowColor: Colorz.black255,
                // centered: false,
              ),
            ),
          );
        }

        /// EMPTY
        else if (navModel?.canShow == false){
          return const SizedBox();
        }

        /// SEPARATOR
        else {
          return const AbsorbPointer(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5, top: 5),
              child: SeparatorLine(
                width: 100,
                lineIsON: false,
                color: Colorz.yellow200,
              ),
            ),
          );
        }

        },
    );

  }
/// --------------------------------------------------------------------------
}
