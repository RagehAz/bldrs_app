import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/d_bz_notes_page/bz_notes_page_controllers.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/pull_to_refresh.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_paginator.dart';
import 'package:bldrs/c_protocols/note_protocols/fire/note_fire_ops.dart';
import 'package:bldrs/e_back_end/x_queries/notes_queries.dart';
import 'package:bldrs/e_back_end/z_helpers/pagination_controller.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:flutter/material.dart';

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
  PaginationController _paginationController;
  // --------------------
  final List<NoteModel> _localNotesToMarkUnseen = <NoteModel>[];
  // --------------------
  bool showNotes = true;
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
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _paginationController = PaginationController.initialize(
      addExtraMapsAtEnd: true,
      onDataChanged: _collectUnseenNotesToMarkAtDispose,
    );
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
    blog('BzNotesPage deactivate START');
    _markAllBzUnseenNotesAsSeen();
    super.deactivate();
    blog('BzNotesPage deactivate END');
  }
  // --------------------
  @override
  void dispose() {
    blog('BzNotesPage dispose START');
    _scrollController.dispose();
    _loading.dispose();
    _paginationController.dispose();
    super.dispose();
    blog('BzNotesPage dispose END');
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _markAllBzUnseenNotesAsSeen(){

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

    if (Mapper.checkCanLoopList(paginatorMaps) == true){

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

    _markAllBzUnseenNotesAsSeen();

    NotesProvider.proSetIsFlashing(
        context: context,
        setTo: false,
        notify: true
    );

    showWaitDialog(context,
      verse: const Verse(
        text: 'phid_reloading',
        translate: true,
      ),
    );

    setState(() {
      showNotes = false;
    });

    await Future.delayed(const Duration(milliseconds: 200), (){

      setNotifier(notifier: _paginationController.paginatorMaps, mounted: mounted, value: []);
      setNotifier(notifier: _paginationController.startAfter, mounted: mounted, value: null);

      setState(() {
        showNotes = true;
      });

    });

    closeWaitDialog(context);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Function _onNoteTap(NoteModel _note) {

    if (_note == null){
      return null;
    }
    else if (_note.navTo.name == Routing.myBzNotesPage || _note.navTo.name == null){
      return null;
    }
    else {
      return () => onBzNoteTap(
        context: context,
        noteModel: _note,
      );
    }
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true,
    );

    return PullToRefresh(
      onRefresh: _onRefresh,
      fadeOnBuild: true,
      child: showNotes == false ? const SizedBox() :

      FireCollPaginator(
          paginationQuery: bzNotesPaginationQueryModel(
            bzID: _bzModel.id,
          ),
          scrollController: _scrollController,
          paginationController: _paginationController,
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
                  key: PageStorageKey<String>('bz_note_card_${_note.id}'),
                  noteModel: _note,
                  isDraftNote: false,
                  onCardTap: _onNoteTap(_note),
                );

              },
            );

          }
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
