import 'dart:io';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/notification/noti_model.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/xxx_dashboard/b_views/c_components/layout/dashboard_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/notifications/notification_balloon.dart';
import 'package:bldrs/b_views/widgets/specific/notifications/notification_card.dart';
import 'package:bldrs/b_views/widgets/specific/notifications/notification_flyers.dart';
import 'package:bldrs/b_views/x_screens/e_saves/e_0_saved_flyers_screen.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_text_field.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/methods/storage.dart' as Storage;
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/e_db/fire/search/user_search.dart' as UserSearch;
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/notifications/bldrs_notiz.dart' as BldrsNotiModelz;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/notifications_manager/noti_banner_editor.dart';
import 'package:bldrs/xxx_dashboard/widgets/user_button.dart';
import 'package:bldrs/xxx_dashboard/widgets/wide_button.dart';
import 'package:flutter/material.dart';

class NotificationMaker extends StatefulWidget {
  const NotificationMaker({Key key}) : super(key: key);

  @override
  _NotificationMakerState createState() => _NotificationMakerState();
}

class _NotificationMakerState extends State<NotificationMaker> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  UserModel _selectedUser;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (function == null) {
      setState(() {
        _loading = !_loading;
      });
    } else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true ?
    blog('LOADING--------------------------------------')
        :
    blog('LOADING COMPLETE--------------------------------------');
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
    if (_isInit) {
      _triggerLoading(function: () {}).then((_) async {
        /// ---------------------------------------------------------0

        /// ---------------------------------------------------------0
      });

      if (_loading == true) {
        _triggerLoading();
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

// -----------------------------------------------------------------------------
  final NotiPicType _notiPicType = NotiPicType.bldrs;
  final String _notiPic = Iconz.bldrsNameEn;
  void _onBalloonTap() {
    blog('on balloon tap');
  }
// -----------------------------------------------------------------------------
  dynamic _attachment;
  NotiAttachmentType _attachmentType = NotiAttachmentType.non;
  double _bannerHeight = 0;
// -----------------------------------------------------------------------------
  Future<void> _onAddAttachment() async {
    blog('choosing attachment');

    final List<NotiAttachmentType> _attachmentTypesList =
        NotiModel.notiAttachmentTypesList();

    await BottomDialog.showBottomDialog(
      context: context,
      title: 'Select Attachment Type',
      draggable: true,
      child: Column(
        children: <Widget>[
          ...List<Widget>.generate(_attachmentTypesList.length, (int index) {
            final String _attachmentTypeString =
                TextMod.removeTextBeforeLastSpecialCharacter(
                    _attachmentTypesList[index].toString(), '.');
            final Color _color = _attachmentType == _attachmentTypesList[index]
                ? Colorz.yellow255
                : Colorz.blue20;

            return DreamBox(
              height: 50,
              width: BottomDialog.clearWidth(context),
              verse: _attachmentTypeString,
              verseScaleFactor: 0.6,
              color: _color,
              onTap: () => _onChooseAttachmentType(_attachmentTypesList[index]),
            );
          }),
        ],
      ),
    );
  }

// -----------------------------------------------------------------------------
  Future<void> _onChooseAttachmentType(
      NotiAttachmentType attachmentType) async {
    if (attachmentType == NotiAttachmentType.banner) {
      await _attachGalleryPicture();
    } else if (attachmentType == NotiAttachmentType.flyers) {
      await _attachFlyers();
    } else {
      blog('attachment type is ${attachmentType.toString()}');
    }
  }

// -----------------------------------------------------------------------------
  Future<void> _attachGalleryPicture() async {
    final File _pic =
        await Imagers.takeGalleryPicture(picType: Imagers.PicType.slideHighRes);

    blog('pic is : $_pic');

    final ImageSize _picSize = await ImageSize.superImageSize(_pic);

    blog('_picSize is : W ${_picSize.width} x H ${_picSize.height}');

    final double _picViewHeight = ImageSize.concludeHeightByGraphicSizes(
      width: NotificationCard.bodyWidth(context),
      graphicWidth: _picSize.width,
      graphicHeight: _picSize.height,
    );

    Nav.goBack(context);
    // await null;

    if (_pic != null) {
      setState(() {
        _attachmentType = NotiAttachmentType.banner;
        _attachment = _pic;
        _bannerHeight = _picViewHeight;
      });
    }
  }

// -----------------------------------------------------------------------------
  Future<void> _attachFlyers() async {
    Keyboarders.closeKeyboard(context);

    final List<FlyerModel> _selectedFlyers = await Nav.goToNewScreen(
      context,
      const SavedFlyersScreen(
        selectionMode: true,
      ),
    );

    setState(() {
      _attachmentType = NotiAttachmentType.flyers;
      _attachment = _selectedFlyers;
    });

    Nav.goBack(context);
    // await null;
  }

// -----------------------------------------------------------------------------
  void _onDeleteAttachment() {
    setState(() {
      _attachment = null;
      _attachmentType = NotiAttachmentType.non;
    });
  }

// -----------------------------------------------------------------------------
  bool _sendFCMIsOn = false;
  void _onSwitchSendFCM(bool val) {
    blog('send fcm val is : $val');
    setState(() {
      _sendFCMIsOn = val;
    });
  }

// -----------------------------------------------------------------------------
  Future<void> _onTapReciever() async {
    Keyboarders.closeKeyboard(context);

    final double _dialogHeight =
        BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.85);

    final double _dialogClearWidth = BottomDialog.clearWidth(context);
    final double _dialogClearHeight = BottomDialog.clearHeight(
      context: context,
      draggable: true,
      titleIsOn: true,
      overridingDialogHeight: _dialogHeight,
    );
    const double _textFieldHeight = 70;

    List<UserModel> _usersModels = <UserModel>[];

    await BottomDialog.showStatefulBottomDialog(
      context: context,
      draggable: true,
      title: 'Search for a user',
      height: _dialogHeight,
      builder: (BuildContext ctx, String title) {
        return StatefulBuilder(builder:
            (BuildContext xxx, void Function(void Function()) setDialogState) {
          return Column(
            children: <Widget>[
              /// USER NAME TEXT FIELD
              SizedBox(
                width: _dialogClearWidth,
                height: _textFieldHeight,
                child: SuperTextField(
                  height: _textFieldHeight,
                  textController: _userNameController,
                  hintText: 'user name ...',
                  keyboardTextInputType: TextInputType.multiline,
                  maxLength: 30,
                  maxLines: 2,
                  fieldIsFormField: true,
                  keyboardTextInputAction: TextInputAction.search,
                  onSubmitted: (String val) async {
                    blog('submitted : val : $val');

                    final List<UserModel> _resultUsers =
                        await UserSearch.usersByUserName(
                      context: context,
                      name: val,
                    );

                    if (_resultUsers == <UserModel>[]) {
                      blog('result is null, no result found');
                    } else {
                      blog('_result found : ${_resultUsers.length} matches');

                      setDialogState(() {
                        _usersModels = _resultUsers;
                      });
                    }
                  },
                ),
              ),

              SizedBox(
                width: _dialogClearWidth,
                height: _dialogClearHeight - _textFieldHeight,
                child: OldMaxBounceNavigator(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: Ratioz.horizon),
                      itemCount: _usersModels.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        final bool _userSelected =
                            _selectedUser == _usersModels[index];

                        return _usersModels == <UserModel>[]
                            ? SizedBox(
                                width: _dialogClearWidth,
                                height: 70,
                                child: const SuperVerse(
                                  verse: 'No match found',
                                  size: 1,
                                  weight: VerseWeight.thin,
                                  italic: true,
                                  color: Colorz.white30,
                                ),
                              )
                            : Row(
                                children: <Widget>[
                                  DashboardUserButton(
                                      width: _dialogClearWidth -
                                          DashboardUserButton.height(),
                                      userModel: _usersModels[index],
                                      index: index,
                                      onDeleteUser: null),
                                  Container(
                                    height: DashboardUserButton.height(),
                                    width: DashboardUserButton.height(),
                                    alignment: Alignment.center,
                                    child: DreamBox(
                                      height: 50,
                                      width: 50,
                                      icon: Iconz.check,
                                      iconSizeFactor: 0.5,
                                      iconColor: _userSelected == true
                                          ? Colorz.green255
                                          : Colorz.white50,
                                      color: null,
                                      onTap: () async {
                                        setDialogState(() {
                                          _selectedUser = _usersModels[index];
                                        });

                                        setState(() {
                                          _selectedUser = _usersModels[index];
                                        });

                                        Nav.goBack(context);
                                        // await null;
                                      },
                                    ),
                                  )
                                ],
                              );
                      }),
                ),
              ),
            ],
          );
        });
      },
    );
  }

