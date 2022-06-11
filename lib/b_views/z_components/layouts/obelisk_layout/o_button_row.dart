import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';

class OButtonRow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OButtonRow({
    @required this.navModel,
    @required this.onTap,
    @required this.isSelected,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NavModel navModel;
  final Function onTap;
  final bool isSelected;
  /// --------------------------------------------------------------------------
  static const double circleWidth = 35;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      key: const ValueKey<String>('OButtonRow'),
      onTap: onTap,
      child: Container(
        height: circleWidth + 5,
        alignment: Alignment.bottomLeft,
        color: Colorz.nothing,
        child: Row(
          children: <Widget>[

            /// ICON
            DreamBox(
              width: circleWidth,
              height: circleWidth,
              corners: circleWidth * 0.5,
              color: isSelected ? Colorz.yellow255 : Colorz.black255,
              icon: navModel.icon,
              iconColor: navModel.iconColor == Colorz.nothing ? null : isSelected ? Colorz.black255 : Colorz.white255,
              iconSizeFactor: navModel.iconSizeFactor ?? 0.45,
            ),

            /// TEXT
            SuperVerse(
              verse: isSelected ? navModel.title.toUpperCase() : navModel.title,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              italic: true,
              weight: isSelected ? VerseWeight.black : VerseWeight.thin,
              labelColor: Colorz.black80,
              color: isSelected ? Colorz.yellow255 : Colorz.white255,
              shadow: true,
              shadowColor: Colorz.black255,
            ),

          ],
        ),
      ),
    );

  }
}
