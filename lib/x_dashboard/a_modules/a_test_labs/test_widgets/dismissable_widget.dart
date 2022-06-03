import 'package:flutter/material.dart';

class DismissibleBitch extends StatelessWidget {

  const DismissibleBitch({
    @required this.onDismissed,
    @required this.child,
    Key key
  }) : super(key: key);

  final ValueChanged<DismissDirection> onDismissed;
  final Widget child;

  @override
  Widget build(BuildContext context) {

    return Dismissible(
      // onResize: (){
      // blog('resizing');
      // },
      // background: Container(
      //   alignment: Aligners.superCenterAlignment(context),
      //   // color: Colorz.White10,
      //   child: SuperVerse(
      //     verse: 'Dismiss -->',
      //     size: 2,
      //     weight: VerseWeight.thin,
      //     italic: true,
      //     color: Colorz.White10,
      //   ),
      // ),
      // behavior: HitTestBehavior.translucent,
      // secondaryBackground: Container(
      //   width: _screenWidth,
      //   height: 50,
      //   color: Colorz.BloodTest,
      // ),
      // dismissThresholds: {
      //   DismissDirection.down : 10,
      //   DismissDirection.endToStart : 20,
      // },
      // dragStartBehavior: DragStartBehavior.start,
      key: key,
      movementDuration: const Duration(milliseconds: 250),
      resizeDuration: const Duration(milliseconds: 250),
      confirmDismiss: (DismissDirection direction) async {
        // blog('confirmDismiss : direction is : $direction');
        /// if needed to make the bubble un-dismissible set to false
        const bool _dismissible = true;
        return _dismissible;
      },
      onDismissed: (DismissDirection direction) => onDismissed(direction),
      child: child,
    );

  }
}
