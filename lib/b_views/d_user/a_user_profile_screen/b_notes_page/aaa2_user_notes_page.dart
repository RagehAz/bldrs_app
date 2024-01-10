import 'dart:async';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/layouts/handlers/pull_to_refresh.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/b_notes_page/x2_user_notes_page_controllers.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/d_bz_notes_page/bz_notes_page.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:basics/helpers/widgets/drawing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/note_protocols/fire/note_fire_ops.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/e_back_end/x_queries/notes_queries.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class UserNotesPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const UserNotesPage({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  State<UserNotesPage> createState() => _UserNotesPageState();
  /// --------------------------------------------------------------------------
}

class _UserNotesPageState extends State<UserNotesPage> {
  // -----------------------------------------------------------------------------
  /*
  // with AutomaticKeepAliveClientMixin<UserNotesPage>
  // @override
  // bool get wantKeepAlive => true;
   */
  // -----------------------------------------------------------------------------
  PaginationController? _paginationController;
  // --------------------
  final List<NoteModel> _localNotesToMarkUnseen = <NoteModel>[];
  // --------------------
  bool showNotes = true;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _paginationController = PaginationController.initialize(
      mounted: mounted,
      addExtraMapsAtEnd: true,
      onDataChanged: _collectUnseenNotesToMarkAtDispose,
    );
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        NotesProvider.proSetIsFlashing(
            setTo: false,
            notify: true
        );
        // -------------------------------
        await _triggerLoading(setTo: false);

      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void deactivate() {
    blog('UserNotesPage deactivate START');
    _markAllUserUnseenNotesAsSeen();
    super.deactivate();
    blog('UserNotesPage deactivate END');
  }
  // --------------------
  @override
  void dispose() {
    blog('UserNotesPage dispose START');
    _loading.dispose();
    _paginationController?.dispose();
    super.dispose();
    blog('UserNotesPage dispose END');
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _markAllUserUnseenNotesAsSeen(){

    /// COLLECT NOTES TO MARK FIRST
    final List<NoteModel> _notesToMark = NoteModel.getOnlyUnseenNotes(
      notes: _localNotesToMarkUnseen,
    );

    /// MARK ON FIREBASE
    unawaited(NoteFireOps.markNotesAsSeen(
        notes: _notesToMark
    ));

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _collectUnseenNotesToMarkAtDispose(List<Map<String, dynamic>> paginatorMaps){

    if (Lister.checkCanLoop(paginatorMaps) == true){

      /// DECIPHER NEW MAPS TO NOTES
      final List<NoteModel> _newNotes = NoteModel.decipherNotes(
        maps: paginatorMaps,
        fromJSON: false,
      );

      /// ADD NEW NOTES TO LOCAL NOTES NEEDS TO MARK AS SEEN
      for (final NoteModel note in _newNotes){
          NoteModel.insertNoteIntoNotes(
            notesToGet: _localNotesToMarkUnseen,
            note: note,
            duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
          );
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onRefresh() async {

    _markAllUserUnseenNotesAsSeen();

    NotesProvider.proSetIsFlashing(
        setTo: false,
        notify: true
    );

    WaitDialog.showUnawaitedWaitDialog(
      verse: const Verse(
        id: 'phid_reloading',
        translate: true,
      ),
    );

    setState(() {
      showNotes = false;
    });

    await Future.delayed(const Duration(milliseconds: 200), (){

      _paginationController?.clear();

      setState(() {
        showNotes = true;
      });

    });

    await WaitDialog.closeWaitDialog();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Function? _onNoteTap(NoteModel? _note) {

    if (canTapNoteBubble(_note) == true){
      return () => onUserNoteTap(
        noteModel: _note,
      );
    }

    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    return PullToRefresh(
      onRefresh: _onRefresh,
      circleColor: Colorz.yellow255,
      fadeOnBuild: true,
      child: showNotes == false ? const SizedBox() :

      FireCollPaginator(
          paginationQuery: userNotesPaginationQueryModel(),
          streamQuery: userNotesWithPendingRepliesQueryModel(),
          paginationController: _paginationController,
          builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget? child){

            if (Lister.checkCanLoop(maps) == true){
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _paginationController?.scrollController,
                itemCount: maps.length,
                padding: Stratosphere.stratosphereSandwich,
                itemBuilder: (BuildContext ctx, int index) {

                  final NoteModel? _note = NoteModel.decipherNote(
                    map: maps[index],
                    fromJSON: false,
                  );

                  return NoteCard(
                    key: PageStorageKey<String>('user_note_card_${_note?.id}'),
                    noteModel: _note,
                    onNoteOptionsTap: () => onShowNoteOptions(
                      context: context,
                      noteModel: _note,
                      paginationController: _paginationController,
                    ),
                    onCardTap: _onNoteTap(_note),
                  );

                  },
              );
            }

            else {
              return const NoNotificationsYet();
            }


          }
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
