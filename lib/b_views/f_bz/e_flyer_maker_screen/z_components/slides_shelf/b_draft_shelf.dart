import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/a_shelf_box.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/d_shelf_slides_part.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/e_shelf_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/xx_draft_shelf_controllers.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SlidesShelf extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SlidesShelf({
    @required this.shelfNumber,
    @required this.bzModel,
    @required this.draft,
    @required this.isEditingFlyer,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final int shelfNumber;
  final BzModel bzModel;
  final ValueNotifier<DraftFlyerModel> draft;
  final ValueNotifier<bool> isEditingFlyer;
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
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'SlidesShelf',);
    }
  }
   */
  // -----------------------------------------------------------------------------
  ScrollController _scrollController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }
  // --------------------
  /// TAMAM
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
    final double _slideZoneHeight = ShelfSlide.shelfSlideZoneHeight(context);
    // --------------------
    return Container(
      width: Scale.superScreenWidth(context),
      height: ShelfBox.height(context),
      decoration: BoxDecoration(
        // color: Colorz.white10,
        borderRadius: Borderers.superBorderAll(context, Bubble.clearCornersValue),
      ),
      alignment: Aligners.superCenterAlignment(context),
      child: ValueListenableBuilder(
        valueListenable: widget.draft,
        builder: (_, DraftFlyerModel draft, Widget child){

          /// WHILE LOADING GIVEN EXISTING FLYER MODEL
          if (draft == null){
            return Container(
              width: ShelfSlide.flyerBoxWidth,
              height: ShelfSlide.shelfSlideZoneHeight(context),
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(Ratioz.appBarPadding),
              child: const FlyerLoading(
                  flyerBoxWidth: ShelfSlide.flyerBoxWidth
              ),
            );
          }

          else {
            return ShelfSlidesPart(
              loading: _loading,
              slideZoneHeight: _slideZoneHeight,
              scrollController: _scrollController,
              draft: draft,
              isEditingFlyer: widget.isEditingFlyer,
              onSlideTap: (MutableSlide slide) => onSlideTap(
                context: context,
                slide: slide,
                draftFlyer: widget.draft,
              ),
              onAddSlides: (ImagePickerType imagePickerType) => onAddNewSlides(
                context: context,
                isLoading: _loading,
                draftFlyer: widget.draft,
                bzModel: widget.bzModel,
                mounted: mounted,
                scrollController: _scrollController,
                flyerWidth: ShelfSlide.flyerBoxWidth,
                isEditingFlyer: widget.isEditingFlyer.value,
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
