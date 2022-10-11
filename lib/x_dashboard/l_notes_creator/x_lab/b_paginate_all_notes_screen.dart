import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/note_red_dot.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/firestore.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_paginator.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_notes_creator_controller.dart';
import 'package:flutter/material.dart';

class FireNotesPaginator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FireNotesPaginator({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<FireNotesPaginator> createState() => _FireNotesPaginatorState();
  /// --------------------------------------------------------------------------
}

class _FireNotesPaginatorState extends State<FireNotesPaginator> {
  // -----------------------------------------------------------------------------
  ///
  //   final ValueNotifier<List<NoteModel>> _notes = ValueNotifier(<NoteModel>[]);
  ///
  // bool _canPaginate = true;
  ///
  final ScrollController _scrollController = ScrollController();
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
      blogLoading(loading: _loading.value, callerName: 'AllNotesScreen',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    // _canPaginate = fuckingPaginator(
    //   context: context,
    //   scrollController: _scrollController,
    //   canPaginate: _canPaginate,
    //   function: _paginateAllNotes,
    // );


  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //   // await _paginateAllNotes();
      //
      //   _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /*
  Future<void> _paginateAllNotes() async {

    _loading.value = true;

    final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
      context: context,
      collName: FireColl.notes,
      startAfter: Mapper.checkCanLoopList(_notes.value) == true ? _notes.value.last.docSnapshot : null,
      orderBy: const Fire.QueryOrderBy(fieldName: 'sentTime', descending: true),
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
      limit: 8,
      // finders: <FireFinder>[
      //   FireFinder(
      //     field: 'recieverID',
      //     comparison: FireComparison.equalTo,
      //     value: recieverID,
      //   ),
      // ],
    );

    if (Mapper.checkCanLoopList(_maps) == true){

      final List<NoteModel> _newNotes = NoteModel.decipherNotes(
        maps: _maps,
        fromJSON: false,
      );

      final List<NoteModel> _combinesNotes = <NoteModel>[..._notes.value, ..._newNotes];
      _notes.value = _combinesNotes;

    }

    _loading.value = false;

//   }
   */
  // -----------------------------------------------------------------------------
  Future<void> _onNoteTap({
    @required NoteModel note,
  }) async {

    final List<Widget> _buttons = <Widget>[

      BottomDialog.wideButton(
        context: context,
        verse: Verse.plain( 'Delete'),
        onTap: () => onDeleteNote(
          context: context,
          noteModel: note,
          // notes: allNotes,
          loading: _loading,
        ),
      ),

    ];

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        numberOfWidgets: _buttons.length,
        titleVerse: Verse.plain('All note screen show button dialog'),
        builder: (_){
          return _buttons;
        }

    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('AllNotesScreen : REBUILDING SCREEN');

    return MainLayout(
      pageTitleVerse: Verse.plain('Fire Notes Paginator'),
      sectionButtonIsOn: false,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      loading: _loading,
      layoutWidget: FireCollPaginator(
        scrollController: _scrollController,
        queryModel: FireQueryModel(
          collRef: Fire.createSuperCollRef(aCollName: FireColl.notes),
          orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
          limit: 5,
          onDataChanged: (List<Map<String, dynamic>> maps){

            setState(() {
              blog('AllNotesScreen : setting state');
            });

          },
        ),

        builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

          final List<NoteModel> notesModels = NoteModel.decipherNotes(
            maps: maps,
            fromJSON: false,
          );

          if (Mapper.checkCanLoopList(notesModels) == false){
            return const SizedBox();
          }

          else {

            return ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: Stratosphere.stratosphereInsets,
                itemCount: notesModels.length,
                itemBuilder: (_, index){

                  final NoteModel _noteModel = notesModels[index];

                  return Container(
                    width: BldrsAppBar.width(context),
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        SuperVerse(
                          verse: Verse(
                            text: _noteModel.id,
                            translate: false,
                          ),
                          italic: true,
                          size: 1,
                          margin: Scale.superInsets(context: context, enLeft: 20, top: 5),
                          weight: VerseWeight.thin,
                        ),

                        NoteRedDotWrapper(
                          redDotIsOn: _noteModel.seen == false,
                          shrinkChild: true,
                          childWidth: BldrsAppBar.width(context),
                          child: NoteCard(
                            noteModel: _noteModel,
                            isDraftNote: false,
                            onNoteOptionsTap: () => _onNoteTap(
                              note: _noteModel,
                            ),
                            onCardTap: () => _noteModel.blogNoteModel(methodName: 'All Notes'),
                          ),
                        ),

                      ],
                    ),
                  );

                }
            );

          }

        },
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
