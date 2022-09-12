import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/nav_model.dart';
import 'package:flutter/material.dart';

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
                  text: navModel?.title,
                  translate: navModel.translateTitle,
                  casing: _isSelected ? Casing.upperCase : Casing.non,
                ),
                margin: Scale.superInsets(
                  context: context,
                  enLeft: 5,
                  enRight: 5,
                ),//const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
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
              ),
            ),
          );
        }

        },
    );

  }
/// --------------------------------------------------------------------------
}
