import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/corner_widget_maximizer.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/notes/banner/note_attachment.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/buttons/note_sender_or_reciever_dynamic_button.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_lab/a_notes_lab_home.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_notes_creator_controller.dart';
import 'package:flutter/material.dart';

class NotesCreatorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NotesCreatorScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _NotesCreatorScreenState createState() => _NotesCreatorScreenState();
  /// --------------------------------------------------------------------------
}

class _NotesCreatorScreenState extends State<NotesCreatorScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --------------------
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleNode = FocusNode();
  final TextEditingController _bodyController = TextEditingController();
  final FocusNode _bodyNode = FocusNode();
  // --------------------
  final ValueNotifier<NoteModel> _noteNotifier = ValueNotifier<NoteModel>(null);
  final ValueNotifier<List<String>> _receiversIDs = ValueNotifier<List<String>>(<String>[]);
  // --------------------
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
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    initializeVariables(
      context: context,
      note: _noteNotifier,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {


        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
    _noteNotifier.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    _scrollController.dispose();
    _titleNode.dispose();
    _bodyNode.dispose();
    _receiversIDs.dispose();
    super.dispose();
  }
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
  String _noteButtonsValidator(NoteModel note){
    String _message;

    // if (note?.type == NoteType.authorship){
    //   if (note?.buttons?.length != 2){
    //     return 'Authorship Note should include yes & no buttons';
    //   }
    // }

    return _message;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _noteButtonButtonWidth = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: PollModel.acceptDeclineButtons.length,
      boxWidth: TileBubble.childWidth(context: context),
    );
    // --------------------
    final double _bubbleWidth = Bubble.bubbleWidth(context);
    final double _bubbleClearWidth = Bubble.clearWidth(context);
    final double _halfBubbleWidth = (_bubbleWidth - 10) / 2;
    final double _halfBubbleChildWidth = TileBubble.childWidth(
        context: context,
        bubbleWidthOverride: _halfBubbleWidth,
    );
    // --------------------
    return MainLayout(
      loading: _loading,
      pageTitleVerse: Verse.plain('Create Note ${Timers.generateString_on_dd_month_yyyy(
          context: context,
          time: DateTime.now()
      )}'),
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// NOTES LAB
        AppBarButton(
          // verse: Verse.plain('Templates'),
          icon: Iconz.lab,
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const NotesLabHome(),
          ),
        ),

      ],
      layoutWidget: ValueListenableBuilder(
        valueListenable: _noteNotifier,
        builder: (_, NoteModel note, Widget child){

          return Stack(
            children: <Widget>[

              /// NOTE CREATOR BUBBLES
              Form(
                key: _formKey,
                child: ListView(
                  controller: _scrollController,
                  padding: Stratosphere.stratosphereInsets,
                  physics: const BouncingScrollPhysics(),
                  children:  <Widget>[

                    /// TITLE
                    TextFieldBubble(
                      appBarType: AppBarType.basic,
                      titleVerse: Verse.plain('Note Title'),
                      isFormField: true,
                      textController: _titleController,
                      textOnChanged: (String text) => onTitleChanged(
                        note: _noteNotifier,
                        text: text,
                      ),
                      counterIsOn: true,
                      maxLines: 2,
                      maxLength: 30,
                      validator: (String text){
                        if (_titleController.text.length >= 30){
                          return 'max length exceeded Bitch';
                        }
                        else if (_titleController.text.length < 5){
                          return 'Atleast put 5 Characters man';
                        }
                        else {
                          return null;
                        }
                      },
                      focusNode: _titleNode,
                      keyboardTextInputAction: TextInputAction.next,
                    ),

                    /// BODY
                    TextFieldBubble(
                      appBarType: AppBarType.basic,
                      titleVerse: Verse.plain('Note Body'),
                      isFormField: true,
                      textController: _bodyController,
                      textOnChanged: (String text) => onBodyChanged(
                        note: _noteNotifier,
                        text: text,
                      ),
                      counterIsOn: true,
                      maxLines: 7,
                      maxLength: 80,
                      keyboardTextInputType: TextInputType.multiline,
                      keyboardTextInputAction: TextInputAction.newline,
                      validator: (String text){
                        if (_bodyController.text.length >= 80){
                          return 'max length exceeded Bitch';
                        }
                        else if (_bodyController.text.length < 5){
                          return 'Add more than 5 Characters';
                        }
                        else {
                          return null;
                        }
                      },
                      focusNode: _bodyNode,
                    ),

                    Row(
                      children: <Widget>[

                        const SizedBox(width: 10, height: 10),

                        /// SENDER
                        TileBubble(
                          bubbleWidth: _halfBubbleWidth,
                          bubbleHeaderVM: const BubbleHeaderVM(
                            headlineVerse: Verse(
                              text: 'Sender',
                              translate: false,
                            ),
                            leadingIcon: Iconz.normalUser,
                            leadingIconSizeFactor: 0.5,
                            leadingIconBoxColor: Colorz.grey50,
                          ),
                          secondLineVerse: const Verse(
                            text: 'Select Note Sender',
                            translate: false,
                          ),
                          validator: () => _noteSenderValidator(note),
                          child: SizedBox(
                            width: _halfBubbleChildWidth,
                            child: Column(
                              children: <Widget>[

                                /// NOTE SENDER TYPES
                                SizedBox(
                                  width: _halfBubbleChildWidth,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[

                                      ...List.generate(NoteParties.noteSenderTypesList.length, (index){

                                        final NotePartyType _senderType = NoteParties.noteSenderTypesList[index];
                                        final bool _isSelected = note?.parties?.senderType == _senderType;
                                        final String _senderTypeString = NoteParties.cipherNoteSenderOrRecieverType(_senderType);

                                        return DreamBox(
                                          height: _halfBubbleChildWidth / NoteParties.noteSenderTypesList.length,
                                          width: _halfBubbleChildWidth / NoteParties.noteSenderTypesList.length,
                                          verse: Verse(
                                            text: _senderTypeString,
                                            translate: false,
                                            casing: Casing.upperCase,
                                          ),
                                          verseScaleFactor: 0.5,
                                          color: _isSelected == true ? Colorz.yellow255 : null,
                                          verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                                          verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                                          onTap: () => onSelectNoteSender(
                                            context: context,
                                            senderType: _senderType,
                                            note: _noteNotifier,
                                          ),
                                        );

                                      }),

                                    ],
                                  ),
                                ),

                                /// NOTE SENDER BUTTON
                                NoteSenderOrRecieverDynamicButton(
                                  width: TileBubble.childWidth(context: context),
                                  type: note?.parties?.senderType,
                                  id: note?.parties?.senderID,
                                ),

                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 10, height: 10),

                        /// RECEIVER
                        TileBubble(
                          bubbleWidth: _halfBubbleWidth,
                          bubbleHeaderVM: const BubbleHeaderVM(
                            headlineVerse: Verse(
                              text: 'Receiver',
                              translate: false,
                            ),
                            leadingIcon: Iconz.news,
                            leadingIconSizeFactor: 0.5,
                            leadingIconBoxColor: Colorz.grey50,
                          ),
                          secondLineVerse: const Verse(
                            text: 'Select who will receive this Note',
                            translate: false,
                          ),
                          validator: () => _noteRecieverValidator(note),
                          child: SizedBox(
                            width: _halfBubbleChildWidth,
                            child: Column(
                              children: <Widget>[

                                /// RECEIVERS TYPES BUTTONS
                                SizedBox(
                                  width: TileBubble.childWidth(context: context),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[

                                      ...List.generate(NoteParties.noteReceiverTypesList.length, (index){

                                        final NotePartyType _receiverType = NoteParties.noteReceiverTypesList[index];
                                        final bool _isSelected = note?.parties?.receiverType == _receiverType;

                                        blog('the fucking selected receiverType is ${note?.parties?.receiverType}');

                                        return DreamBox(
                                          height: 40,
                                          width: _noteButtonButtonWidth,
                                          verse: Verse(
                                            text: NoteParties.cipherNoteSenderOrRecieverType(_receiverType),
                                            translate: false,
                                            casing: Casing.upperCase,
                                          ),
                                          verseScaleFactor: 0.5,
                                          color: _isSelected == true ? Colorz.yellow255 : null,
                                          verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                                          verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                                          onTap: () async {
                                            await onSelectReceiverType(
                                              context: context,
                                              selectedReceiverType: _receiverType,
                                              noteNotifier: _noteNotifier,
                                              receiversIDs: _receiversIDs,
                                            );
                                          },
                                        );

                                      }),

                                    ],
                                  ),
                                ),

                                /// RECEIVERS LABELS
                                if (note?.parties?.receiverID != null)
                                  ValueListenableBuilder(
                                    valueListenable: _receiversIDs,
                                    builder: (_, List<String> receiversIDs, Widget child){

                                      /// RECEIVERS SELECTED
                                      if (Mapper.checkCanLoopList(receiversIDs) == true){

                                        return NoteSenderOrRecieverDynamicButtonsColumn(
                                          width: TileBubble.childWidth(context: context),
                                          type: note?.parties?.receiverType,
                                          ids: receiversIDs,
                                        );

                                      }

                                      /// NO RECEIVERS SELECTED
                                      else {
                                        return NoteSenderOrRecieverDynamicButton(
                                          width: TileBubble.childWidth(context: context),
                                          id: null,
                                          type: null,
                                        );
                                      }
                                    },
                                  ),

                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 10, height: 10),

                      ],
                    ),



                    /// FCM SWITCH
                    TileBubble(
                      bubbleHeaderVM: BubbleHeaderVM(
                        headlineVerse: const Verse(
                          text: 'Send FCM',
                          translate: false,
                        ),
                        leadingIcon: Iconz.news,
                        leadingIconSizeFactor: 0.5,
                        leadingIconBoxColor: Colorz.grey50,
                        switchValue: note?.sendFCM,
                        hasSwitch: true,
                        onSwitchTap: (bool val) => onSwitchSendFCM(
                          note: _noteNotifier,
                          value: val,
                        ),

                      ),
                      secondLineVerse: const Verse(
                        text: 'This sends firebase cloud message to the receiver or '
                            'to a group of receivers through a channel',
                        translate: false,
                      ),
                    ),

                    /// BUTTONS
                    TileBubble(
                      bubbleHeaderVM: const BubbleHeaderVM(
                        headlineVerse: Verse(
                          text: 'Buttons',
                          translate: false,
                        ),
                        leadingIcon: Iconz.pause,
                        leadingIconSizeFactor: 0.5,
                        leadingIconBoxColor: Colorz.grey50,
                      ),
                      secondLineVerse: const Verse(
                        text: 'Add buttons to the Note',
                        translate: false,
                      ),
                      validator: () => _noteButtonsValidator(note),
                      child: SizedBox(
                        width: _bubbleClearWidth,
                        child: Column(
                          children: <Widget>[

                            SizedBox(
                              width: TileBubble.childWidth(context: context),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  ...List.generate(PollModel.acceptDeclineButtons.length, (index){

                                    final String _phid = PollModel.acceptDeclineButtons[index];
                                    final bool _isSelected = Stringer.checkStringsContainString(
                                        strings: note?.poll?.buttons,
                                        string: _phid
                                    );

                                    return DreamBox(
                                      height: 40,
                                      width: _noteButtonButtonWidth,
                                      verse: Verse(
                                        text: _phid,
                                        translate: true,
                                        casing: Casing.upperCase,
                                      ),
                                      verseScaleFactor: 0.5,
                                      color: _isSelected == true ? Colorz.yellow255 : null,
                                      verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                                      verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                                      onTap: () => onAddNoteButton(
                                        note: _noteNotifier,
                                        button: _phid,
                                      ),
                                    );

                                  }),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    /// ATTACHMENTS
                    TileBubble(
                      bubbleHeaderVM: const BubbleHeaderVM(
                        headlineVerse: Verse(
                          text: 'Attachments',
                          translate: false,
                        ),
                        leadingIcon: Iconz.flyer,
                        leadingIconSizeFactor: 0.5,
                        leadingIconBoxColor: Colorz.grey50,

                      ),
                      secondLineVerse: const Verse(
                        text: 'Add attachments',
                        translate: false,
                      ),
                      child: SizedBox(
                        width: _bubbleClearWidth,
                        child: Column(
                          children: <Widget>[

                            /// ATTACHMENT TYPES
                            // SizedBox(
                            //   width: TileBubble.childWidth(context: context),
                            //   height: 50,
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //     children: <Widget>[
                            //
                            //       // ...List.generate(NoteModel.noteAttachmentTypesList.length, (index){
                            //       //
                            //       //   final NoteAttachmentType _attachmentType = NoteModel.noteAttachmentTypesList[index];
                            //       //   final bool _isSelected = note?.posterType == _attachmentType;
                            //       //   final String _attachmentTypeString = NoteModel.cipherNoteAttachmentType(_attachmentType);
                            //       //
                            //       //   return DreamBox(
                            //       //     height: 40,
                            //       //     width: Scale.getUniformRowItemWidth(
                            //       //       context: context,
                            //       //       numberOfItems: NoteModel.noteAttachmentTypesList.length,
                            //       //       boxWidth: TileBubble.childWidth(context: context),
                            //       //     ),
                            //       //     verse: Verse(
                            //       //       text: _attachmentTypeString,
                            //       //       translate: false,
                            //       //       casing: Casing.upperCase,
                            //       //     ),
                            //       //     verseScaleFactor: 0.5,
                            //       //     color: _isSelected == true ? Colorz.yellow255 : null,
                            //       //     verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                            //       //     verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                            //       //     onTap: () => onSelectPosterType(
                            //       //       context: context,
                            //       //       note: _noteNotifier,
                            //       //       posterType: _attachmentType,
                            //       //     ),
                            //       //   );
                            //       //
                            //       // }),
                            //
                            //     ],
                            //   ),
                            // ),

                            /// ATTACHMENT
                            NoteAttachment(
                              noteModel: note,
                              boxWidth: _bubbleClearWidth,
                              canOpenFlyer: false,
                            ),

                          ],
                        ),
                      ),
                    ),

                    /// HORIZON
                    const Horizon(heightFactor: 2),

                  ],
                ),
              ),

              /// CONFIRM BUTTON
              CornerWidgetMaximizer(
                minWidth: 150,
                maxWidth: _bubbleWidth * 0.8,
                childWidth: _bubbleWidth,
                topChild: SizedBox(
                  width: _bubbleWidth,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[

                      /// SENDING TO INFO
                      Container(
                        width: 260,
                        constraints: const BoxConstraints(
                          maxHeight: 300,

                        ),
                        decoration: BoxDecoration(
                          color: note?.parties?.receiverID == null ? Colorz.bloodTest : Colorz.white50,
                          borderRadius: Borderers.constantCornersAll10,
                        ),
                        padding: Scale.constantMarginsAll5,
                        margin: const EdgeInsets.only(top: 10),
                        child: ValueListenableBuilder(
                            valueListenable: _receiversIDs,
                            builder: (_, List<String> receiversIDs, Widget child){

                              return ListView(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                children: <Widget>[

                                  DreamBox(
                                    width: 250,
                                    height: 40,
                                    icon: note?.sendFCM == true ? Iconz.news : Iconz.star,
                                    iconSizeFactor: 0.5,
                                    verseScaleFactor: 0.9,
                                    verseItalic: true,
                                    // verseWeight: VerseWeight.thin,
                                    verse: Verse(
                                      text: '${note?.sendFCM == true ? 'with FCM' : 'without FCM'} to',
                                      translate: false,
                                      casing: Casing.upperCase,
                                    ),
                                    secondLine: Verse(
                                      text: '${receiversIDs.length} ${note?.parties?.receiverType == NotePartyType.bz ? 'bzz' : 'users'}',
                                      translate: false,
                                    ),
                                    color: note?.sendFCM == true ? Colorz.bloodTest : Colorz.blue125,
                                    bubble: false,
                                    verseCentered: false,
                                    margins: const EdgeInsets.only(bottom: 10),
                                  ),

                                  NoteSenderOrRecieverDynamicButtonsColumn(
                                    width: 250,
                                    type: note?.parties?.receiverType,
                                    ids: receiversIDs,
                                  ),

                                ],
                              );

                            }
                        ),
                      ),

                      const Expander(),

                      /// SEND BUTTON
                      ConfirmButton(
                        confirmButtonModel: ConfirmButtonModel(
                          firstLine: Verse.plain('Send'),
                          isDeactivated: !NoteModel.checkCanSendNote(note),
                          onTap: () => onSendNote(
                            context: context,
                            note: _noteNotifier,
                            formKey: _formKey,
                            titleController: _titleController,
                            bodyController: _bodyController,
                            scrollController: _scrollController,
                            receiversIDs: _receiversIDs,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                child: NoteCard(
                  bubbleWidth: _bubbleWidth,
                  bubbleColor: note?.sendFCM == true ? Colorz.bloodTest : Colorz.blue125,
                  noteModel: note,
                  isDraftNote: false,
                  onNoteOptionsTap: () => onNoteCreatorCardOptionsTap(
                    context: context,
                    note: _noteNotifier,
                    titleController: _titleController,
                    bodyController: _bodyController,
                    scrollController: _scrollController,
                    receiversIDs: _receiversIDs,
                  ),
                ),

              ),

            ],
          );

        },
      ),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
