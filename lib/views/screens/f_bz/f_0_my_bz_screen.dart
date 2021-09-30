import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/views/widgets/specific/bz/tabs/bz_about_tab.dart';
import 'package:bldrs/views/widgets/specific/bz/appbar/bz_app_bar.dart';
import 'package:bldrs/views/widgets/specific/bz/tabs/bz_flyers_tab.dart';
import 'package:bldrs/views/widgets/specific/bz/tabs/bz_powers_tab.dart';
import 'package:bldrs/views/widgets/specific/bz/tabs/bz_targets_tab.dart';
import 'package:bldrs/views/widgets/general/layouts/tab_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBzScreen extends StatefulWidget {
  final TinyBz tinyBz;
  final UserModel userModel;

  MyBzScreen({
    @required this.tinyBz,
    @required this.userModel,
  });

  @override
  _MyBzScreenState createState() => _MyBzScreenState();

}

class _MyBzScreenState extends State<MyBzScreen> with SingleTickerProviderStateMixin {
  // bool _showOldFlyers;
  BzModel _bzModel;
  // double _bubblesOpacity = 0;
  TabController _tabController;
  int _currentTabIndex = 0;
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
    print('1 - we got temp bzModel');

    _bzModel = BzModel.getTempBzModelFromTinyBz(widget.tinyBz);
    // _showOldFlyers = false;

    // TODO: implement initState

    _tabModels = createBzTabModels();

    _tabController = TabController(vsync: this, length: BzModel.bzPagesTabsTitles.length);

    _tabController.addListener(() async {
      _onChangeTab(_tabController.index);
    });

    _tabController.animation
      ..addListener(() {
        if(_tabController.indexIsChanging == false){
          _onChangeTab((_tabController.animation.value).round());
        }
      });


  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {

        print('2 - retrieving bzModel from firebase');
        BzModel _bzFromDB = await BzOps.readBzOps(context: context, bzID: widget.tinyBz.bzID);
        print('3 - got the bzModel');
        // setState(() {
        // _bzModel = _bzFromDB;
        // _bubblesOpacity = 1;
        // });
        print('4 - rebuilt tree with the retrieved bzModel');

        FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
        _prof.setCurrentBzModel(_bzFromDB);

        /// X - REBUILD : TASK : check previous set states malhomsh lazma keda ba2a
        _triggerLoading(
            function: (){
              _bzModel = _bzFromDB;
              // _bubblesOpacity = 1;
              _tabModels = createBzTabModels();
            }
        );

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  List<TabModel> _tabModels = [];
  List<TabModel> createBzTabModels(){
    List<TabModel> _models = <TabModel>[

      /// 0 : Flyers
      BzFlyersTab.flyersTabModel(
        bzModel: _bzModel,
        isSelected: BzModel.bzPagesTabsTitles[_currentTabIndex] == BzModel.bzPagesTabsTitles[0],
        onChangeTab: (int index) => _onChangeTab(index),
        tabIndex: 0,
      ),

      /// 1 : ABOUT
      BzAboutTab.aboutTabModel(
        bzModel: _bzModel,
        isSelected: BzModel.bzPagesTabsTitles[_currentTabIndex] == BzModel.bzPagesTabsTitles[1],
        onChangeTab: (int index) => _onChangeTab(index),
        tabIndex: 1,
      ),

      /// 2 : Targets
      BzTargetsTab.targetsTabModel(
        bzModel: _bzModel,
        isSelected: BzModel.bzPagesTabsTitles[_currentTabIndex] == BzModel.bzPagesTabsTitles[2],
        onChangeTab: (int index) => _onChangeTab(index),
        tabIndex: 2,
      ),

      /// 3 : Powers
      BzPowersTab.powersTabModel(
        bzModel: _bzModel,
        isSelected: BzModel.bzPagesTabsTitles[_currentTabIndex] == BzModel.bzPagesTabsTitles[3],
        onChangeTab: (int index) => _onChangeTab(index),
        tabIndex: 3,
      ),

    ];


    return _models;
  }
// -----------------------------------------------------------------------------
  Future<void> _onChangeTab(int index) async {

    setState(() {
      _currentTabIndex = index;
      _tabModels = createBzTabModels();
    });

    _tabController.animateTo(index, curve: Curves.easeIn, duration: Ratioz.duration150ms);

  }
// -----------------------------------------------------------------------------
    @override
  Widget build(BuildContext context) {

    return TabLayout(
      tabModels: _tabModels,
      tabController: _tabController,
      currentIndex: _currentTabIndex,
      appBarRowWidgets: <Widget>[
        BzAppBar(
          bzModel: _bzModel,
          userModel: widget.userModel,
        ),
      ], //bzPageAppBarWidgets(),
    );

  }

}




















