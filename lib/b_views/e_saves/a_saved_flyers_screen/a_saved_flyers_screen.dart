import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/aa_saved_flyers_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedFlyersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersScreen({
    this.selectionMode = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool selectionMode;
  /// --------------------------------------------------------------------------
  @override
  _SavedFlyersScreenState createState() => _SavedFlyersScreenState();
/// --------------------------------------------------------------------------
}

class _SavedFlyersScreenState extends State<SavedFlyersScreen>  {
  /*
   with AutomaticKeepAliveClientMixin<SavedFlyersScreen>
   @override
   bool get wantKeepAlive => true;
   */
  // -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  @override
  void dispose() {
    /// SCROLL_CONTROLLER_IS_DISPOSED_IN_ZOOMABLE_GRID_CONTROLLER
    // _scrollController.dispose(); // so do not dispose here, kept for reference
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _passSelectedFlyersBack() async {

    /// shall pass selected flyers through flyers provider
    await Nav.goBack(
      context: context,
      invoker: '_passSelectedFlyersBack',
      passedData: Provider.of<FlyersProvider>(context, listen: false).selectedFlyers,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    return MainLayout(
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidsAreOn: true,
      title: const Verse(
        id: 'phid_savedFlyers',
        translate: true,
      ),
      onBack: widget.selectionMode ? _passSelectedFlyersBack : null,
      listenToHideLayout: true,
      child:

      SavedFlyersScreenView(
        selectionMode: widget.selectionMode,
        scrollController: _scrollController,
      ),

    );

  }
// -----------------------------------------------------------------------------
}
