import 'dart:async';

import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/walls/home_wall.dart';
import 'package:bldrs/b_views/widgets/general/loading/loading.dart';
import 'package:bldrs/c_controllers/a_1_home_controller.dart';
import 'package:flutter/material.dart';

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
  /// --- FUTURE LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;

    if (_loading.value == true) {
      blog('LOADING --------------------------------------');
    } else {
      blog('LOADING COMPLETE -----------------------------');
    }
  }

// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        await controlHomeScreen(context);

        await _triggerLoading();
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // traceWidgetBuild(widgetName: 'Home screen', varName: '_isInit', varValue: _isInit);
    return WillPopScope(
      onWillPop: () => Future<bool>.value(false),
      child: MainLayout(
        key: const ValueKey<String>('mainLayout'),
        appBarType: AppBarType.main,
        layoutWidget: ValueListenableBuilder(
          valueListenable: _loading,
          builder: (_, bool loading, Widget child){

                if (loading == true) {
                  return const Loading(loading: true,);
                }

                else {
                  return const HomeWall();
                }

          },
        ),

      ),
    );
  }
}
