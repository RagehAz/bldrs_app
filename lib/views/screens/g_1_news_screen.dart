import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/notifications/bldrs_notiz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/views/widgets/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/notifications/notification_card.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<dynamic> _notifications = BldrsNotiModelz.allNotifications();
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

      if (_loading == true){
        _triggerLoading();
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);

    return MainLayout(
      appBarType: AppBarType.Basic,
      appBarRowWidgets: [],
      loading: _loading,
      pageTitle: 'News & Notifications',
      sky: Sky.Black,
      pyramids: Iconz.PyramidzYellow,
      layoutWidget: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: ScrollController(),
        addAutomaticKeepAlives: true,
        itemCount: _notifications.length,
        padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
        itemBuilder: (ctx, index){

          NotiModel _notiModel = _notifications[index];

          return Dismissible(
            key: ValueKey<String>(_notiModel.body),
            background: Container(
              alignment: Aligners.superCenterAlignment(context),
              // color: Colorz.White10,
              child: SuperVerse(
                verse: 'Dismiss -->',
                size: 2,
                weight: VerseWeight.thin,
                italic: true,
                color: Colorz.White10,
              ),
            ),
            // behavior: HitTestBehavior.translucent,
            confirmDismiss: (DismissDirection direction) async {
              print('confirmDismiss : direction is : $direction');
              return true;
            },
            crossAxisEndOffset: 0,
            direction: DismissDirection.startToEnd,
            movementDuration: Duration(milliseconds: 500),
            onDismissed: (DismissDirection direction){
              print('onDismissed : direction is : $direction');
            },
            onResize: (){
              print('resizing');
            },
            resizeDuration: Duration(milliseconds: 500),
            secondaryBackground: Container(
              width: _screenWidth,
              height: 50,
              color: Colorz.BloodTest,
            ),
            // dismissThresholds: {
            //   DismissDirection.down : 10,
            //   DismissDirection.endToStart : 20,
            // },
            // dragStartBehavior: DragStartBehavior.start,
            child: Container(
              width: _screenWidth,
              decoration: BoxDecoration(
                borderRadius: Borderers.superBorderAll(context, Bubble.cornersValue() + Ratioz.appBarMargin),
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
