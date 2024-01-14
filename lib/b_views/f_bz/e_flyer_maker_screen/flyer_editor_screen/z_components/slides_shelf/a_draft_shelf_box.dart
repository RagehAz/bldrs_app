import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/e_draft_shelf_slide.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';

class DraftShelfBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DraftShelfBox({
    required this.child,
    required this.shelfUI,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Widget child;
  final ValueNotifier<ShelfUI> shelfUI;
  /// --------------------------------------------------------------------------
  static const Duration animationDuration = Ratioz.duration150ms;
  static const Curve animationCurve  = Curves.easeOut;
  // -----------------------------------------------------------------------------
  static double height(){
    return DraftShelfSlide.shelfSlideZoneHeight();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        key: const ValueKey<String>('ShelfBox'),
        valueListenable: shelfUI,

        child: Container(
          width: Scale.screenWidth(context),
          height: DraftShelfSlide.shelfSlideZoneHeight(),
          color: Colorz.white10,
          child: child,
        ),

        builder: (_, ShelfUI shelfUI, Widget? kid){

          return AnimatedContainer(
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
  // -----------------------------------------------------------------------------
}

class ShelfUI {
  // -----------------------------------------------------------------------------
  ShelfUI({
    required this.height,
    required this.opacity,
    required this.index,
  });
  // -----------------------------------------------------------------------------
  double height;
  double opacity;
  int index;
  // -----------------------------------------------------------------------------
  ShelfUI copyWith({
    double? height,
    double? opacity,
    int? index,
  }){
    return ShelfUI(
      height: height ?? this.height,
      opacity: opacity ?? this.opacity,
      index: index ?? this.index,
    );
  }
  // -----------------------------------------------------------------------------
}
