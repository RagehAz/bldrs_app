import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class GallerySlide extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const GallerySlide({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.flyerModel,
    @required this.bzModel,
    this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final String heroTag;
  /// --------------------------------------------------------------------------
  @override
  State<GallerySlide> createState() => _GallerySlideState();
  /// --------------------------------------------------------------------------
}

class _GallerySlideState extends State<GallerySlide> {
  // -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {

    if (setTo != null){
      _loading.value = setTo;
    }
    else {
      _loading.value = !_loading.value;
    }

    if (_loading.value == true) {
      blog('GallerySlide : LOADING --------------------------------------');
    } else {
      blog('GallerySlide : LOADING COMPLETE -----------------------------');
    }

  }
  // -----------------------------------------------------------------------------
  ScrollController _scrollController;
  bool _canPaginate;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_addScrollListener);

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {

        await _fetchMoreFlyers();

      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _scrollController.dispose();
    _loadedFlyers.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _addScrollListener() async {
    final double _maxScroll = _scrollController.position.maxScrollExtent;
    final double _currentScroll = _scrollController.position.pixels;
    // final double _screenHeight = Scale.superScreenHeight(context);
    const double _paginationHeightLight = Ratioz.horizon * 3;

    if (_maxScroll - _currentScroll <= _paginationHeightLight && _canPaginate == true){

      // blog('_maxScroll : $_maxScroll : _currentScroll : $_currentScroll : diff : ${_maxScroll - _currentScroll} : _delta : $_delta');

      _canPaginate = false;

      await _fetchMoreFlyers();

      _canPaginate = true;

    }

  }
  // -----------------------------------------------------------------------------

  /// BZ FLYERS

  // --------------------
  final ValueNotifier<List<FlyerModel>> _loadedFlyers = ValueNotifier(<FlyerModel>[]);
  // --------------------
  Future<void> _fetchMoreFlyers() async {

    unawaited(_triggerLoading(setTo: true));

    final List<FlyerModel> _moreFlyers = await fetchMoreFlyers(
      context: context,
      flyerModel: widget.flyerModel,
      bzModel: widget.bzModel,
      loadedFlyers: _loadedFlyers.value,
      heroTag: widget.heroTag,
    );

    _addToBzFlyers(_moreFlyers);

    unawaited(_triggerLoading(setTo: true));
  }
  // --------------------
  void _addToBzFlyers(List<FlyerModel> flyers){
    _loadedFlyers.value = <FlyerModel>[..._loadedFlyers.value, ...flyers];
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _headerAndProgressHeights =
    FlyerDim.headerAndProgressHeights(context, widget.flyerBoxWidth);

    return ClipRRect(
      key: const ValueKey<String>('Gallery_slide_of_Flyer'),
      borderRadius: FlyerDim.footerBoxCorners(context: context, flyerBoxWidth: widget.flyerBoxWidth),
      child: Container(
        width: widget.flyerBoxWidth,
        height: widget.flyerBoxHeight,
        color: Colorz.black80,
        // margin: EdgeInsets.only(top: _headerAndProgressHeights),
        // decoration: const BoxDecoration(
        //   color: Colorz.yellow255,
        // ),
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder(
          valueListenable: _loadedFlyers,
          child: Container(),
          builder: (_, List<FlyerModel> flyers, Widget child){

            return FlyersGrid(
              gridWidth: widget.flyerBoxWidth,
              gridHeight: widget.flyerBoxHeight,
              flyers: flyers,
              topPadding: _headerAndProgressHeights,
              // numberOfColumns: 2,
              heroTag: widget.heroTag,
              scrollController: _scrollController,
            );

          },

        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
