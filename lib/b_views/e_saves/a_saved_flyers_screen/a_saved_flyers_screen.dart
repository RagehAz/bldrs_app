import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/aa_saved_flyers_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
}

// with AutomaticKeepAliveClientMixin<SavedFlyersScreen>
class _SavedFlyersScreenState extends State<SavedFlyersScreen>  {
  // @override
  // bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  ScrollController _scrollController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _passSelectedFlyersBack(){

    /// shall pass selected flyers through flyers provider
    Nav.goBack(
      context: context,
      invoker: '_passSelectedFlyersBack',
      passedData: [],
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
      pageTitleVerse: 'phid_savedFlyers',
      sectionButtonIsOn: false,
      onBack: widget.selectionMode ? _passSelectedFlyersBack : null,
      layoutWidget:

      SavedFlyersScreenView(
        selectionMode: widget.selectionMode,
        scrollController: _scrollController,
      ),

    );

  }
}
