import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/note_model.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/x4_bz_notes_page_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/fire_coll_paginator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzNotesPage extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzNotesPage({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<BzNotesPage> createState() => _BzNotesPageState();
  /// --------------------------------------------------------------------------
}

class _BzNotesPageState extends State<BzNotesPage>{
  // -----------------------------------------------------------------------------
  /*
  // with AutomaticKeepAliveClientMixin<BzNotesPage>
  // @override
  // bool get wantKeepAlive => true;
   */
  // -----------------------------------------------------------------------------
  ScrollController _scrollController;
  // Stream<List<NoteModel>> _receivedNotesStream;
  BzModel _bzModel;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'BzNotesPage',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    blog('initState --------------- BZ - NOTES - PAGE ---- BIAAATCH');
    _scrollController = ScrollController();
    _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: false);
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
  bool _disposed = false;
  @override
  void dispose() {
    if (_disposed == false){
      blog('DISPOSING --------------- BZ - NOTES - PAGE ---- BIAAATCH');
      _scrollController.dispose();
      _loading.dispose();
      _markAllBzUnseenNotesAsSeen();
      _disposed = true;
    }
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  List<NoteModel> _localNotesToMarkUnseen = <NoteModel>[];
  // --------------------
  void _markAllBzUnseenNotesAsSeen(){

    /// COLLECT NOTES TO MARK FIRST
    final List<NoteModel> _notesToMark = NoteModel.getOnlyUnseenNotes(
      notes: _localNotesToMarkUnseen,
    );

    /// MARK ON FIREBASE
    unawaited(NoteFireOps.markNotesAsSeen(
        context: context,
        notes: _notesToMark
    ));

    if (Mapper.checkCanLoopList(_notesToMark) == true){
      WidgetsBinding.instance.addPostFrameCallback((_){

        // /// DECREMENT UNSEEN BZ NOTES NUMBER IN OBELISK
        // decrementBzObeliskUnseenNotesNumber(
        //   notesProvider: _notesProvider,
        //   markedNotesLength: _notesToMark.length,
        //   bzID: _bzModel.id,
        // );

        /// UN-FLASH PYRAMID
        NotesProvider.proSetIsFlashing(
          context: context,
          setTo: false,
          notify: true,
        );

        /// REMOVE UNSEEN NOTES FROM ALL BZZ UNSEEN NOTES
        NotesProvider.proRemoveNotesFromBzzNotes(
          context: context,
          notes: _notesToMark,
          bzID: _bzModel.id,
          notify: true,
        );

      });
    }


  }
  // --------------------
  void _onProviderDataChanged({
    @required List<NoteModel> bzNotes,
  }){

    /// ADD THIS BZ UNSEEN PROVIDER NOTES TO LOCAL NOTES TO MARK SEEN
    _localNotesToMarkUnseen = NoteModel.insertNotesInNotes(
      notesToGet: _localNotesToMarkUnseen,
      notesToInsert: bzNotes,
      duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
    );

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

    final List<NoteModel> _ordered = NoteModel.orderNotesBySentTime(_combined);

    return _ordered;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    return Selector<NotesProvider, List<NoteModel>>(
        key: const ValueKey<String>('BzNotesPage'),
        selector: (_, NotesProvider notesProvider){

          final Map<String, List<NoteModel>> _map = notesProvider.myBzzNotes;

          final List<NoteModel> _bzNotes = _map[_bzModel.id];

          _onProviderDataChanged(
            bzNotes: _bzNotes,
          );

          return _bzNotes;
        },
        shouldRebuild: (before, after) => true,
        builder: (_,List<NoteModel> _providerNotes, Widget child){

          return FireCollPaginator(
              scrollController: _scrollController,
              queryModel: bzReceivedNotesPaginationQueryParameters(
                bzID: _bzModel.id,
                onDataChanged: _onPaginatorDataChanged,
              ),
              builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

                /// COMBINE NOTES FROM PAGINATOR + NOTES FROM PROVIDER
                final List<NoteModel> _combined = _combinePaginatorMapsWithProviderNotes(
                  providerNotes: _providerNotes ?? [],
                  paginatedMaps: maps,
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
                      key: PageStorageKey<String>('bz_note_card_${_notiModel.id}'),
                      noteModel: _notiModel,
                      isDraftNote: false,
                    );

                  },
                );

              }
          );

        });

    // return FireCollPaginator(
    //     queryParameters: BzModel.allReceivedBzNotesQueryParameters(
    //       bzModel: _bzModel,
    //       context: context,
    //     ),
    //     scrollController: _controller,
    //     builder: (_, List<Map<String, dynamic>> maps, bool isLoading){
    //
    //       final List<NoteModel> _notes = NoteModel.decipherNotesModels(
    //         maps: maps,
    //         fromJSON: false,
    //       );
    //
    //       return ListView.builder(
    //         physics: const BouncingScrollPhysics(),
    //         controller: _controller,
    //         itemCount: _notes.length,
    //         padding: Stratosphere.stratosphereSandwich,
    //         itemBuilder: (_, int index){
    //
    //           final NoteModel _note = _notes[index];
    //
    //           return NoteCard(
    //             noteModel: _note,
    //             isDraftNote: false,
    //             // onNoteOptionsTap: null,
    //             // onCardTap: null,
    //           );
    //
    //         },
    //       );
    //
    //     }
    // );

  }
// -----------------------------------------------------------------------------
}
