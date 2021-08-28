import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class NotificationsManager extends StatefulWidget {
  @override
  _NotificationsManagerState createState() => _NotificationsManagerState();
}

class _NotificationsManagerState extends State<NotificationsManager> {

// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

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
  @override
  Widget build(BuildContext context) {
    return DashBoardLayout(
      pageTitle: 'Notifications Manager',
      loading: _loading,
      appBarRowWidgets: <Widget>[],
      listWidgets: <Widget>[

        DreamBox(
          height: 50,
          width: 200,
          verse: 'click me',
          onTap: (){},
        ),

      ],
    );
  }
}
