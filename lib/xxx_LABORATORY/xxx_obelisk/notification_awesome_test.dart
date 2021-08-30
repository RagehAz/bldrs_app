import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/layouts/test_layout.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class AwesomeNotificationTest extends StatefulWidget {


  @override
  _AwesomeNotificationTestState createState() => _AwesomeNotificationTestState();
}

class _AwesomeNotificationTestState extends State<AwesomeNotificationTest> {
  //var vibrationPattern = new Int64List.fromList([1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000]);
// -----------------------------------------------------------------------------

  AwesomeNotifications _awesomeNotification;

  @override
  void initState() {

    _awesomeNotification = AwesomeNotifications();

    _awesomeNotification.isNotificationAllowed().then((isAllowed) async {
      if(isAllowed == false){

        bool _result = await CenterDialog.superDialog(
          context: context,
          title: 'Allow notifications',
          body: 'To be able to know what is going on',
          boolDialog: true,
        );

        if (_result == true){
          await _awesomeNotification.requestPermissionToSendNotifications();
        }

        await Nav.goBack(context);

      }
    });


    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return TestLayout(
        screenTitle: 'Awesome notification test',
        appbarButtonVerse: 'button',
        appbarButtonOnTap: (){

        },
        listViewWidgets: <Widget>[

          DreamBox(
            height: 40,
            width: 250,
            verse: 'some button',
          ),

        ],
    );
  }
}
