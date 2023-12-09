import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/e_extra_layers/saving_notice_layer/b_saving_graphic.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SavingNotice extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SavingNotice({
    required this.flyerBoxWidth,
    required this.flyerBoxHeight,
    required this.flyerIsSaved,
    required this.animationController,
    required this.graphicIsOn,
    required this.graphicOpacity,
    this.isStarGraphic = false, // if not star would be heart
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final ValueNotifier<bool> flyerIsSaved;
  final AnimationController animationController;
  final ValueNotifier<bool> graphicIsOn;
  final ValueNotifier<double> graphicOpacity;
  final bool isStarGraphic;
  /// --------------------------------------------------------------------------
  @override
  State<SavingNotice> createState() => _SavingNoticeState();
  /// --------------------------------------------------------------------------
}

class _SavingNoticeState extends State<SavingNotice> {
  // -----------------------------------------------------------------------------
  late CurvedAnimation _curvedAnimation;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _curvedAnimation = CurvedAnimation(
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn,
      parent: widget.animationController,
    );

  }
  // --------------------
  @override
  void dispose() {
    _curvedAnimation.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // Widget _yellowSlide = Container(
    //   width: widget.flyerBoxWidth,
    //   height: widget.flyerBoxHeight,
    //   alignment: Alignment.center,
    //   decoration: BoxDecoration(
    //     borderRadius: FlyerBox.corners(context, widget.flyerBoxWidth),
    //     color: Colorz.yellow20,
    //   ),
    // );

    return ValueListenableBuilder(
      // key: const ValueKey<String>('SavingNotice'),
      valueListenable: widget.graphicIsOn,
        builder: (_, bool canShowGraphic, Widget? canShowGraphicChild){

          /// SHOWING GRAPHIC
          if (canShowGraphic == true){

            return canShowGraphicChild!;

          }

          /// SHOWING NOTHING
          else {

            return const SizedBox();

          }

        },
      child: ValueListenableBuilder<double>(
        valueListenable: widget.graphicOpacity,
        builder: (_, double graphicOpacity, Widget? fadeOutChild){

          return AnimatedOpacity(
            opacity: graphicOpacity,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: fadeOutChild,
          );

        },

        /// FADE OUT CHILD
        child: ValueListenableBuilder(
          valueListenable: widget.flyerIsSaved,
          builder: (_, bool isSaved, Widget? ankh){

            return AnimatedOpacity(
              opacity: isSaved ? 1 : 0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 200),
              child: ScaleTransition(
                scale: _curvedAnimation,
                child: SavedGraphic(
                  flyerBoxWidth: widget.flyerBoxWidth,
                  flyerBoxHeight: widget.flyerBoxHeight,
                  isSaved: isSaved,
                  isStarGraphic: widget.isStarGraphic,
                  saveIcon: ankh,
                ),
              ),
            );

          },
          child: WebsafeSvg.asset(
            Iconz.love,
            // colorFilter: ColorFilter.mode(
            //   _iconAndVerseColor,
            //   BlendMode.srcIn,
            // ),
            // package: Iconz.bldrsTheme,
            // fit: BoxFit.fitWidth,
            width: widget.flyerBoxWidth,
            height: widget.flyerBoxWidth,
            // alignment: Alignment.center,
          ),
        ),

      ),
    );

  }
  // -----------------------------------------------------------------------------
}
