import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_page/b_bz_flyer_page/bz_flyers_view.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:flutter/material.dart';

class BzFlyersPreviewScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const BzFlyersPreviewScreen({
    required this.bzModel,
    super.key
  });
  // --------------------
  final BzModel? bzModel;
  // --------------------------------------------------------------------------
  static Future<void> openBzFlyersPage({
    required BzModel? bzModel,
  }) async {

    await BldrsNav.goToNewScreen(
        screen: BzFlyersPreviewScreen(
          bzModel: bzModel,
        ),
    );

  }
  // --------------------------------------------------------------------------
  @override
  State<BzFlyersPreviewScreen> createState() => _BzFlyersPreviewScreenState();
  // --------------------------------------------------------------------------
}

class _BzFlyersPreviewScreenState extends State<BzFlyersPreviewScreen> with SingleTickerProviderStateMixin{
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
    return MainLayout(
      canSwipeBack: true,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      pyramidType: PyramidType.crystalWhite,
      title: Verse(
        id: '${getWord('phid_published_flyers_by')}\n${widget.bzModel?.name}',
        translate: false,
      ),
      listenToHideLayout: true,
      child: BzFlyersView(
        bzModel: widget.bzModel,
        activePhid: _activePhid,
        mounted: mounted,
        scrollController: _scrollController,
        zGridController: _zGridController,
        onlyShowPublished: true,
      ),
    );
    // --------------------
  }
}
