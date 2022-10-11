import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/multi_button/a_multi_button.dart';
import 'package:bldrs/b_views/z_components/layouts/corner_widget_maximizer.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/buttons/send_button.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_notes_creator_controller.dart';
import 'package:flutter/material.dart';

class NotePreviewPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotePreviewPanel({
    @required this.note,
    @required this.noteNotifier,
    @required this.receiversModels,
    @required this.titleController,
    @required this.bodyController,
    @required this.scrollController,
    @required this.formKey,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel note;
  final ValueNotifier<NoteModel> noteNotifier;
  final ValueNotifier<List<dynamic>> receiversModels;
  final TextEditingController titleController;
  final TextEditingController bodyController;
  final ScrollController scrollController;
  final GlobalKey<FormState> formKey;
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
                          icon: note?.sendFCM == true ? Iconz.news : Iconz.star,
                          iconSizeFactor: 0.5,
                          verseScaleFactor: 0.9,
                          verseItalic: true,
                          verse: Verse(
                            text: '${note?.sendFCM == true ? 'with FCM' : 'No FCM'} to',
                            translate: false,
                            casing: Casing.upperCase,
                          ),
                          secondLine: Verse(
                            text: '${receiversModels.length} ${note?.parties?.receiverType == NotePartyType.bz ? 'bzz' : 'users'}',
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
                          SendButton(
                            text: 'Clear',
                            // icon: Iconz.xSmall,
                            onTap: () async {

                              clearNote(
                                context: context,
                                note: noteNotifier,
                                titleController: titleController,
                                bodyController: bodyController,
                                receiversModels: receiversModels,
                              );

                            },
                          ),

                          const SizedBox(width: 5, height: 5,),

                          /// IMPORT BUTTON
                          SendButton(
                            text: 'Import',
                            verseScaleFactor: 0.40,
                            onTap: () async {

                              await onGoToNoteTemplatesScreen(
                                context: context,
                                scrollController: scrollController,
                                note: noteNotifier,
                                bodyController: bodyController,
                                titleController: titleController,
                                receiversModels: receiversModels,
                              );

                            },
                          ),

                        ],
                      ),

                      const SizedBox(width: 5, height: 5,),

                      /// TEST - BLOG
                      Row(
                        children: <Widget>[

                          /// TEST BUTTON
                          SendButton(
                            text: 'Test',
                            onTap: (){},
                          ),

                          const SizedBox(width: 5, height: 5,),

                          /// BLOG BUTTON
                          SendButton(
                            text: 'Blog',
                            onTap: (){
                              noteNotifier.value.blogNoteModel();
                            },
                          ),


                        ],
                      ),

                    ],
                  ),

                  const SizedBox(width: 5, height: 5,),

                  /// SEND BUTTON
                  SendButton(
                    text: 'Send',
                    height: _sendButtonSize,
                    width: _sendButtonSize,
                    verseScaleFactor: 1,
                    isDeactivated: !NoteModel.checkCanSendNote(note),
                    onTap: () => onSendNote(
                      formKey: formKey,
                      context: context,
                      note: noteNotifier,
                      titleController: titleController,
                      bodyController: bodyController,
                      scrollController: scrollController,
                      receiversModels: receiversModels,
                    ),
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
        onNoteOptionsTap: () => onNoteCreatorCardOptionsTap(
          context: context,
          note: noteNotifier,
          titleController: titleController,
          bodyController: bodyController,
          scrollController: scrollController,
        ),
      ),

    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
