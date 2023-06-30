import 'package:basics/animators/widgets/animate_widget_to_matrix.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/delete_draft_slide_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/c_slide_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/d_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/e_slide_headline.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/template_flyer/b_header_template.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';
import 'package:basics/super_image/super_image.dart';

class DraftShelfSlide extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DraftShelfSlide({
    required this.draftSlide,
    required this.number,
    required this.onTap,
    required this.onDeleteSlide,
    super.key
  });
  /// --------------------------------------------------------------------------
  final DraftSlide draftSlide;
  final int number;
  final Function onTap;
  final Function onDeleteSlide;
  /// --------------------------------------------------------------------------
  static const double flyerBoxWidth = 150;
  static const double slideNumberBoxHeight = 20;
  // -----------------------------------------------------------------------------
  static double shelfSlideZoneHeight(){
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
    );
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

    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
    );

    return Container(
      width: DraftShelfSlide.flyerBoxWidth,
      height: DraftShelfSlide.shelfSlideZoneHeight(),
      margin: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding,),
      child: Column(
        children: <Widget>[

          /// SPACER
          const SizedBox(
            height: Ratioz.appBarPadding,
          ),

          /// FLYER NUMBER
          ReorderableDragStartListener(
            index: widget.draftSlide.slideIndex,
            child: Container(
              width: DraftShelfSlide.flyerBoxWidth,
              height: DraftShelfSlide.slideNumberBoxHeight,
              alignment: BldrsAligners.superCenterAlignment(context),
              child: widget.number == null ?
              const SizedBox()
                  :
              BldrsBox(
                verse: Verse.plain('${widget.number}'),
                height: DraftShelfSlide.slideNumberBoxHeight,
                // color: Colorz.white255,
                color: widget.draftSlide?.midColor?.withAlpha(80) ?? Colorz.white10,
                bubble: DeviceChecker.deviceIsWindows(),
                onTap: (){},
              ),
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
                    builder: (_, bool _animate, Widget? child){

                      if (_animate == true){
                        return AnimateWidgetToMatrix(
                          matrix: Trinity.renderSlideMatrix(
                              matrix: widget.draftSlide.matrix,
                              flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
                              flyerBoxHeight: _flyerBoxHeight
                          ),
                          replayOnRebuild: true,
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
                    flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
                    opacity: 0.5,
                  ),

                /// HEADLINE
                if (widget.draftSlide != null)
                  SlideHeadline(
                    flyerBoxWidth: DraftShelfSlide.flyerBoxWidth, /// i don't know why i decreased the 10
                    text: widget.draftSlide.headline,
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
