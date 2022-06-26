import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/notes/note_red_dot.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/query_parameters.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/b_views/z_components/streamers/fire/fire_coll_paginator.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/notes_creator_controller.dart';
import 'package:flutter/material.dart';

class AllNotesScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AllNotesScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<AllNotesScreen> createState() => _AllNotesScreenState();
/// --------------------------------------------------------------------------
}

class _AllNotesScreenState extends State<AllNotesScreen> {
// -----------------------------------------------------------------------------
//   final ValueNotifier<List<NoteModel>> _notes = ValueNotifier(<NoteModel>[]);
  final ScrollController _scrollController = ScrollController();
  // bool _canPaginate = true;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'BzAuthorsPage',
    );
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
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        // await _paginateAllNotes();

      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    // _notes.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
//   Future<void> _paginateAllNotes() async {
//
//     _loading.value = true;
//
//     final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
//       context: context,
//       collName: FireColl.notes,
//       startAfter: Mapper.checkCanLoopList(_notes.value) == true ? _notes.value.last.docSnapshot : null,
//       orderBy: const Fire.QueryOrderBy(fieldName: 'sentTime', descending: true),
//       addDocsIDs: true,
//       addDocSnapshotToEachMap: true,
//       limit: 8,
//       // finders: <FireFinder>[
//       //   FireFinder(
//       //     field: 'recieverID',
//       //     comparison: FireComparison.equalTo,
//       //     value: recieverID,
//       //   ),
//       // ],
//     );
//
//     if (Mapper.checkCanLoopList(_maps) == true){
//
//       final List<NoteModel> _newNotes = NoteModel.decipherNotes(
//         maps: _maps,
//         fromJSON: false,
//       );
//
//       final List<NoteModel> _combinesNotes = <NoteModel>[..._notes.value, ..._newNotes];
//       _notes.value = _combinesNotes;
//
//     }
//
//     _loading.value = false;
//
//   }
// -----------------------------------------------------------------------------
  Future<void> _onNoteTap({
    @required NoteModel note,
  }) async {

    final List<Widget> _buttons = <Widget>[

      BottomDialog.wideButton(
        context: context,
        verse: 'Delete',
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
        title: 'Fuck this',
        builder: (_, PhraseProvider phrasePro){

          return _buttons;

        }

    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('AllNotesScreen : REBUILDING SCREEN');

    return MainLayout(
      pageTitle: 'Note Creator',
      sectionButtonIsOn: false,
      pyramidsAreOn: true,
      zoneButtonIsOn: false,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      loading: _loading,
      layoutWidget: FireCollPaginator(
        scrollController: _scrollController,
        queryParameters: FireQueryModel(
          collName: FireColl.notes,
          orderBy: const Fire.QueryOrderBy(fieldName: 'sentTime', descending: true),
          limit: 5,
          onDataChanged: (List<Map<String, dynamic>> maps){

            setState(() {
              blog('AllNotesScreen : setting state');
            });

          },
        ),
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading){

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
                    margin: Scale.superInsets(context: context, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        SuperVerse(
                          verse: _noteModel.id,
                          italic: true,
                          size: 1,
                          margin: Scale.superInsets(context: context, enLeft: 20, top: 5),
                          weight: VerseWeight.thin,
                        ),

                        NoteRedDotWrapper(
                          redDotIsOn: NoteModel.checkIsUnSeen(_noteModel),
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
}
