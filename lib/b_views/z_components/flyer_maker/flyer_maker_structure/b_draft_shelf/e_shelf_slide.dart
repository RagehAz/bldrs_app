import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/animators/animate_widget_to_matrix.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_headline.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_shadow.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/static_header.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/trinity.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ShelfSlide extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ShelfSlide({
    @required this.mutableSlide,
    @required this.number,
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final MutableSlide mutableSlide;
  final int number;
  final Function onTap;
  /// --------------------------------------------------------------------------
  static const double flyerBoxWidth = 150;
  static const double slideNumberBoxHeight = 20;
// -----------------------------------------------------------------------------
  static double shelfSlideZoneHeight(BuildContext context){
    final double _flyerBoxHeight = FlyerBox.height(context, flyerBoxWidth);
    return _flyerBoxHeight + slideNumberBoxHeight + (Ratioz.appBarPadding * 3);
  }
// -----------------------------------------------------------------------------
  @override
  State<ShelfSlide> createState() => _ShelfSlideState();
// -----------------------------------------------------------------------------
}

class _ShelfSlideState extends State<ShelfSlide> {
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _animateSlide = ValueNotifier(true);
  void _onReAnimate(){

    blog('re-animating');

    _animateSlide.value = false;
    _animateSlide.value = true;
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _animateSlide.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _flyerBoxHeight = FlyerBox.height(context, ShelfSlide.flyerBoxWidth);

    blog('ShelfSlide : BUILDING : file : ${widget.mutableSlide?.picFileModel?.file?.path}');

    return Container(
      width: ShelfSlide.flyerBoxWidth,
      height: ShelfSlide.shelfSlideZoneHeight(context),
      margin: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding,),
      child: Column(
        children: <Widget>[

          /// SPACER
          const SizedBox(
            height: Ratioz.appBarPadding,
          ),

          /// FLYER NUMBER
          Container(
            width: ShelfSlide.flyerBoxWidth,
            height: ShelfSlide.slideNumberBoxHeight,
            alignment: Aligners.superCenterAlignment(context),
            child: widget.number == null ?
            const SizedBox()
                :
                SuperVerse(
              verse:  '${widget.number}',
              size: 1,
              // color: Colorz.white255,
              labelColor: widget.mutableSlide?.midColor?.withAlpha(80) ?? Colorz.white10,
            ),
          ),

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding,),

          /// SLIDE
          GestureDetector(
            onTap: widget.onTap,
            onDoubleTap: _onReAnimate,
            child: FlyerBox(
              key: const ValueKey<String>('shelf_slide_flyer_box'),
              flyerBoxWidth: ShelfSlide.flyerBoxWidth,
              boxColor: widget.mutableSlide?.midColor ?? Colorz.white10,
              stackWidgets: <Widget>[

                /// BACK GROUND COVER PIC
                if (widget.mutableSlide != null)
                SuperFilteredImage(
                  width: ShelfSlide.flyerBoxWidth,
                  height: _flyerBoxHeight,
                  imageFile: widget.mutableSlide.picFileModel.file,
                  filterModel: widget.mutableSlide.filter,
                ),

                /// BLUR LAYER
                if (widget.mutableSlide != null)
                BlurLayer(
                  key: const ValueKey<String>('blur_layer'),
                  width: ShelfSlide.flyerBoxWidth,
                  height: _flyerBoxHeight,
                  blurIsOn: true,
                  blur: 20,
                  borders: FlyerBox.corners(context, ShelfSlide.flyerBoxWidth),
                ),

                /// IMAGE
                if (widget.mutableSlide != null)
                  ValueListenableBuilder(
                      valueListenable: _animateSlide,
                      builder: (_, bool _animate, Widget child){

                        if (_animate == true){
                          return AnimateWidgetToMatrix(
                            matrix: Trinity.renderSlideMatrix(
                                matrix: widget.mutableSlide.matrix,
                                flyerBoxWidth: ShelfSlide.flyerBoxWidth,
                                flyerBoxHeight: _flyerBoxHeight
                            ),
                            child: child,
                          );
                        }
                        else {
                          return child;
                        }

                      },
                    child: SuperFilteredImage(
                      width: ShelfSlide.flyerBoxWidth,
                      height: _flyerBoxHeight,
                      imageFile: widget.mutableSlide.picFileModel.file,
                      filterModel: widget.mutableSlide.filter,
                      boxFit: widget.mutableSlide.picFit,
                    ),
                  ),

                /// SLIDE SHADOW
                if (widget.mutableSlide != null)
                  const SlideShadow(
                  flyerBoxWidth: ShelfSlide.flyerBoxWidth,
                ),

                /// BOTTOM SHADOW
                if (widget.mutableSlide != null)
                const FooterShadow(
                  flyerBoxWidth: ShelfSlide.flyerBoxWidth,
                  tinyMode: false,
                ),

                // /// STATIC FOOTER
                // if (widget.mutableSlide != null)
                // const StaticFooter(
                //   flyerBoxWidth: ShelfSlide.flyerBoxWidth,
                // ),

                /// STATIC HEADER
                if (widget.mutableSlide != null)
                const StaticHeader(
                  flyerBoxWidth: ShelfSlide.flyerBoxWidth,
                  opacity: 0.5,
                ),

                /// HEADLINE
                if (widget.mutableSlide != null)
                  SlideHeadline(
                    flyerBoxWidth: ShelfSlide.flyerBoxWidth,
                    verse: widget.mutableSlide.headline,
                  ),

              ],
            ),
          ),

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding,),

        ],
      ),
    );

  }
}
