import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_separator_line.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';

class ObeliskVerse extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskVerse({
    @required this.navModel,
    @required this.currentTabIndex,
    @required this.navModelIndex,
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NavModel navModel;
  final ValueNotifier<int> currentTabIndex;
  final int navModelIndex;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('ObeliskVerse'),
      valueListenable: currentTabIndex,
      builder: (_, int _tabIndex, Widget child){

        final bool _isSelected = _tabIndex == navModelIndex;

        /// TEXT
        if (navModel?.canShow == true){
          return GestureDetector(
            onTap: onTap,
            child: Container(
              height: Obelisk.circleWidth + 5,
              alignment: Alignment.centerLeft,
              color: Colorz.nothing,
              child: SuperVerse(
                verse: _isSelected ? navModel.title.toUpperCase() : navModel.title,
                margin: superInsets(
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
            child: SeparatorLine(
              width: 100,
              margins: EdgeInsets.only(bottom: 10, top: 5),
              lineIsON: false,
            ),
          );
        }

        },
    );

  }
}