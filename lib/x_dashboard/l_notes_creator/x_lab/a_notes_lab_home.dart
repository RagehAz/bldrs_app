import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_lab/b_paginate_all_notes_screen.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_lab/c_local_noot_test_screen.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_lab/d_noot_route_to_screen.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_lab/note_templates/a_real_note_paginator_test.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
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

        /// FIRE NOTES PAGINATOR
        WideButton(
          verse: Verse.plain('Fire Notes paginator'),
          icon: Iconz.power,
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const FireNotesPaginator(),
          ),
        ),

        /// REAL NOTE PAGINATOR
        WideButton(
          verse: Verse.plain('Real Notes paginator'),
          icon: Iconz.spark,
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const RealNotePaginatorTest(),
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

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
