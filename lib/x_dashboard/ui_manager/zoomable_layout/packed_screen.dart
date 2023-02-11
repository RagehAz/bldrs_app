import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_zoomed_layout.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/zoomable_layout/zoomable_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/zoomable_layout/zoomable_grid_controller.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:numeric/numeric.dart';
import 'package:filers/filers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
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

class PackedZoomableLayout extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PackedZoomableLayout({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<PackedZoomableLayout> createState() => _PackedZoomableLayoutState();
  /// --------------------------------------------------------------------------
}

class _PackedZoomableLayoutState extends State<PackedZoomableLayout> {
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
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// 2
        AppBarButton(
          verse: Verse.plain('[ 2 ]'),
          onTap: () async {

            await Nav.goToNewScreen(
                context: context,
                screen: const FlyersZoomedLayout(),
            );

          },
        ),

        /// 3
        AppBarButton(
          verse: Verse.plain('[ 3 ]'),
          onTap: () async {

            await Nav.goToNewScreen(
                context: context,
                screen: const FlyersZoomedLayout(columnsCount: 3,),
            );

          },
        ),

        /// 4
        AppBarButton(
          verse: Verse.plain('[ 4 ]'),
          onTap: () async {

            await Nav.goToNewScreen(
                context: context,
                screen: const FlyersZoomedLayout(columnsCount: 4),
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
