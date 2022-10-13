import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/target/target_progress.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/b_views/d_user/d_user_search_screen/search_users_screen.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/f_bz/g_search_bzz_screen/search_bzz_screen.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/x_note_poster_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_progress_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/storage.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/aa_image_poster.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/a_note_poster.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class LocalNootTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const LocalNootTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _LocalNootTestScreenState createState() => _LocalNootTestScreenState();
  /// --------------------------------------------------------------------------
}

class _LocalNootTestScreenState extends State<LocalNootTestScreen> {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey();
  // --------------------
  final ScreenshotController screenshotController = ScreenshotController();
  // --------------------
  /// JUST TO ACTIVATE VALIDATORS
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  // --------------------
  bool isGlobal = true;
  bool _isNotificationAllowed = false;
  // --------------------
  String _posterURL;
  dynamic _posterModel;
  dynamic _posterHelperModel;
  PosterType _posterType;
  File _posterPreviewFile;
  // --------------------
  File _largeImageFile;
  String _largeIconURL;
  // --------------------
  Progress _progress;
  bool _nootProgressIsLoading = false;
  final List<String> _buttons = <String>[];
  // --------------------
  bool _canBeDismissedWithoutTapping = true;
  // --------------------
  StreamSubscription _streamSubscription;
  // -----------------------------------------------------------------------------
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

      if (_posterPreviewFile != null){

        final String _url = await Storage.createStoragePicAndGetURL(
          docName: 'testNotesBanners',
          fileName: Numeric.createUniqueID().toString(),
          ownersIDs: [AuthFireOps.superUserID()],
          inputFile: _posterPreviewFile,
        );
        setState(() {
          _posterURL = _url;
        });

      }

