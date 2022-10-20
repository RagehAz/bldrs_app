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
  void _markAllUserUnseenNotesAsSeen(){

    blog('_markAllUserUnseenNotesAsSeen : START');

    /// COLLECT NOTES TO MARK FIRST
    final List<NoteModel> _notesToMark = NoteModel.getOnlyUnseenNotes(
      notes: _localNotesToMarkUnseen,
    );

    blog('_markAllUserUnseenNotesAsSeen : ${_notesToMark.length} notes should be marked');

    /// MARK ON FIREBASE
    unawaited(NoteFireOps.markNotesAsSeen(
        notes: _notesToMark
    ));

    /// DEPRECATED SHIT
    /// AS STREAM LISTENER SETS BADGE NUMBERS AND CONTROLS PYRAMIDS FLASHING
    // if (Mapper.checkCanLoopList(_notesToMark) == true){
    //   if (mounted == true){
    //     WidgetsBinding.instance.addPostFrameCallback((_){
    //
    //       final BuildContext _context = BldrsAppStarter.navigatorKey.currentContext;
    //
    //       blog('_context from navigator key is : ${_context.toString()}');
    //
    //       /// TASK : SHOULD DECREMENT OBLISK NUMBER INSTEAD OF FLASHING,
    //       /// AND LET THE FLASHING LISTENES TO OBLESIK NUMBERS
    //
    //       NotesProvider.proSetIsFlashing(
    //         context: _context,
    //         setTo: false,
    //         notify: true,
    //       );
    //     });
    //   }
    //
    // }

    blog('_markAllUserUnseenNotesAsSeen : END');

  }
  // --------------------
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

    /// DEPRECATED
    // _localNotesToMarkUnseen = NoteModel.insertNotesInNotes(
    //   notesToGet: _localNotesToMarkUnseen,
    //   notesToInsert: _newNotes,
    //   duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
    // );

  }
  // --------------------
  /// DEPRECATED
  /*
  List<NoteModel> _combinePaginatorMapsWithProviderNotes({
    @required List<Map<String, dynamic>> paginatedMaps,
    @required List<NoteModel> providerNotes,
  }){


    /// DECIPHER STREAM MAPS
    final List<NoteModel> _paginatedNotes = NoteModel.decipherNotes(
      maps: paginatedMaps,
      fromJSON: false,
    );

    /// COMBINE NOTES FROM PAGINATOR + NOTES FROM PROVIDER
    final List<NoteModel> _combined = NoteModel.insertNotesInNotes(
        notesToGet: <NoteModel>[],
        notesToInsert: <NoteModel>[...providerNotes, ..._paginatedNotes],
        duplicatesAlgorithm: DuplicatesAlgorithm.keepFirst
    );

    blog('_combinePaginatorMapsWithProviderNotes : combining shit : (${providerNotes.length} pro notes) + (${paginatedMaps.length}) pagi notes = ${_combined.length} combined notes');


    final List<NoteModel> _ordered = NoteModel.orderNotesBySentTime(_combined);

    return _ordered;
  }
   */
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

    // return Selector<NotesProvider, List<NoteModel>>(
    //     key: const ValueKey<String>('UserNotesPage'),
    //     selector: (_, NotesProvider notesProvider) => notesProvider.userNotes,
    //     shouldRebuild: (before, after) => true,
    //     builder: (_,List<NoteModel> _proNotes, Widget child){
    //
    //       blog('user pro notes rebuilds ${_proNotes.length} notes');
    //
    //       /// ADD USER UNSEEN NOTES TO LOCAL NOTES TO MARK SEEN
    //       _localNotesToMarkUnseen = NoteModel.insertNotesInNotes(
    //         notesToGet: _localNotesToMarkUnseen,
    //         notesToInsert: _proNotes,
    //         duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
    //       );
    //
    //       return FireCollPaginator(
    //           scrollController: _scrollController,
    //           queryModel: getUserNotesPaginationQueryModel(
    //               onDataChanged: _onPaginatorDataChanged
    //           ),
    //           builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){
    //
    //             blog('FireCollPaginator : rebuilding with ${maps.length} map');
    //
    //             /// COMBINE NOTES FROM STREAM + NOTES FROM PROVIDER
    //             final List<NoteModel> _combined = _combinePaginatorMapsWithProviderNotes(
    //               paginatedMaps: maps,
    //               providerNotes: _proNotes,
    //             );
    //
    //             return ListView.builder(
    //               physics: const BouncingScrollPhysics(),
    //               controller: _scrollController,
    //               itemCount: _combined?.length,
    //               padding: Stratosphere.stratosphereSandwich,
    //               itemBuilder: (BuildContext ctx, int index) {
    //
    //                 final NoteModel _notiModel = Mapper.checkCanLoopList(_combined) == true ?
    //                 _combined[index]
    //                     :
    //                 null;
    //
    //                 return NoteCard(
    //                   key: PageStorageKey<String>('user_note_card_${_notiModel.id}'),
    //                   noteModel: _notiModel,
    //                   isDraftNote: false,
    //                 );
    //
    //               },
    //             );
    //
    //           }
    //       );
    //
    //     });

  }
  // -----------------------------------------------------------------------------
}
