import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_light_flyer_structure/a_light_small_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_light_flyer_structure/b_light_big_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/src/zoomable_grid.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/src/zoomable_grid_controller.dart';
import 'package:flutter/material.dart';

class FlyersZoomedLayout extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyersZoomedLayout({
    @required this.controller,
    Key key
  }) : super(key: key);

  final ZoomableGridController controller;

  @override
  State<FlyersZoomedLayout> createState() => _FlyersZoomedLayoutState();
}

class _FlyersZoomedLayoutState extends State<FlyersZoomedLayout> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<Map<String, dynamic>> _selectedModels = ValueNotifier(null);
  ZoomableGridController _controller;
  // -----------------------------------------------------------------------------
  /// --- LOADING
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

    _controller = widget.controller;

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> onZoomInStart() async {
    blog('onZoomInStart');
  }
  Future<void> onZoomInEnd() async {
    blog('onZoomInEnd');
  }
  Future<void> onZoomOutStart() async {
    blog('onZoomOutStart');
  }
  Future<void> onZoomOutEnd() async {
    blog('onZoomOutEnd');
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: true);

    final List<String> _flyersIDs = [..._user.savedFlyers.all];

    return MainLayout(
      appBarType: AppBarType.basic,
      child: ZoomableGrid(
        controller: _controller,
        bigItemFootprint: FlyerBox(
          flyerBoxWidth: _controller.getBigItemWidth(context),
          boxColor: Colorz.black255,
        ),

        bigItem: ValueListenableBuilder(
          valueListenable: _selectedModels,
          builder: (_, Map<String, dynamic> maps, Widget child){

            final FlyerModel flyerModel = maps['flyerModel'];
            final BzModel bzModel = maps['bzModel'];

            return LightBigFlyer(
              flyerBoxWidth: _controller.getBigItemWidth(context),
              flyerModel: flyerModel,
              bzModel: bzModel,
              onHorizontalExit: () async {

                await _controller.zoomOut(
                  mounted: true,
                  onStart: onZoomOutStart,
                  onEnd: onZoomOutEnd,
                );

                setNotifier(
                  notifier: _selectedModels,
                  mounted: mounted,
                  value: {
                    'flyerModel': null,
                    'bzModel': null,
                  },
                );

              },
            );

          },
        ),

        itemCount: _flyersIDs.length,
        builder: (int index){

          final String _flyerID = _flyersIDs[index];

          return LightSmallFlyer(
            flyerID: _flyerID,
            flyerBoxWidth: _controller.smallItemWidth,
            // onMoreTap: (){blog('onMoreTap');},
            onTap: (FlyerModel flyerModel, BzModel bzModel) async {

              if (flyerModel != null){

                setNotifier(
                  notifier: _selectedModels,
                  mounted: mounted,
                  value: {
                    'flyerModel': flyerModel,
                    'bzModel': bzModel,
                  },
                );

                await _controller.zoomIn(
                  context: context,
                  itemIndex: index,
                  mounted: true,
                  onStart: onZoomInStart,
                  onEnd: onZoomInEnd,
                );

              }

            },
          );

        },
        onZoomOutStart: onZoomOutStart,
        onZoomOutEnd: onZoomOutEnd,
      ),
    );

    /// FOR TESTING : WORKS PERFECT
    // return MainLayout(
    //   appBarType: AppBarType.basic,
    //   child: ZoomableGrid(
    //     controller: _controller,
    //     bigItem: FlyerBox(
    //       flyerBoxWidth: _controller.getBigItemWidth(context),
    //       boxColor: Colorz.green80,
    //       stackWidgets: const [
    //         Loading(loading: true),
    //       ],
    //     ),
    //     bigItemFootprint: FlyerBox(
    //       flyerBoxWidth: _controller.getBigItemWidth(context),
    //       boxColor: Colorz.black255,
    //     ),
    //
    //     itemCount: 14,
    //     builder: (int index){
    //
    //       return GestureDetector(
    //         onTap: () => _controller.zoomIn(
    //           context: context,
    //           itemIndex: index,
    //           mounted: true,
    //           onStart: onZoomInStart,
    //           onEnd: onZoomInEnd,
    //         ),
    //         child: FlyerBox(
    //           flyerBoxWidth: _controller.smallItemWidth,
    //           boxColor: Colorz.blue125.withAlpha(Numeric.createRandomIndex(listLength: 1000)),
    //           stackWidgets: [
    //
    //             SuperVerse(
    //               verse: Verse.plain(index.toString()),
    //               margin: 20,
    //               labelColor: Colorz.black255,
    //             ),
    //
    //           ],
    //
    //         ),
    //       );
    //
    //     },
    //     onZoomOutStart: onZoomOutStart,
    //     onZoomOutEnd: onZoomOutEnd,
    //   ),
    // );

  }
  // -----------------------------------------------------------------------------
}
