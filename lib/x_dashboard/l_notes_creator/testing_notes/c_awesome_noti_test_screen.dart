import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/d_user_search_screen/search_users_screen.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/tile_bubble.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
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
  final ValueNotifier<bool> _isGlobalNotification = ValueNotifier(true);
  final ValueNotifier<Map<String, dynamic>> _notificationData = ValueNotifier(null);
  // --------------------
  /// JUST TO ACTIVATE VALIDATORS
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  // --------------------
  bool _isNotificationAllowed = false;
  File _selectedPic;
  String _picURL;
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

    _notificationData.value = {
      'title': '',
      'body': '',
    };

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
    _isGlobalNotification.dispose();
    _notificationData.dispose();

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
      if (_isGlobalNotification.value == true){
        await FCM.pushGlobalNoot(
          title: _notificationData.value['title'],
          body: _notificationData.value['body'],
          largeIconURL: _picURL,
          bannerURL: _picURL,
          payloadMap: {
            'fuck': 'you',
            'whore': 'payloadMapaho',
          },
        );
      }

      /// PUSH LOCAL NOTIFICATION
      else {
        await FCM.pushLocalNoot(
          title: _notificationData.value['title'],
          body: _notificationData.value['body'],
          payloadString: 'fucking payload',
          largeIconFile: _selectedPic,
        );
      }

    }

  }
  // --------------------
  Future<void> _selectGalleryPic() async {

    final FileModel _pickedFileModel = await Imagers.pickAndCropSingleImage(
      context: context,
      cropAfterPick: true,
      isFlyerRatio: false,
    );

    if (_pickedFileModel != null){
      setState(() {
        _selectedPic = _pickedFileModel.file;
      });
    }

  }
  // --------------------
  Future<void> _selectURL() async {

    final UserModel _user = await SearchUsersScreen.selectUser(context);

    if (_user != null){

      blog(_user.pic);
      // final Uint8List _uints = await Floaters.getUint8ListFromURL(_user.pic);
      // final File _file = await Filers.getFileFromUint8List(
      //   uInt8List: _uints,
      //   fileName: _user.id,
      // );
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
          _selectedPic = _file;
          _picURL = _user.pic;
        });
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
          verse: Verse.plain(_isNotificationAllowed == true ? 'Allowed' : 'Not Allowed'),
          onTap: _requestNotificationPermission,
        ),

      ],
      layoutWidget: ValueListenableBuilder(
        valueListenable: _notificationData,
        builder: (_, Map<String, dynamic> notification, Widget child){

          return ListView(
            padding: Stratosphere.stratosphereSandwich,
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// NOTIFICATION MAKER
              ValueListenableBuilder(
                  valueListenable: _isGlobalNotification,
                  builder: (_, bool isGlobal, Widget child){

                    final String _notificationTypeString = isGlobal == true ? 'Global' : 'Local';

                    return Form(
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
                                  _isGlobalNotification.value = value;
                                }
                            ),
                          ),

                          /// TITLE
                          TextFieldBubble(
                            bubbleWidth: _clearWidth,
                            appBarType: AppBarType.basic,
                            titleVerse: Verse.plain('Title'),
                            isFormField: true,
                            textController: _titleController,
                            textOnChanged: (String text){
                              final Map<String, dynamic> _map = Mapper.replacePair(
                                map: _notificationData.value,
                                fieldKey: 'title',
                                inputValue: text,
                              );
                              _notificationData.value = _map;
                            },
                            counterIsOn: true,
                            maxLines: 2,
                            maxLength: 30,
                            initialText: notification['title'],
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
                            textOnChanged: (String text){

                              final Map<String, dynamic> _map = Mapper.replacePair(
                                map: _notificationData.value,
                                fieldKey: 'body',
                                inputValue: text,
                              );

                              _notificationData.value = _map;

                            },
                            counterIsOn: true,
                            maxLines: 7,
                            maxLength: 80,
                            // keyboardTextInputType: TextInputType.text,
                            keyboardTextInputAction: TextInputAction.send,
                            initialText: notification['body'],
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
                              leadingIcon: _selectedPic ?? Iconz.phoneGallery,
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
                                      _selectedPic = null;
                                    });
                                  },
                                ),

                                const SizedBox(
                                  height: 10,
                                  width: 10,
                                ),

                                /// URL
                                DreamBox(
                                  width: 50,
                                  height: 50,
                                  icon: Iconz.comWebsite,
                                  iconSizeFactor: 0.4,
                                  onTap: _selectURL,
                                ),

                                const SizedBox(
                                  height: 10,
                                  width: 10,
                                ),

                                /// GALLERY
                                DreamBox(
                                  width: 50,
                                  height: 50,
                                  icon: Iconz.phoneGallery,
                                  iconSizeFactor: 0.4,
                                  onTap: _selectGalleryPic,
                                ),


                              ],
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
                    );

                  }
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
          );

        },
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
