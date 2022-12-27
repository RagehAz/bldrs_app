import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/delete_draft_slide_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/c_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/d_slide_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/e_slide_headline.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_header_template.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/animators/animate_widget_to_matrix.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/drafters/trinity.dart';

import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class DraftShelfSlide extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DraftShelfSlide({
    @required this.draftSlide,
    @required this.number,
    @required this.onTap,
    @required this.onDeleteSlide,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final DraftSlide draftSlide;
  final int number;
  final Function onTap;
  final Function onDeleteSlide;
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

    setNotifier(notifier: _animateSlide, mounted: mounted, value: false);
    setNotifier(notifier: _animateSlide, mounted: mounted, value: true);

  }
  // -----------------------------------------------------------------------------
  @override
  void dispose() {
    _animateSlide.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(context, DraftShelfSlide.flyerBoxWidth);
    // blog('ShelfSlide : BUILDING : picSize : ${widget.draftSlide?.picModel?.bytes?.length} bytes');

    return Container(
      width: DraftShelfSlide.flyerBoxWidth - 10,
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
              labelColor: widget.draftSlide?.midColor?.withAlpha(80) ?? Colorz.white10,
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
              flyerBoxWidth: DraftShelfSlide.flyerBoxWidth - 10,
              boxColor: widget.draftSlide?.midColor ?? Colorz.white10,
              stackWidgets: <Widget>[

                /// BACK GROUND COVER PIC
                if (widget.draftSlide != null)
                  SuperFilteredImage(
                    width: DraftShelfSlide.flyerBoxWidth,
                    height: _flyerBoxHeight,
                    pic: widget.draftSlide.picModel?.bytes,
                    filterModel: widget.draftSlide?.filter,
                  ),

                /// BLUR LAYER
                if (widget.draftSlide != null)
                  BlurLayer(
                    key: const ValueKey<String>('blur_layer'),
                    width: DraftShelfSlide.flyerBoxWidth,
                    height: _flyerBoxHeight,
                    blurIsOn: true,
                    blur: 20,
                    borders: FlyerDim.flyerCorners(context, DraftShelfSlide.flyerBoxWidth),
                  ),

                /// IMAGE
                if (widget.draftSlide != null)
                  ValueListenableBuilder(
                    valueListenable: _animateSlide,
                    builder: (_, bool _animate, Widget child){

                      if (_animate == true){
                        return AnimateWidgetToMatrix(
                          matrix: Trinity.renderSlideMatrix(
                              matrix: widget.draftSlide.matrix,
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
                      width: DraftShelfSlide.flyerBoxWidth - 10,
                      height: _flyerBoxHeight,
                      // bytes: widget.draftSlide.picModel.bytes,
                      pic: widget.draftSlide.picModel?.bytes,
                      filterModel: widget.draftSlide?.filter,
                      boxFit: widget.draftSlide.picFit,
                    ),
                  ),

                /// SLIDE SHADOW
                if (widget.draftSlide != null)
                  const SlideShadow(
                    flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
                  ),

                /// BOTTOM SHADOW
                if (widget.draftSlide != null)
                  const FooterShadow(
                    flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
                  ),

                // /// STATIC FOOTER
                // if (widget.mutableSlide != null)
                // const StaticFooter(
                //   flyerBoxWidth: ShelfSlide.flyerBoxWidth,
                // ),

                /// STATIC HEADER
                if (widget.draftSlide != null)
                  const HeaderTemplate(
                    flyerBoxWidth: DraftShelfSlide.flyerBoxWidth - 10,
                    opacity: 0.5,
                  ),

                /// HEADLINE
                if (widget.draftSlide != null)
                  SlideHeadline(
                    flyerBoxWidth: DraftShelfSlide.flyerBoxWidth - 10, /// i don't know why i decreased the 10
                    verse: Verse(
                      text: widget.draftSlide.headline,
                      translate: false,
                    ),
                  ),

                if (widget.draftSlide != null)
                  DeleteDraftSlideButton(
                    onTap: widget.onDeleteSlide,
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
