import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/a_shelf_box.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/c_shelf_header_part.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/d_shelf_slides_part.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/e_shelf_slide.dart';
import 'package:bldrs/c_controllers/i_flyer_maker_controllers/draft_shelf_controller.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class DraftShelf extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DraftShelf({
    @required this.shelfNumber,
    @required this.onDeleteDraft,
    @required this.bzModel,
    @required this.flyerModel,
    @required this.shelfUI,
    Key key,
}) : super(key: key);
  /// --------------------------------------------------------------------------
  final int shelfNumber;
  final Function onDeleteDraft;
  final BzModel bzModel;
  final FlyerModel flyerModel;
  final ValueNotifier<ShelfUI> shelfUI;
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
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(loading: _loading.value);
  }
// -----------------------------------------------------------------------------
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
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

      _triggerLoading().then((_) async {

        _draftFlyer.value = await initializeDraftFlyerModel(
          bzModel: widget.bzModel,
          existingFlyer: widget.flyerModel,
        );

        await _triggerLoading();
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
    if (_draftFlyer == null){
      return const SizedBox();
    }
// -----------------------------------------------------------------------------
    else {

      final double _slideZoneHeight = ShelfSlide.shelfSlideZoneHeight(context);

      return ShelfBox(
        shelfUI: widget.shelfUI,
        child: ValueListenableBuilder(
          valueListenable: _draftFlyer,
          builder: (_, DraftFlyerModel draft, Widget child){

            if (draft == null){
              return const SizedBox();
            }
            else {
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[

                  /// SHELF HEADER
                  ShelfHeaderPart(
                    formKey: _formKey,
                    draft: draft,
                    shelfNumber: widget.shelfNumber,
                    titleLength: _headlineLength,
                    loading: _loading,
                    headlineController: _headlineController,
                    onHeadlineChanged: (String val) => onFlyerHeadlineChanged(
                      val: val,
                      formKey: _formKey,
                      headlineLength: _headlineLength,
                      draftFlyer: _draftFlyer,
                    ),
                    onMoreTap: () => onMoreTap(
                      context: context,
                      onDeleteDraft: widget.onDeleteDraft,
                      onPublishFlyer: (){blog('on publish flyer is tapped');},
                      onSaveDraft: (){blog('on Save flyer is tapped');},
                    ),
                  ),

                  /// SHELF SLIDES
                  ShelfSlidesPart(
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
                  ),

                ],
              );
            }

          },
        ),
      );

    }
// -----------------------------------------------------------------------------
  }
}
