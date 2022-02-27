import 'package:bldrs/a_models/notification/noti_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/widgets/specific/notifications/notification_card.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/notifications/noti_ops.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // List<dynamic> _notifications = [];
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

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
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
      _triggerLoading(function: () {}).then((_) async {
        /// ---------------------------------------------------------0

        // _notiModelsAho[0].printNotiModel(methodName: 'kos omak');
        //
        // blog('ahooooooooooooooooooooooooooooooooooo : the noti fucking models are here aho : ${_notiModelsAho.toString()}');

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
  Future<void> _dismissNotification({String id, int notiModelsLength}) async {
    blog(
        'removing noti with id : $id ---------------------------------------------------------------------------------xxxxx ');

    await Fire.updateSubDocField(
      context: context,
      collName: FireColl.users,
      docName: FireAuthOps.superUserID(),
      subCollName: FireSubColl.users_user_notifications,
      subDocName: id,
      field: 'dismissed',
      input: true,
    );

    if (notiModelsLength == 1) {
      blog(
          'this was the last notification and is gone khalas --------------------------------------------------------------------------------- oooooo ');
    }

    // setState(() {
    //   _notifications.removeWhere((notiModel) => notiModel.id == id,);
    // });
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = Scale.superScreenWidth(context);

    return MainLayout(
      appBarType: AppBarType.basic,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      appBarRowWidgets: <Widget>[
        const Expander(),
        DreamBox(
          width: 40,
          height: 40,
          iconSizeFactor: 0.5,
          icon: Iconz.clock,
          color: Colorz.blue20,
          corners: Borderers.superBorderAll(context, Ratioz.appBarButtonCorner),
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          onTap: () {
            blog('to dismissed notifications');
          },
        ),
      ],
      // loading: _loading,
      pageTitle: 'News And Notifications',
      skyType: SkyType.black,
      pyramidsAreOn: true,
      // tappingRageh: () async {
      //
      //   blog('fuck fuck');
      //
      //   final UserModel _rageh = await UserFireOps.readUser(
      //     context: context,
      //     userID: superUserID(),
      //   );
      //
      //   final List<String> _tri = TextGen.createTrigram(input: _rageh.name);
      //
      //   await Fire.updateDocField(
      //     context: context,
      //     collName: FireColl.users,
      //     docName: _rageh.id,
      //     field: 'nameTrigram',
      //     input: _tri,
      //   );
      //
      //   blog('finished');
      //
      //   },

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
              userID: FireAuthOps.superUserID(),
              builder: (BuildContext ctx, List<NotiModel> notiModels) {
                blog('the shit is : notiModels : $notiModels');

                return notiModels == null || notiModels.isEmpty
                    ? Container()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: ScrollController(),
                        itemCount: notiModels?.length,
                        padding: const EdgeInsets.only(
                            top: Ratioz.stratosphere, bottom: Ratioz.horizon),
                        itemBuilder: (BuildContext ctx, int index) {
                          final NotiModel _notiModel =
                              notiModels == null ? null : notiModels[index];

                          return Dismissible(
                            // onResize: (){
                            // blog('resizing');
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
                            key: UniqueKey(),
                            movementDuration: const Duration(milliseconds: 250),
                            resizeDuration: const Duration(milliseconds: 250),
                            confirmDismiss: (DismissDirection direction) async {
                              // blog('confirmDismiss : direction is : $direction');

                              /// if needed to make the bubble un-dismissible set to false
                              const bool _dismissible = true;

                              return _dismissible;
                            },
                            onDismissed: (DismissDirection direction) async {
                              await _dismissNotification(
                                id: _notiModel.id,
                                notiModelsLength: notiModels.length,
                              );
                            },
                            child: Container(
                              width: _screenWidth,
                              decoration: BoxDecoration(
                                borderRadius: Borderers.superBorderAll(context,
                                    Bubble.cornersValue + Ratioz.appBarMargin),
                                // color: Colorz.BloodTest,
                              ),
                              child: NotificationCard(
                                notiModel: _notiModel,
                              ),
                            ),
                          );
                        },
                      );
              }),
    );
  }
}
