import 'package:bldrs/models/planet/area_model.dart';
import 'package:bldrs/models/planet/country_model.dart';
import 'package:bldrs/models/planet/province_model.dart';
import 'package:bldrs/view_brains/controllers/streamerz.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/texters.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersManagerScreen extends StatefulWidget {

  @override
  _UsersManagerScreenState createState() => _UsersManagerScreenState();
}

class _UsersManagerScreenState extends State<UsersManagerScreen> {
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING') : print('LOADING COMPLETE');
  }
// ---------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _screenWidth = superScreenWidth(context);
    double _screenHeight = superScreenHeight(context);

    return DashBoardLayout(
      loading: _loading,
      pageTitle: 'Users Manager',
      listWidgets: <Widget>[

        DreamBox(
          height: 50,
          width: 200,
          verse: 'trigger loading',
          boxFunction: _triggerLoading,
        ),

      ],
    );
  }
}
