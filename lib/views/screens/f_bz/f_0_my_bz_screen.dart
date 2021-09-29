import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/views/screens/f_bz/f_x_bz_editor_screen.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/specific/bz/bz_about_tab.dart';
import 'package:bldrs/views/widgets/specific/bz/bz_flyers_tab.dart';
import 'package:bldrs/views/widgets/specific/bz/bz_powers_tab.dart';
import 'package:bldrs/views/widgets/specific/bz/bz_targets_tab.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/tab_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
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
  Future<void> _deleteBzOnTap(BzModel bzModel) async {


    Nav.goBack(context);

    bool _dialogResult = await CenterDialog.showCenterDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to Delete ${_bzModel.bzName} Business account ?',
      boolDialog: true,
    );

    print(_dialogResult);

    /// if user chooses to stop ops
    if (_dialogResult == false){
      print('user cancelled ops');
    }

    /// if user chose to continue ops
    else {

      _triggerLoading();

      /// start delete bz ops
      await BzOps().superDeleteBzOps(
        context: context,
        bzModel: bzModel,
      );

      // /// remove tinyBz from Local list
      FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
      // _prof.removeTinyBzFromLocalList(_bzModel.bzID);

      /// remove tinyBz from local userTinyBzz
      _prof.removeTinyBzFromLocalUserTinyBzz(_bzModel.bzID);

      _triggerLoading();

      /// re-route back
      Nav.goBack(context, argument: true);

    }
  }
// -----------------------------------------------------------------------------
  Future<void> _deactivateBzOnTap(BzModel bzModel) async {

    /// close bottom sheet
    Nav.goBack(context);

    bool _dialogResult = await CenterDialog.showCenterDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to Deactivate ${_bzModel.bzName} Business account ?',
      boolDialog: true,
    );

    print(_dialogResult);

    /// if user chooses to cancel ops
    if (_dialogResult == false) {
      print('user cancelled ops');
    }

    /// if user chooses to continue ops
    else {

      _triggerLoading();

      /// start deactivate bz ops
      await BzOps().deactivateBzOps(
        context: context,
        bzModel: bzModel,
      );

      /// remove tinyBz from Local list
      FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
      _prof.removeTinyBzFromLocalList(_bzModel.bzID);

      /// remove tinyBz from local userTinyBzz
      _prof.removeTinyBzFromLocalUserTinyBzz(_bzModel.bzID);

      _triggerLoading();

      /// re-route back
      Nav.goBack(context, argument: true);

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _editBzOnTap(BzModel bzModel) async {
    var _result = await Navigator.push(context, new MaterialPageRoute(
      // maintainState: ,
      // settings: ,
        fullscreenDialog: true,
        builder: (BuildContext context){
          return new BzEditorScreen(
            firstTimer: false,
            userModel: widget.userModel,
            bzModel: bzModel,
          );
        }
    ));

    if (_result == true){
      setState(() {});
    }

    print(_result);
  }
// -----------------------------------------------------------------------------
  void _slideBzOptions(BuildContext context, BzModel bzModel){

    double _buttonHeight = 50;

    BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: _buttonHeight,
      buttons: <Widget>[

        // --- DELETE BZ
        DreamBox(
          height: _buttonHeight,
          width: BottomDialog.dialogClearWidth(context),
          icon: Iconz.XSmall,
          iconSizeFactor: 0.5,
          iconColor: Colorz.Red255,
          verse: 'Delete Business Account',
          verseScaleFactor: 1.2,
          verseWeight: VerseWeight.black,
          verseColor: Colorz.Red255,
          // verseWeight: VerseWeight.thin,
          onTap: () => _deleteBzOnTap(bzModel),
        ),

        // --- DEACTIVATE BZ
        DreamBox(
            height: _buttonHeight,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.XSmall,
            iconSizeFactor: 0.5,
            iconColor: Colorz.Red255,
            verse: 'Deactivate Business Account',
            verseScaleFactor: 1.2,
            verseWeight: VerseWeight.black,
            verseColor: Colorz.Red255,
            // verseWeight: VerseWeight.thin,
            onTap: () => _deactivateBzOnTap(bzModel)

        ),

        // --- EDIT BZ
        DreamBox(
          height: _buttonHeight,
          width: BottomDialog.dialogClearWidth(context),
          icon: Iconz.Gears,
          iconSizeFactor: 0.5,
          verse: 'Edit Business Account info',
          verseScaleFactor: 1.2,
          verseColor: Colorz.White255,
          onTap: () => _editBzOnTap(bzModel),
        ),

      ],

    );

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
      appBarRowWidgets: bzPageAppBarWidgets(),
    );

  }

  List<Widget> bzPageAppBarWidgets(){

    double _appBarBzButtonWidth = Scale.superScreenWidth(context) - (Ratioz.appBarMargin * 2) -
        (Ratioz.appBarButtonSize * 2) - (Ratioz.appBarPadding * 4);

    String _zoneString = TextGenerator.cityCountryStringer(context: context, zone: _bzModel.bzZone);

    return
      <Widget>[

        /// --- BZ LOGO
        DreamBox(
          height: Ratioz.appBarButtonSize,
          width: _appBarBzButtonWidth,
          icon: _bzModel.bzLogo,
          verse: '${_bzModel.bzName}',
          verseCentered: false,
          bubble: false,
          verseScaleFactor: 0.7,
          color: Colorz.White10,
          secondLine: '${TextGenerator.bzTypeSingleStringer(context, _bzModel.bzType)} $_zoneString',
          secondLineColor: Colorz.White200,
          secondLineScaleFactor: 0.8,
        ),

        /// -- SLIDE BZ ACCOUNT OPTIONS
        DreamBox(
          height: Ratioz.appBarButtonSize,
          width: Ratioz.appBarButtonSize,
          icon: Iconz.More,
          iconSizeFactor: 0.6,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          bubble: false,
          onTap:  () => _slideBzOptions(context, _bzModel),
        ),


      ];
  }

}




