// -----------------------------------------------------------------------------
  Future<void> _onSendNotification({bool sendToMyself = false}) async {
    final String _userID =
        sendToMyself == true ? FireAuthOps.superUserID() : _selectedUser.id;
    final String _userName = sendToMyself == true
        ? 'YOURSELF : ${FireAuthOps.superUserID()}'
        : _selectedUser.name;

    final bool _confirmSend = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Send ?',
      body: 'Do you want to confirm sending this notification to $_userName',
      boolDialog: true,
    );

    if (_confirmSend == true) {
      final String _id = '${Numeric.createUniqueID()}';

      dynamic _outputAttachment;

      if (_attachment != null && _attachmentType == NotiAttachmentType.banner) {
        _outputAttachment = await Storage.createStoragePicAndGetURL(
          context: context,
          inputFile: _attachment,
          picName: _id,
          docName: StorageDoc.notiBanners,
          ownerID: _userID,
        );
      }

      if (_attachment != null && _attachmentType == NotiAttachmentType.flyers) {
        _outputAttachment = FlyerModel.getFlyersIDsFromFlyers(_attachment);
      }

      final NotiModel _newNoti = NotiModel(
        id: _id,
        name: 'targeted notification',
        sudo: null,
        senderID: BldrsNotiModelz.bldrsSenderID,
        pic: BldrsNotiModelz.bldrsLogoURL,
        notiPicType: NotiPicType.bldrs,
        title: _titleController.text,
        timeStamp: DateTime.now(),
        body: _bodyController.text,
        attachment: _outputAttachment,
        attachmentType: _attachmentType,
        dismissed: false,
        sendFCM: _sendFCMIsOn,
        metaData: BldrsNotiModelz.notiDefaultMap,
      );

      // _newNoti.printNotiModel(methodName: '_onSendNotification');

      final bool result = await tryCatchAndReturn(
        context: context,
        methodName: '_onSendNotification',
        functions: () async {
          await Fire.createNamedSubDoc(
            context: context,
            collName: FireColl.users,
            docName: sendToMyself == true
                ? FireAuthOps.superUserID()
                : _selectedUser.id,
            subCollName: FireSubColl.users_user_notifications,
            input: _newNoti.toMap(toJSON: false),
            subDocName: _id,
          );
        },
      );

      if (result == true) {
        await CenterDialog.showCenterDialog(
          context: context,
          title: 'Done',
          body: 'Notification has been sent to $_userName',
        );

        setState(() {
          _titleController.clear();
          _bodyController.clear();
          _attachment = null;
          _attachmentType = NotiAttachmentType.non;
          _sendFCMIsOn = false;
          _selectedUser = null;
        });
      } else {
        await CenterDialog.showCenterDialog(
          context: context,
          title: 'FAILED',
          body: 'The notification was not sent',
        );
      }
    }
  }

