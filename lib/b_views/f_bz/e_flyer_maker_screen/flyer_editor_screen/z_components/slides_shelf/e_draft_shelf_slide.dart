import 'package:basics/components/animators/matrix_animator.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/helpers/space/trinity.dart';
import 'package:basics/components/super_box/src/f_super_box_tap_layer/x_tap_layer.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/delete_draft_slide_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/c_slide_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/d_footer_shadow.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/components/e_slide_headline.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';
import 'package:basics/components/super_image/super_image.dart';

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
  final DraftSlide? draftSlide;
  final int? number;
  final Function? onTap;
  final Function? onDeleteSlide;
  /// --------------------------------------------------------------------------
  static const double flyerBoxWidth = 110;
  static const double slideNumberBoxHeight = 20;
  // -----------------------------------------------------------------------------
  static double flyerBoxHeight(){
    return FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: flyerBoxWidth,
    );
  }
// --------------------
  static double shelfSlideZoneHeight(){
    final double _flyerBoxHeight = flyerBoxHeight();
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
      margin: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enLeft: Ratioz.appBarMargin,
      ),
      child: Column(
        children: <Widget>[

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding),

          /// FLYER NUMBER
          ReorderableDragStartListener(
            index: widget.draftSlide?.slideIndex ?? 0,
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
                color: Colorz.white10,
                bubble: DeviceChecker.deviceIsWindows(),
                onTap: (){},
              ),
            ),
          ),

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding),

          /// SLIDE
          GestureDetector(
            onTap: widget.onTap == null ? null : () => widget.onTap?.call(),
            onDoubleTap: _onReAnimate,
            child: FlyerBox(
              key: const ValueKey<String>('shelf_slide_flyer_box'),
              flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
              boxColor: widget.draftSlide?.midColor ?? Colorz.white10,
              stackWidgets: <Widget>[

                /// BACK PIC
                if (widget.draftSlide?.backPic != null)
                  BldrsImage(
                    width: DraftShelfSlide.flyerBoxWidth,
                    height: _flyerBoxHeight,
                    pic: widget.draftSlide?.backPic?.bytes,
                    // loading: false,
                  ),

                /// BACK COLOR
                if (widget.draftSlide?.backColor != null)
                  Container(
                    width: DraftShelfSlide.flyerBoxWidth,
                    height: _flyerBoxHeight,
                    color: widget.draftSlide!.backColor,
                  ),

                /// IMAGE
                if (widget.draftSlide != null)
                  ValueListenableBuilder(
                    valueListenable: _animateSlide,
                    builder: (_, bool _animate, Widget? child){

                      if (_animate == true){
                        return MatrixAnimator(
                          matrix: Trinity.renderSlideMatrix(
                              matrix: widget.draftSlide?.matrix,
                              flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
                              flyerBoxHeight: _flyerBoxHeight
                          ),
                          matrixFrom: Trinity.renderSlideMatrix(
                              matrix: widget.draftSlide?.matrixFrom,
                              flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
                              flyerBoxHeight: _flyerBoxHeight
                          ),
                          canAnimate: widget.draftSlide?.animationCurve != null,
                          replayOnRebuild: true,
                          child: child!,
                        );
                      }
                      else {
                        return child!;
                      }

                    },
                    child: SuperFilteredImage(
                      width: DraftShelfSlide.flyerBoxWidth,
                      height: _flyerBoxHeight,
                      // bytes: widget.draftSlide.picModel.bytes,
                      pic: widget.draftSlide?.bigPic?.bytes,
                      boxFit: BoxFit.fitWidth,
                      loading: false,
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

                /// STATIC HEADER
                if (widget.draftSlide != null)
                  ReorderableDragStartListener(
                    index: widget.draftSlide?.slideIndex ?? 0,
                    child: TapLayer(
                      width: DraftShelfSlide.flyerBoxWidth,
                      height: FlyerDim.headerSlateHeight(DraftShelfSlide.flyerBoxWidth),
                      corners: FlyerDim.headerSlateCorners(flyerBoxWidth: DraftShelfSlide.flyerBoxWidth),
                      boxColor: Colorz.black80,
                      splashColor: Colorz.white20,
                    ),
                  ),

                /// HEADLINE
                if (widget.draftSlide != null)
                  SlideHeadline(
                    flyerBoxWidth: DraftShelfSlide.flyerBoxWidth, /// i don't know why i decreased the 10
                    text: widget.draftSlide?.headline,
                  ),

                /// DELETE SLIDE
                if (widget.draftSlide != null)
                  DeleteDraftSlideButton(
                    onTap: () => widget.onDeleteSlide?.call(),
                  ),

              ],
            ),
          ),

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding),

        ],
      ),
    );

  }
// -----------------------------------------------------------------------------
}
