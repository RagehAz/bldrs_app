import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/helper_screens/all_notes_screen.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/testing_notes/c_awesome_noti_test_screen.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/testing_notes/b_fcm_tet_screen.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/testing_notes/cc_note_route_to_screen.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class NotesTestingScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NotesTestingScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _NotesTestingScreenState createState() => _NotesTestingScreenState();
/// --------------------------------------------------------------------------
}

class _NotesTestingScreenState extends State<NotesTestingScreen> {
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
    }
  }
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

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// XXXX
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

        /// VIEW ALL NOTES
        WideButton(
          verse: Verse.plain('Paginate all fire Notes'),
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const AllNotesScreen(),
          ),
        ),

        /// FCM TEST
        WideButton(
          verse: Verse.plain('go to FCM tests'),
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const FCMTestScreen(),
          ),
        ),

        /// AWESOME NOTIFICATIONS TEST
        WideButton(
          verse: Verse.plain('go to Awesome Notifications tests'),
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const AwesomeNotiTestScreen(),
          ),
        ),

        /// NOTE ROUTE TO SCREEN
        WideButton(
          verse: Verse.plain('go to Note route to screen'),
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const NoteRouteToScreen(),
          ),
        ),


      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
