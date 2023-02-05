import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/multi_button/a_multi_button.dart';
import 'package:bldrs/b_views/z_components/layouts/corner_widget_maximizer.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/x_dashboard/notes_creator/z_components/buttons/note_panel_button.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class NotePreviewPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotePreviewPanel({
    @required this.note,
    @required this.receiversModels,
    @required this.onTestNote,
    @required this.onBlogNote,
    @required this.onImportNote,
    @required this.onClearNote,
    @required this.onSendNote,
    @required this.onNoteOptionsTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel note;
  final ValueNotifier<List<dynamic>> receiversModels;
  final Function onTestNote;
  final Function onBlogNote;
  final Function onImportNote;
  final Function onClearNote;
  final Function onSendNote;
  final Function onNoteOptionsTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = Bubble.bubbleWidth(context);
    final double _clearWidth = Bubble.clearWidth(context);
    const double _sendButtonSize = (50 * 2) + 5.0;
    const double _buttonsZoneWidth = _sendButtonSize + 5 + _sendButtonSize;
    // --------------------
    final double _receiversZoneWidth = _clearWidth - (5 * 3) - _buttonsZoneWidth;
    // --------------------
    return CornerWidgetMaximizer(
      minWidth: 150,
      maxWidth: _bubbleWidth * 0.9,
      childWidth: _bubbleWidth,

      /// PANEL
      topChild: SizedBox(
        width: _clearWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            const SizedBox(width: 5, height: 5,),

            /// SENDING TO INFO
            Container(
              width: _receiversZoneWidth,
              height: _sendButtonSize,
              decoration: BoxDecoration(
                color: note?.parties?.receiverID == null ? Colorz.bloodTest : Colorz.white50,
                borderRadius: Borderers.constantCornersAll10,
              ),
              child: ValueListenableBuilder(
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

                    return Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // physics: const BouncingScrollPhysics(),
                      // padding: EdgeInsets.zero,
                      children: <Widget>[

                        DreamBox(
                          width: _receiversZoneWidth,
                          height: 50,
                          icon: note?.sendFCM == true ? Iconz.notification : Iconz.star,
                          iconSizeFactor: 0.5,
                          verseScaleFactor: 0.9,
                          verseItalic: true,
                          verse: Verse(
                            text: '${note?.sendFCM == true ? 'with FCM' : 'No FCM'} to',
                            translate: false,
                            casing: Casing.upperCase,
                          ),
                          secondLine: Verse(
                            text: '${receiversModels.length} ${note?.parties?.receiverType == PartyType.bz ? 'bzz' : 'users'}',
                            translate: false,
                          ),
                          color: note?.sendFCM == true ? Colorz.bloodTest : Colorz.blue125,
                          bubble: false,
                          verseCentered: false,
                          // margins: const EdgeInsets.only(bottom: 10),
                        ),

                        const SizedBox(width: 5, height: 5,),

                        MultiButton(
                          width: _receiversZoneWidth,
                          height: 50,
                          verse: _pics.isEmpty == true ? null : Verse.plain('${_pics.length} ${xPhrase(context, _receiversTypePhid)}'),
                          // margins: const EdgeInsets.symmetric(vertical: 5),
                          bubble: false,
                          color: Colorz.white10,
                          pics: _pics,
                        ),

                        // NoteSenderOrRecieverDynamicButtonsColumn(
                        //   width: 250,
                        //   type: note?.parties?.receiverType,
                        //   ids: NoteParties.getReceiversIDs(
                        //     receiversModels: receiversModels,
                        //     partyType: note?.parties?.receiverType,
                        //   ),
                        // ),

                      ],
                    );

                  }
              ),
            ),

            const SizedBox(width: 5, height: 5,),

            /// SEND - TEST - BLOG BUTTONS
            SizedBox(
              width: _buttonsZoneWidth,
              child: Row(
                children: <Widget>[

                  /// CLEAR - IMPORT - TEST - BLOG
                  Column(
                    children: <Widget>[

                      /// CLEAR - IMPORT
                      Row(
                        children: <Widget>[

                          /// CLEAR BUTTON
                          NotePanelButton(
                            text: 'Clear',
                            // icon: Iconz.xSmall,
                            onTap: onClearNote,
                          ),

                          const SizedBox(width: 5, height: 5,),

                          /// IMPORT BUTTON
                          NotePanelButton(
                            text: 'Import',
                            verseScaleFactor: 0.40,
                            onTap: onImportNote,
                          ),

                        ],
                      ),

                      const SizedBox(width: 5, height: 5,),

                      /// TEST - BLOG
                      Row(
                        children: <Widget>[

                          /// TEST BUTTON
                          NotePanelButton(
                            text: 'Test',
                            onTap: onTestNote,
                          ),

                          const SizedBox(width: 5, height: 5,),

                          /// BLOG BUTTON
                          NotePanelButton(
                            text: 'Blog',
                            onTap: onBlogNote,
                          ),


                        ],
                      ),

                    ],
                  ),

                  const SizedBox(width: 5, height: 5,),

                  /// SEND BUTTON
                  NotePanelButton(
                    text: 'Send',
                    height: _sendButtonSize,
                    width: _sendButtonSize,
                    verseScaleFactor: 1,
                    isDeactivated: !NoteModel.checkNoteIsSendable(note),
                    onTap: onSendNote,
                  ),

                ],
              ),
            ),

            const SizedBox(width: 5, height: 5,),

          ],
        ),
      ),

      /// NOTE
      child: NoteCard(
        bubbleWidth: _clearWidth,
        bubbleColor: note?.sendFCM == true ? Colorz.bloodTest : Colorz.blue125,
        noteModel: note.copyWith(id: 'preview_panel'),
        isDraftNote: false,
        onNoteOptionsTap: onNoteOptionsTap,
      ),

    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
