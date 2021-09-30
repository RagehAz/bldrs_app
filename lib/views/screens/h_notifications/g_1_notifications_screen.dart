import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/notifications/noti_ops.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/specific/notifications/notification_card.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // List<dynamic> _notifications = [];
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
    // _notifications.addAll(BldrsNotiModelz.allNotifications());
    super.initState();

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(function: (){}).then((_) async {
        /// ---------------------------------------------------------0


        // _notiModelsAho[0].printNotiModel(methodName: 'kos omak');
        //
        // print('ahooooooooooooooooooooooooooooooooooo : the noti fucking models are here aho : ${_notiModelsAho.toString()}');

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
  Future<void> _dismissNotification({String id, int notiModelsLength}) async {

    print('removing noti with id : $id ---------------------------------------------------------------------------------xxxxx ');

    await Fire.updateSubDocField(
      context: context,
      collName: FireCollection.users,
      docName: superUserID(),
      subCollName: FireCollection.users_user_notifications,
      subDocName: id,
      field: 'dismissed',
      input: true,
    );

    if (notiModelsLength == 1){
      print('this was the last notification and is gone khalas --------------------------------------------------------------------------------- oooooo ');
    }

    // setState(() {
    //   _notifications.removeWhere((notiModel) => notiModel.id == id,);
    // });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);

    return MainLayout(
      appBarType: AppBarType.Basic,
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
      pageTitle: 'News And Notifications',
      sky: Sky.Black,
      pyramids: Iconz.PyramidzYellow,
      tappingRageh: () async {

        print('fuck fuck');

        UserModel _rageh = await UserOps().readUserOps(
          context: context,
          userID: superUserID(),
        );

        List<String> _tri = TextMod.createTrigram(input: _rageh.name, maxTrigramLength: 15);

        await Fire.updateDocField(
          context: context,
          collName: FireCollection.users,
          docName: _rageh.userID,
          field: 'nameTrigram',
          input: _tri,
        );

        print('finished');

        },

      layoutWidget:

        // _notifications.length == 0 ?
        // Center(
        //   child: SuperVerse(
        //     verse: 'No new Notifications',
        //     weight: VerseWeight.thin,
        //     italic: true,
        //     color: Colorz.White20,
        //   ),
        // )
        //
        //     :

      notiStreamBuilder(
          context: context,
          userID: superUserID(),
          builder: (ctx, notiModels){

            print('the shit is : notiModels : $notiModels');

            return

              notiModels == null || notiModels.length == 0 ?
              Container()
                  :
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: ScrollController(),
                addAutomaticKeepAlives: true,
                itemCount: notiModels?.length,
                padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
                itemBuilder: (ctx, index){

                  NotiModel _notiModel = notiModels == null ? null : notiModels[index];

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
                    key:  UniqueKey(),//ValueKey<String>(_notiModel?.id),
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
                    onDismissed: (DismissDirection direction) async {
                      await _dismissNotification(
                        id : _notiModel.id,
                        notiModelsLength : notiModels.length,
                      );

                      },
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


              );
          }
      ),



    );
  }
}
