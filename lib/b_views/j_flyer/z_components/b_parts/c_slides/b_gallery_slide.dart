import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';

class GallerySlide extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const GallerySlide({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.onMaxBounce,
    this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final String heroTag;
  final Function onMaxBounce;
  /// --------------------------------------------------------------------------
  @override
  State<GallerySlide> createState() => _GallerySlideState();
  /// --------------------------------------------------------------------------
}

class _GallerySlideState extends State<GallerySlide> {
  /// --------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  bool _canPaginate;
  bool _canBounce = false;
  // -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

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
  @override
  void dispose() {
    _scrollController.dispose();
    _loadedFlyers.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _addScrollListener() async {

    /// TASK : REFACTOR THIS SCROLLER LISTENER : OR MAYBE CREATE FUTURE PAGINATOR WIDGET
    // Scrollers.createPaginationListener(
    //     controller: controller,
    //     isPaginating: isPaginating,
    //     canKeepReading: canKeepReading,
    //     onPaginate: onPaginate
    // );

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

    setNotifier(
        notifier: _loadedFlyers,
        mounted: mounted,
        value: <FlyerModel>[..._loadedFlyers.value, ...flyers],
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _headerAndProgressHeights = FlyerDim.headerSlateAndProgressHeights(
      flyerBoxWidth: widget.flyerBoxWidth,
    );

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

            return MaxBounceNavigator(
              onNavigate: () async {

                if (_canBounce = true) {
                  _canBounce = false;
                  blog('Bouncing back : $_canBounce');
                  await widget.onMaxBounce();

                  /// to wait header shrinkage until allowing new shrinkage
                  await Future.delayed(Ratioz.duration750ms, () {
                    _canBounce = true;
                  });
                }
              },
              boxDistance: FlyerDim.flyerHeightByFlyerWidth(
                flyerBoxWidth: widget.flyerBoxWidth,
              ),
              // numberOfScreens: 2,
              slideLimitRatio: 0.1,
              child: FlyersGrid(
                gridWidth: widget.flyerBoxWidth,
                gridHeight: widget.flyerBoxHeight,
                flyers: flyers,
                isHeroicGrid: true,
                topPadding: _headerAndProgressHeights,
                // numberOfColumns: 2,
                screenName: widget.heroTag,
                scrollController: _scrollController,
              ),
            );

          },

        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
