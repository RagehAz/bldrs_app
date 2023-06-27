import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/xx_draft_shelf_controllers.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/d_shelf_slides_part.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/draft_shelf/a_draft_shelf_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/draft_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:mediators/pic_maker/pic_maker.dart';

class SlidesShelf extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SlidesShelf({
    required this.shelfNumber,
    required this.bzModel,
    required this.draftNotifier,
    super.key
  });
  /// --------------------------------------------------------------------------
  final int shelfNumber;
  final BzModel bzModel;
  final ValueNotifier<DraftFlyer> draftNotifier;
  /// --------------------------------------------------------------------------
  @override
  _SlidesShelfState createState() => _SlidesShelfState();
  /// --------------------------------------------------------------------------
}

class _SlidesShelfState extends State<SlidesShelf> with AutomaticKeepAliveClientMixin{
  // -----------------------------------------------------------------------------
  @override
  bool get wantKeepAlive => true;
  // -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
   */
  // -----------------------------------------------------------------------------
  /*
  @override
  void initState() {
    super.initState();
  }
   */
  // --------------------
  @override
  void dispose(){
    _scrollController.dispose();
    _loading.dispose();
    super.dispose();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //   await _triggerLoading(setTo: false);
      // });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);
    // --------------------
    final double _slideZoneHeight = DraftShelfSlide.shelfSlideZoneHeight();
    // --------------------
    return Container(
      width: Scale.screenWidth(context),
      height: DraftShelfBox.height(),
      decoration: BoxDecoration(
        // color: Colorz.white10,
        borderRadius: Borderers.cornerAll(Bubble.clearCornersValue),
      ),
      alignment: BldrsAligners.superCenterAlignment(context),
      child: ValueListenableBuilder(
        valueListenable: widget.draftNotifier,
        builder: (_, DraftFlyer draft, Widget? child){

          /// WHILE LOADING GIVEN EXISTING FLYER MODEL
          if (draft == null){

            return Container(
              width: DraftShelfSlide.flyerBoxWidth,
              height: _slideZoneHeight,
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(Ratioz.appBarPadding),
              child: const FlyerLoading(
                flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
                animate: false,
              ),
            );

          }

          else {

            return ShelfSlidesPart(
              loading: _loading,
              slideZoneHeight: _slideZoneHeight,
              scrollController: _scrollController,
              draft: draft,
              onSlideTap: (DraftSlide slide) => onSlideTap(
                slide: slide,
                draftFlyer: widget.draftNotifier,
                mounted: mounted,
              ),
              onDeleteSlide: (DraftSlide slide)=> onDeleteSlide(
                draftSlide: slide,
                draftFlyer: widget.draftNotifier,
                mounted: mounted,
              ),
              onAddSlides: (PicMakerType imagePickerType) => onAddNewSlides(
                context: context,
                isLoading: _loading,
                draftFlyer: widget.draftNotifier,
                bzModel: widget.bzModel,
                mounted: mounted,
                scrollController: _scrollController,
                flyerWidth: DraftShelfSlide.flyerBoxWidth,
                imagePickerType: imagePickerType,
              ),
              onReorderSlide: (int oldIndex, int newIndex) => onReorderSlide(
                draftFlyer: widget.draftNotifier,
                mounted: mounted,
                oldIndex: oldIndex,
                newIndex: newIndex,
              )

            );

          }

        },
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
