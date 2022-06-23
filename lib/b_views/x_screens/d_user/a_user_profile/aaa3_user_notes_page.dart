import 'dart:async';

import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_controllers/d_user_controllers/a_user_profile/aaa3_user_notes_controllers.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/b_views/z_components/streamers/fire_coll_paginator.dart';
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
  final ScrollController _scrollController = ScrollController();
  NotesProvider _notesProvider;
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
    _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    super.initState();
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  @override
  void dispose() {

    blog('DISPOSING USER NOTES PAGE AHO');

    _scrollController.dispose();
    _loading.dispose();
    _markAllUserUnseenNotesAsSeen();

    // _notesProvider.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  List<NoteModel> _localNotesToMarkUnseen = <NoteModel>[];
// -----------------------------------
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

        _notesProvider.setIsFlashing(
          setTo: false,
          notify: true,
        );
      });

    }

  }
// -----------------------------------
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
// -----------------------------------
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


    return _combined;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Selector<NotesProvider, List<NoteModel>>(
        selector: (_, NotesProvider notesProvider) => notesProvider.userUnseenNotes,
        shouldRebuild: (before, after) => true,
        builder: (_,List<NoteModel> _proNotes, Widget child){

          /// ADD USER UNSEEN NOTES TO LOCAL NOTES TO MARK SEEN
          _localNotesToMarkUnseen = NoteModel.insertNotesInNotes(
            notesToGet: _localNotesToMarkUnseen,
            notesToInsert: _proNotes,
            duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
          );

          return FireCollPaginator(
              scrollController: _scrollController,
              queryParameters: userReceivedNotesPaginationQueryParameters(
                onDataChanged: _onPaginatorDataChanged
              ),
              builder: (_, List<Map<String, dynamic>> maps, bool isLoading){

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
                      noteModel: _notiModel,
                      isDraftNote: false,
                    );

                  },
                );

              }
              );

        });

  }
}