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
    super.key
  });
  // --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final Function onTap;
  final bool isActive;
  final Function onDeactivatedTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _buttonWidth = Bubble.bubbleWidth(context: context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
      child: Center(
        child: InkWell(
          borderRadius: Borderers.constantCornersAll12,
          onTap: isActive == true ? onTap : onDeactivatedTap,
          highlightColor: Colorz.white10,
          child: Container(
            width: _buttonWidth,
            decoration: BoxDecoration(
              color: isActive == true ? Colorz.white20 : Colorz.white10,
              borderRadius: Borderers.constantCornersAll12,
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
