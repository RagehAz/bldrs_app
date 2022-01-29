import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GallerySlide extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const GallerySlide({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.flyerModel,
    @required this.bzModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  State<GallerySlide> createState() => _GallerySlideState();
}

class _GallerySlideState extends State<GallerySlide> {
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;

    if (_loading.value == true) {
      blog('LOADING --------------------------------------');
    } else {
      blog('LOADING COMPLETE -----------------------------');
    }
  }

// -----------------------------------------------------------------------------
  ScrollController _scrollController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {

        /// GET FLYERS IDS
        final List<String> _flyersIDs = _getFlyersIDs(bzModel: widget.bzModel);

        /// GET FLYERS
        final List<FlyerModel> _flyers = await _readMoreFlyers(
          flyersIDs: _flyersIDs,
        );

        /// ADD FLYERS
        _addToBzFlyers(_flyers);

        /// END
        await _triggerLoading();

      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _scrollController.dispose();
    _bzFlyers.dispose();
    _loading.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------

  /// BZ FLYERS

// --------------------------------------------
  final ValueNotifier<List<FlyerModel>> _bzFlyers = ValueNotifier(<FlyerModel>[]);
// --------------------------------------------
  void _addToBzFlyers(List<FlyerModel> flyers){
    _bzFlyers.value = <FlyerModel>[..._bzFlyers.value, ...flyers];
  }
// --------------------------------------------
  Future<List<FlyerModel>> _readMoreFlyers({@required List<String> flyersIDs}) async {

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    final List<FlyerModel> _flyers = await _flyersProvider.fetchFlyersByIDs(context: context, flyersIDs: flyersIDs);
    return _flyers;
  }
// -----------------------------------------------------------------------------

  /// FLYERS IDS

// --------------------------------------------
  List<String> _flyersIDs = <String>[];
// --------------------------------------------
  List<String> _getFlyersIDs({@required BzModel bzModel}){
    final List<String> _ids = <String>[];

    /// TASK : THINGS

    return _ids;
  }
// --------------------------------------------
  void _addToFlyersIDs(List<String> flyersIDs){

    /// TASK : THINGS

    _flyersIDs = <String>[..._flyersIDs, ];
  }
// -----------------------------------------------------------------------------
  void _onFlyerTap(FlyerModel flyerModel){
    blog('tapping on flyer : ${flyerModel.id}');
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
        margin: EdgeInsets.only(top: _headerAndProgressHeights),
        decoration: const BoxDecoration(
          color: Colorz.yellow255,
        ),
        alignment: Alignment.center,
        child: ValueListenableBuilder(
          valueListenable: _bzFlyers,
          child: Container(),
          builder: (_, List<FlyerModel> flyers, Widget child){

            return FlyersGrid(
              gridZoneWidth: widget.flyerBoxWidth,
              scrollable: true,
              scrollController: _scrollController,
              onFlyerTap: _onFlyerTap,
              numberOfColumns: 2,
              flyers: flyers,
            );

          },

        ),
      ),
    );

  }
}
