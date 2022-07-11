import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/notes/note_attachment.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/sizing/super_positioned.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/tile_bubble.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_separator_line.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/components/note_sender_dynamic_button.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/helper_screens/all_notes_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/notes_creator_controller.dart';
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
// -----------------------------------------------------------------------------
  final ValueNotifier<NoteModel> _note = ValueNotifier<NoteModel>(null);
  final ValueNotifier<NoteSenderType> _selectedSenderType = ValueNotifier<NoteSenderType>(NoteSenderType.bldrs);
  final ValueNotifier<dynamic> _selectedSenderModel = ValueNotifier<dynamic>(NoteModel.bldrsSenderModel);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'xxxxx',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading.dispose();
    _note.dispose();
    _selectedSenderType.dispose();
    _selectedSenderModel.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    _scrollController.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _noteSenderTypeButtonWidth = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: NoteModel.noteSenderTypesList.length,
      boxWidth: TileBubble.childWidth(context),
    );
    final double _noteTypeButtonWidth = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: NoteModel.noteTypesList.length,
      boxWidth: TileBubble.childWidth(context),
    );
    final double _noteButtonButtonWidth = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: NoteModel.noteButtonsList.length,
      boxWidth: TileBubble.childWidth(context),
    );
    final double _noteAttachmentTypeButtonWidth = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: NoteModel.noteAttachmentTypesList.length,
      boxWidth: TileBubble.childWidth(context),
    );

    return MainLayout(
      loading: _loading,
      pageTitle: 'Note Creator',
      sectionButtonIsOn: false,
      pyramidsAreOn: true,
      zoneButtonIsOn: false,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: 'All Notes',
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const AllNotesScreen(),
          ),
        ),

        AppBarButton(
          verse: 'Templates',
          onTap: () => onGoToNoteTemplatesScreen(
            context: context,
            scrollController: _scrollController,
            selectedSenderType: _selectedSenderType,
            selectedSenderModel: _selectedSenderModel,
            note: _note,
            bodyController: _bodyController,
            titleController: _titleController,
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

                /// TIME STAMP
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                  child: SuperVerse(
                    verse: Timers.generateString_on_dd_month_yyyy(
                        context: context,
                        time: DateTime.now()
                    ),
                    color: Colorz.grey255,
                    italic: true,
                    weight: VerseWeight.thin,
                    size: 1,
                    maxLines: 2,
                    centered: false,
                  ),
                ),

                /// LINE
                const SeparatorLine(),

                /// NOTE PREVIEW
                ValueListenableBuilder(
                    valueListenable: _note,
                    builder: (_, NoteModel noteModel, Widget child){

                      return NoteCard(
                        noteModel: noteModel,
                        isDraftNote: true,
                      );

                    }
                ),

                /// LINE
                const SeparatorLine(),

                /// TITLE
                TextFieldBubble(
                  title: 'Note Title',
                  isFormField: true,
                  textController: _titleController,
                  textOnChanged: (String text) => onTitleChanged(
                    note: _note,
                    text: text,
                  ),
                  counterIsOn: true,
                  maxLines: 2,
                  maxLength: 30,
                  validator: (){
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
                ),

                /// BODY
                TextFieldBubble(
                  title: 'Note Body',
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
                  validator: (){
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
                ),

                /// NOTE TYPE
                TileBubble(
                  verse: 'Note Type',
                  secondLine: 'Select Note Type',
                  icon: Iconz.star,
                  iconSizeFactor: 0.5,
                  iconBoxColor: Colorz.grey50,
                  child: SizedBox(
                    width: Bubble.clearWidth(context),
                    child: Column(
                      children: <Widget>[

                        ValueListenableBuilder(
                          valueListenable: _note,
                          builder: (_, NoteModel noteModel, Widget child){

                            return SizedBox(
                              width: TileBubble.childWidth(context),
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
                                      width: _noteTypeButtonWidth,
                                      verse: _noteTypeString.toUpperCase(),
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
                  verse: 'Sender',
                  secondLine: 'Select Note Sender',
                  icon: Iconz.normalUser,
                  iconSizeFactor: 0.5,
                  iconBoxColor: Colorz.grey50,
                  child: SizedBox(
                    width: Bubble.clearWidth(context),
                    child: Column(
                      children: <Widget>[

                        /// NOTE SENDER TYPES
                        ValueListenableBuilder(
                            valueListenable: _selectedSenderType,
                            builder: (_, NoteSenderType selectedSenderType, Widget child){

                              return SizedBox(
                                width: TileBubble.childWidth(context),
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
                                        width: _noteSenderTypeButtonWidth,
                                        verse: _senderTypeString.toUpperCase(),
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
                                  width: TileBubble.childWidth(context),
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
                  verse: 'Receiver',
                  secondLine: 'Select who will receive this Note',
                  icon: Iconz.news,
                  iconSizeFactor: 0.5,
                  iconBoxColor: Colorz.grey50,
                  child: SizedBox(
                    width: Bubble.clearWidth(context),
                    child: ValueListenableBuilder(
                      valueListenable: _note,
                      builder: (_, NoteModel noteModel, Widget child){

                        return Column(
                          children: <Widget>[

                            SizedBox(
                              width: TileBubble.childWidth(context),
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
                                      verse: NoteModel.cipherNoteReceiverType(_receiverType).toUpperCase(),
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
                                  UsersProvider.proFetchUserModel(
                                    context: context,
                                    userID: noteModel.receiverID,
                                  )
                                      :
                                  BzzProvider.proFetchBzModel(
                                      context: context,
                                      bzID: noteModel.receiverID
                                  ),
                                  builder: (_, AsyncSnapshot<Object> snap){

                                    return NoteSenderDynamicButton(
                                      model : snap.data,
                                      width: TileBubble.childWidth(context),
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
                        verse: 'Send FCM',
                        secondLine: 'This sends firebase cloud message to the receiver or '
                            'to a group of receivers through a channel',
                        icon: Iconz.news,
                        iconSizeFactor: 0.5,
                        iconBoxColor: Colorz.grey50,
                        switchIsOn: noteModel.sendFCM,
                        switching: (bool val) => onSwitchSendFCM(
                          note: _note,
                          value: val,
                        ),
                      );

                    },
                ),

                /// BUTTONS
                TileBubble(
                  verse: 'Buttons',
                  secondLine: 'Add buttons to the Note',
                  icon: Iconz.pause,
                  iconSizeFactor: 0.5,
                  iconBoxColor: Colorz.grey50,
                  child: SizedBox(
                    width: Bubble.clearWidth(context),
                    child: Column(
                      children: <Widget>[

                        ValueListenableBuilder(
                          valueListenable: _note,
                          builder: (_, NoteModel noteModel, Widget child){

                            return SizedBox(
                              width: TileBubble.childWidth(context),
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[

                                  ...List.generate(NoteModel.noteButtonsList.length, (index){

                                    final String _phid = NoteModel.noteButtonsList[index];
                                    final bool _isSelected = Mapper.checkStringsContainString(
                                        strings: noteModel.buttons,
                                        string: _phid
                                    );

                                    return DreamBox(
                                      height: 40,
                                      width: _noteButtonButtonWidth,
                                      verse: _phid.toUpperCase(),
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
                  verse: 'Attachments',
                  secondLine: 'Add attachments',
                  icon: Iconz.flyer,
                  iconSizeFactor: 0.5,
                  iconBoxColor: Colorz.grey50,
                  child: SizedBox(
                    width: Bubble.clearWidth(context),
                    child: ValueListenableBuilder(
                      valueListenable: _note,
                      builder: (_, NoteModel note, Widget child){

                        return Column(
                          children: <Widget>[

                            /// ATTACHMENT TYPES
                            SizedBox(
                              width: TileBubble.childWidth(context),
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
                                      width: _noteAttachmentTypeButtonWidth,
                                      verse: _attachmentTypeString.toUpperCase(),
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
          SuperPositioned(
            enAlignment: Alignment.bottomLeft,
            child: ValueListenableBuilder(
                valueListenable: _note,
                builder: (_, NoteModel note, Widget child){

                  final List<String> _missingNoteFields = NoteModel.getMissingNoteFields(
                    note: note,
                    considerAllFields: false,
                  );

                  final String _missingFieldsString = TextGen.generateStringFromStrings(
                    strings: _missingNoteFields,
                    stringsSeparator: ' - ',
                  );

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[

                      /// CONFIRM BUTTON
                      FutureBuilder(
                          future:
                          note?.receiverType == NoteReceiverType.user ?
                          UsersProvider.proFetchUserModel(
                            context: context,
                            userID: note.receiverID,
                          )
                              :
                          note?.receiverType == NoteReceiverType.bz ?
                          BzzProvider.proFetchBzModel(
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

                          return EditorConfirmButton(
                            firstLine: 'Send',
                            secondLine: 'to $_receiverName',
                            positionedAlignment: null,
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
                          );

                          }
                      ),

                      /// MISSING FIELDS BOX
                      if (Mapper.checkCanLoopList(_missingNoteFields) == true)
                        Container(
                          width: 220,
                          height: 50,
                          alignment: Aligners.superTopAlignment(context),
                          child: SuperVerse(
                            verse: 'Missing Fields :-\n$_missingFieldsString',
                            color: Colorz.red255,
                            size: 1,
                            italic: true,
                            weight: VerseWeight.thin,
                            maxLines: 3,
                            centered: false,
                            labelColor: Colorz.black255,
                            onTap: () => note.blogNoteModel(),
                          ),
                        ),

                    ],
                  );

                }
            ),
          ),


        ],
      ),
    );
  }

}
