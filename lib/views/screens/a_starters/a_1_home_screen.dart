import 'dart:async';

import 'package:bldrs/controllers/b_0_home_controller.dart';
import 'package:bldrs/providers/ui_provider.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/walls/home_wall.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HomeScreen({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _HomeScreenState createState() => _HomeScreenState();
  /// --------------------------------------------------------------------------
}

class _HomeScreenState extends State<HomeScreen> {
// -----------------------------------------------------------------------------
  UiProvider _uiProvider;
  @override
  void initState() {
    super.initState();
    _uiProvider = Provider.of<UiProvider>(context, listen: false);
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _uiProvider.triggerLoading().then((_) async {

            await controlHomeScreen(context);

            await _uiProvider.triggerLoading();

      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    // Tracer.traceScreenBuild(screenName: 'HomeScreen');
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: MainLayout(
        key: const ValueKey<String>('mainLayout'),
        appBarType: AppBarType.main,
        layoutWidget: Selector<UiProvider, bool>(
          selector: (_, UiProvider uiProvider) => uiProvider.loading,
          builder: (_, bool loading, Widget child){

            if (loading == true){
              return
                const Loading(loading: true,);
            }

            else {

              return
                const HomeWall();

            }

            },
        ),

      ),
    );
  }
}
