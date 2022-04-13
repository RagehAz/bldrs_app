import 'package:bldrs/f_helpers/notifications/notifications_manager/notification_maker.dart';
import 'package:bldrs/f_helpers/notifications/notifications_manager/notification_templates_screen.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class NotificationCreator extends StatefulWidget {

  const NotificationCreator({
    Key key
  }) : super(key: key);

  @override
  _NotificationCreatorState createState() => _NotificationCreatorState();
}

class _NotificationCreatorState extends State<NotificationCreator> {
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final bool _loading = false;
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
        WideButton(
          verse: 'Templates',
          onTap: () =>
              Nav.goToNewScreen(context, const NotificationTemplatesScreen()),
        ),
        WideButton(
          verse: 'Send to single user',
          onTap: () => Nav.goToNewScreen(context, const NotificationMaker()),
        ),
      ],
    );
  }
}
