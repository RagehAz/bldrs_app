import 'package:bldrs/a_models/notification/noti_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/notifications/notification_card.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/notifications/bldrs_notiz.dart' as BldrsNotiModelz;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class NotificationTemplatesScreen extends StatefulWidget {
  const NotificationTemplatesScreen({Key key}) : super(key: key);

  @override
  _NotificationTemplatesScreenState createState() =>
      _NotificationTemplatesScreenState();
}

class _NotificationTemplatesScreenState
    extends State<NotificationTemplatesScreen> {
  final List<NotiModel> _notifications = <NotiModel>[];
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
    _notifications.addAll(BldrsNotiModelz.allNotifications());
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
  void _dismissNotification(String id) {
    blog('removing noti with id : $id');

    setState(() {
      _notifications.removeWhere(
        (NotiModel notiModel) => notiModel.id == id,
      );
    });
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = Scale.superScreenWidth(context);

    return MainLayout(
      appBarType: AppBarType.basic,
      // tappingRageh: () async {
      //
      //   bool upload = await CenterDialog.showCenterDialog(
      //     context: context,
      //     title: 'Upload ?',
      //     body: 'upload all these local templates ?',
      //     boolDialog: true,
      //   );
      //
      //   if (upload == true){
      //     blog('uploading aho');
      //
      //
      //   }
      //
      // },
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
      pageTitle: 'News & Notifications',
      skyType: SkyType.black,
      pyramidsAreOn: true,
      layoutWidget: _notifications.isEmpty
          ? const Center(
              child: SuperVerse(
                verse: 'No new Notifications',
                weight: VerseWeight.thin,
                italic: true,
                color: Colorz.white20,
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              controller: ScrollController(),
              itemCount: _notifications.length,
              padding: const EdgeInsets.only(
                  top: Ratioz.stratosphere, bottom: Ratioz.horizon),
              itemBuilder: (BuildContext ctx, int index) {
                final NotiModel _notiModel = _notifications[index];

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
                  key: ValueKey<String>(_notiModel.id),
                  movementDuration: const Duration(milliseconds: 250),
                  resizeDuration: const Duration(milliseconds: 250),
                  confirmDismiss: (DismissDirection direction) async {
                    // blog('confirmDismiss : direction is : $direction');

                    /// if needed to make the bubble un-dismissible set to false
                    const bool _dismissible = true;

                    return _dismissible;
                  },
                  onDismissed: (DismissDirection direction) {
                    _dismissNotification(_notiModel.id);
                    // blog('onDismissed : direction is : $direction');
                  },
                  child: Container(
                    width: _screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: Borderers.superBorderAll(
                          context, Bubble.cornersValue + Ratioz.appBarMargin),
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
