import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class ObeliskVerse extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskVerse({
    @required this.navModel,
    @required this.progressBarModel,
    @required this.navModelIndex,
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NavModel navModel;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final int navModelIndex;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('ObeliskVerse'),
      valueListenable: progressBarModel,
      builder: (_, ProgressBarModel _progressBarModel, Widget child){

        final bool _isSelected = _progressBarModel?.index == navModelIndex;

        /// TEXT
        if (navModel?.canShow == true){
          return GestureDetector(
            onTap: onTap,
            child: Container(
              height: Obelisk.circleWidth,
              alignment: Alignment.centerLeft,
              color: Colorz.nothing,
              child: SuperVerse(
                verse: Verse(
                  id: navModel?.titleVerse?.id,
                  translate: navModel?.titleVerse?.translate,
                  casing: _isSelected ? Casing.upperCase : Casing.non,
                ),
                margin: Scale.constantHorizontal5,
                italic: true,
                weight: _isSelected ? VerseWeight.black : VerseWeight.thin,
                labelColor: Colorz.black200,
                color: _isSelected ? Colorz.yellow255 : Colorz.white255,
                shadow: true,
                shadowColor: Colorz.black255,
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
