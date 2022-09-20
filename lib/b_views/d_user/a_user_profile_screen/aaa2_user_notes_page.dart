import 'dart:async';

import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/x2_user_notes_page_controllers.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_db/fire/ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/fire_coll_paginator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  ScrollController _scrollController;
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
      blogLoading(loading: _loading.value, callerName: 'UserNotesPage',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading().then((_) async {
        // -------------------------------
        NotesProvider.proSetIsFlashing(
            context: context,
            setTo: false,
            notify: true
        );
        // -------------------------------
        await _triggerLoading();

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {

    blog('DISPOSING USER NOTES PAGE AHO');

    _loading.dispose();
    _markAllUserUnseenNotesAsSeen();
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  List<NoteModel> _localNotesToMarkUnseen = <NoteModel>[];
  // --------------------
  void _markAllUserUnseenNotesAsSeen(){

    /// COLLECT NOTES TO MARK FIRST
    final List<NoteModel> _notesToMark = NoteModel.getOnlyUnseenNotes(
      notes: _localNotesToMarkUnseen,
    );

    blog('_markAllUserUnseenNotesAsSeen : ${_notesToMark.length} notes should be marked');

    /// MARK ON FIREBASE
    unawaited(NoteFireOps.markNotesAsSeen(
        context: context,
        notes: _notesToMark
    ));

    if (Mapper.checkCanLoopList(_notesToMark) == true){
      WidgetsBinding.instance.addPostFrameCallback((_){

        NotesProvider.proSetIsFlashing(
          context: context,
          setTo: false,
          notify: true,
        );
      });

    }

  }
  // --------------------
  void _onPaginatorDataChanged(List<Map<String, dynamic>> newMaps){

    /// DECIPHER NEW MAPS TO NOTES
    final List<NoteModel> _newNotes = NoteModel.decipherNotes(
      maps: newMaps,
      fromJSON: false,
    );

    /// ADD NEW NOTES TO LOCAL NOTES NEEDS TO MARK AS SEEN
    _localNotesToMarkUnseen = NoteModel.insertNotesInNotes(
      notesToGet: _localNotesToMarkUnseen,
      notesToInsert: _newNotes,
      duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
    );

  }
  // --------------------
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    return Selector<NotesProvider, List<NoteModel>>(
        key: const ValueKey<String>('UserNotesPage'),
        selector: (_, NotesProvider notesProvider) => notesProvider.userNotes,
        shouldRebuild: (before, after) => true,
        builder: (_,List<NoteModel> _proNotes, Widget child){

          blog('user pro notes rebuilds ${_proNotes.length} notes');

          /// ADD USER UNSEEN NOTES TO LOCAL NOTES TO MARK SEEN
          _localNotesToMarkUnseen = NoteModel.insertNotesInNotes(
            notesToGet: _localNotesToMarkUnseen,
            notesToInsert: _proNotes,
            duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
          );

          return FireCollPaginator(
              scrollController: _scrollController,
              queryModel: userReceivedNotesPaginationQueryParameters(
                  onDataChanged: _onPaginatorDataChanged
              ),
              builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

                blog('FireCollPaginator : rebuilding with ${maps.length} map');

                /// COMBINE NOTES FROM STREAM + NOTES FROM PROVIDER
                final List<NoteModel> _combined = _combinePaginatorMapsWithProviderNotes(
                  paginatedMaps: maps,
                  providerNotes: _proNotes,
                );

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  itemCount: _combined?.length,
                  padding: Stratosphere.stratosphereSandwich,
                  itemBuilder: (BuildContext ctx, int index) {

                    final NoteModel _notiModel = Mapper.checkCanLoopList(_combined) == true ?
                    _combined[index]
                        :
                    null;

                    return NoteCard(
                      key: PageStorageKey<String>('user_note_card_${_notiModel.id}'),
                      noteModel: _notiModel,
                      isDraftNote: false,
                    );

                  },
                );

              }
          );

        });

  }
// -----------------------------------------------------------------------------
}
