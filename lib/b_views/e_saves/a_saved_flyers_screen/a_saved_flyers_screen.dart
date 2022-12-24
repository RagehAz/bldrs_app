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
  ScrollController _scrollController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }
  // --------------------
  @override
  void dispose() {
    _scrollController.dispose();
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
        text: 'phid_savedFlyers',
        translate: true,
      ),
      onBack: widget.selectionMode ? _passSelectedFlyersBack : null,
      child:

      SavedFlyersScreenView(
        selectionMode: widget.selectionMode,
        scrollController: _scrollController,
      ),

    );

  }
// -----------------------------------------------------------------------------
}
