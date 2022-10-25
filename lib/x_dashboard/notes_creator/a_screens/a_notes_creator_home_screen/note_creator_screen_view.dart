import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/a_note_switches_controllers.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/b_parties_controllers.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/c_note_texts_controllers.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/f_topics_controllers.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/d_poster_controllers.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/e_progress_controller.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/g_buttons_controller.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/h_panel_controllers.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/i_note_sending_controllers.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/j_trigger_controllers.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/bubbles/a_parties_creator_bubble.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/bubbles/b_note_title_creator_bubble.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/bubbles/c_note_body_creator_bubble.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/bubbles/d_poster_creator_bubble.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/bubbles/e_note_progress_creator_bubble.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/bubbles/f_note_buttons_creator_bubble.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/bubbles/g_note_topic_selector_bubble.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/bubbles/h_note_fcm_trigger_bubble.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/bubbles/i_note_dismissible_trigger_bubble.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/bubbles/k_note_trigger_creator.dart';
import 'package:bldrs/x_dashboard/notes_creator/components/bubbles/x_note_preview_panel.dart';
import 'package:bldrs/x_dashboard/notes_creator/draft_note.dart';
import 'package:flutter/material.dart';

class NoteCreatorScreenView extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NoteCreatorScreenView({
    @required this.receiverType,
    @required this.toSingleParty,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PartyType receiverType;
  final bool toSingleParty;
  /// --------------------------------------------------------------------------
  @override
  _NoteCreatorScreenViewState createState() => _NoteCreatorScreenViewState();
  /// --------------------------------------------------------------------------
}

class _NoteCreatorScreenViewState extends State<NoteCreatorScreenView> {
  // -----------------------------------------------------------------------------
  DraftNote _draftNote;
  // -----------------------------------------------------------------------------
  /*
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
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _draftNote = DraftNote.initialize();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _draftNote.dispose();
    // _loading.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: _draftNote.noteNotifier,
      builder: (_, NoteModel note, Widget child){

        return Stack(
          children: <Widget>[

            /// CREATOR BUBBLES
            Form(
              key: _draftNote.formKey,
              child: ListView(
                controller: _draftNote.scrollController,
                padding: Stratosphere.stratosphereInsets,
                physics: const BouncingScrollPhysics(),
                children:  <Widget>[

                  /// FCM SWITCH
                  NoteAndFCMTriggersBubble(
                    note: note,
                    onTriggerSendFCM: (bool val) => onSwitchSendFCM(
                      noteNotifier: _draftNote.noteNotifier,
                      value: val,
                    ),
                    onTriggerSendNote: (bool val) => onSwitchSendNote(
                      noteNotifier: _draftNote.noteNotifier,
                      value: val,
                    ),
                  ),

                  /// PARTIES
                  NotePartiesBubbles(
                    note: note,
                    receiversModels: _draftNote.receiversModels,
                    onSelectSenderType: (PartyType senderType) => onSelectNoteSender(
                      context: context,
                      senderType: senderType,
                      noteNotifier: _draftNote.noteNotifier,
                    ),
                    onSelectReceiverType: (PartyType receiverType) => onSelectReceiverType(
                      context: context,
                      selectedReceiverType: receiverType,
                      noteNotifier: _draftNote.noteNotifier,
                      receiversModels: _draftNote.receiversModels,
                    ),
                  ),

                  /// TOPIC
                  NoteTopicSelectorBubble(
                    noteModel: note,
                    receiversModels: _draftNote.receiversModels,
                    onSelectTopic: (TopicModel topic) => onSelectTopic(
                      topic: topic,
                      partyType: widget.receiverType,
                      noteNotifier: _draftNote.noteNotifier,
                    ),
                  ),

                  /// TITLE
                  NoteTitleCreatorBubble(
                    titleController: _draftNote.titleController,
                    bodyNode: _draftNote.bodyNode,
                    titleNode: _draftNote.titleNode,
                    onTextChanged: (String text) => onTitleChanged(
                      noteNotifier: _draftNote.noteNotifier,
                      text: text,
                    ),
                  ),

                  /// BODY
                  NoteBodyCreatorBubble(
                    bodyController: _draftNote.bodyController,
                    bodyNode: _draftNote.bodyNode,
                    onTextChanged: (String text) => onBodyChanged(
                      noteNotifier: _draftNote.noteNotifier,
                      text: text,
                    ),
                  ),

                  /// POSTER
                  PosterCreatorBubble(
                    note: note,
                    onSwitchPoster: (bool value) => onSwitchPoster(
                      noteNotifier: _draftNote.noteNotifier,
                      value: value,
                    ),
                    onSelectPosterType: (PosterType posterType) => onSelectPosterType(
                        context: context,
                        posterType: posterType,
                        noteNotifier: _draftNote.noteNotifier,
                    ),
                  ),

                  /// PROGRESS
                  NoteProgressCreatorBubble(
                    note: note,
                    onSwitch: (bool value) => onSwitchNoteProgress(
                      value: value,
                      noteNotifier: _draftNote.noteNotifier,
                    ),
                    onTriggerLoading: () => onTriggerNoteLoading(
                      noteNotifier: _draftNote.noteNotifier,
                    ),
                    onIncrement: (int amount) => onIncrementNoteProgress(
                      noteNotifier: _draftNote.noteNotifier,
                      amount: amount,
                    ),
                    onDecrement: (int amount) => onDecrementNoteProgress(
                      noteNotifier: _draftNote.noteNotifier,
                      amount: amount,
                    ),
                  ),

                  /// BUTTONS
                  NoteButtonsCreatorBubble(
                    note: note,
                    onAddButton: (String phid) => onAddNoteButton(
                        noteNotifier: _draftNote.noteNotifier,
                        button: phid,
                    ),
                  ),

                  /// TRIGGER
                  NoteTriggerCreator(
                    noteModel: note,
                    onSelectTrigger: (TriggerModel trigger) => onAddTrigger(
                      noteNotifier: _draftNote.noteNotifier,
                      trigger: trigger,
                    ),
                    onRemoveTrigger: () => removeTrigger(
                      noteNotifier: _draftNote.noteNotifier,
                    ),
                  ),

                  /// CAN BE DISMISSED
                  NoteDismissibleTriggerBubble(
                    isDismissible: note.dismissible,
                    note: note,
                    onSwitch: (bool value) => onSwitchIsDismissible(
                        noteNotifier: _draftNote.noteNotifier,
                        value: value,
                    ),
                  ),

                  /// HORIZON
                  const Horizon(heightFactor: 2),

                ],
              ),
            ),

            /// CONFIRM BUTTON
            NotePreviewPanel(
              note: note,
              receiversModels: _draftNote.receiversModels,
              onTestNote: () => onTestNote(
                context: context,
                noteNotifier: _draftNote.noteNotifier,
              ),
              onBlogNote: () => onBlogNote(
                noteNotifier: _draftNote.noteNotifier,
              ),
              onClearNote: () => clearNote(
                draftNote: _draftNote,
              ),
              onImportNote: () => onGoToNoteTemplatesScreen(
                context: context,
                draftNote: _draftNote,
              ),
              onSendNote: () => onSendNote(
                context: context,
                draftNote: _draftNote,
              ),
              onNoteOptionsTap: () => onNoteCreatorCardOptionsTap(
                context: context,
                draftNote: _draftNote,
              )
            ),

          ],
        );

      },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
