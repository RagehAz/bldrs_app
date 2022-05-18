import 'dart:async';

import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/b_views/y_views/a_starters/a_1_anonymous_home_screen_view.dart';
import 'package:bldrs/b_views/y_views/a_starters/a_2_user_home_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/a_1_home_controller.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// NOT disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'HomeScreen',
    );
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

        await initializeHomeScreen(context);

        await _triggerLoading();
      });

    _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    // if (_loading != null){_loading.dispose();}
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    traceWidgetBuild(widgetName: 'Home screen', varName: '_isInit', varValue: _isInit);

    final bool _userIsSignedIn = AuthModel.userIsSignedIn();

    return WillPopScope(
      onWillPop: () async {

        /// TO CLOSE DRAWER IF OPEN
        final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
        _uiProvider.closeDrawerIfOpen(context);

        /// prevents going back from home screen
        // final bool thing = await Future<bool>.value(false);
        return false;
      },
      child: MainLayout(
        key: const ValueKey<String>('mainLayout'),
        navBarIsOn: true,
        appBarType: AppBarType.main,
        layoutWidget: ValueListenableBuilder(
          valueListenable: _loading,
          builder: (_, bool loading, Widget child){

                /// LOADING
                if (loading == true) {
                  return const Center(child: Loading(loading: true,));
                }

                /// FOR ANONYMOUS USER
                else if (_userIsSignedIn == false){
                  return const AnonymousHomeScreenView();
                }

                /// FOR KNOWN SIGNED IN USER
                else if (_userIsSignedIn == true){
                  return const UserHomeScreen();
                }

                /// UNKNOWN CONDITION
                else {
                  return Container();
                }

          },
        ),

      ),
    );
  }
}
