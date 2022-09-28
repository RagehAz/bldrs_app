import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/corner_widget_maximizer.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/notes/note_attachment.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/sizing/super_positioned.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/note_sender_dynamic_button.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/testing_notes/a_notes_testing_screen.dart';
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
  final ValueNotifier<NoteModel> _note = ValueNotifier<NoteModel>(null);
  final ValueNotifier<NoteSenderType> _selectedSenderType = ValueNotifier<NoteSenderType>(NoteSenderType.bldrs);
  final ValueNotifier<dynamic> _selectedSenderModel = ValueNotifier<dynamic>(NoteModel.bldrsSenderModel);
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
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        initializeVariables(
          context: context,
          note: _note,
        );

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
    _note.dispose();
    _selectedSenderType.dispose();
    _selectedSenderModel.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    _scrollController.dispose();
    _titleNode.dispose();
    _bodyNode.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _noteButtonButtonWidth = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: NoteModel.noteButtonsList.length,
      boxWidth: TileBubble.childWidth(context: context),
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

        /// GO TO =>  NOTES TESTING LAB
        AppBarButton(
          // verse: Verse.plain('Templates'),
          icon: Iconz.lab,
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const NotesTestingScreen(),
          ),
        ),

      ],
      layoutWidget: Stack(
        children: <Widget>[

          /// CREATOR BUBBLES
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
                    note: _note,
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
                      return 'write something for fuck sake !';
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
                    note: _note,
                    text: text,
                  ),
                  counterIsOn: true,
                  maxLines: 7,
                  maxLength: 80,
                  keyboardTextInputType: TextInputType.multiline,
                  keyboardTextInputAction: TextInputAction.newline,
                  validator: (String text){
                    if (_titleController.text.length >= 80){
                      return 'max length exceeded Bitch';
                    }
                    else if (_titleController.text.length < 5){
                      return 'write something for fuck sake !';
                    }
                    else {
                      return null;
                    }
                  },
                  focusNode: _bodyNode,
                ),

                /// NOTE TYPE
                TileBubble(
                  bubbleHeaderVM: const BubbleHeaderVM(
                    headlineVerse: Verse(
                      text: 'Note Type',
                      translate: false,
                    ),
                    leadingIcon: Iconz.star,
                    leadingIconSizeFactor: 0.5,
                    leadingIconBoxColor: Colorz.grey50,

                  ),
                  secondLineVerse: const Verse(
                    text: 'Select Note Type',
                    translate: false,
                  ),
                  child: SizedBox(
                    width: Bubble.clearWidth(context),
                    child: Column(
                      children: <Widget>[

                        ValueListenableBuilder(
                          valueListenable: _note,
                          builder: (_, NoteModel noteModel, Widget child){

                            return SizedBox(
                              width: TileBubble.childWidth(context: context),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  ...List.generate(NoteModel.noteTypesList.length, (index){

                                    final NoteType _noteType = NoteModel.noteTypesList[index];
                                    final bool _isSelected = noteModel?.noteType == _noteType;
                                    final String _noteTypeString = NoteModel.cipherNoteType(_noteType);

                                    return DreamBox(
                                      height: 40,
                                      width: Scale.getUniformRowItemWidth(
                                        context: context,
                                        numberOfItems: NoteModel.noteTypesList.length,
                                        boxWidth: TileBubble.childWidth(context: context),
                                      ),
                                      verse: Verse(
                                        text: _noteTypeString,
                                        translate: false,
                                        casing: Casing.upperCase,
                                      ),
                                      verseScaleFactor: 0.5,
                                      color: _isSelected == true ? Colorz.yellow255 : null,
                                      verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                                      verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                                      onTap: () => onChangeNoteType(
                                        context: context,
                                        note: _note,
                                        noteType: _noteType,
                                        noteSenderType: _selectedSenderType,
                                        selectedSenderModel: _selectedSenderModel,
                                      ),
                                    );

                                  }),

                                ],
                              ),
                            );

                          },
                        ),

                      ],
                    ),
                  ),
                ),

                /// SENDER
                TileBubble(
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
                  child: SizedBox(
                    width: Bubble.clearWidth(context),
                    child: Column(
                      children: <Widget>[

                        /// NOTE SENDER TYPES
                        ValueListenableBuilder(
                          valueListenable: _selectedSenderType,
                          builder: (_, NoteSenderType selectedSenderType, Widget child){

                            return SizedBox(
                              width: TileBubble.childWidth(context: context),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  ...List.generate(NoteModel.noteSenderTypesList.length, (index){

                                    final NoteSenderType _senderType = NoteModel.noteSenderTypesList[index];
                                    final bool _isSelected = selectedSenderType == _senderType;
                                    final String _senderTypeString = NoteModel.cipherNoteSenderType(_senderType);

                                    return DreamBox(
                                      height: 40,
                                      width: Scale.getUniformRowItemWidth(
                                        context: context,
                                        numberOfItems: NoteModel.noteSenderTypesList.length,
                                        boxWidth: TileBubble.childWidth(context: context),
                                      ),
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
                                        selectedSenderType: _selectedSenderType,
                                        selectedSenderModel: _selectedSenderModel,
                                        note: _note,
                                      ),
                                    );

                                  }),

                                ],
                              ),
                            );

                          },
                        ),

                        /// NOTE SENDER BUTTON
                        ValueListenableBuilder(
                            valueListenable: _selectedSenderModel,
                            builder: (_, dynamic model, Widget child){

                              if (model == null){
                                return const SizedBox();
                              }

                              else {
                                return NoteSenderDynamicButton(
                                  model : model,
                                  width: TileBubble.childWidth(context: context),
                                );
                              }

                            }
                        ),

                      ],
                    ),
                  ),
                ),

                /// RECEIVER
                TileBubble(
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
                  child: SizedBox(
                    width: Bubble.clearWidth(context),
                    child: ValueListenableBuilder(
                      valueListenable: _note,
                      builder: (_, NoteModel noteModel, Widget child){

                        return Column(
                          children: <Widget>[

                            SizedBox(
                              width: TileBubble.childWidth(context: context),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  ...List.generate(NoteModel.noteReceiverTypesList.length, (index){

                                    final NoteReceiverType _receiverType = NoteModel.noteReceiverTypesList[index];
                                    final bool _isSelected = noteModel?.receiverType == _receiverType;

                                    return DreamBox(
                                      height: 40,
                                      width: _noteButtonButtonWidth,
                                      verse: Verse(
                                        text: NoteModel.cipherNoteReceiverType(_receiverType),
                                        translate: false,
                                        casing: Casing.upperCase,
                                      ),
                                      verseScaleFactor: 0.5,
                                      color: _isSelected == true ? Colorz.yellow255 : null,
                                      verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                                      verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                                      onTap: () => onSelectReceiverType(
                                        context: context,
                                        note: _note,
                                        receiverType: _receiverType,
                                      ),
                                    );

                                  }),

                                ],
                              ),
                            ),

                            if (noteModel?.receiverID != null)
                              FutureBuilder(
                                  future: noteModel.receiverType == NoteReceiverType.user ?
                                  UserProtocols.fetchUser(
                                    context: context,
                                    userID: noteModel.receiverID,
                                  )
                                      :
                                  BzProtocols.fetchBz(
                                      context: context,
                                      bzID: noteModel.receiverID
                                  ),
                                  builder: (_, AsyncSnapshot<Object> snap){

                                    return NoteSenderDynamicButton(
                                      width: TileBubble.childWidth(context: context),
                                      model : snap.data,
                                    );

                                  }
                              ),

                          ],
                        );

                      },
                    ),
                  ),
                ),

                /// FCM SWITCH
                ValueListenableBuilder(
                  valueListenable: _note,
                  builder: (_, NoteModel noteModel, Widget child){

                    return TileBubble(
                      bubbleHeaderVM: BubbleHeaderVM(
                        headlineVerse: const Verse(
                          text: 'Send FCM',
                          translate: false,
                        ),
                        leadingIcon: Iconz.news,
                        leadingIconSizeFactor: 0.5,
                        leadingIconBoxColor: Colorz.grey50,
                        switchValue: noteModel?.sendFCM,
                        hasSwitch: true,
                        onSwitchTap: (bool val) => onSwitchSendFCM(
                          note: _note,
                          value: val,
                        ),

                      ),
                      secondLineVerse: const Verse(
                        text: 'This sends firebase cloud message to the receiver or '
                            'to a group of receivers through a channel',
                        translate: false,
                      ),
                    );

                  },
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
                  child: SizedBox(
                    width: Bubble.clearWidth(context),
                    child: Column(
                      children: <Widget>[

                        ValueListenableBuilder(
                          valueListenable: _note,
                          builder: (_, NoteModel noteModel, Widget child){

                            return SizedBox(
                              width: TileBubble.childWidth(context: context),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  ...List.generate(NoteModel.noteButtonsList.length, (index){

                                    final String _phid = NoteModel.noteButtonsList[index];
                                    final bool _isSelected = Stringer.checkStringsContainString(
                                        strings: noteModel.buttons,
                                        string: _phid
                                    );

                                    return DreamBox(
                                      height: 40,
                                      width: _noteButtonButtonWidth,
                                      verse: Verse(
                                        text: _phid,
                                        translate: false,
                                        casing: Casing.upperCase,
                                      ),
                                      verseScaleFactor: 0.5,
                                      color: _isSelected == true ? Colorz.yellow255 : null,
                                      verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                                      verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                                      onTap: () => onAddNoteButton(
                                        note: _note,
                                        button: _phid,
                                      ),
                                    );

                                  }),

                                ],
                              ),
                            );

                          },
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
                    width: Bubble.clearWidth(context),
                    child: ValueListenableBuilder(
                      valueListenable: _note,
                      builder: (_, NoteModel note, Widget child){

                        return Column(
                          children: <Widget>[

                            /// ATTACHMENT TYPES
                            SizedBox(
                              width: TileBubble.childWidth(context: context),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  ...List.generate(NoteModel.noteAttachmentTypesList.length, (index){

                                    final NoteAttachmentType _attachmentType = NoteModel.noteAttachmentTypesList[index];
                                    final bool _isSelected = note.attachmentType == _attachmentType;
                                    final String _attachmentTypeString = NoteModel.cipherNoteAttachmentType(_attachmentType);

                                    return DreamBox(
                                      height: 40,
                                      width: Scale.getUniformRowItemWidth(
                                        context: context,
                                        numberOfItems: NoteModel.noteAttachmentTypesList.length,
                                        boxWidth: TileBubble.childWidth(context: context),
                                      ),
                                      verse: Verse(
                                        text: _attachmentTypeString,
                                        translate: false,
                                        casing: Casing.upperCase,
                                      ),
                                      verseScaleFactor: 0.5,
                                      color: _isSelected == true ? Colorz.yellow255 : null,
                                      verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                                      verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                                      onTap: () => onSelectAttachmentType(
                                        context: context,
                                        note: _note,
                                        attachmentType: _attachmentType,
                                      ),
                                    );

                                  }),

                                ],
                              ),
                            ),

                            /// ATTACHMENT
                            NoteAttachment(
                              noteModel: note,
                              boxWidth: Bubble.clearWidth(context),
                            ),


                          ],
                        );

                      },
                    ),
                  ),
                ),

                /// HORIZON
                const Horizon(),

              ],
            ),
          ),

          /// CONFIRM BUTTON
          ValueListenableBuilder(
              valueListenable: _note,
              builder: (_, NoteModel note, Widget child){

                final List<String> _missingNoteFields = NoteModel.getMissingNoteFields(
                  note: note,
                  considerAllFields: false,
                );

                final String _missingFieldsString = Stringer.generateStringFromStrings(
                  strings: _missingNoteFields,
                  stringsSeparator: ' - ',
                );

                return CornerWidgetMaximizer(
                  minWidth: 150,
                  maxWidth: PageBubble.width(context),
                  childWidth: PageBubble.width(context),
                  topChild: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[

                      /// MISSING FIELDS BOX
                      if (Mapper.checkCanLoopList(_missingNoteFields) == true)
                        Container(
                          width: 250,
                          height: 60,
                          alignment: Aligners.superTopAlignment(context),
                          child: SuperVerse(
                            verse: Verse(
                              text: 'Missing : $_missingFieldsString',
                              translate: false,
                            ),
                            color: Colorz.red255,
                            size: 2,
                            italic: true,
                            weight: VerseWeight.thin,
                            maxLines: 3,
                            centered: false,
                            labelColor: Colorz.white20,
                            onTap: () => note.blogNoteModel(),
                          ),
                        ),

                      /// CONFIRM BUTTON
                      FutureBuilder(
                          future:
                          note?.receiverType == NoteReceiverType.user ?
                          UserProtocols.fetchUser(
                            context: context,
                            userID: note.receiverID,
                          )
                              :
                          note?.receiverType == NoteReceiverType.bz ?
                          BzProtocols.fetchBz(
                            context: context,
                            bzID: note.receiverID,
                          )
                              :
                          null
                          ,
                          builder: (_, AsyncSnapshot<Object> snapshot){


                            String _receiverName;

                            if (note?.receiverType == NoteReceiverType.user){
                              final UserModel _user = snapshot.data;
                              _receiverName = _user?.name;
                            }
                            else if (note?.receiverType == NoteReceiverType.bz){
                              final BzModel _bz = snapshot.data;
                              _receiverName = _bz?.name;
                            }

                            return ConfirmButton(
                              confirmButtonModel: ConfirmButtonModel(
                                firstLine: Verse.plain('Send'),
                                secondLine: Verse.plain('to $_receiverName'),
                                isDeactivated: !NoteModel.checkCanSendNote(note),
                                onTap: () => onSendNote(
                                  context: context,
                                  note: _note,
                                  formKey: _formKey,
                                  titleController: _titleController,
                                  bodyController: _bodyController,
                                  receiverName: _receiverName,
                                  selectedSenderType: _selectedSenderType,
                                  selectedSenderModel: _selectedSenderModel,
                                  scrollController: _scrollController,
                                ),
                              ),
                            );

                          }
                      ),


                    ],
                  ),
                  child: ValueListenableBuilder(
                      valueListenable: _note,
                      builder: (_, NoteModel noteModel, Widget child){

                        return NoteCard(
                          bubbleWidth: PageBubble.width(context),
                          bubbleColor: Colorz.blue125,
                          noteModel: noteModel,
                          isDraftNote: true,
                          onNoteOptionsTap: () => onNoteCreatorCardOptionsTap(
                            context: context,
                            note: _note,
                            titleController: _titleController,
                            bodyController: _bodyController,
                            scrollController: _scrollController,
                            selectedSenderModel: _selectedSenderModel,
                            selectedSenderType: _selectedSenderType,
                          ),
                        );

                      }
                  ),

                );


              }
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
