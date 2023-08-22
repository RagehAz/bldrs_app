import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:flutter/material.dart';

class ZoneButtonBox extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ZoneButtonBox({
    required this.columnChildren,
    required this.onTap,
    required this.isActive,
    required this.onDeactivatedTap,
    required this.isSelected,
    this.canTap = true,
    this.isSelectedColor,
    super.key
  });
  // --------------------
  final List<Widget> columnChildren;
  final Function? onTap;
  final bool isActive;
  final Function? onDeactivatedTap;
  final bool isSelected;
  final bool canTap;
  final Color? isSelectedColor;
  // --------------------
  static Color getBoxColor({
    required bool isActive,
    required bool isSelected,
    required Color? isSelectedColor,
  }){
    return isActive == false ?
              Colorz.white10
                  :
              isSelected == true ? (isSelectedColor ?? Colorz.yellow50)
                  :
              Colorz.white20;
  }
  // --------------------
  static const Color borderColor = Colorz.white125;
  // --------------------
  static BoxBorder? getBorders({
    required bool isSelected,
  }){
    return isSelected == false ? null
        :
    Border.all(
      width: 0.5,
      color: borderColor,
      strokeAlign: BorderSide.strokeAlignOutside,
    );
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _buttonWidth = Bubble.bubbleWidth(context: context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
      child: Center(
        child: InkWell(
          borderRadius: Borderers.constantCornersAll12,
          onTap:  canTap == false ? null
                  :
                  isActive == true ? () => onTap?.call()
                  :
                  () => onDeactivatedTap?.call(),
          highlightColor: Colorz.white10,
          child: Container(
            width: _buttonWidth + 1,
            decoration: BoxDecoration(
              color: getBoxColor(
                isActive: isActive,
                isSelected: isSelected,
                isSelectedColor: isSelectedColor,
              ),
              borderRadius: Borderers.constantCornersAll12,
              border: getBorders(
                isSelected: isSelected,
              ),
            ),
            child: Column(
              children: columnChildren,
          ),
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
