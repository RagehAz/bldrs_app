import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/b_bz/target/target_progress.dart';
import 'package:bldrs/a_models/e_notes/channels.dart';
import 'package:bldrs/a_models/e_notes/note_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/d_user_search_screen/search_users_screen.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/b_expanding_tile.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_progress_bar.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class AwesomeNotiTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AwesomeNotiTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _AwesomeNotiTestScreenState createState() => _AwesomeNotiTestScreenState();
  /// --------------------------------------------------------------------------
}

class _AwesomeNotiTestScreenState extends State<AwesomeNotiTestScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey();
  // --------------------
  /// JUST TO ACTIVATE VALIDATORS
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  // --------------------
  bool isGlobal = true;
  bool _isNotificationAllowed = false;
  File _largeImageFile;
  String _largeIconURL;
  final List<String> _buttons = <String>[];
  Progress _progress = const Progress(
    targetID: 'noot',
    current: 0,
    objective: 20,
  );
  Channel _channel = Channel.bulletin;
  bool _nootProgressIsLoading = false;
  String _bannerURL;
  bool _canBeDismissedWithoutTapping = true;
  // --------------------
  StreamSubscription _streamSubscription;
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
      blogLoading(loading: _loading.value, callerName: 'StaticLogoScreen',);
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
    super.didChangeDependencies();
    if (_isInit) {
      // ---------
      _triggerLoading(setTo: true).then((_) async {

        await _checkAndUpdateIsNotificationAllowed();

        await _triggerLoading(setTo: false);
      });
      // ---------
      _isInit = false;
    }
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();

    _titleController.dispose();
    _bodyController.dispose();

    // _awesomeNotification.actionSink.close();
    // _awesomeNotification.createdSink.close();
    // _awesomeNotification.dispose();

    _streamSubscription?.cancel();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _checkAndUpdateIsNotificationAllowed() async {

    final bool _isAllowed = await FCM.checkIsNootAllowed();

    setState(() {
      _isNotificationAllowed = _isAllowed;
    });

  }
  // --------------------
  Future<void> _requestNotificationPermission() async {

    if (_isNotificationAllowed == false){

      final bool _result = await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: Verse.plain('Allow notifications ?'),
        bodyVerse: Verse.plain('To be able show Global & Local notifications'),
        boolDialog: true,
      );

      if (_result == true) {
        await FCM.requestAwesomePermission();
        await _checkAndUpdateIsNotificationAllowed();
      }

    }

  }
  // --------------------
  Future<void> _pushNotification() async {

    final bool _continue = Formers.validateForm(_formKey);

    blog('_pushNotification :" _continue : $_continue');

    if (_continue == true){

      /// PUSH GLOBAL NOTIFICATION
      if (isGlobal == true){
        await FCM.pushGlobalNoot(
          title: _titleController.text,
          body: _bodyController.text,
          largeIconURL: _largeIconURL,
          bannerURL: _bannerURL,
          buttonsTexts: _buttons.isEmpty == true ? null : xPhrases(context, _buttons),
          channel: _channel,
          progress: _progress,
          progressBarIsLoading: _nootProgressIsLoading ?? false,
          canBeDismissedWithoutTapping: _canBeDismissedWithoutTapping,

          payloadMap: {
            'fuck': 'you',
            'whore': 'payloadMapaho',
          },
        );
      }

      /// PUSH LOCAL NOTIFICATION
      else {
        await FCM.pushLocalNoot(
          title: _titleController.text,
          body: _bodyController.text,
          largeIconFile: _largeImageFile,
          canBeDismissedWithoutTapping: _canBeDismissedWithoutTapping,
          channel: _channel,
          progress: _progress,
          progressBarIsLoading: _nootProgressIsLoading,

          payloadString: 'fucking payload',
          // subText: '...',
          // showStopWatch: false,
          // showTime: true,
        );
      }

    }

  }
  // --------------------
  /*
  Future<void> _listenToNotificationsStream(BuildContext context) async {

    blog('_listenToNotificationsStream --------- START');

    final bool _notificationsAllowed = await isNotificationAllowed();

    if (_notificationsAllowed != null) {

      _streamSubscription = _awesomeNotification.createdStream.listen((ReceivedNotification notification) async {

        blog('the FUCKING notification is aho 5ara :  Channel : ${notification.channelKey} : id : ${notification.id}');

        await TopDialog.showTopDialog(
          context: context,
          firstVerse: Verse.plain('Notification created'),
          secondVerse: Verse.plain('sent on Channel : ${notification.channelKey} : id : ${notification.id}'),
        );

      });

      _awesomeNotification.actionStream.listen((ReceivedAction notification) async {

        final bool _isBasicChannel = notification.channelKey == FCM.getNotificationChannelName(FCMChannel.basic);

        final bool _isIOS = DeviceChecker.deviceIsIOS();

        if (_isBasicChannel && _isIOS) {
          final int _x = await _awesomeNotification.getGlobalBadgeCounter();
          await _awesomeNotification.setGlobalBadgeCounter(_x - 1);
        }

        await Nav.pushAndRemoveUntil(
          context: context,
          screen: const NoteRouteToScreen(

          ),
        );

      });
    }

    blog('_listenToNotificationsStream --------- END');
  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _clearWidth = Bubble.clearWidth(context);

    final bool _bannerIsOn = isGlobal == true && _progress == null;
    final String _notificationTypeString = isGlobal == true ? 'Global' : 'Local';

    return MainLayout(
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      pageTitleVerse: Verse.plain('Awesome notification test'),
      loading: _loading,
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// NOTIFICATIONS ALLOWED - PERMISSION REQUEST
        AppBarButton(
          icon: Iconz.news,
          verseColor: _isNotificationAllowed == true ? Colorz.white255 : Colorz.white50,
          buttonColor: _isNotificationAllowed == true ? Colorz.green255 : Colorz.white10,
          // verse: Verse.plain(_isNotificationAllowed == true ? 'Allowed' : 'Not Allowed'),
          onTap: _requestNotificationPermission,
        ),

      ],
      layoutWidget: ListView(
        padding: Stratosphere.stratosphereSandwich,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          /// NOTIFICATION MAKER
          Form(
            key: _formKey,
            onChanged: (){
              blog('something changed in this form');
            },
            child: Bubble(
              headerViewModel: BubbleHeaderVM(
                headlineVerse: Verse.plain('Send $_notificationTypeString Notification'),
              ),
              columnChildren: <Widget>[

                /// GLOBAL - LOCAL SWITCH
                TileBubble(
                  bubbleWidth: _clearWidth,
                  bubbleHeaderVM: BubbleHeaderVM(
                      headlineVerse: Verse.plain('is $_notificationTypeString'),
                      hasSwitch: true,
                      switchValue: isGlobal,
                      onSwitchTap: (bool value){
                        setState(() {
                          isGlobal = value;
                        });
                      }
                  ),
                ),

                /// CHANNEL
                ExpandingTile(
                  firstHeadline: Verse.plain('Channel'),
                  secondHeadline: Verse.plain(_channel.name),
                  width: Bubble.clearWidth(context),
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

                /// TITLE
                TextFieldBubble(
                  bubbleWidth: _clearWidth,
                  appBarType: AppBarType.basic,
                  titleVerse: Verse.plain('Title'),
                  isFormField: true,
                  textController: _titleController,
                  counterIsOn: true,
                  maxLines: 2,
                  maxLength: 30,
                  validator: (String text){
                    final int _length = text?.length ?? 0;
                    if (_length >= 30){
                      return 'max length exceeded Bitch';
                    }
                    else if (_length < 5){
                      return 'Atleast put 5 Characters man';
                    }
                    else {
                      return null;
                    }
                  },
                  // focusNode: _titleNode,
                  keyboardTextInputAction: TextInputAction.next,
                ),

                /// BODY
                TextFieldBubble(
                  bubbleWidth: _clearWidth,
                  appBarType: AppBarType.basic,
                  titleVerse: Verse.plain('Body'),
                  isFormField: true,
                  textController: _bodyController,
                  counterIsOn: true,
                  maxLines: 7,
                  maxLength: 80,
                  // keyboardTextInputType: TextInputType.text,
                  keyboardTextInputAction: TextInputAction.send,
                  validator: (String text){
                    final int _length = text?.length ?? 0;
                    if (_length >= 80){
                      return 'max length exceeded Bitch';
                    }
                    else if (_length < 5){
                      return 'Add more than 5 Characters';
                    }
                    else {
                      return null;
                    }
                  },
                  onSubmitted: (String text) => _pushNotification(),
                ),

                /// BIG ICON
                TileBubble(
                  bubbleWidth: Bubble.clearWidth(context),
                  bubbleHeaderVM: BubbleHeaderVM(
                    headerWidth: Bubble.clearWidth(context) - 20,
                    leadingIcon: Iconz.balloonCircle,
                    headlineVerse: Verse.plain('LargeIcon'),
                  ),
                  child: Row(
                    children: <Widget>[

                      /// CLEAR
                      DreamBox(
                        width: 50,
                        height: 50,
                        icon: Iconz.xLarge,
                        iconSizeFactor: 0.4,
                        onTap: (){
                          setState(() {
                            _largeImageFile = null;
                            _largeIconURL = null;
                          });
                        },
                      ),

                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),

                      /// URL
                      DreamBox(
                        height: 50,
                        isDeactivated: !isGlobal,
                        icon: _largeIconURL ?? Iconz.comWebsite,
                        iconSizeFactor: 0.5,
                        verse: Verse.plain('URL'),
                        onTap: () async {

                          final UserModel _user = await SearchUsersScreen.selectUser(context);

                          if (_user != null){

                            final File _file = await Filers.getFileFromURL(_user.pic);

                            if (_file == null){
                              await Dialogs.errorDialog(
                                context: context,
                                titleVerse: Verse.plain('Something is wrong with this image'),
                                bodyVerse: Verse.plain('Maybe check another picture !'),
                              );
                            }
                            else {
                              setState(() {
                                _largeIconURL = _user.pic;
                              });
                            }

                          }

                        },
                      ),

                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),

                      /// GALLERY
                      DreamBox(
                        height: 50,
                        isDeactivated: isGlobal,
                        icon: isGlobal == true ? (_largeImageFile ?? Iconz.phoneGallery) : Iconz.phoneGallery,
                        iconSizeFactor: 0.5,
                        verse: Verse.plain('FILE'),
                        onTap: () async {

                          final FileModel _pickedFileModel = await Imagers.pickAndCropSingleImage(
                            context: context,
                            cropAfterPick: true,
                            isFlyerRatio: false,
                          );

                          if (_pickedFileModel != null){
                            setState(() {
                              _largeImageFile = _pickedFileModel.file;
                            });
                          }

                        },
                      ),


                    ],
                  ),
                ),

                /// BANNER URL
                WidgetFader(
                  fadeType: _bannerIsOn == true ? FadeType.stillAtMax : FadeType.stillAtMin,
                  min: 0.35,
                  absorbPointer: !_bannerIsOn,
                  child: TileBubble(
                    bubbleWidth: Bubble.clearWidth(context),
                    bubbleHeaderVM: BubbleHeaderVM(
                      headerWidth: Bubble.clearWidth(context) - 20,
                      leadingIcon: Iconz.phoneGallery,
                      headlineVerse: Verse.plain('Banner'),
                    ),
                    child: Row(
                      children: <Widget>[

                        /// CLEAR
                        DreamBox(
                          width: 50,
                          height: 50,
                          icon: Iconz.xLarge,
                          iconSizeFactor: 0.4,
                          onTap: (){
                            setState(() {
                              _bannerURL = null;
                            });
                          },
                        ),

                        const SizedBox(
                          height: 10,
                          width: 10,
                        ),

                        /// URL
                        DreamBox(
                          height: 50,
                          isDeactivated: !_bannerIsOn,
                          icon: _bannerURL ?? Iconz.comWebsite,
                          iconSizeFactor: 0.5,
                          verse: Verse.plain('URL'),
                          onTap: () async {

                            final List<FlyerModel> _selectedFlyers = await Nav.goToNewScreen(
                              context: context,
                              screen: const SavedFlyersScreen(
                                selectionMode: true,
                              ),
                            );

                            if (Mapper.checkCanLoopList(_selectedFlyers) == true){

                              setState(() {
                                _bannerURL = _selectedFlyers.first.slides[0].pic;
                              });

                            }

                          },
                        ),

                      ],
                    ),
                  ),
                ),

                /// PROGRESS
                TileBubble(
                  bubbleWidth: Bubble.clearWidth(context),
                  bubbleHeaderVM: BubbleHeaderVM(
                    headerWidth: Bubble.clearWidth(context) - 20,
                    leadingIcon: Iconz.phoneGallery,
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
                        flyerBoxWidth: _clearWidth - 50,
                        swipeDirection: SwipeDirection.freeze,
                        loading: _nootProgressIsLoading,
                        stripThicknessFactor: 2,
                        margins: const EdgeInsets.only(top: 10),
                      ),

                    ],
                  ),
                ),

                /// BUTTONS
                WidgetFader(
                  fadeType: isGlobal == true ? FadeType.stillAtMax : FadeType.stillAtMin,
                  min: 0.35,
                  absorbPointer: !isGlobal,
                  child: TileBubble(
                    bubbleWidth: Bubble.clearWidth(context),
                    bubbleHeaderVM: const BubbleHeaderVM(
                      headlineVerse: Verse(
                        text: 'Buttons',
                        translate: false,
                      ),
                      leadingIcon: Iconz.pause,
                      leadingIconSizeFactor: 0.5,
                      leadingIconBoxColor: Colorz.grey50,
                    ),
                    secondLineVerse: Verse(
                      text: _buttons.isEmpty == true ? ' '
                          :
                      Stringer.generateStringFromStrings(strings: xPhrases(context, _buttons)),
                      translate: false,
                    ),
                    child: Column(
                      children: <Widget>[

                        SizedBox(
                          width: _clearWidth - 20,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[

                              ...List.generate(NoteModel.noteButtonsList.length, (index){

                                final String _phid = NoteModel.noteButtonsList[index];

                                bool _isSelected = false;
                                if (isGlobal == true){
                                  _isSelected = Stringer.checkStringsContainString(
                                      strings: _buttons,
                                      string: _phid
                                  );
                                }

                                return DreamBox(
                                  height: 40,
                                  width: 100,
                                  verse: Verse(
                                    text: _phid,
                                    translate: true,
                                    casing: Casing.upperCase,
                                  ),
                                  verseScaleFactor: 0.5,
                                  color: _isSelected == true ? Colorz.yellow255 : null,
                                  verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                                  verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                                  onTap: (){

                                    if (_isSelected == true){
                                      setState(() {
                                        _buttons.remove(_phid);
                                      });
                                    }
                                    else {
                                      setState(() {
                                        _buttons.add(_phid);
                                      });
                                    }

                                  },
                                );

                              }),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                /// CAN BE DISMISSED
                TileBubble(
                  bubbleWidth: _clearWidth,
                  bubbleHeaderVM: BubbleHeaderVM(
                    headlineVerse: Verse.plain('Dismissible'),
                    hasSwitch: true,
                    switchValue: _canBeDismissedWithoutTapping,
                    onSwitchTap: (bool value){
                      setState(() {
                        _canBeDismissedWithoutTapping = value;
                      });
                    },
                  ),
                ),

                /// CONFIRM BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    const Expander(),

                    /// SEND NOTIFICATION
                    DreamBox(
                      height: 50,
                      verse: Verse.plain('Send $_notificationTypeString'),
                      verseScaleFactor: 0.7,
                      color: Colorz.yellow255,
                      verseColor: Colorz.black255,
                      verseShadow: false,
                      onTap: _pushNotification,
                    ),

                  ],
                ),

              ],
            ),
          ),

          const Horizon(),

          // /// SEND SCHEDULED
          // DreamBox(
          //   height: 60,
          //   width: 250,
          //   verse: Verse.plain('send scheduled'),
          //   verseScaleFactor: 0.7,
          //   color: Colorz.yellow255,
          //   verseColor: Colorz.black255,
          //   verseShadow: false,
          //   onTap: _onSendScheduledNotification,
          // ),

          // /// CANCEL SCHEDULED
          // DreamBox(
          //   height: 60,
          //   width: 250,
          //   verse: Verse.plain('cancel schedules'),
          //   verseScaleFactor: 0.7,
          //   color: Colorz.yellow255,
          //   verseColor: Colorz.black255,
          //   verseShadow: false,
          //   onTap: () async {
          //     await FCM.cancelScheduledNotification();
          //   },
          // ),

          // WideButton(
          //   verse:  Verse.plain('Cancel Stream'),
          //   onTap: () async {
          //
          //     if (_streamSubscription == null){
          //       blog('_streamSubscription is null');
          //     }
          //     else {
          //       await _streamSubscription.cancel();
          //       blog('_streamSubscription is cancelled');
          //     }
          //
          //   },
          // ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
