import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/dashboard/notifications_manager/notification_maker.dart';
import 'package:bldrs/dashboard/notifications_manager/notification_templates_screen.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';

class NotificationsManager extends StatefulWidget {
  @override
  _NotificationsManagerState createState() => _NotificationsManagerState();
}

class _NotificationsManagerState extends State<NotificationsManager> {

// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
//   Future <void> _triggerLoading({Function function}) async {
//
//     if(mounted){
//
//       if (function == null){
//         setState(() {
//           _loading = !_loading;
//         });
//       }
//
//       else {
//         setState(() {
//           _loading = !_loading;
//           function();
//         });
//       }
//
//     }
//
//     _loading == true?
//     print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
//   }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    return DashBoardLayout(
      pageTitle: 'Notifications Manager',
      loading: _loading,
      listWidgets: <Widget>[

        DashboardWideButton(
            title: 'Templates',
            onTap: () => Nav.goToNewScreen(context, NotificationTemplatesScreen()),
        ),

        DashboardWideButton(
          title: 'Send to single user',
          onTap: () => Nav.goToNewScreen(context, NotificationMaker()),
        ),


      ],
    );
  }
}