// -----------------------------------------------------------------------------
  bool _canSendNotification({bool sendToMySelf}) {
    bool _canSend = false;

    if (TextChecker.textControllerIsEmpty(_titleController) == false &&
            TextChecker.textControllerIsEmpty(_bodyController) == false &&
            _attachment != null &&
            _attachmentType != null &&
            _sendFCMIsOn != null &&
            _selectedUser != null ||
        sendToMySelf == true) {
      _canSend = true;
    }

    return _canSend;
  }

// -----------------------------------------------------------------------------
  void _onDeleteFlyer(String flyerID) {
    final List<FlyerModel> flyers = _attachment;

    final FlyerModel _flyer =
        FlyerModel.getFlyerFromFlyersByID(flyers: flyers, flyerID: flyerID);

    flyers.remove(_flyer);

    bool _attachmentIsEmpty = true;
    if (Mapper.canLoopList(flyers)) {
      _attachmentIsEmpty = false;
    }

    setState(() {
      _attachment = flyers;

      if (_attachmentIsEmpty == true) {
        _attachmentType = NotiAttachmentType.non;
      }
    });
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // double _screenHeight = Scale.superScreenHeight(context);
    final double _screenWidth = Scale.superScreenWidth(context);

    final double _bodyWidth = NotificationCard.bodyWidth(context);

    return DashBoardLayout(
      loading: _loading,
      pageTitle: 'Notification Maker',
      listWidgets: <Widget>[
        /// TIME STAMP
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
          child: SuperVerse(
            verse: Timers.stringOnDateMonthYear(
                context: context, time: DateTime.now()),

            /// task : fix timestamp parsing
            color: Colorz.grey255,
            italic: true,
            weight: VerseWeight.thin,
            size: 1,
            maxLines: 2,
            centered: false,
          ),
        ),

        /// CONTENT CREATOR
        Bubble(
          centered: true,
          margins: const EdgeInsets.symmetric(
              horizontal: Ratioz.appBarMargin, vertical: Ratioz.appBarPadding),
          // bubbleOnTap: null,
          columnChildren: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// SENDER BALLOON
                GestureDetector(
                  onTap: _onBalloonTap,
                  child: NotificationSenderBalloon(
                    sender: _notiPicType,
                    pic: _notiPic,
                  ),
                ),

                /// SPACER
                const SizedBox(
                  width: Ratioz.appBarMargin,
                  height: Ratioz.appBarMargin,
                ),

                /// NOTIFICATION CONTENT
                SizedBox(
                  width: _bodyWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// TITLE
                      SuperTextField(
                        height: 80,
                        textController: _titleController,
                        hintText: 'Title',
                        keyboardTextInputAction: TextInputAction.next,
                        maxLength: 30,
                        maxLines: 2,
                        fieldIsFormField: true,

                        // validator: (){}, // TASK : question body must include question mark '?'
                      ),

                      /// SPACER
                      const SizedBox(
                        width: Ratioz.appBarMargin,
                        height: Ratioz.appBarMargin,
                      ),

                      /// BODY
                      SuperTextField(
                        textController: _bodyController,
                        hintText: 'body',
                        keyboardTextInputType: TextInputType.multiline,
                        maxLength: 80,
                        maxLines: 10,
                        inputWeight: VerseWeight.thin,
                        fieldIsFormField: true,
                        // validator: (){}, // TASK : question body must include question mark '?'
                      ),

                      /// SPACER
                      const SizedBox(
                        width: Ratioz.appBarPadding,
                        height: Ratioz.appBarPadding,
                      ),

                      /// ADD ATTACHMENT BUTTON
                      if (_attachment == null || _attachment.length == 0)
                        Container(
                          width: _bodyWidth,
                          height: 60,
                          alignment:
                              Aligners.superInverseCenterAlignment(context),
                          child: DreamBox(
                            height: 50,
                            verse: 'Add Attachment',
                            verseScaleFactor: 0.6,
                            onTap: _onAddAttachment,
                          ),
                        ),

                      /// FLYERS ATTACHMENT
                      if (_attachment != null &&
                          _attachmentType == NotiAttachmentType.flyers)
                        NotificationFlyers(
                          bodyWidth: _bodyWidth,
                          flyers: _attachment,
                          onFlyerTap: (String flyerID) =>
                              _onDeleteFlyer(flyerID),
                        ),

                      /// BANNER
                      if (_attachment != null &&
                          _attachmentType == NotiAttachmentType.banner)
                        NotiBannerEditor(
                          width: _bodyWidth,
                          height: _bannerHeight,
                          attachment: _attachment,
                          onDelete: _onDeleteAttachment,
                        ),

                      /// BUTTONS
                      if (_attachment != null &&
                          _attachmentType == NotiAttachmentType.buttons &&
                          _attachment is List<String>)
                        SizedBox(
                          width: _bodyWidth,
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ...List<Widget>.generate(_attachment.length,
                                  (int index) {
                                final double _width = (_bodyWidth -
                                        ((_attachment.length + 1) *
                                            Ratioz.appBarMargin)) /
                                    (_attachment.length);

                                return DreamBox(
                                  width: _width,
                                  height: 60,
                                  verse: _attachment[index],
                                  verseScaleFactor: 0.7,
                                  color: Colorz.blue80,
                                  splashColor: Colorz.yellow255,
                                  // onTap: () => _onButtonTap(notiModel.attachment[index]),
                                );
                              }),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        /// FCM SWITCH
        TileBubble(
          verse: 'Send FCM',
          secondLine:
              'This sends firebase cloud message to the receiver or to a group of receivers through a channel',
          icon: Iconz.news,
          iconSizeFactor: 0.5,
          iconBoxColor: Colorz.grey50,
          switchIsOn: _sendFCMIsOn,
          switching: (bool val) => _onSwitchSendFCM(val),
        ),

        /// USER SELECTOR
        TileBubble(
          verse: 'Reciever',
          secondLine: 'Choose who to send this notification to',
          icon: Iconz.normalUser,
          iconSizeFactor: 0.5,
          iconBoxColor: Colorz.grey50,
          btOnTap: _onTapReciever,
          child: SizedBox(
            width: Bubble.clearWidth(context),
            // height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (_selectedUser != null)
                  DashboardUserButton(
                    width: TileBubble.childWidth(context),
                    index: 0,
                    userModel: _selectedUser,
                    onDeleteUser: null,
                  ),
                if (_selectedUser != null)
                  DreamBox(
                    height: 40,
                    verse: 'Delete ${_selectedUser.name}',
                    icon: Iconz.xSmall,
                    iconSizeFactor: 0.5,
                    onTap: () {
                      setState(() {
                        _selectedUser = null;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),

        SizedBox(
          width: _screenWidth,
          height: 50,
        ),

        /// SEND BUTTON
        SizedBox(
          width: _screenWidth,
          // height: 150,
          child: Center(
            child: WideButton(
              verse: 'Send Notification',
              icon: Iconz.share,
              onTap: _onSendNotification,
              color: Colorz.yellow255,
              isActive: _canSendNotification(sendToMySelf: false),
            ),
          ),
        ),

        /// SEND TO MYSELF
        SizedBox(
          width: _screenWidth,
          // height: 150,
          child: Center(
            child: WideButton(
              verse: 'Send To Myself',
              verseColor: Colorz.black255,
              icon: Iconz.share,
              onTap: () => _onSendNotification(sendToMyself: true),
              color: Colorz.yellow255,
              isActive: _canSendNotification(sendToMySelf: true),
            ),
          ),
        ),

        /// HORIZON
        const Horizon(),
      ],
    );
  }
}
