// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/multi_button/a_multi_button.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/a_tile_button.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/buttons/note_sender_or_reciever_dynamic_button.dart';
import 'package:bldrs/x_dashboard/notes_creator/x_notes_creator_controller.dart';
import 'package:flutter/material.dart';

class NotePartiesBubbles extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotePartiesBubbles({
    @required this.note,
    @required this.noteNotifier,
    @required this.receiversModels,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel note;
  final ValueNotifier<NoteModel> noteNotifier;
  final ValueNotifier<List<dynamic>> receiversModels;
  // -----------------------------------------------------------------------------
  /*
  List<Verse> _getNotTypeBulletPoints(NoteType noteType){

    // /// NOTHING SELECTED
    // if (noteType == null){
    //   return <Verse>[];
    // }
    //
    // /// NOTICE
    // else if (noteType == NoteType.notice){
    //   return <Verse>[
    //     const Verse(
    //       text: 'Notice note : is the default type of notes',
    //       translate: false,
    //     ),
    //   ];
    // }
    //
    // /// AUTHORSHIP
    // else if (noteType == NoteType.authorship){
    //   return <Verse>[
    //     const Verse(
    //       text: 'Authorship note : is when business invites user to become an author in the team',
    //       translate: false,
    //     ),
    //   ];
    // }
    //
    // /// FLYER UPDATE
    // else if (noteType == NoteType.flyerUpdate){
    //   return <Verse>[
    //     const Verse(
    //       text: 'FlyerUpdate note : is when an author updates a flyer, note is sent to his bz',
    //       translate: false,
    //     ),
    //     const Verse(
    //       text: 'This fires [reFetchFlyer] mesh faker esm el protocol',
    //       translate: false,
    //     ),
    //   ];
    // }
    //
    // /// BZ DELETION
    // else if (noteType == NoteType.bzDeletion){
    //   return <Verse>[
    //     const Verse(
    //       text: 'bzDeletion note : is when an author deletes his bz, all authors team receive this',
    //       translate: false,
    //     ),
    //     const Verse(
    //       text: 'This fires [deleteBzLocally] protocol, bardo mesh faker esm el protocol awy delwa2ty',
    //       translate: false,
    //     ),
    //   ];
    // }
    //
    // /// OTHERWISE
    // else {
    //   return null;
    // }

  }
   */
  // --------------------
  /*
  String _noteTypeValidator(NoteModel note){
    String _message;

    /// NOTE NULL
    if (note == null){
      _message = 'Note is null';
    }

    /// TYPE IS NULL
    else if (note?.type == null){
      _message = 'Select note type';
    }

    /// OTHERWISE
    else {

      _message ??= NoteModel.receiverVsNoteTypeValidator(
          receiverType: note?.receiverType,
          noteType: note?.type,
      );

      _message ??= NoteModel.senderVsNoteTypeValidator(
          senderType: note?.senderType,
        noteType: note?.type,
      );

    }

    return _message;
  }
   */
  // --------------------
  String _noteSenderValidator(NoteModel note){
    String _message;

    /// NOTE IS NULL
    if (note == null){
      _message = 'Note is null';
    }

    /// NO SENDER SELECTED
    else if (note?.parties?.senderID == null){
      _message = 'Select a sender';
    }

    /// NO SENDER TYPE
    else if (note?.parties?.senderType == null){
      _message = 'SenderType is null';
    }

    /// IMAGE IN NULL
    else if (note?.parties?.senderImageURL == null){
      _message = 'Sender pic is null';
    }

    /// OTHERWISE
    else {

      // _message ??= NoteModel.senderVsNoteTypeValidator(
      //     senderType: note?.senderType,
      //     noteType: note?.type,
      // );

      _message ??= NoteModel.receiverVsSenderValidator(
          senderType: note?.parties?.senderType,
          receiverType: note?.parties?.receiverType
      );

    }

    return _message;
  }
  // --------------------
  String _noteRecieverValidator(NoteModel note){
    String _message;

    /// NOTE IS NULL
    if (note == null){
      _message = 'Note is null';
    }

    /// NO SENDER SELECTED
    else if (note?.parties?.receiverID == null){
      _message = 'Select a receiver';
    }

    /// NO SENDER TYPE
    else if (note?.parties?.receiverType == null){
      _message = 'Receiver type is null';
    }

    /// OTHERWISE
    else {

      // _message ??= NoteModel.receiverVsNoteTypeValidator(
      //     receiverType: note?.receiverType,
      //     noteType: note?.type,
      // );

      _message ??= NoteModel.receiverVsSenderValidator(
          senderType: note?.parties?.senderType,
          receiverType: note?.parties?.receiverType
      );

    }

    return _message;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = Bubble.bubbleWidth(context);
    final double _halfBubbleWidth = (_bubbleWidth - 10) / 2;
    final double _halfBubbleChildWidth = TileBubble.childWidth(
      context: context,
      bubbleWidthOverride: _halfBubbleWidth,
    );
    final double _partyIconSize = _halfBubbleChildWidth / NoteParties.noteSenderTypesList.length;
    // --------------------
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        const SizedBox(width: 10, height: 10),

        /// SENDER
        TileBubble(
          bubbleWidth: _halfBubbleWidth,
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: const Verse(
              text: 'Sender',
              translate: false,
            ),
            leadingIcon: Iconz.phone,
            leadingIconSizeFactor: 0.5,
            leadingIconBoxColor: note?.parties?.senderID == null ? Colorz.grey50 : Colorz.green255,
          ),
          validator: () => _noteSenderValidator(note),
          child: SizedBox(
            width: _halfBubbleChildWidth,
            child: Column(
              children: <Widget>[

                /// NOTE SENDER TYPES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    ...List.generate(NoteParties.noteSenderTypesList.length, (index){

                      final NotePartyType _senderType = NoteParties.noteSenderTypesList[index];
                      final bool _isSelected = note?.parties?.senderType == _senderType;
                      final String _senderTypeIcon = NoteParties.getPartyIcon(_senderType);

                      return DreamBox(
                        height: _partyIconSize,
                        width: _partyIconSize,
                        icon: _senderTypeIcon,
                        iconSizeFactor: 0.5,
                        color: _isSelected == true ? Colorz.yellow255 : null,
                        verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                        iconColor:  _isSelected == true ? Colorz.black255 : null,
                        verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                        onTap: () => onSelectNoteSender(
                          context: context,
                          senderType: _senderType,
                          note: noteNotifier,
                        ),
                      );

                    }),

                  ],
                ),

                /// NOTE SENDER BUTTON
                NotePartyButton(
                  width: _halfBubbleChildWidth,
                  type: note?.parties?.senderType,
                  id: note?.parties?.senderID,
                ),

              ],
            ),
          ),
        ),

        const SizedBox(width: 10, height: 10),

        /// RECEIVERS
        TileBubble(
          bubbleWidth: _halfBubbleWidth,
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: const Verse(
              text: 'Receivers',
              translate: false,
            ),
            leadingIcon: Iconz.phone,
            leadingIconSizeFactor: 0.5,
            leadingIconBoxColor: note?.parties?.receiverType == null ? Colorz.grey50 : Colorz.green255,
          ),
          validator: () => _noteRecieverValidator(note),
          child: SizedBox(
            width: _halfBubbleChildWidth,
            child: Column(
              children: <Widget>[

                /// RECEIVERS TYPES BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    ...List.generate(NoteParties.noteReceiverTypesList.length, (index){

                      final NotePartyType _receiverType = NoteParties.noteReceiverTypesList[index];
                      final bool _isSelected = note?.parties?.receiverType == _receiverType;
                      final String _receiverTypeIcon = NoteParties.getPartyIcon(_receiverType);

                      return DreamBox(
                        height: _partyIconSize,
                        width: _halfBubbleChildWidth/2,
                        icon: _receiverTypeIcon,
                        iconSizeFactor: 0.5,
                        color: _isSelected == true ? Colorz.yellow255 : null,
                        verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                        iconColor:  _isSelected == true ? Colorz.black255 : null,
                        verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                        onTap: () async {
                          await onSelectReceiverType(
                            context: context,
                            selectedReceiverType: _receiverType,
                            noteNotifier: noteNotifier,
                            receiversModels: receiversModels,
                          );
                        },
                      );

                    }),

                  ],
                ),

                /// RECEIVERS LABEL
                ValueListenableBuilder(
                  valueListenable: receiversModels,
                  builder: (_, List<dynamic> receiversModels, Widget child){

                    final List<String> _pics = NoteParties.getReceiversPics(
                      receiversModels: receiversModels,
                      partyType: note.parties.receiverType,
                    );

                    final String _receiversTypePhid = NoteParties.getReceiversTypePhid(
                      partyType: note.parties.receiverType,
                      receiversModels: receiversModels,
                      plural: receiversModels.length > 1,
                    );

                    return MultiButton(
                      height: TileButton.defaultHeight,
                      width: _halfBubbleChildWidth,
                      verse: _pics.isEmpty == true ? null : Verse.plain('${_pics.length} ${xPhrase(context, _receiversTypePhid)}'),
                      margins: const EdgeInsets.symmetric(vertical: 5),
                      bubble: false,
                      color: Colorz.white10,
                      pics: _pics,
                    );

                  },
                ),

              ],
            ),
          ),
        ),

        const SizedBox(width: 10, height: 10),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
