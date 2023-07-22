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
    super.key
  });
  // --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final Function? onTap;
  final bool isActive;
  final Function? onDeactivatedTap;
  final bool isSelected;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _buttonWidth = Bubble.bubbleWidth(context: context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
      child: Center(
        child: InkWell(
          borderRadius: Borderers.constantCornersAll12,
          onTap: isActive == true ? () => onTap?.call() : () => onDeactivatedTap?.call(),
          highlightColor: Colorz.white10,
          child: Container(
            width: _buttonWidth + 1,
            decoration: BoxDecoration(
              color: isActive == false ?
              Colorz.white10
                  :
              isSelected == true ? Colorz.yellow50
                  :
              Colorz.white20,
              borderRadius: Borderers.constantCornersAll12,
              border: isSelected == false ? null : Border.all(
                width: 0.5,
                color: Colorz.white125,
                strokeAlign: BorderSide.strokeAlignOutside,
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
