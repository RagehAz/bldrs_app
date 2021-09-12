

import 'dart:io';

import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/dashboard/notifications_manager/noti_banner_editor.dart';
import 'package:bldrs/dashboard/widgets/user_button.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/search_ops.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/secondary_models/image_size.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_welcome_banner.dart';
import 'package:bldrs/views/widgets/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/user_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/notifications/notification_balloon.dart';
import 'package:bldrs/views/widgets/notifications/notification_card.dart';
import 'package:bldrs/views/widgets/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class NotificationMaker extends StatefulWidget {


  @override
  _NotificationMakerState createState() => _NotificationMakerState();
}

class _NotificationMakerState extends State<NotificationMaker> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _bodyController = new TextEditingController();
  TextEditingController _userNameController = new TextEditingController();
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
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

      _triggerLoading(function: (){}).then((_) async {
        /// ---------------------------------------------------------0



        /// ---------------------------------------------------------0
      });

      if(_loading == true){
        _triggerLoading();
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  NotiPicType _notiPicType = NotiPicType.bldrs;
  String _notiPic = Iconz.BldrsNameEn;
  void _onBalloonTap(){
    print('on balloon tap');
  }
// -----------------------------------------------------------------------------
  dynamic _attachment;
  NotiAttachmentType _attachmentType;

  // dynamic _bannerImage;
  double _bannerHeight = 0;
  Future<void> _onAddAttachment() async {
    print('choosing attachment');

    List<NotiAttachmentType> _attachmentTypesList = NotiModel.notiAttachmentTypesList();

    await BottomDialog.showBottomDialog(
      context: context,
      title: 'Select Attachment Type',
      draggable: true,
      child: Column(
        children: <Widget>[

          ...List.generate(
              _attachmentTypesList.length,
                  (index) {

                String _attachmentTypeString = TextMod.trimTextBeforeLastSpecialCharacter(_attachmentTypesList[index].toString(), '.');
                Color _color = _attachmentType == _attachmentTypesList[index]? Colorz.Yellow255 : Colorz.Blue20;


                return
                  DreamBox(
                    height: 50,
                    width: BottomDialog.dialogClearWidth(context),
                    verse: _attachmentTypeString,
                    verseScaleFactor: 0.6,
                    color: _color,
                    onTap: () => _onChooseAttachmentType(_attachmentTypesList[index]),
                  );

              }
          ),

        ],
      ),
    );
  }
// -----------------------------------------------------------------------------
  Future<void> _onChooseAttachmentType(NotiAttachmentType attachmentType) async {

    if (attachmentType == NotiAttachmentType.banner){
      await _takeGalleryPicAndAttachToBanner();
    }

    else {
      print('attachment type is ${attachmentType.toString()}');
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _takeGalleryPicAndAttachToBanner() async {
    File _pic = await Imagers.takeGalleryPicture(PicType.slideHighRes);

    print('pic is : $_pic');

    ImageSize _picSize = await ImageSize.superImageSize(_pic);

    print('_picSize is : W ${_picSize.width} x H ${_picSize.height}');

    double _picViewHeight = Imagers.concludeHeightByGraphicSizes(
      width: NotificationCard.bodyWidth(context),
      graphicWidth: _picSize.width,
      graphicHeight: _picSize.height,
    );

    await Nav.goBack(context);

    if (_pic != null){
      setState(() {
        _attachmentType = NotiAttachmentType.banner;
        _attachment = _pic;
        _bannerHeight = _picViewHeight;
      });
    }

  }
// -----------------------------------------------------------------------------
  void _onDeleteAttachment(){
    setState(() {
      _attachment = null;
      _attachmentType = null;
    });
  }
// -----------------------------------------------------------------------------
  bool _sendFCMIsOn = false;
  void _onSwitchSendFCM(bool val){
    print('send fcm val is : $val');
    setState(() {
      _sendFCMIsOn = val;
    });
  }
// -----------------------------------------------------------------------------
  Future<void> _onTapReciever() async {

    double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.85);

    double _dialogClearWidth = BottomDialog.dialogClearWidth(context);
    double _dialogClearHeight = BottomDialog.dialogClearHeight(
      context: context,
      draggable: true,
      titleIsOn: true,
      overridingDialogHeight: _dialogHeight,
    );
    double _textFieldHeight = 70;

    List<UserModel> _usersModels = [];

    await BottomDialog.showStatefulBottomDialog(
      context: context,
      draggable: true,
      title: 'Search for a user',
      height: _dialogHeight,
      builder: (ctx, title){
        return StatefulBuilder(
          builder: (xxx, setDialogState){

            return
              Column(
                children: <Widget>[

                  /// USER NAME TEXT FIELD
                  Container(
                    width: _dialogClearWidth,
                    height: _textFieldHeight,
                    child: SuperTextField(
                      height: _textFieldHeight,
                      inputSize: 2,
                      textController: _userNameController,
                      inputColor: Colorz.White255,
                      hintText: 'user name ...',
                      keyboardTextInputType: TextInputType.multiline,
                      maxLength: 30,
                      maxLines: 2,
                      counterIsOn: true,
                      fieldIsFormField: true,
                      keyboardTextInputAction: TextInputAction.search,
                      onSubmitted: (String val) async {
                        print('submitted : val : $val');

                        List<UserModel> _resultUsers = await FireSearch.usersByUserName(
                          context: context,
                          compareValue: val,
                        );

                        if (_resultUsers == []){
                          print('result is null, no result found');
                        }
                        else {
                          print('_result found : ${_resultUsers.length} matches');


                          setDialogState(() {
                            _usersModels = _resultUsers;
                          });

                        }

                      },

                    ),
                  ),

                  Container(
                    width: _dialogClearWidth,
                    height: _dialogClearHeight - _textFieldHeight,
                    child: GoHomeOnMaxBounce(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: Ratioz.horizon),
                          itemCount: _usersModels.length,
                          itemBuilder: (xyz, index){
                            return

                              _usersModels == [] ?

                              Container(
                                width: _dialogClearWidth,
                                height: 70,
                                child: SuperVerse(
                                  verse: 'No match found',
                                  size: 1,
                                  weight: VerseWeight.thin,
                                  italic: true,
                                  color: Colorz.White30,
                                ),
                              )

                                  :

                              Row(
                                children: <Widget>[

                                  dashboardUserButton(
                                      width: _dialogClearWidth - dashboardUserButton.height() ,
                                      userModel: _usersModels[index],
                                      index: index,
                                      onDeleteUser: null
                                  ),

                                  Container(
                                    height: dashboardUserButton.height(),
                                    width: dashboardUserButton.height(),
                                    alignment: Alignment.center,
                                    child: DreamBox(
                                      height: 50,
                                      width: 50,
                                      icon: Iconz.Check,
                                      iconSizeFactor: 0.5,
                                      iconColor: Colorz.White50,
                                      onTap: (){print('fuck you');},
                                    ),
                                  )

                                ],
                              );


                          }
                      ),
                    ),
                  ),

                ],
              );
          }
        );
        },

    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _screenHeight = Scale.superScreenHeight(context);
    double _screenWidth = Scale.superScreenWidth(context);

    double _bodyWidth = NotificationCard.bodyWidth(context);

    return DashBoardLayout(
      loading: _loading,
        pageTitle: 'Notification Maker',
        listWidgets: <Widget>[

          /// TIME STAMP
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            child: SuperVerse(
              verse: '${Timers.stringOnDateMonthYear(context: context, time: DateTime.now())}', /// task : fix timestamp parsing
              color: Colorz.Grey225,
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
            margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin, vertical: Ratioz.appBarPadding),
            columnChildren: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(
                    width: Ratioz.appBarMargin,
                    height: Ratioz.appBarMargin,
                  ),

                  /// NOTIFICATION CONTENT
                  Container(
                    width: _bodyWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        /// TITLE
                        SuperTextField(
                          height: 80,
                          inputSize: 2,
                          textController: _titleController,
                          inputColor: Colorz.White255,
                          hintText: 'Title',
                          keyboardTextInputType: TextInputType.multiline,
                          maxLength: 30,
                          maxLines: 2,
                          counterIsOn: true,
                          fieldIsFormField: true,
                          // validator: (){}, // TASK : question body must include question mark '?'
                        ),

                        /// SPACER
                        SizedBox(
                          width: Ratioz.appBarMargin,
                          height: Ratioz.appBarMargin,
                        ),

                        /// BODY
                        SuperTextField(
                          textController: _bodyController,
                          inputColor: Colorz.White255,
                          hintText: 'body',
                          keyboardTextInputType: TextInputType.multiline,
                          maxLength: 80,
                          maxLines: 10,
                          counterIsOn: true,
                          inputWeight: VerseWeight.thin,
                          fieldIsFormField: true,
                          // validator: (){}, // TASK : question body must include question mark '?'
                        ),

                        /// SPACER
                        SizedBox(
                          width: Ratioz.appBarPadding,
                          height: Ratioz.appBarPadding,
                        ),

                        if (_attachment == null)
                        Container(
                          width: _bodyWidth,
                          height: 60,
                          alignment: Aligners.superInverseCenterAlignment(context),
                          child: DreamBox(
                            height: 50,
                            verse: 'Add Attachment',
                            verseScaleFactor: 0.6,
                            onTap: _onAddAttachment,
                          ),
                        ),

                        /// BANNER
                        if(_attachment != null && _attachmentType == NotiAttachmentType.banner)
                          NotiBannerEditor(
                              width: _bodyWidth,
                              height: _bannerHeight,
                              attachment: _attachment,
                              onDelete: _onDeleteAttachment,
                          ),

                        /// BUTTONS
                        if(_attachment != null && _attachmentType == NotiAttachmentType.buttons && _attachment is List<String>)
                          Container(
                            width: _bodyWidth,
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                ...List.generate(_attachment.length,
                                        (index){

                                      double _width = (_bodyWidth - ((_attachment.length + 1) * Ratioz.appBarMargin) ) / (_attachment.length);

                                      return
                                        DreamBox(
                                          width: _width,
                                          height: 60,
                                          verse: _attachment[index],
                                          verseScaleFactor: 0.7,
                                          color: Colorz.Blue80,
                                          splashColor: Colorz.Yellow255,
                                          // onTap: () => _onButtonTap(notiModel.attachment[index]),
                                        );

                                    }
                                ),

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
            secondLine: 'This sends firebase cloud message to the receiver or to a group of receivers through a channel',
            icon: Iconz.News,
            iconSizeFactor: 0.5,
            verseColor: Colorz.White255,
            iconBoxColor: Colorz.Grey50,
            switchIsOn: _sendFCMIsOn,
            switching: (bool val) => _onSwitchSendFCM(val),
          ),

          /// USER SELECTOR
          TileBubble(
            verse: 'Reciever',
            secondLine: 'Choose who to send this notification to',
            icon: Iconz.NormalUser,
            iconSizeFactor: 0.5,
            verseColor: Colorz.White255,
            iconBoxColor: Colorz.Grey50,
            btOnTap: _onTapReciever,
          ),

        ],
    );
  }
}
