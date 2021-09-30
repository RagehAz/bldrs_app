import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/notifications/bldrs_notiz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/specific/notifications/notification_card.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class NotificationTemplatesScreen extends StatefulWidget {
  @override
  _NotificationTemplatesScreenState createState() => _NotificationTemplatesScreenState();
}

class _NotificationTemplatesScreenState extends State<NotificationTemplatesScreen> {
  List<dynamic> _notifications = [];
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
    _notifications.addAll(BldrsNotiModelz.allNotifications());
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

      if (_loading == true){
        _triggerLoading();
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  void _dismissNotification(String id){

    print('removing noti with id : $id');

    setState(() {
      _notifications.removeWhere((notiModel) => notiModel.id == id,);
    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    return MainLayout(
      appBarType: AppBarType.Basic,
      tappingRageh: () async {

        bool upload = await CenterDialog.showCenterDialog(
          context: context,
          title: 'Upload ?',
          body: 'upload all these local templates ?',
          boolDialog: true,
        );

        if (upload == true){
          print('uploading aho');


        }

      },
      appBarRowWidgets: <Widget>[

        const Expander(),

        DreamBox(
          width: 40,
          height: 40,
          iconSizeFactor: 0.5,
          icon: Iconz.Clock,
          color: Colorz.Blue20,
          corners: Borderers.superBorderAll(context, Ratioz.appBarButtonCorner),
          margins: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          onTap: (){
            print('to dismissed notifications');
          },
        ),

      ],
      loading: _loading,
      pageTitle: 'News & Notifications',
      sky: Sky.Black,
      pyramids: Iconz.PyramidzYellow,
      layoutWidget:

      _notifications.length == 0 ?
      Center(
        child: SuperVerse(
          verse: 'No new Notifications',
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.White20,
        ),
      )

          :

      ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        addAutomaticKeepAlives: true,
        itemCount: _notifications.length,
        padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
        itemBuilder: (ctx, index){

          final NotiModel _notiModel = _notifications[index];

          return Dismissible(
            // onResize: (){
            // print('resizing');
            // },
            // background: Container(
            //   alignment: Aligners.superCenterAlignment(context),
            //   // color: Colorz.White10,
            //   child: SuperVerse(
            //     verse: 'Dismiss -->',
            //     size: 2,
            //     weight: VerseWeight.thin,
            //     italic: true,
            //     color: Colorz.White10,
            //   ),
            // ),
            // behavior: HitTestBehavior.translucent,
            // secondaryBackground: Container(
            //   width: _screenWidth,
            //   height: 50,
            //   color: Colorz.BloodTest,
            // ),
            // dismissThresholds: {
            //   DismissDirection.down : 10,
            //   DismissDirection.endToStart : 20,
            // },
            // dragStartBehavior: DragStartBehavior.start,
            key: ValueKey<String>(_notiModel.id),
            crossAxisEndOffset: 0,
            direction: DismissDirection.horizontal,
            movementDuration: Duration(milliseconds: 250),
            resizeDuration: Duration(milliseconds: 250),
            confirmDismiss: (DismissDirection direction) async {
              // print('confirmDismiss : direction is : $direction');

              /// if needed to make the bubble un-dismissible set to false
              bool _dismissible = true;

              return _dismissible;
            },
            onDismissed: (DismissDirection direction){
              _dismissNotification(_notiModel.id);
              // print('onDismissed : direction is : $direction');
            },
            child: Container(
              width: _screenWidth,
              decoration: BoxDecoration(
                borderRadius: Borderers.superBorderAll(context, Bubble.cornersValue + Ratioz.appBarMargin),
                // color: Colorz.BloodTest,
              ),
              child: NotificationCard(
                notiModel: _notiModel,
              ),
            ),
          );

        },


      ),

    );
  }
}
