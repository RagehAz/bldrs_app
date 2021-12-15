import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/components/expander.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/e_db/fire/methods/cloud_functions.dart' as CloudFunctionz;
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/scrollers.dart' as Scrollers;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/widgets/user_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersManagerScreen extends StatefulWidget {
  const UsersManagerScreen({Key key}) : super(key: key);

  @override
  _UsersManagerScreenState createState() => _UsersManagerScreenState();
}

class _UsersManagerScreenState extends State<UsersManagerScreen> {
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
    super.initState();
  }

  // -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading(function: () {}).then((_) async {
        /// ---------------------------------------------------------0

        await _readMoreUsers();

        /// ---------------------------------------------------------0
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

// -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
// -----------------------------------------------------------------------------
  QueryDocumentSnapshot<Object> _lastSnapshot;
  final List<UserModel> _usersModels = <UserModel>[];
  Future<void> _readMoreUsers() async {
    final List<dynamic> _maps = await Fire.readCollectionDocs(
      collName: FireColl.users,
      orderBy: 'id',
      limit: 5,
      startAfter: _lastSnapshot,
      addDocSnapshotToEachMap: true,
    );

    final List<UserModel> _fetchedModel = UserModel.decipherUsersMaps(
      maps: _maps,
      fromJSON: false,
    );

    setState(() {
      _lastSnapshot = _maps[_maps.length - 1]['docSnapshot'];
      _usersModels.addAll(_fetchedModel);
    });

    await Future<void>.delayed(const Duration(milliseconds: 400), () async {
      await Scrollers.scrollToBottom(controller: _scrollController);
    });
  }

// -----------------------------------------------------------------------------
  Future<void> _onDeleteUser(UserModel userModel) async {
    final String _result =
        await CloudFunctionz.deleteFirebaseUser(userID: userModel.id);

    if (_result == 'stop') {
      blog('operation stopped');
    } else if (_result == 'deleted') {
      final int _userIndex =
          _usersModels.indexWhere((UserModel user) => user.id == userModel.id);
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
      appBarType: AppBarType.basic,
      pyramids: Iconz.dvBlankSVG,
      skyType: SkyType.black,
      appBarRowWidgets: <Widget>[
        const Expander(),
        DreamBox(
          width: 150,
          height: 40,
          verse: 'Load More',
          secondLine: 'showing ${_usersModels.length} users',
          verseScaleFactor: 0.7,
          secondLineScaleFactor: 0.9,
          margins: const EdgeInsets.symmetric(horizontal: 5),
          onTap: () async {
            await _readMoreUsers();
          },
        ),
      ],
      layoutWidget: ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: _usersModels.length,
        padding: const EdgeInsets.only(
            bottom: Ratioz.grandHorizon, top: Ratioz.stratosphere),
        itemExtent: 70,
        itemBuilder: (BuildContext context, int index) {
          return DashboardUserButton(
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
