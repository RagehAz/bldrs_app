// ignore_for_file: invariant_booleans
import 'dart:async';

import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_paginator.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/e_back_end/x_queries/notes_queries.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class UserNotesPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const UserNotesPage({
    Key key
  }) : super(key: key);
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
  final List<NoteModel> _localNotesToMarkUnseen = <NoteModel>[];
  // --------------------
  final ScrollController _scrollController = ScrollController();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
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
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        NotesProvider.proSetIsFlashing(
            context: context,
            setTo: false,
            notify: true
        );
        // -------------------------------
        await _triggerLoading(setTo: false);

      });

    }
    _isInit = false;
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
  /// TAMAM
  @override
  void dispose() {
    blog('UserNotesPage dispose START');
    _loading.dispose();
    _scrollController.dispose();
    super.dispose();
    blog('UserNotesPage dispose END');
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _markAllUserUnseenNotesAsSeen(){

    // blog('_markAllUserUnseenNotesAsSeen : START');

    /// COLLECT NOTES TO MARK FIRST
    final List<NoteModel> _notesToMark = NoteModel.getOnlyUnseenNotes(
      notes: _localNotesToMarkUnseen,
    );

    // blog('_markAllUserUnseenNotesAsSeen : ${_notesToMark.length} notes should be marked');

    /// MARK ON FIREBASE
    unawaited(NoteFireOps.markNotesAsSeen(
        notes: _notesToMark
    ));

    // blog('_markAllUserUnseenNotesAsSeen : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _onPaginatorDataChanged(List<Map<String, dynamic>> newMaps){

    /// DECIPHER NEW MAPS TO NOTES
    final List<NoteModel> _newNotes = NoteModel.decipherNotes(
      maps: newMaps,
      fromJSON: false,
    );

    /// ADD NEW NOTES TO LOCAL NOTES NEEDS TO MARK AS SEEN
    for (final NoteModel note in _newNotes){
      if (note.seen == false){
        NoteModel.insertNoteIntoNotes(
            notesToGet: _localNotesToMarkUnseen,
            note: note,
            duplicatesAlgorithm: DuplicatesAlgorithm.keepFirst,
        );
      }
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    return FireCollPaginator(
        queryModel: userNotesPaginationQueryModel(
            onDataChanged: _onPaginatorDataChanged
        ),
        scrollController: _scrollController,
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            itemCount: maps?.length,
            padding: Stratosphere.stratosphereSandwich,
            itemBuilder: (BuildContext ctx, int index) {

              final NoteModel _note = NoteModel.decipherNote(
                  map: maps[index],
                  fromJSON: false,
              );

              return NoteCard(
                key: PageStorageKey<String>('user_note_card_${_note.id}'),
                noteModel: _note,
                isDraftNote: false,
              );

            },
          );

        }
    );

  }
  // -----------------------------------------------------------------------------
}
