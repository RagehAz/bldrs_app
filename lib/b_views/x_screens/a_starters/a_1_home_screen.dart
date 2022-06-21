import 'dart:async';

import 'package:bldrs/b_views/y_views/a_starters/a_2_user_home_screen_view.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/super_pyramids.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/home_controllers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
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
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// NOT disposed
  // Stream<List<NoteModel>> _receivedNotesStream;
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

    initializeUserNotes(context);

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        await initializeHomeScreen(context);

        if (mounted){
          initializeObeliskNumbers(context);
          initializeUserNotes(context);
          initializeMyBzzNotes(context);
        }

        await _triggerLoading();

      });

    _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    // if (_loading != null){_loading.dispose();}
    _loading.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------

  /// PYRAMID EXPANSION

// -------------------------------------
  final ValueNotifier<bool> _isExpanded = ValueNotifier(null);
  final ValueNotifier<int> _tabIndex = ValueNotifier(null);
// -------------------------------------
  void onTriggerExpansion(){
    _isExpanded.value = !_isExpanded.value;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// TASK MAIN NAV MODELS SHOULD BE PLACED IN PROVIDER TO LISTEN TO REBUILDS WHEN DELETING A BZ
    final List<NavModel> _navModels = generateMainNavModels(context);

    return MainLayout(
      key: const ValueKey<String>('mainLayout'),
      // navBarIsOn: false,
      appBarType: AppBarType.basic,
      zoneButtonIsOn: false,
      onBack: (){
        Nav.closeApp(context);
      },
      layoutWidget: Stack(
        children: <Widget>[

          /// PAGE CONTENTS
          ValueListenableBuilder(
            valueListenable: _loading,
            builder: (_, bool loading, Widget child){

              /// LOADING
              if (loading == true) {
                return const FlyersGrid(
                  isLoadingGrid: true,
                );
              }

              /// UNKNOWN CONDITION
              else {

                return const UserHomeScreen();
              }

            },
          ),

          /// PYRAMIDS NAVIGATOR
          /// TASK : SHOULD LISTEN TO NAV MODELS IN A PROVIDER,, AND SHOULD PUT THE SELECTOR DEEPTER INSIDE SUPER PYRAMIDS
          SuperPyramids(
            isExpanded: _isExpanded,
            onExpansion: onTriggerExpansion,
            onRowTap: (int index) => onNavigate(
              context: context,
              index: index,
              models: _navModels,
              tabIndex: _tabIndex,
              isExpanded: _isExpanded,
            ),
            tabIndex: _tabIndex,
            navModels: _navModels,
            isYellow: true,
          ),

        ],
      ),
    );

  }

}
