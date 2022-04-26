import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/a_shelf_box.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/d_shelf_slides_part.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/e_shelf_slide.dart';
import 'package:bldrs/c_controllers/i_flyer_maker_controllers/draft_shelf_controller.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SlidesShelf extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SlidesShelf({
    @required this.shelfNumber,
    @required this.bzModel,
    @required this.draft,
    @required this.headlineController,
    Key key,
}) : super(key: key);
  /// --------------------------------------------------------------------------
  final int shelfNumber;
  final BzModel bzModel;
  final ValueNotifier<DraftFlyerModel> draft; /// p
  final TextEditingController headlineController;
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
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading({bool setTo}) async {
    _loading.value = setTo ?? !_loading.value;
    blogLoading(loading: _loading.value);
  }
// -----------------------------------------------------------------------------
  ScrollController _scrollController; /// tamam disposed
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
    _loading.dispose();
  }
// -----------------------------------------------------------------------------
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
    /// when using with AutomaticKeepAliveClientMixin
    super.build(context);
// -----------------------------------------------------------------------------
    final double _slideZoneHeight = ShelfSlide.shelfSlideZoneHeight(context);

    return Container(
      width: superScreenWidth(context),
      height: ShelfBox.height(context),
      decoration: BoxDecoration(
        color: Colorz.white10,
        borderRadius: superBorderAll(context, Bubble.clearCornersValue),
      ),
      alignment: superCenterAlignment(context),
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
              mutableSlides: draft?.mutableSlides,
              onSlideTap: (MutableSlide slide) => onSlideTap(
                context: context,
                slide: slide,
                draftFlyer: widget.draft,
              ),
              onAddNewSlides: () => onAddNewSlides(
                context: context,
                isLoading: _loading,
                draftFlyer: widget.draft,
                bzModel: widget.bzModel,
                mounted: mounted,
                scrollController: _scrollController,
                headlineController: widget.headlineController,
                flyerWidth: ShelfSlide.flyerBoxWidth,
              ),
            );

          }

        },
      ),
    );
// -----------------------------------------------------------------------------
  }
}
