import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/a_shelf_box.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/d_shelf_slides_part.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/e_shelf_slide.dart';
import 'package:bldrs/c_controllers/i_flyer_maker_controllers/draft_shelf_controller.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class DraftShelf extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DraftShelf({
    @required this.shelfNumber,
    @required this.bzModel,
    @required this.flyerModel,
    Key key,
}) : super(key: key);
  /// --------------------------------------------------------------------------
  final int shelfNumber;
  final BzModel bzModel;
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  @override
  _DraftShelfState createState() => _DraftShelfState();
  /// --------------------------------------------------------------------------
}

class _DraftShelfState extends State<DraftShelf> with AutomaticKeepAliveClientMixin{
// -----------------------------------------------------------------------------
  @override
  bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// -----------------------------------------------------------------------------
  final TextEditingController _headlineController = TextEditingController();
  final ValueNotifier<int> _headlineLength = ValueNotifier(0);
// ----------------------------------------
  ValueNotifier<DraftFlyerModel> _draftFlyer;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  ValueNotifier<bool> _loading;
// -----------------------------------
  Future<void> _triggerLoading({bool setTo}) async {
    _loading.value = setTo ?? !_loading.value;
    blogLoading(loading: _loading.value);
  }
// -----------------------------------------------------------------------------
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _loading = ValueNotifier(false);
    _draftFlyer = ValueNotifier<DraftFlyerModel>(null);
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose(){
    disposeControllerIfPossible(_headlineController);
    super.dispose();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

        _triggerLoading(setTo: true).then((_) async {

          _draftFlyer.value = await initializeDraftFlyerModel(
            bzModel: widget.bzModel,
            existingFlyer: widget.flyerModel,
          );

          await _triggerLoading(setTo: false);
        });

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
      color: Colorz.white10,
      alignment: superCenterAlignment(context),
      child: ValueListenableBuilder(
        valueListenable: _draftFlyer,
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
              flyerHeaderController: _headlineController,
              onSlideTap: (MutableSlide slide) => onSlideTap(
                context: context,
                slide: slide,
                draftFlyer: _draftFlyer,
              ),
              onAddNewSlides: () => onAddNewSlides(
                context: context,
                isLoading: _loading,
                draftFlyer: _draftFlyer,
                bzModel: widget.bzModel,
                mounted: mounted,
                scrollController: _scrollController,
                headlineController: _headlineController,
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
