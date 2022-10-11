import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/c_channel_model.dart';
import 'package:bldrs/a_models/e_notes/noot_event.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/a_parties_creator_bubble.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/b_note_title_creator_bubble.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/c_note_body_creator_bubble.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/d_poster_creator_bubble.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/e_note_progress_creator_bubble.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/f_note_buttons_creator_bubble.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/g_note_topic_selector_bubble.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/h_note_fcm_trigger_bubble.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/i_note_dismissible_trigger_bubble.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/j_note_channel_selector_bubble.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/k_note_trigger_creator.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/bubbles/x_note_preview_panel.dart';
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
  bool _isDismissible = true;
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
  @override
  Widget build(BuildContext context) {
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

              /// CREATOR BUBBLES
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
                    NoteTitleCreatorBubble(
                      noteNotifier: _noteNotifier,
                      titleController: _titleController,
                      bodyNode: _bodyNode,
                      titleNode: _titleNode,
                    ),

                    /// BODY
                    NoteBodyCreatorBubble(
                      bodyNode: _bodyNode,
                      noteNotifier: _noteNotifier,
                      bodyController: _bodyController,
                    ),

                    /// POSTER
                    PosterCreatorBubble(
                      note: note,
                      noteNotifier: _noteNotifier,
                    ),

                    /// PROGRESS
                    NoteProgressCreatorBubble(
                      note: note,
                      noteNotifier: _noteNotifier,
                      // progress: _progress,
                      // nootProgressIsLoading: _nootProgressIsLoading,
                      // onSwitch: (bool value){
                      //   if (value == true){
                      //
                      //     setState(() {
                      //       _progress = const Progress(
                      //         targetID: 'noot',
                      //         current: 0,
                      //         objective: 20,
                      //       );
                      //     });
                      //
                      //
                      //   }
                      //   else {
                      //
                      //     setState(() {
                      //       _progress = null;
                      //       _nootProgressIsLoading = false;
                      //     });
                      //
                      //   }
                      // },
                      // onTriggerLoading: (){
                      //   setState(() {
                      //     _nootProgressIsLoading = !_nootProgressIsLoading;
                      //   });
                      // },
                      // onIncrement: (){
                      //
                      //   if (_progress.current < _progress.objective){
                      //     setState(() {
                      //       _progress = _progress.copyWith(
                      //         current: _progress.current + 1,
                      //       );
                      //     });
                      //   }
                      //
                      // },
                      // onDecrement: (){
                      //
                      //   if (_progress.current > 0){
                      //     setState(() {
                      //       _progress = _progress.copyWith(
                      //         current: _progress.current - 1,
                      //       );
                      //     });
                      //   }
                      //
                      // },
                    ),

                    /// BUTTONS
                    NoteButtonsCreatorBubble(
                      noteNotifier: _noteNotifier,
                      note: note,
                    ),

                    /// TOPIC
                    NoteTopicSelectorBubble(
                        nootEvent: _nootEvent,
                        onSelectTopic: (NootEvent event){
                          setState(() {
                            _nootEvent = event;
                          });
                        }),

                    /// TRIGGER
                    const NoteTriggerCreator(),

                    /// FCM SWITCH
                    NoteFCMTriggerBubble(
                      note: note,
                      noteNotifier: _noteNotifier,
                    ),

                    /// CAN BE DISMISSED
                    NoteDismissibleTriggerBubble(
                      isDismissible: _isDismissible,
                      note: note,
                      onSwitch: (bool value){
                        setState(() {
                          _isDismissible = value;
                        });
                        },
                    ),

                    /// CHANNEL
                    NoteChannelSelectorBubble(
                      note: note,
                      channel: _channel,
                      onSelectChannel: (ChannelModel channelModel){
                        setState(() {
                          _channel = channelModel.channel;
                        });
                      },
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