      /// PUSH GLOBAL NOTIFICATION
      if (isGlobal == true){
        await FCM.pushGlobalNoot(
          title: _titleController.text,
          body: _bodyController.text,
          largeIconURL: _largeIconURL,
          posterURL: _posterURL,
          buttonsTexts: _buttons.isEmpty == true ? null : xPhrases(context, _buttons),
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
  Future<void> _takePosterScreenshot() async {

    blog('_takeBannerScreenshot : START');

    final double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    final Uint8List uint8List = await screenshotController.capture(
      pixelRatio: pixelRatio,
      delay: const Duration(milliseconds: 200),
    );

    final String _fileName = Numeric.createUniqueID().toString();

    final FileModel _fileModel = await Imagers.resizeImage(
        resizeToWidth: NotePosterBox.standardSize.width,
        fileModel: FileModel(
          fileName: _fileName,
          file: await Filers.getFileFromUint8List(
            uInt8List: uint8List,
            fileName: _fileName,
          )
        ),
    );

    setState(() {
      _posterPreviewFile = _fileModel.file;
    });

    blog('_takeBannerScreenshot : END');

    // if (_attachmentType == NoteAttachmentType.flyer){
    //
    //  
    //
    // }
    // else if (_attachmentType == NoteAttachmentType.bz){
    //
    // }
    // else if (_attachmentType == NoteAttachmentType.image){
    //
    // }

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

    final bool _posterIsOn = isGlobal == true && _progress == null;
    final String _notificationTypeString = isGlobal == true ? 'Global' : 'Local';

    final double _tileChildWidth = TileBubble.childWidth(
        context: context,
        bubbleWidthOverride: Bubble.clearWidth(context)
    );

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
                // ExpandingTile(
                //   firstHeadline: Verse.plain('Channel'),
                //   secondHeadline: Verse.plain(_channel.name),
                //   width: Bubble.clearWidth(context),
                //   icon: Iconz.advertise,
                //   iconSizeFactor: 0.4,
                //   margin: const EdgeInsets.only(bottom: 10),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //
                //       ...List<Widget>.generate(ChannelModel.bldrsChannels.length, (int index) {
                //
                //         final ChannelModel _channelModel = ChannelModel.bldrsChannels[index];
                //         final bool _isSelected = _channelModel.channel == _channel;
                //
                //         return DreamBox(
                //           height: 40,
                //           margins: const EdgeInsets.only(bottom: 3, left: 10),
                //           verse: Verse.plain(_channelModel.name),
                //           secondLine: Verse.plain(_channelModel.description),
                //           verseScaleFactor: 0.6,
                //           verseCentered: false,
                //           bubble: false,
                //           color: _isSelected == true ? Colorz.yellow255 : Colorz.white20,
                //           verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                //           secondLineColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                //           onTap: (){
                //             setState(() {
                //               _channel = _channelModel.channel;
                //             });
                //           },
                //         );
                //
                //       }),
                //
                //     ],
                //   ),
                // ),

                /// TITLE
                TextFieldBubble(
                  headerViewModel: BubbleHeaderVM(
                    headlineVerse: Verse.plain('Title'),
                  ),
                  bubbleWidth: _clearWidth,
                  appBarType: AppBarType.basic,
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
                  headerViewModel: BubbleHeaderVM(
                    headlineVerse: Verse.plain('Body'),
                  ),
                  bubbleWidth: _clearWidth,
                  appBarType: AppBarType.basic,
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
                            aspectRatio: 1,
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

                /// POSTER
                WidgetFader(
                  fadeType: _posterIsOn == true ? FadeType.stillAtMax : FadeType.stillAtMin,
                  min: 0.35,
                  absorbPointer: !_posterIsOn,
                  child: TileBubble(
                    bubbleWidth: Bubble.clearWidth(context),
                    bubbleHeaderVM: BubbleHeaderVM(
                      headerWidth: Bubble.clearWidth(context) - 20,
                      leadingIcon: Iconz.phoneGallery,
                      headlineVerse: Verse.plain('Poster'),
                    ),
                    child: Column(
                      children: <Widget>[

                        Row(
                          children: <Widget>[

                            /// CLEAR
                            DreamBox(
                              width: 40,
                              height: 40,
                              icon: Iconz.xLarge,
                              iconSizeFactor: 0.4,
                              onTap: (){
                                setState(() {
                                  _posterURL = null;
                                  _posterType = null;
                                  _posterModel = null;
                                  _posterHelperModel = null;
                                  _posterPreviewFile = null;
                                });
                              },
                            ),

                            const SizedBox(height: 5, width: 5,),

                            /// URL
                            DreamBox(
                              height: 40,
                              isDeactivated: !_posterIsOn,
                              icon: Iconz.comWebsite,
                              iconSizeFactor: 0.5,
                              // verse: Verse.plain('URL'),
                              onTap: () async {

                                // final List<FlyerModel> _selectedFlyers = await Nav.goToNewScreen(
                                //   context: context,
                                //   screen: const SavedFlyersScreen(
                                //     selectionMode: true,
                                //   ),
                                // );
                                //
                                // if (Mapper.checkCanLoopList(_selectedFlyers) == true){
                                //
                                //   setState(() {
                                //     _bannerURL = _selectedFlyers.first.slides[0].pic;
                                //   });
                                //
                                // }

                              },
                            ),

                            const SizedBox(height: 5, width: 5,),

                            /// GALLERY
                            DreamBox(
                              height: 40,
                              isDeactivated: !_posterIsOn,
                              icon: Iconz.phoneGallery,
                              iconSizeFactor: 0.5,
                              // verse: Verse.plain('URL'),
                              onTap: () async {

                                final FileModel _pickedFileModel = await Imagers.pickAndCropSingleImage(
                                  context: context,
                                  cropAfterPick: true,
                                  aspectRatio: NotePosterBox.getAspectRatio(),
                                );

                                if (_pickedFileModel != null){

                                  setState(() {
                                    _posterType = PosterType.galleryImage;
                                    _posterModel = _pickedFileModel.file;
                                    _posterHelperModel = null;
                                  });

                                  await _takePosterScreenshot();

                                }


                              },
                            ),

                            const SizedBox(height: 5, width: 5,),

                            /// BZ
                            DreamBox(
                              height: 40,
                              isDeactivated: !_posterIsOn,
                              icon: Iconz.bz,
                              iconSizeFactor: 0.5,
                              // verse: Verse.plain('URL'),
                              onTap: () async {

                                final List<BzModel> bzModels = await Nav.goToNewScreen(
                                  context: context,
                                  screen: const SearchBzzScreen(),
                                );

                                if (Mapper.checkCanLoopList(bzModels) == true){

                                  final FlyerModel _allBzSlidesInOneFlyer = await FlyerProtocols.fetchAndCombineBzSlidesInOneFlyer(
                                    context: context,
                                    bzModel: bzModels.first,
                                    maxSlides: 20,
                                  );

                                  blog('slides are : ${_allBzSlidesInOneFlyer?.slides?.length} slides');

                                  setState(() {
                                    _posterType = PosterType.bz;
                                    _posterModel = bzModels.first;
                                    _posterHelperModel = _allBzSlidesInOneFlyer;
                                  });

                                  await _takePosterScreenshot();

                                }

                              },
                            ),

                            const SizedBox(height: 5, width: 5,),

                            /// FLYER
                            DreamBox(
                              height: 40,
                              isDeactivated: !_posterIsOn,
                              icon: Iconz.addFlyer,
                              iconSizeFactor: 0.5,
                              // verse: Verse.plain('URL'),
                              onTap: () async {

                                final List<FlyerModel> _selectedFlyers = await Nav.goToNewScreen(
                                  context: context,
                                  screen: const SavedFlyersScreen(
                                    selectionMode: true,
                                  ),
                                );

                                if (Mapper.checkCanLoopList(_selectedFlyers) == true){

                                  final BzModel _bz = await BzProtocols.fetchBz(
                                      context: context,
                                      bzID: _selectedFlyers.first.bzID,
                                  );

                                  setState(() {
                                    _posterType = PosterType.flyer;
                                    _posterModel = _selectedFlyers.first;
                                    _posterHelperModel = _bz;
                                  });

                                  await _takePosterScreenshot();

                                }

                              },
                            ),

                          ],
                        ),

                        const SizedBox(height: 5, width: 5,),

                        if (_posterModel != null)
                          Screenshot(
                            controller: screenshotController,
                            child: NotePoster(
                              posterType: _posterType,
                              width: _tileChildWidth,
                              model: _posterModel,
                              modelHelper: _posterHelperModel,
                            ),
                          ),

                        if (_posterPreviewFile != null)
                        const SizedBox(height: 5, width: 5,),

                        if (_posterPreviewFile != null)
                        ImagePoster(
                            width: _tileChildWidth,
                            pic: _posterPreviewFile,
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

                              ...List.generate(PollModel.acceptDeclineButtons.length, (index){

                                final String _phid = PollModel.acceptDeclineButtons[index];

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

          /// ACTIVATE NOOT LISTENERS
          WideButton(
            verse: Verse.plain('Activate Listeners'),
            onTap: () async {

              // await FCM.getAwesomeNoots().setListeners(
              //     onActionReceivedMethod:         NootController.onActionReceivedMethod,
              //     onNotificationCreatedMethod:    NootController.onNotificationCreatedMethod,
              //     onNotificationDisplayedMethod:  NootController.onNotificationDisplayedMethod,
              //     onDismissActionReceivedMethod:  NootController.onDismissActionReceivedMethod,
              // );

            },
          ),

          /// REQUEST FCM PERMISSION
          WideButton(
            verse: Verse.plain('requestFCMPermission'),
            onTap: () async {

              blog('REQUEST FCM PERMISSION : START');

              final NotificationSettings _settings = await FCM.requestFCMPermission();

              FCM.blogNootSettings(
                settings: _settings,
                invoker: 'requestFCMPermission',
              );

              blog('REQUEST FCM PERMISSION : END');

            },
          ),

          /// UPDATE USER PROTOCOL
          WideButton(
            verse: Verse.plain('updateMyUserFCMToken'),
            onTap: () async {

              blog('UPDATE USER PROTOCOL : START');

              await UserProtocols.updateMyUserFCMToken(context: context);

              blog('UPDATE USER PROTOCOL : END');

            },
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
