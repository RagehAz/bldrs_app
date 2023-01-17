import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/notes_creator/x_lab_screens/x_lab/b_notes_viewer_screen.dart';
import 'package:bldrs/x_dashboard/notes_creator/x_lab_screens/x_lab/c_local_noot_test_screen.dart';
import 'package:bldrs/x_dashboard/notes_creator/x_lab_screens/x_lab/d_noot_route_to_screen.dart';
import 'package:bldrs/x_dashboard/notes_creator/x_lab_screens/x_lab/e_badge_test.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class NotesLabHome extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NotesLabHome({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _NotesLabHomeState createState() => _NotesLabHomeState();
  /// --------------------------------------------------------------------------
}

class _NotesLabHomeState extends State<NotesLabHome> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  /*
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        /// FIRE NOTES PAGINATOR
        WideButton(
          verse: Verse.plain('Fire Notes paginator'),
          icon: Iconz.power,
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const NotesViewerScreen(),
          ),
        ),

        /// AWESOME NOTIFICATIONS TEST
        WideButton(
          verse: Verse.plain('go to Awesome Notifications tests'),
          icon: Iconz.lab,
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const LocalNootTestScreen(),
          ),
        ),

        /// NOTE ROUTE TO SCREEN
        WideButton(
          verse: Verse.plain('go to Note route to screen'),
          icon: Iconz.reload,
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const NoteRouteToScreen(
              receivedAction: null,
            ),
          ),
        ),

        /// GLOBAL BADGE NUMBER
        WideButton(
          verse: Verse.plain('go to Global Badge Number Test'),
          icon: Iconz.circleDot,
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const GlobalBadgeTest(),
          ),
        ),


      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
