import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
}

class _GallerySlideState extends State<GallerySlide> {
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------------------------------
  Future<void> _triggerLoading({bool setTo}) async {

    if (setTo != null){
      _loading.value = setTo;
    }
    else {
      _loading.value = !_loading.value;
    }

    if (_loading.value == true) {
      blog('LOADING --------------------------------------');
    } else {
      blog('LOADING COMPLETE -----------------------------');
    }

  }
// -----------------------------------------------------------------------------
  ScrollController _scrollController;
  bool _canPaginate;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _scrollController = ScrollController();

    _scrollController.addListener(() async {

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

    });


    super.initState();
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _scrollController.dispose();
    _loadedFlyers.dispose();
    _loading.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------

  /// BZ FLYERS

// --------------------------------------------
  final ValueNotifier<List<FlyerModel>> _loadedFlyers = ValueNotifier(<FlyerModel>[]);
// --------------------------------------------
  Future<void> _fetchMoreFlyers() async {

    unawaited(_triggerLoading(setTo: true));

    final List<String> _loadedFlyersIDs = FlyerModel.getFlyersIDsFromFlyers(_loadedFlyers.value);

    final List<String> _nextFlyersIDs = _getNextFlyersIDs(
        allFlyersIDs: widget.bzModel.flyersIDs,
        loadedFlyersIDs: _loadedFlyersIDs,
    );


    final List<FlyerModel> _moreFlyers = await _fetchFlyers(flyersIDs: _nextFlyersIDs);

    _addToBzFlyers(_moreFlyers);

    unawaited(_triggerLoading(setTo: true));
  }
// --------------------------------------------
  void _addToBzFlyers(List<FlyerModel> flyers){
    _loadedFlyers.value = <FlyerModel>[..._loadedFlyers.value, ...flyers];
  }
// --------------------------------------------
  Future<List<FlyerModel>> _fetchFlyers({@required List<String> flyersIDs}) async {
    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    final List<FlyerModel> _flyers = await _flyersProvider.fetchFlyersByIDs(context: context, flyersIDs: flyersIDs);
    return _flyers;
  }
// --------------------------------------------
  /// GETS ONLY THE NEXT UNLOADED NUMBER OF FLYERS IDS
  List<String> _getNextFlyersIDs({
    @required List<String> allFlyersIDs,
    @required List<String> loadedFlyersIDs,
    int numberOfFlyers = 4,
  }){
    final List<String> _nextFlyersIDs = <String>[];

    /// 1 - check each id in all Ids
    /// 2 - if id is already inserted in [loadedFlyersIDs], skip
    /// 3 - if not
    ///   A - if next flyers IDs reach max count [numberOfFlyers] => break
    ///   B - if not : insert that id

    for (int i = 0; i < allFlyersIDs.length; i++){

      /// A - WHILE TARGET [numberOfFlyers] NOT YET REACHED
      if (_nextFlyersIDs.length <= numberOfFlyers){

        final String _flyerID = allFlyersIDs[i];

        final bool _alreadyLoaded = Mapper.stringsContainString(
          strings: loadedFlyersIDs,
          string: _flyerID,
        );

        final List<String> _parentFlyersIDs = _getFlyersIDsFromHeroTag();

        final bool _alreadyAParentFlyer = Mapper.stringsContainString(
            strings: _parentFlyersIDs,
            string: _flyerID
        );

        final bool _flyerIsAlreadyActive = _flyerID == widget.flyerModel.id;

        /// B - WHEN ID IS NOT YET LOADED NOR A PARENT
        if (
        _alreadyLoaded == false
            &&
            _flyerIsAlreadyActive == false
            &&
            _alreadyAParentFlyer == false
        ){
          /// do nothing and go next
          _nextFlyersIDs.add(_flyerID);
        }

        /// B - WHEN ID IS ALREADY LOADED
        // else {
        /// do nothing
        // }

      }

      /// A - WHEN TARGET [numberOfFlyers] IS REACHED
      else {
        break;
      }

    }

    return _nextFlyersIDs;
  }
// -----------------------------------------------------------------------------
  List<String> _getFlyersIDsFromHeroTag(){
    final List<String> _flyersIDs = widget.heroTag?.split('_');

    List<String> _output = <String>[];

    if (Mapper.canLoopList(_flyersIDs)){
      _output = [..._flyersIDs];
    }

    return _output;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _headerAndProgressHeights = FlyerBox.headerAndProgressHeights(
      context: context,
      flyerBoxWidth: widget.flyerBoxWidth,
    );

    return ClipRRect(
      borderRadius: FlyerFooter.corners(context: context, flyerBoxWidth: widget.flyerBoxWidth),
      child: Container(
        width: widget.flyerBoxWidth,
        height: widget.flyerBoxHeight,
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
              numberOfColumns: 2,
              heroTag: widget.heroTag,
            );

          },

        ),
      ),
    );

  }
}
