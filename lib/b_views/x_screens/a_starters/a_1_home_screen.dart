import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/d_zoning/d_1_select_country_screen.dart';
import 'package:bldrs/b_views/x_screens/e_saves/e_0_saved_flyers_screen.dart';
import 'package:bldrs/b_views/x_screens/f_bz/f_0_my_bz_screen.dart';
import 'package:bldrs/b_views/x_screens/g_user/g_0_user_profile_screen.dart';
import 'package:bldrs/b_views/y_views/a_starters/a_2_user_home_screen_view.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/loading_flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/o_pyramids.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/a_1_home_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HomeScreen({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _HomeScreenState createState() => _HomeScreenState();
  /// --------------------------------------------------------------------------
}

class _HomeScreenState extends State<HomeScreen> {
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// NOT disposed
  // Stream<List<NoteModel>> _receivedNotesStream;
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'HomeScreen',
    );
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
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        await initializeHomeScreen(context);

        await _triggerLoading();
      });

    _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    // if (_loading != null){_loading.dispose();}
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------

  /// PYRAMID EXPANSION

// -------------------------------------
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);
  final ValueNotifier<int> _tabIndex = ValueNotifier(null);
// -------------------------------------
  void onTriggerExpansion(){
    _isExpanded.value = !_isExpanded.value;
  }
// -----------------------------------------------------------------------------
  List<NavModel> _generateMainNavModels(){

    final List<BzModel> _bzzModels = BzzProvider.proGetMyBzz(context: context, listen: true);
    final UserModel _userModel = UsersProvider.proGetMyUserModel(context, listen: true);
    final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(context: context, listen: true);
    final String _countryFlag = Flag.getFlagIconByCountryID(_currentZone?.countryID);


    return <NavModel>[

      NavModel(
        title: '${_currentZone.cityName}, ${_currentZone.countryName}',
        icon: _countryFlag,
        screen: const SelectCountryScreen(),
        iconSizeFactor: 1,
        iconColor: Colorz.nothing,
      ),

      NavModel(
        title: _userModel.name,
        icon: _userModel.pic,
        screen: const UserProfileScreen(),
        iconSizeFactor: 1,
        iconColor: Colorz.nothing,
      ),

      NavModel(
        title: 'Saved Flyers',
        icon: Iconz.savedFlyers,
        screen: const SavedFlyersScreen(),
      ),

      // NavModel(
      //   title: 'Questions',
      //   icon: Iconz.utPlanning,
      //   screen: const QScreen(),
      // ),

      ...List.generate(_bzzModels.length, (index){

        final BzModel _bzModel = _bzzModels[index];

        return NavModel(
            title: _bzModel.name,
            icon: _bzModel.logo,
            iconSizeFactor: 1,
            iconColor: Colorz.nothing,
            screen: const MyBzScreen(),
            onNavigate: (){

              final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
              _bzzProvider.setActiveBz(bzModel: _bzModel, notify: true);

            }
            );

      }),

    ];
  }
// -----------------------------------------------------------------------------
  Future<void> onRowTap({
    @required int index,
    @required List<NavModel> models,
  }) async {

    final NavModel _navModel = models[index];

    _tabIndex.value = index;
    // onTriggerExpansion();

    await Future.delayed(const Duration(milliseconds: 50), () async {

      if (_navModel.onNavigate != null){
        await _navModel.onNavigate();
      }

      await Nav.goToNewScreen(
        context: context,
        screen: _navModel.screen,
        transitionType: PageTransitionType.fade,
      );

      onTriggerExpansion();

    });


  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<NavModel> _navModels = _generateMainNavModels();

    return MainLayout(
      key: const ValueKey<String>('mainLayout'),
      // navBarIsOn: false,
      appBarType: AppBarType.basic,
      zoneButtonIsOn: false,
      onBack: (){
        Nav.closeApp(context);
      },
      layoutWidget: Stack(
        children: <Widget>[

          ValueListenableBuilder(
            valueListenable: _loading,
            builder: (_, bool loading, Widget child){

              /// LOADING
              if (loading == true) {
                return const LoadingFlyersGrid();
              }

              /// UNKNOWN CONDITION
              else {
                return const UserHomeScreen();
              }

            },
          ),

          /// PYRAMIDS NAVIGATOR
          SuperPyramids(
            isExpanded: _isExpanded,
            onExpansion: onTriggerExpansion,
            onRowTap: (int index) => onRowTap(index: index, models: _navModels),
            tabIndex: _tabIndex,
            navModels: _navModels,
            isYellow: true,
          ),

        ],
      ),
    );

  }

}
