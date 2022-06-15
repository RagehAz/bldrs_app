import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_controllers/g_user_controllers/user_notes_controllers.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_order_by.dart';
import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/pagination_and_streaming/fire_coll_paginator.dart';
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
  @override
  void initState() {
    _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {

    _scrollController.dispose();
    _markAllUserUnseenNotesAsSeen();

    // _notesProvider.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  List<NoteModel> _localNotesToMarkUnseen = <NoteModel>[];
// -----------------------------------
  void _markAllUserUnseenNotesAsSeen(){

    WidgetsBinding.instance.addPostFrameCallback((_){

      markUserUnseenNotes(
        context: context,
        notes: _localNotesToMarkUnseen,
        notesProvider: _notesProvider,
      );

    });

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Selector<NotesProvider, List<NoteModel>>(
        selector: (_, NotesProvider notesProvider) => notesProvider.userUnseenNotes,
        shouldRebuild: (before, after) => true,
        builder: (_,List<NoteModel> _proNotes, Widget child){

          _localNotesToMarkUnseen = NoteModel.insertNotesInNotes(
            notesToGet: _localNotesToMarkUnseen,
            notesToInsert: _proNotes,
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
                    value: superUserID(),
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
                  notesToInsert: <NoteModel>[..._proNotes, ..._streamNotes],
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

  }
}
