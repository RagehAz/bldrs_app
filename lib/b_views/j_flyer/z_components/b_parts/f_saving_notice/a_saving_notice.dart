import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/f_saving_notice/b_saving_graphic.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class SavingNotice extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SavingNotice({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.flyerIsSaved,
    @required this.animationController,
    @required this.graphicIsOn,
    @required this.graphicOpacity,
    this.isStarGraphic = false, // if not star would be Ankh
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final ValueNotifier<bool> flyerIsSaved; /// p
  final AnimationController animationController;
  final ValueNotifier<bool> graphicIsOn; /// p
  final ValueNotifier<double> graphicOpacity; /// p
  final bool isStarGraphic;
  /// --------------------------------------------------------------------------
  @override
  State<SavingNotice> createState() => _SavingNoticeState();
}

class _SavingNoticeState extends State<SavingNotice> {
  // -----------------------------------------------------------------------------
  CurvedAnimation _curvedAnimation;
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
  /// TAMAM
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
      key: const ValueKey<String>('SavingNotice'),
      valueListenable: widget.graphicIsOn,
        builder: (_, bool canShowGraphic, Widget canShowGraphicChild){

          /// SHOWING GRAPHIC
          if (canShowGraphic == true){

            return canShowGraphicChild;

          }

          /// SHOWING NOTHING
          else {

            return const SizedBox();

          }

        },
      child: ValueListenableBuilder<double>(
        valueListenable: widget.graphicOpacity,
        builder: (_, double graphicOpacity, Widget fadeOutChild){

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
          builder: (_, bool isSaved, Widget ankh){

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
                  ankh: ankh,
                ),
              ),
            );

          },
          child: SuperImage(
            width: widget.flyerBoxWidth,
            height: widget.flyerBoxHeight,
            pic: widget.isStarGraphic ? Iconz.sexyStar : Iconz.saveOn,
            scale: widget.isStarGraphic ? 0.7 : 0.8,
          ),
        ),

      ),
    );

  }
  // -----------------------------------------------------------------------------
}
