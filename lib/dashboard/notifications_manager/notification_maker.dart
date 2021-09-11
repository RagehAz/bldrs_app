

import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_welcome_banner.dart';
import 'package:bldrs/views/widgets/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/bubbles/tile_bubble.dart';
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

  dynamic _bannerImage;
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

                String _attachmentType = TextMod.trimTextBeforeLastSpecialCharacter(_attachmentTypesList[index].toString(), '.');

                return
                  DreamBox(
                    height: 50,
                    width: BottomDialog.dialogClearWidth(context),
                    verse: _attachmentType,
                    verseScaleFactor: 0.6,
                    color: Colorz.Blue20,
                    onTap: (){
                      print(_attachmentType);
                      },
                  );

              }
          ),

        ],
      ),
    );
  }
// -----------------------------------------------------------------------------
  bool _sendFCMIsOn = false;
  void _onSendFCMSwitch(bool val){
    print('send fcm val is : $val');
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

                        /// WELCOME BANNER
                        if(_attachment != null && _attachmentType == NotiAttachmentType.banner)
                          Container(
                            width: _bodyWidth,
                            height: _bannerHeight,
                            child: ClipRRect(
                              borderRadius: Borderers.superBorderAll(context, NotificationCard.bannerCorners()),
                              child: Imagers.superImageWidget(
                                _bannerImage,
                                fit: BoxFit.fitWidth,
                                width: _bodyWidth,
                                height: _bannerHeight,
                              ),
                            ),
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
            secondLine: 'This sends firebase cloud message to the reciever',
            icon: Iconz.News,
            iconSizeFactor: 0.5,
            verseColor: Colorz.White255,
            iconBoxColor: Colorz.Grey50,
            switchIsOn: _sendFCMIsOn,
            switching: (bool val) => _onSendFCMSwitch(val),
          ),

          /// USER SELECTOR
          Bubble(
            title: 'Reciever',
            leadingIcon: Iconz.NormalUser,
            columnChildren: <Widget>[],
          ),

        ],
    );
  }
}
