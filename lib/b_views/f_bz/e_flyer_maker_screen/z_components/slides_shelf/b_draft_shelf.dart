import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/draft_shelf/a_draft_shelf_box.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/d_shelf_slides_part.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/draft_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/xx_draft_shelf_controllers.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SlidesShelf extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SlidesShelf({
    @required this.shelfNumber,
    @required this.bzModel,
    @required this.draftNotifier,
    Key key,
  }) : super(key: key);
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
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
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
    final double _slideZoneHeight = DraftShelfSlide.shelfSlideZoneHeight(context);
    // --------------------
    return Container(
      width: Scale.screenWidth(context),
      height: DraftShelfBox.height(context),
      decoration: BoxDecoration(
        // color: Colorz.white10,
        borderRadius: Borderers.cornerAll(context, Bubble.clearCornersValue),
      ),
      alignment: Aligners.superCenterAlignment(context),
      child: ValueListenableBuilder(
        valueListenable: widget.draftNotifier,
        builder: (_, DraftFlyer draft, Widget child){

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
                context: context,
                slide: slide,
                draftFlyer: widget.draftNotifier,
                mounted: mounted,
              ),
              onDeleteSlide: (DraftSlide slide)=> onDeleteSlide(
                context: context,
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

            );

          }

        },
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
