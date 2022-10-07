import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_lab/b_paginate_all_notes_screen.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_lab/c_local_noot_test_screen.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_lab/d_noot_route_to_screen.dart';
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

        /// VIEW ALL NOTES
        WideButton(
          verse: Verse.plain('Paginate all fire Notes'),
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const PaginateAllNotesScreen(),
          ),
        ),

        /// AWESOME NOTIFICATIONS TEST
        WideButton(
          verse: Verse.plain('go to Awesome Notifications tests'),
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const LocalNootTestScreen(),
          ),
        ),

        /// NOTE ROUTE TO SCREEN
        WideButton(
          verse: Verse.plain('go to Note route to screen'),
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
