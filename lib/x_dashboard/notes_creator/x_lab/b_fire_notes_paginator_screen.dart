import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_paginator.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/buttons/note_sender_or_reciever_dynamic_button.dart';
import 'package:bldrs/x_dashboard/notes_creator/x_notes_creator_controller.dart';
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
  final ScrollController _scrollController = ScrollController();
  // --------------------
  String _collName = FireColl.users;
  String _receiverID = 'z0Obwze3JLYjoEl6uVeXfo4Luup1';
  NotePartyType _partyType = NotePartyType.user;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
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
  int _num = 1;
  static const List<String> _alpha = [
    'a', 'b', 'c', 'd', 'e',
    'f', 'g', 'h', 'i', 'j',
    'k', 'l', 'm', 'n', 'o',
    'p', 'q', 'r', 's', 't',
    'u', 'v', 'w', 'x', 'y',
    'z',
  ];
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
  // --------------------
  Future<void> _onSelectParty() async {

    await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: 2,
      buttonHeight: 50,
      builder: (_){

        return <Widget>[

          /// USER
          BottomDialog.wideButton(
            context: context,
            icon: Iconz.normalUser,
              onTap: () async {

              await Nav.goBack(context: context);

              final List<UserModel> _users = await onSelectUserAsNoteReceiver(
                context: context,
                selectedUsers: [],
              );

              if (Mapper.checkCanLoopList(_users) == true) {

                // setState(() {
                //   _receiverID = null;
                // });

                setState(() {
                  _receiverID = _users.first.id;
                  _collName = FireColl.users;
                  _partyType = NotePartyType.user;
                });

              }

              }
          ),

          /// BZ
          BottomDialog.wideButton(
            context: context,
            icon: Iconz.bz,
            onTap: () async {

              await Nav.goBack(context: context);

              final List<BzModel> _bzz = await onSelectBzAsNoteReceiver(
                context: context,
                selectedBzz: [],
              );

              if (Mapper.checkCanLoopList(_bzz) == true) {

                // setState(() {
                //   _receiverID = null;
                // });

                setState(() {
                  _receiverID = _bzz.first.id;
                  _collName = FireColl.bzz;
                  _partyType = NotePartyType.bz;
                });

              }

            }
          ),


        ];

      }
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitleVerse: Verse.plain('Notes Paginator Test'),
      sectionButtonIsOn: false,
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
          onTap: _onSelectParty,
        ),

        AppBarButton(
          icon: Iconz.share,
          isDeactivated: _receiverID == null,
          onTap: () async {

            final NoteModel _note = NoteModel.quickUserNotice(
              userID: AuthFireOps.superUserID(),
              title: _num.toString(),
              body: 'x',
            );

            await NoteProtocols.composeToOne(
              context: context,
              note: _note.copyWith(
                id: _alpha[_num-1],
              ),
            );

            _num++;

          },
        ),

      ],
      layoutWidget:

      _receiverID == null ? const SizedBox()
          :
      FireCollPaginator(
        scrollController: _scrollController,

        queryModel: FireQueryModel(
          collRef: Fire.getSuperCollRef(
              aCollName: _collName,
              bDocName: _receiverID,
              cSubCollName: FireSubColl.noteReceiver_receiver_notes
          ),
          orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
          limit: 5,
          onDataChanged: (List<Map<String, dynamic>> maps){

            if (mounted){
              setState(() {
                blog('AllNotesScreen : setting state');
              });
            }

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
                            text: 'from : ${_noteModel.parties.senderType} : ${_noteModel.parties.senderID}',
                            translate: false,
                          ),
                          italic: true,
                          size: 1,
                          margin: Scale.superInsets(
                            context: context,
                            enLeft: 20,
                          ),
                          weight: VerseWeight.thin,
                        ),

                        NoteCard(
                          noteModel: _noteModel,
                          isDraftNote: false,
                          onNoteOptionsTap: () => _onNoteTap(
                            note: _noteModel,
                          ),
                          onCardTap: () => _noteModel.blogNoteModel(invoker: 'All Notes'),
                        ),

                      ],
                    ),
                  );

                }
            );

          }

        },
      )
      ,
    );

  }
  // -----------------------------------------------------------------------------
}
