import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/bz_notes_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_order_by.dart';
import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/pagination_and_streaming/fire_coll_paginator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;

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

class _BzNotesPageState extends State<BzNotesPage> {
// -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  NotesProvider _notesProvider;
  BzModel _bzModel;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: false);
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {

    _scrollController.dispose();
    _markAllBzUnseenNotesAsSeen();

    // _notesProvider.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  List<NoteModel> _localNotesToMarkUnseen = <NoteModel>[];
// -----------------------------------
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

      /// DECREMENT UNSEEN BZ NOTES NUMBER IN OBELISK
      decrementBzObeliskUnseenNotesNumber(
        notesProvider: _notesProvider,
        markedNotesLength: _notesToMark.length,
        bzID: _bzModel.id,
      );

      /// UN-FLASH PYRAMID
      _notesProvider.setIsFlashing(
        setTo: false,
        notify: true,
      );

      /// REMOVE UNSEEN NOTES FROM ALL BZZ UNSEEN NOTES
      _notesProvider.removeNotesFromAllBzzUnseenNotes(
        notes: _notesToMark,
        notify: true,
      );

    });
    }


  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    return Selector<NotesProvider, List<NoteModel>>(
        selector: (_, NotesProvider notesProvider) => notesProvider.myBzzUnseenReceivedNotes,
        shouldRebuild: (before, after) => true,
        builder: (_,List<NoteModel> _allMyBzzNotes, Widget child){

          final List<NoteModel> _bzNotes = NoteModel.getUnseenNotesByReceiverID(
            notes: _allMyBzzNotes,
            receiverID: _bzModel.id,
          );

          _localNotesToMarkUnseen = NoteModel.insertNotesInNotes(
            notesToGet: _localNotesToMarkUnseen,
            notesToInsert: _bzNotes,
            duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
          );

          return FireCollPaginator(
              scrollController: _scrollController,
              queryParameters: QueryParameters(
                collName: FireColl.notes,
                limit: 5,
                orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
                finders: <FireFinder>[
                  FireFinder(
                    field: 'receiverID',
                    comparison: FireComparison.equalTo,
                    value: _bzModel.id,
                  ),
                ],
                onDataChanged: (List<Map<String, dynamic>> newMaps){

                  final List<NoteModel> _newNotes = NoteModel.decipherNotesModels(
                    maps: newMaps,
                    fromJSON: false,
                  );

                  _localNotesToMarkUnseen = NoteModel.insertNotesInNotes(
                    notesToGet: _localNotesToMarkUnseen,
                    notesToInsert: _newNotes,
                    duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
                  );

                },
              ),
              builder: (_, List<Map<String, dynamic>> maps, bool isLoading){

                final List<NoteModel> _streamNotes = NoteModel.decipherNotesModels(
                  maps: maps,
                  fromJSON: false,
                );

                /// maps from stream + new provider notes
                final List<NoteModel> _combined = NoteModel.insertNotesInNotes(
                    notesToGet: <NoteModel>[],
                    notesToInsert: <NoteModel>[..._bzNotes, ..._streamNotes],
                    duplicatesAlgorithm: DuplicatesAlgorithm.keepFirst
                );

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  itemCount: _combined?.length,
                  padding: Stratosphere.stratosphereSandwich,
                  itemBuilder: (BuildContext ctx, int index) {

                    final NoteModel _notiModel = Mapper.checkCanLoopList(_combined) == true ? _combined[index] : null;

                    return NoteCard(
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

}