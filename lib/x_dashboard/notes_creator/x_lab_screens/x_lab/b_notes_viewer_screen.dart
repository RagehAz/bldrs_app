import 'dart:async';

import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_paginator.dart';
import 'package:bldrs/e_back_end/x_queries/notes_queries.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/x_notes_viewer_screen_controllers.dart';
import 'package:bldrs/x_dashboard/notes_creator/z_components/buttons/note_party_button.dart';
import 'package:flutter/material.dart';

class NotesViewerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NotesViewerScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<NotesViewerScreen> createState() => _NotesViewerScreenState();
  /// --------------------------------------------------------------------------
}

class _NotesViewerScreenState extends State<NotesViewerScreen> {
  // -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  // --------------------
  String _receiverID = 'z0Obwze3JLYjoEl6uVeXfo4Luup1';
  PartyType _partyType = PartyType.user;
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

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        await _triggerLoading(setTo: false);
      });

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
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      title: Verse.plain('Notes Paginator Test'),
      pyramidsAreOn: true,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      loading: _loading,
      appBarRowWidgets: <Widget>[

        const Expander(),

        NotePartyButton(
          type: _partyType,
          id: _receiverID,
          width: 100,
          height: 40,
          onTap: () => onShowReceiverTypes(
            context: context,
            onSelect: (String receiverID, PartyType partyType, String collName){

              setState(() {
                _receiverID = receiverID;
                _partyType = partyType;
              });

            }
          ),
        ),

      ],
      child:

      _receiverID == null ? const SizedBox()
          :
      FireCollPaginator(
        scrollController: _scrollController,
          paginationQuery: allNotesPaginationQueryModel(
            receiverPartyType: _partyType,
            receiverID: _receiverID,
          ),
        onDataChanged: (List<Map<String, dynamic>> maps){

          if (mounted){
            setState(() {
              blog('AllNotesScreen : setting state');
            });
          }

        },
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
                            text: 'from : ${_noteModel.parties.senderType} : ${_noteModel.parties.senderID} : ${_noteModel?.poll?.buttons}',
                            translate: false,
                          ),
                          italic: true,
                          size: 1,
                          margin: Scale.superInsets(
                            context: context,
                            appIsLeftToRight: TextDir.checkAppIsLeftToRight(context),
                            enLeft: 20,
                          ),
                          weight: VerseWeight.thin,
                        ),

                        NoteCard(
                          noteModel: _noteModel,
                          isDraftNote: false,
                          onNoteOptionsTap: () => onNoteTap(
                            context: context,
                            note: _noteModel,
                            loading: _loading,
                            mounted: mounted,
                          ),
                          onCardTap: () => _noteModel.blogNoteModel(
                              invoker: 'Notes viewer'
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
