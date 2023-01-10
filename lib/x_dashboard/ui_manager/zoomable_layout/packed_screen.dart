import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/src/flyers_zoomed_layout.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/src/zoomable_grid.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/src/zoomable_grid_controller.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

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

ZoomableGridController initializeBldrsZoomableGridController({
  @required BuildContext context,
  @required int columnsCount,
}){

  final double _screenWidth = UiProvider.proGetScreenDimensions(context: context, listen: false).width;
  final double _screenHeight = UiProvider.proGetScreenDimensions(context: context, listen: false).height;
  // const double _spacingRatio = 0.0;

  final double _gridFlyerWidth = FlyerDim.flyerGridFlyerBoxWidth(
    context: context,
    scrollDirection: Axis.vertical,
    numberOfColumnsOrRows: columnsCount,
    gridWidth: _screenWidth,
    gridHeight: _screenHeight,
    // spacingRatio: _spacingRatio,
  );

  /// ZOOMED FLYER ALIGNMENT : IF YOU WANT TO CENTER
  // final double _zoomedInFlyerHeight = BldrsAppBar.width(context) * FlyerDim.xFlyerBoxHeightRatioToWidth;
  // final double _topPaddingOnZoomIn = (_screenHeight - _zoomedInFlyerHeight) / 2;
  /// IF YOU WANT TO ALIGN TO TOP
  const double _topPaddingOnZoomIn = 10;

  final ZoomableGridController _controller = ZoomableGridController()..initialize(
    topPaddingOnZoomedOut: Stratosphere.smallAppBarStratosphere,
    topPaddingOnZoomedIn: _topPaddingOnZoomIn, //Stratosphere.smallAppBarStratosphere - 10,

    smallItemWidth: _gridFlyerWidth,
    smallItemHeight: _gridFlyerWidth * FlyerDim.xFlyerBoxHeightRatioToWidth,

    columnsCount: columnsCount,
    // spacingRatio: _spacingRatio,
    gridHeight: _screenHeight,
    gridWidth: _screenWidth,

  );

  return _controller;
}

class PackedZoomedLayout extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PackedZoomedLayout({
    Key key
  }) : super(key: key);

  @override
  State<PackedZoomedLayout> createState() => _PackedZoomedLayoutState();
}

class _PackedZoomedLayoutState extends State<PackedZoomedLayout> {
  // -----------------------------------------------------------------------------
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
    _controller = initializeBldrsZoomableGridController(
      context: context,
      columnsCount: 3,
    );
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
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // blog('PackedZoomedLayout.build()');

    return MainLayout(
      appBarType: AppBarType.basic,
      appBarRowWidgets: [

        const Expander(),

        ///2
        AppBarButton(
          verse: Verse.plain('[ 2 ]'),
          onTap: () async {

            final ZoomableGridController _controller = initializeBldrsZoomableGridController(
              context: context,
              columnsCount: 2,
            );

            await Nav.goToNewScreen(
                context: context,
                screen: FlyersZoomedLayout(
                    controller: _controller,
                ),
            );
          },
        ),

        /// 3
        AppBarButton(
          verse: Verse.plain('[ 3 ]'),
          onTap: () async {

            final ZoomableGridController _controller = initializeBldrsZoomableGridController(
              context: context,
              columnsCount: 3,
            );

            await Nav.goToNewScreen(
                context: context,
                screen: FlyersZoomedLayout(
                    controller: _controller,
                ),
            );
          },
        ),

        /// 4
        AppBarButton(
          verse: Verse.plain('[ 4 ]'),
          onTap: () async {

            final ZoomableGridController _controller = initializeBldrsZoomableGridController(
              context: context,
              columnsCount: 4,
            );

            await Nav.goToNewScreen(
                context: context,
                screen: FlyersZoomedLayout(
                    controller: _controller,
                ),
            );
          },
        ),

      ],
      child: ZoomableGrid(
        controller: _controller,
        bigItem: FlyerBox(
          flyerBoxWidth: _controller.getBigItemWidth(context),
          boxColor: Colorz.bloodTest,
          stackWidgets: const [
            Loading(loading: true),
          ],
        ),
        bigItemFootprint: FlyerBox(
          flyerBoxWidth: _controller.getBigItemWidth(context),
          boxColor: Colorz.black80,
        ),

        itemCount: 14,
        builder: (int index){

          return GestureDetector(
            onTap: () => _controller.zoomIn(
              context: context,
              itemIndex: index,
              mounted: true,
              onStart: onZoomInStart,
              onEnd: onZoomInEnd,
            ),
            child: FlyerBox(
              flyerBoxWidth: _controller.smallItemWidth,
              boxColor: Colorz.blue125.withAlpha(Numeric.createRandomIndex(listLength: 1000)),
              stackWidgets: [

                SuperVerse(
                  verse: Verse.plain(index.toString()),
                  margin: 20,
                  labelColor: Colorz.black255,
                ),

              ],

            ),
          );

        },
        onZoomOutStart: onZoomOutStart,
        onZoomOutEnd: onZoomOutEnd,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
