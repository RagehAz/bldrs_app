import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/dashboard/widgets/user_button.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog_data_row.dart';
import 'package:bldrs/firestore/cloud_functions.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/zones/zone_provider.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/dream_wrapper.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersManagerScreen extends StatefulWidget {

  @override
  _UsersManagerScreenState createState() => _UsersManagerScreenState();
}

class _UsersManagerScreenState extends State<UsersManagerScreen> {
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

        _readMoreUsers();

        /// ---------------------------------------------------------0
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  ScrollController _scrollController = ScrollController();
// -----------------------------------------------------------------------------
  QueryDocumentSnapshot _lastSnapshot;
  List<UserModel> _usersModels = [];
  Future<void> _readMoreUsers() async {

    List<dynamic> _maps = await Fire.readCollectionDocs(
      collectionName:  FireCollection.users,
      orderBy: 'userID',
      limit: 5,
      startAfter: _lastSnapshot,
      addDocSnapshotToEachMap: true,
    );

    List<UserModel> _fetchedModel = UserModel.decipherUsersMaps(_maps);

    setState(() {
      _lastSnapshot = _maps[_maps.length - 1]['docSnapshot'];
      _usersModels.addAll(_fetchedModel);
    });


    await Future.delayed(Duration(milliseconds: 400), () async {

      await Scrollers.scrollToBottom(controller: _scrollController);

    });

  }
// -----------------------------------------------------------------------------
  Future<void> _onDeleteUser(UserModel userModel) async {

    String _result = await CloudFunctionz.deleteFirebaseUser(userID: userModel.userID);

    if (_result == 'stop'){
      print('operation stopped');
    }

    else if (_result == 'deleted'){

      int _userIndex = _usersModels.indexWhere((user) => user.userID == userModel.userID);
      setState(() {
      _usersModels.removeAt(_userIndex);
      });

    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      loading: _loading,
      pageTitle: 'Users Manager',
      appBarType: AppBarType.Basic,
      pyramids: Iconz.DvBlankSVG,
      sky: Sky.Black,
      appBarRowWidgets: <Widget>[

        Expander(),

        DreamBox(
          width: 150,
          height: 40,
          verse: 'Load More',
          secondLine: 'showing ${_usersModels.length} users',
          verseScaleFactor: 0.7,
          secondLineScaleFactor: 0.9,
          margins: EdgeInsets.symmetric(horizontal: 5),
          onTap: () async {

            await _readMoreUsers();

          },
        ),

      ],
      layoutWidget: ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: _usersModels.length,
        padding: const EdgeInsets.only(bottom: Ratioz.grandHorizon, top: Ratioz.stratosphere),
        itemExtent: 70,
        itemBuilder: (context, index){

          return
            dashboardUserButton(
              width: Scale.superScreenWidth(context) - 20,
              userModel: _usersModels[index],
              index: index,
              onDeleteUser: (UserModel userModel) => _onDeleteUser(userModel),
            );

        },
      ),

    );
  }
}