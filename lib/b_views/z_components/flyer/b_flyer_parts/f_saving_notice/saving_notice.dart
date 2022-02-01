import 'package:bldrs/b_views/widgets/general/images/super_image.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/f_saving_notice/saving_graphic.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

class SavingNotice extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SavingNotice({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.flyerIsSaved,
    @required this.animationController,
    @required this.graphicIsOn,
    @required this.graphicOpacity,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final ValueNotifier<bool> flyerIsSaved;
  final AnimationController animationController;
  final ValueNotifier<bool> graphicIsOn;
  final ValueNotifier<double> graphicOpacity;
  /// --------------------------------------------------------------------------
  @override
  State<SavingNotice> createState() => _SavingNoticeState();
}

class _SavingNoticeState extends State<SavingNotice> {
// -----------------------------------------------------------------------------
  CurvedAnimation _curvedAnimation;
  ColorTween _colorTween;
  Tween<double> _scaleTween;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _curvedAnimation = CurvedAnimation(
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn,
      parent: widget.animationController,
    );

    _scaleTween = Tween<double>(begin: 0, end: 1);
    _colorTween = ColorTween(begin: Colorz.white125, end: Colorz.yellow125);

    super.initState();
  }
// -----------------------------------------------------------------------------
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
        valueListenable: widget.graphicIsOn,
        builder: (_, bool canShowGraphic, Widget canShowGraphicChild){

          /// SHOWING GRAPHIC
          if (canShowGraphic == true){

            return ValueListenableBuilder<double>(
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
                child: const SuperImage(
                  pic: Iconz.saveOn,
                  scale: 10,
                ),
                builder: (_, bool isSaved, Widget ankhChild){

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
                          ankh: ankhChild,
                        ),
                      ),
                    );

                    // return AnimatedOpacity(
                    //   opacity: canShowGraphic ? 1 : 0,
                    //   duration: Ratioz.duration750ms,
                    //   curve: Curves.easeOut,
                    //   child: AnimatedOpacity(
                    //     opacity: isSaved ? 1 : 0,
                    //     duration: Ratioz.durationFading200,
                    //     curve: Curves.fastOutSlowIn,
                    //     child: AnimatedScale(
                    //       scale: isSaved ? 1 : 0,
                    //       duration: Ratioz.durationFading200,
                    //       curve: Curves.bounceInOut,
                    //       child: child,
                    //     ),
                    //   ),
                    // );

                    // return ScaleTransition(
                    //   scale: _scaleController,
                    //   child: child,
                    // );
                    // }

                    // else {
                    //   return const SizedBox();
                    // }

                  },
                ),

            );

          }

          /// SHOWING NOTHING
          else {

            return const SizedBox();

          }

        }
    );
  }
}
