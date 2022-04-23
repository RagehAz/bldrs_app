import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/flyer_creator_shelf/shelf_header.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/flyer_creator_shelf/shelf_slide.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ShelfBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ShelfBox({
    @required this.child,
    @required this.shelfUI,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final ValueNotifier<ShelfUI> shelfUI;
  /// --------------------------------------------------------------------------
  static const Duration animationDuration = Ratioz.duration150ms;
  static const Curve animationCurve  = Curves.easeOut;
// -----------------------------------------------------------------------------
  static double maxHeight(BuildContext context){
    return ShelfSlide.shelfSlideZoneHeight(context) + ShelfHeader.height;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: shelfUI,
        child: child,
        builder: (_, ShelfUI shelfUI, Widget kid){

          return AnimatedContainer(
            // key: ValueKey<String>(_shelvesIndexes[_shelfIndex].id),
            duration: animationDuration,
            curve: animationCurve,
            height: shelfUI.height,
            margin: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
            child: AnimatedOpacity(
              curve: animationCurve,
              duration: animationDuration,
              opacity: shelfUI.opacity,
              child: kid,
            ),
          );

        }
    );

  }
}

class ShelfUI {
// -----------------------------------------------------------------------------
  ShelfUI({
    @required this.height,
    @required this.opacity,
    @required this.index,
});
// -----------------------------------------------------------------------------
  double height;
  double opacity;
  int index;
// -----------------------------------------------------------------------------
  ShelfUI copyWith({
    double height,
    double opacity,
    int index,
}){
    return ShelfUI(
      height: height ?? this.height,
      opacity: opacity ?? this.opacity,
      index: index ?? this.index,
    );
  }
// -----------------------------------------------------------------------------
}
