import 'dart:async';

import 'package:bldrs/b_views/y_views/a_starters/a_2_user_home_screen_view.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/loading_flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/super_pyramids.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/a_1_home_controller.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
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

    final List<NavModel> _navModels = generateMainNavModels(context);

    return MainLayout(
      key: const ValueKey<String>('mainLayout'),
      // navBarIsOn: false,
      appBarType: AppBarType.basic,
      zoneButtonIsOn: false,
      onBack: (){
        Nav.closeApp(context);
      },

      appBarRowWidgets: <Widget>[

        AppBarButton(
          icon: Iconz.plus,
          onTap: () async {

            final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);

            _notesProvider.incrementObeliskNoteNumber(
                value: 1,
                navModelID: NavModel.getMainNavIDString(navID: MainNavModel.profile),
                notify: true,
            );

            _notesProvider.setIsFlashing(
                flashing: !_notesProvider.isFlashing,
                notify: true,
            );

          },
        ),

      ],
      layoutWidget: Stack(
        children: <Widget>[

          /// PAGE CONTENTS
          ValueListenableBuilder(
            valueListenable: _loading,
            builder: (_, bool loading, Widget child){

              /// LOADING
              if (loading == true) {
                return const LoadingFlyersGrid();
              }

              /// UNKNOWN CONDITION
              else {
                return const UserHomeScreen();
              }

            },
          ),

          /// PYRAMIDS NAVIGATOR
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
