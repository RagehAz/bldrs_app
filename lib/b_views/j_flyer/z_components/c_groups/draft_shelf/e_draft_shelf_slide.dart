import 'package:bldrs/a_models/f_flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_header_template.dart';
import 'package:bldrs/b_views/z_components/animators/animate_widget_to_matrix.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/e_slide_headline.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/d_slide_shadow.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/trinity.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class DraftShelfSlide extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DraftShelfSlide({
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
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(context, flyerBoxWidth);
    return _flyerBoxHeight + slideNumberBoxHeight + (Ratioz.appBarPadding * 3);
  }
  // -----------------------------------------------------------------------------
  @override
  State<DraftShelfSlide> createState() => _DraftShelfSlideState();
  // -----------------------------------------------------------------------------
}

class _DraftShelfSlideState extends State<DraftShelfSlide> {
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

    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(context, DraftShelfSlide.flyerBoxWidth);
    blog('ShelfSlide : BUILDING : file : ${widget.mutableSlide?.picFileModel?.file?.path}');

    return Container(
      width: DraftShelfSlide.flyerBoxWidth,
      height: DraftShelfSlide.shelfSlideZoneHeight(context),
      margin: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding,),
      child: Column(
        children: <Widget>[

          /// SPACER
          const SizedBox(
            height: Ratioz.appBarPadding,
          ),

          /// FLYER NUMBER
          Container(
            width: DraftShelfSlide.flyerBoxWidth,
            height: DraftShelfSlide.slideNumberBoxHeight,
            alignment: Aligners.superCenterAlignment(context),
            child: widget.number == null ?
            const SizedBox()
                :
            SuperVerse(
              verse: Verse.plain('${widget.number}'),
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
              flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
              boxColor: widget.mutableSlide?.midColor ?? Colorz.white10,
              stackWidgets: <Widget>[

                /// BACK GROUND COVER PIC
                if (widget.mutableSlide != null)
                  SuperFilteredImage(
                    width: DraftShelfSlide.flyerBoxWidth,
                    height: _flyerBoxHeight,
                    imageFile: widget.mutableSlide.picFileModel.file,
                    filterModel: widget.mutableSlide.filter,
                  ),

                /// BLUR LAYER
                if (widget.mutableSlide != null)
                  BlurLayer(
                    key: const ValueKey<String>('blur_layer'),
                    width: DraftShelfSlide.flyerBoxWidth,
                    height: _flyerBoxHeight,
                    blurIsOn: true,
                    blur: 20,
                    borders: FlyerDim.flyerCorners(context, DraftShelfSlide.flyerBoxWidth),
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
                              flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
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
                      width: DraftShelfSlide.flyerBoxWidth,
                      height: _flyerBoxHeight,
                      imageFile: widget.mutableSlide.picFileModel.file,
                      filterModel: widget.mutableSlide.filter,
                      boxFit: widget.mutableSlide.picFit,
                    ),
                  ),

                /// SLIDE SHADOW
                if (widget.mutableSlide != null)
                  const SlideShadow(
                    flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
                  ),

                /// BOTTOM SHADOW
                if (widget.mutableSlide != null)
                  const FooterShadow(
                    flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
                  ),

                // /// STATIC FOOTER
                // if (widget.mutableSlide != null)
                // const StaticFooter(
                //   flyerBoxWidth: ShelfSlide.flyerBoxWidth,
                // ),

                /// STATIC HEADER
                if (widget.mutableSlide != null)
                  const HeaderTemplate(
                    flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
                    opacity: 0.5,
                  ),

                /// HEADLINE
                if (widget.mutableSlide != null)
                  SlideHeadline(
                    flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
                    verse: Verse(
                      text: widget.mutableSlide.headline,
                      translate: false,
                    ),
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
// -----------------------------------------------------------------------------
}
