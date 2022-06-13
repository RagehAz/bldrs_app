import 'dart:async';

import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_controllers/g_user_controllers/user_notes_controller.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_order_by.dart';
import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
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

  @override
  void initState() {
    _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {

    _scrollController.dispose();
    _markAllUnseenNotesAsSeen();

    // _notesProvider.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  List<NoteModel> _localNotesToMarkUnseen = <NoteModel>[];
// -----------------------------------
  void _markAllUnseenNotesAsSeen(){

    final List<NoteModel> _notesToMark = <NoteModel>[];

    /// COLLECT NOTES TO MARK FIRST
    if (Mapper.checkCanLoopList(_localNotesToMarkUnseen) == true){

      for (final NoteModel note in _localNotesToMarkUnseen){

        if (note.seen != true){

          _notesToMark.add(note);


        }

      }

    }

    /// MARK THE SHIT OUT OF THEM BITCH
    if (Mapper.checkCanLoopList(_notesToMark) == true){

      /// MARK ON FIREBASE
      for (final NoteModel note in _notesToMark){
        unawaited(markNoteAsSeen(
          context: context,
          noteModel: note,
        ));
      }

      WidgetsBinding.instance.addPostFrameCallback((_){
        /// MARK ON PROVIDER
        _notesProvider.incrementObeliskNoteNumber(
          value: _notesToMark.length,
          navModelID: NavModel.getMainNavIDString(navID: MainNavModel.profile),
          notify: true,
          isIncrementing: false,
        );
        _notesProvider.incrementObeliskNoteNumber(
          value: _notesToMark.length,
          navModelID: NavModel.getUserTabNavID(UserTab.notifications),
          notify: true,
          isIncrementing: false,
        );
        _notesProvider.setIsFlashing(
          flashing: false,
          notify: true,
        );
      });


    }

  }
// -----------------------------------------------------------------------------
  /*
  Future<void> _dismissNote({
    @required String id,
    @required int notiModelsLength,
  }) async {

    blog('removing noti with id : $id ---------------------------------------xxxxx ');

    // await Fire.updateSubDocField(
    //   context: context,
    //   collName: FireColl.users,
    //   docName: FireAuthOps.superUserID(),
    //   subCollName: FireSubColl.users_user_notifications,
    //   subDocName: id,
    //   field: 'dismissed',
    //   input: true,
    // );

    if (notiModelsLength == 1) {
      blog('this was the last notification and is gone khalas  --------------------------------------- oooooo ');
    }

    // setState(() {
    //   _notifications.removeWhere((notiModel) => notiModel.id == id,);
    // });

  }
   */
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final List<NoteModel> _userNotes = NotesProvider.proGetUserNotes(
    //   context: context,
    //   listen: true,
    // );

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
            );

          },

        ),
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading){

          final List<NoteModel> _userNotes = NoteModel.decipherNotesModels(
              maps: maps,
              fromJSON: false,
          );

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            itemCount: _userNotes?.length,
            padding: Stratosphere.stratosphereSandwich,
            itemBuilder: (BuildContext ctx, int index) {

              final NoteModel _notiModel = Mapper.checkCanLoopList(_userNotes) == true ? _userNotes[index] : null;

              return NoteCard(
                noteModel: _notiModel,
                isDraftNote: false,
              );

            },
          );

        }
    );


    // if (Mapper.checkCanLoopList(_userNotes) == false){
    //
    //   return const SizedBox();
    //
    // }
    //
    // else {
    //
    //   return ListView.builder(
    //     physics: const BouncingScrollPhysics(),
    //     controller: ScrollController(),
    //     itemCount: _userNotes?.length,
    //     padding: Stratosphere.stratosphereSandwich,
    //     itemBuilder: (BuildContext ctx, int index) {
    //
    //       final NoteModel _notiModel = Mapper.checkCanLoopList(_userNotes) == true ? _userNotes[index] : null;
    //
    //       return NoteCard(
    //         noteModel: _notiModel,
    //         isDraftNote: false,
    //       );
    //
    //     },
    //   );
    //
    // }

  }
}
