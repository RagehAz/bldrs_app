// ignore_for_file: avoid_bool_literals_in_conditional_expressions
import 'package:bldrs/a_models/b_bz/target/target_progress.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/a_models/e_notes/noot_event.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/notes/banner/note_attachment.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_progress_bar.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/note_parties_bubbles.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/note_preview_panel.dart';
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
  Progress _progress;
  bool _nootProgressIsLoading = false;
  bool _canBeDismissedWithoutTapping = true;
  Channel _channel = Channel.bulletin;

  NootEvent _nootEvent;
  // --------------------
  final ValueNotifier<NoteModel> _noteNotifier = ValueNotifier<NoteModel>(null);
  final ValueNotifier<List<dynamic>> _receiversModels = ValueNotifier<List<dynamic>>([]);
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
    _receiversModels.dispose();
    super.dispose();
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
    final double _bubbleChildWidth = TileBubble.childWidth(
      context: context,
      bubbleWidthOverride: _bubbleWidth,
    );
    // --------------------
    return MainLayout(
      loading: _loading,
      pageTitleVerse: Verse.plain('Note ${Timers.generateString_on_dd_month_yyyy(
          context: context,
          time: DateTime.now()
      )}'),
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      onBack: () async {

        await Dialogs.goBackDialog(
          context: context,
          goBackOnConfirm: true,
        );

      },
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

                    /// PARTIES
                    NotePartiesBubbles(
                      note: note,
                      receiversModels: _receiversModels,
                      noteNotifier: _noteNotifier,
                    ),

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
                        else if (_titleController.text.isEmpty == true){
                          return 'Atleast put 1 Character man';
                        }
                        else {
                          return null;
                        }
                      },
                      focusNode: _titleNode,
                      keyboardTextInputAction: TextInputAction.next,
                      onSubmitted: (String text){
                        Formers.focusOnNode(_bodyNode);
                      },
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
                        else if (_bodyController.text.isEmpty){
                          return 'Add more than 1 Character';
                        }
                        else {
                          return null;
                        }
                      },
                      focusNode: _bodyNode,
                    ),

                    /// POSTER
                    WidgetFader(
                      fadeType: _progress == null ? FadeType.stillAtMax : FadeType.stillAtMin,
                      min: 0.2,
                      absorbPointer: _progress != null,
                      child: TileBubble(
                        bubbleHeaderVM: const BubbleHeaderVM(
                          headlineVerse: Verse(
                            text: 'Poster',
                            translate: false,
                          ),
                          leadingIcon: Iconz.phoneGallery,
                          leadingIconSizeFactor: 0.5,
                          leadingIconBoxColor: Colorz.grey50,

                        ),
                        child: SizedBox(
                          width: _bubbleClearWidth,
                          child: Column(
                            children: <Widget>[

                              /// POSTER TYPES
                              SizedBox(
                                width: TileBubble.childWidth(context: context),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[

                                    ...List.generate(PosterModel.posterTypes.length, (index){

                                      final PosterType _posterType = PosterModel.posterTypes[index];
                                      final bool _isSelected = note?.poster?.type == _posterType;
                                      final String _attachmentTypeString = PosterModel.cipherPosterType(_posterType);

                                      return DreamBox(
                                        height: 40,
                                        width: Scale.getUniformRowItemWidth(
                                          context: context,
                                          numberOfItems: PosterModel.posterTypes.length,
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
                                        onTap: () => onSelectPosterType(
                                          context: context,
                                          note: _noteNotifier,
                                          posterType: _posterType,
                                        ),
                                      );

                                    }),

                                  ],
                                ),
                              ),

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
                    ),

                    /// PROGRESS
                    TileBubble(
                      bubbleHeaderVM: BubbleHeaderVM(
                        leadingIcon: Iconz.reload,
                        leadingIconSizeFactor: 0.5,
                        leadingIconBoxColor: _progress != null ? Colorz.green255 : Colorz.grey50,
                        headlineVerse: Verse.plain(
                            _progress == null ? 'Progress'
                                :
                            'Progress : ( ${((_progress.current / _progress.objective) * 100).toInt()} % )'
                        ),
                        hasSwitch: true,
                        switchValue: _progress != null,
                        onSwitchTap: (bool value){

                          if (value == true){

                            setState(() {
                              _progress = const Progress(
                                targetID: 'noot',
                                current: 0,
                                objective: 20,
                              );
                            });


                          }
                          else {

                            setState(() {
                              _progress = null;
                              _nootProgressIsLoading = false;
                            });

                          }

                        },
                      ),
                      child: Column(
                        children: <Widget>[

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[

                              /// LOADING
                              DreamBox(
                                height: 35,
                                isDeactivated: _progress == null,
                                icon: Iconz.reload,
                                iconColor: Colorz.white200,
                                iconSizeFactor: 0.4,
                                onTap: (){

                                  setState(() {
                                    _nootProgressIsLoading = !_nootProgressIsLoading;
                                  });

                                },
                              ),

                              const SizedBox(
                                width: 5,
                                height: 5,
                              ),

                              /// MINUS
                              DreamBox(
                                height: 35,
                                isDeactivated: _nootProgressIsLoading == true || _progress == null,
                                icon: Iconz.arrowLeft,
                                iconColor: Colorz.white200,
                                iconSizeFactor: 0.4,
                                onTap: (){

                                  if (_progress.current > 0){
                                    setState(() {
                                      _progress = _progress.copyWith(
                                        current: _progress.current - 1,
                                      );
                                    });
                                  }

                                },
                              ),

                              const SizedBox(
                                width: 5,
                                height: 5,
                              ),

                              /// PLUS
                              DreamBox(
                                height: 35,
                                icon: Iconz.arrowRight,
                                isDeactivated: _nootProgressIsLoading == true || _progress == null,
                                iconColor: Colorz.white200,
                                iconSizeFactor: 0.4,
                                onTap: (){

                                  if (_progress.current < _progress.objective){
                                    setState(() {
                                      _progress = _progress.copyWith(
                                        current: _progress.current + 1,
                                      );
                                    });
                                  }

                                },
                              ),

                              const SizedBox(
                                width: 20,
                                height: 20,
                              ),

                            ],
                          ),

                          StaticProgressBar(
                            numberOfSlides: _progress == null ? 1 : _progress.objective,
                            index: _progress == null ? 0 : _progress.current - 1,
                            opacity: _progress == null ? 0.2 : 1,
                            flyerBoxWidth: _bubbleChildWidth,
                            swipeDirection: SwipeDirection.freeze,
                            loading: _nootProgressIsLoading,
                            stripThicknessFactor: 2,
                            margins: const EdgeInsets.only(top: 10),
                          ),

                        ],
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
                      // secondLineVerse: const Verse(
                      //   text: 'Add buttons to the Note',
                      //   translate: false,
                      // ),
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

                    /// TOPIC
                    ExpandingTile(
                      width: _bubbleWidth,
                      firstHeadline: Verse.plain('Topic'),
                      secondHeadline: Verse.plain(_nootEvent?.id),
                      icon: Iconz.keywords,
                      iconSizeFactor: 0.4,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          ...List<Widget>.generate(NootEvent.allEvent.length, (int index) {

                            final NootEvent _event = NootEvent.allEvent[index];
                            final bool _isSelected = _nootEvent?.id == _event.id;

                            return DreamBox(
                              height: 40,
                              margins: const EdgeInsets.only(bottom: 3, left: 10),
                              verse: Verse.plain(_event.id),
                              secondLine: Verse.plain(_event.description),
                              verseScaleFactor: 0.6,
                              verseCentered: false,
                              bubble: false,
                              color: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
                              verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                              secondLineColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                              onTap: (){
                                setState(() {
                                  _nootEvent = _event;
                                });
                              },
                            );

                          }),

                        ],
                      ),
                    ),


                    /// TRIGGER
                    const SizedBox(),

                    /// FCM SWITCH
                    TileBubble(
                      bubbleHeaderVM: BubbleHeaderVM(
                        headlineVerse: const Verse(
                          text: 'Send FCM',
                          translate: false,
                        ),
                        leadingIcon: Iconz.news,
                        leadingIconSizeFactor: 0.5,
                        leadingIconBoxColor: note.sendFCM == true ? Colorz.green255 : Colorz.grey50,
                        switchValue: note?.sendFCM,
                        hasSwitch: true,
                        onSwitchTap: (bool val) => onSwitchSendFCM(
                          note: _noteNotifier,
                          value: val,
                        ),

                      ),
                      // secondLineVerse: const Verse(
                      //   text: 'This sends firebase cloud message to the receiver or '
                      //       'to a group of receivers through a channel',
                      //   translate: false,
                      // ),
                    ),

                    /// CAN BE DISMISSED
                    WidgetFader(
                      fadeType: note.sendFCM == true ? FadeType.stillAtMax : FadeType.stillAtMin,
                      min: 0.2,
                      absorbPointer: !note.sendFCM,
                      child: TileBubble(
                        bubbleHeaderVM: BubbleHeaderVM(
                          headlineVerse: Verse.plain('Notification is Dismissible'),
                          leadingIcon: Iconz.fingerTap,
                          leadingIconSizeFactor: 0.5,
                          leadingIconBoxColor: _canBeDismissedWithoutTapping == true ? Colorz.green255 : Colorz.grey50,
                          hasSwitch: true,
                          switchValue: note.sendFCM == true ? _canBeDismissedWithoutTapping : false,
                          onSwitchTap: (bool value){
                            setState(() {
                              _canBeDismissedWithoutTapping = value;
                            });
                          },
                        ),
                      ),
                    ),

                    /// CHANNEL
                    WidgetFader(
                      fadeType: note.sendFCM == true ? FadeType.stillAtMax : FadeType.stillAtMin,
                      min: 0.2,
                      absorbPointer: !note.sendFCM,
                      child: ExpandingTile(
                        width: _bubbleWidth,
                        isDisabled: !note.sendFCM,
                        firstHeadline: Verse.plain('Channel'),
                        secondHeadline: Verse.plain(_channel.name),
                        icon: Iconz.advertise,
                        iconSizeFactor: 0.4,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            ...List<Widget>.generate(ChannelModel.bldrsChannels.length, (int index) {

                              final ChannelModel _channelModel = ChannelModel.bldrsChannels[index];
                              final bool _isSelected = _channelModel.channel == _channel;

                              return DreamBox(
                                height: 40,
                                margins: const EdgeInsets.only(bottom: 3, left: 10),
                                verse: Verse.plain(_channelModel.name),
                                secondLine: Verse.plain(_channelModel.description),
                                verseScaleFactor: 0.6,
                                verseCentered: false,
                                bubble: false,
                                color: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
                                verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                                secondLineColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                                onTap: (){
                                  setState(() {
                                    _channel = _channelModel.channel;
                                  });
                                },
                              );

                            }),

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
              NotePreviewPanel(
                noteNotifier: _noteNotifier,
                receiversModels: _receiversModels,
                note: note,
                bodyController: _bodyController,
                formKey: _formKey,
                scrollController: _scrollController,
                titleController: _titleController,
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
