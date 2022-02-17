import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/c_controllers/a_1_home_controller.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnonymousHomeScreen extends StatefulWidget {
  const AnonymousHomeScreen({
    Key key
  }) : super(key: key);

  @override
  _AnonymousHomeScreenState createState() => _AnonymousHomeScreenState();
}

class _AnonymousHomeScreenState extends State<AnonymousHomeScreen> {
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
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: true);
    final List<FlyerModel> _wallFlyers = _flyersProvider.wallFlyers;

    return  FlyersGrid(
      gridWidth: Scale.superScreenWidth(context),
      gridHeight: Scale.superScreenHeight(context),
      numberOfColumns: 2,
      flyers: _wallFlyers,
      scrollController: _scrollController,
    );

  }
}
