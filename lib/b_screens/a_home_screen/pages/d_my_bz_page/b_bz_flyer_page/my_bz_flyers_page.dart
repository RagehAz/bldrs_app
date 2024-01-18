import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/b_bz_flyer_page/bz_flyers_view.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class MyBzFlyersPage extends StatefulWidget {
  // --------------------------------------------------------------------------
  const MyBzFlyersPage({
    super.key
  });
  // --------------------
  ///
  // --------------------
  @override
  _MyBzFlyersPageState createState() => _MyBzFlyersPageState();
  // --------------------------------------------------------------------------
}

class _MyBzFlyersPageState extends State<MyBzFlyersPage> with SingleTickerProviderStateMixin{
  // -----------------------------------------------------------------------------
  late ZGridController _zGridController;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<String?> _activePhid = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _zGridController = ZGridController.initialize(
      vsync: this,
      scrollController: _scrollController,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

      });

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
    /// SCROLL_CONTROLLER_IS_DISPOSED_IN_ZOOMABLE_GRID_CONTROLLER
    // _scrollController.dispose(); // so do not dispose here, kept for reference
    _zGridController.dispose();
    _activePhid.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BzModel? _myActiveBz = HomeProvider.proGetActiveBzModel(
        context: context,
        listen: true,
    );
    // --------------------
    return BzFlyersView(
      bzModel: _myActiveBz,
      activePhid: _activePhid,
      mounted: mounted,
      scrollController: _scrollController,
      zGridController: _zGridController,
      onlyShowPublished: true,
      appBarType: AppBarType.non,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
