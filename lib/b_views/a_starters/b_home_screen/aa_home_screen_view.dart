import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/pull_to_refresh.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHomeScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const UserHomeScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
  /// --------------------------------------------------------------------------
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  // -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  bool _canPaginate = true;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _canPaginate = initializeFlyersPagination(
        context: context,
        scrollController: _scrollController,
        canPaginate: _canPaginate
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
      _uiProvider.startController(
              () async {

            await readMoreFlyers(context);
            _canPaginate = true;

          }
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: true);
    final List<FlyerModel> _wallFlyers = _flyersProvider.wallFlyers;

    if (Mapper.checkCanLoopList(_wallFlyers) == false){
      return const Center(
        child: SuperVerse(
          verse: Verse(
            text: 'phid_no_flyers_to_show',
            translate: true,
            casing: Casing.capitalizeFirstChar,
          ),
          italic: true,
          weight: VerseWeight.black,
          size: 5,
          shadow: true,
        ),
      );
    }

    else {
      return PullToRefresh(
        onRefresh: () => onRefreshHomeWall(context),
        child: FlyersGrid(
          gridWidth: Scale.superScreenWidth(context),
          gridHeight: Scale.superScreenHeight(context),
          // numberOfColumns: 2,
          flyers: _wallFlyers,
          scrollController: _scrollController,
          heroPath: 'userHomeScreen',
        ),
      );
    }

  }
  // -----------------------------------------------------------------------------
}
