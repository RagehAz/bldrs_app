import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/multi_button/a_multi_button.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/a_tile_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/b_parties_controllers.dart';
import 'package:bldrs/x_dashboard/notes_creator/z_components/buttons/note_party_button.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/lib/bubbles.dart';
import 'package:flutter/material.dart';

class NotePartiesBubbles extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotePartiesBubbles({
    @required this.note,
    @required this.receiversModels,
    @required this.onSelectSenderType,
    @required this.onSelectReceiverType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel note;
  final ValueNotifier<List<dynamic>> receiversModels;
  final ValueChanged<PartyType> onSelectSenderType;
  final ValueChanged<PartyType> onSelectReceiverType;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = Bubble.bubbleWidth(context: context);
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
        BldrsTileBubble(
          bubbleWidth: _halfBubbleWidth,
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            headlineVerse: const Verse(
              id: 'Sender',
              translate: false,
            ),
            leadingIcon: Iconz.phone,
            leadingIconSizeFactor: 0.5,
            leadingIconBoxColor: note?.parties?.senderID == null ? Colorz.grey50 : Colorz.green255,
          ),
          validator: () => noteSenderValidator(note),
          child: SizedBox(
            width: _halfBubbleChildWidth,
            child: Column(
              children: <Widget>[

                /// NOTE SENDER TYPES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    ...List.generate(NoteParties.noteSenderTypesList.length, (index){

                      final PartyType _senderType = NoteParties.noteSenderTypesList[index];
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
                        onTap: () => onSelectSenderType(_senderType),
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
        BldrsTileBubble(
          bubbleWidth: _halfBubbleWidth,
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            headlineVerse: const Verse(
              id: 'Receivers',
              translate: false,
            ),
            leadingIcon: Iconz.phone,
            leadingIconSizeFactor: 0.5,
            leadingIconBoxColor: note?.parties?.receiverType == null ? Colorz.grey50 : Colorz.green255,
          ),
          validator: () => noteRecieverValidator(note),
          child: SizedBox(
            width: _halfBubbleChildWidth,
            child: Column(
              children: <Widget>[

                /// RECEIVERS TYPES BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    ...List.generate(NoteParties.noteReceiverTypesList.length, (index){

                      final PartyType _receiverType = NoteParties.noteReceiverTypesList[index];
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
                        onTap: () => onSelectReceiverType(_receiverType),
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
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
