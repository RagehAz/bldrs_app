import 'dart:async';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/flyers_grid.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/h_0_flyer_screen.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
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
  bool _allLoaded = false;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() async {

      final double _maxScroll = _scrollController.position.maxScrollExtent;
      final double _currentScroll = _scrollController.position.pixels;
      final double _screenHeight = Scale.superScreenHeight(context); // * 0.25 why ??
      final double _delta = _screenHeight * 0.1;

      if (_maxScroll - _currentScroll <= Ratioz.horizon * 3 && _canPaginate == true){

        blog('_maxScroll : $_maxScroll : _currentScroll : $_currentScroll : diff : ${_maxScroll - _currentScroll} : _delta : $_delta');

        // setState(() {
          _canPaginate = false;
        // });

        await _readMoreFlyers();

        // setState(() {
          _canPaginate = true;
        // });

      }


    });


  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
      _uiProvider.startController(
              () async {

                await _readMoreFlyers();

                setState(() {
                  _allLoaded = false;
                });

          }
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  Future<void> _readMoreFlyers() async {
    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    await _flyersProvider.paginateWallFlyers(context);
  }
// -----------------------------------------------------------------------------
  Future<void> _onFlyerTap(FlyerModel flyer) async {

    await Nav.goToNewScreen(context,
        FlyerScreen(
          flyerModel: flyer,
          flyerID: flyer.id,
          initialSlideIndex: 0,
        )
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: true);
    final List<FlyerModel> _wallFlyers = _flyersProvider.wallFlyers;

    return  FlyersGrid(
      gridZoneWidth: FlyerBox.width(context, 1),
      scrollController: _scrollController,
      stratosphere: true,
      numberOfColumns: 2,
      scrollable: true,
      flyers: _wallFlyers,
      onFlyerTap: (FlyerModel flyer) => _onFlyerTap(flyer),
    );

  }
}
