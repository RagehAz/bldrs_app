import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_0_my_bz_screen_view.dart';
import 'package:bldrs/b_views/z_components/bz_profile/appbar/bz_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/f_my_bz_screen_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBzScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreen({
    @required this.bzModel,
    Key key
  }) : super(key: key);

  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  _MyBzScreenState createState() => _MyBzScreenState();
/// --------------------------------------------------------------------------
}

class _MyBzScreenState extends State<MyBzScreen> with SingleTickerProviderStateMixin {
// -----------------------------------------------------------------------------
  TabController _tabController;
  UiProvider _uiProvider;
  BzzProvider _bzzProvider;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

    _tabController = TabController(
      vsync: this,
      length: BzModel.bzPagesTabsTitlesInEnglishOnly.length,
      initialIndex: getInitialMyBzScreenTabIndex(context),
    );

    _tabController.animation.addListener(
            () => onChangeMyBzScreenTabIndexWhileAnimation(
          context: context,
          tabController: _tabController,
        )
    );

    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _uiProvider.startController(
              () async {

                _uiProvider.triggerLoading(
                  setLoadingTo: true,
                  notify: true,
                  callerName: 'MyBzScreen didChangeDependencies',
                );

                final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

                /// GET BZ COUNTRY
                final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(
                  context: context,
                  countryID: widget.bzModel.zone.countryID,
                );

                /// GET BZ CITY
                final CityModel _bzCity = await _zoneProvider.fetchCityByID(
                  context: context,
                  cityID: widget.bzModel.zone.cityID,
                );

                /// SET ACTIVE BZ
                _bzzProvider.setActiveBz(
                  bzModel: widget.bzModel,
                  bzCountry: _bzCountry,
                  bzCity: _bzCity,
                  notify: false,
                );

                /// SET ACTIVE BZ FLYERS
                await _bzzProvider.getsetActiveBzFlyers(
                  context: context,
                  bzID: widget.bzModel.id,
                  notify: true,
                );

                _uiProvider.triggerLoading(
                  setLoadingTo: false,
                  callerName: 'MyBzScreen didChangeDependencies',
                  notify: true,
                );

              }
      );

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
  Future<void> _onBack() async {
    _bzzProvider.clearActiveBzFlyers(notify: false);
    _bzzProvider.clearMyActiveBz(notify: false);
    goBack(context);
  }
// -----------------------------------------------------------------------------
  bool _canBuild(BuildContext context){

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: true);

    final BzModel _bzModel = _bzzProvider.myActiveBz;
    final CountryModel _bzCountry = _bzzProvider.myActiveBzCountry;
    final CityModel _bzCity = _bzzProvider.myActiveBzCity;
    final List<FlyerModel> _bzFlyers = _bzzProvider.myActiveBzFlyers;
    final bool _isLoading =  _uiProvider.isLoading;

    // blog('MyBzScreen : BUILDING WITH : ${_bzFlyers.length} flyers');
    // FlyerModel.blogFlyers(
    //   flyers: _bzFlyers,
    //   methodName: 'my bz screen : [_canBuild method]',
    // );

    if (
    _bzModel != null
    &&
    _bzCountry != null
    &&
    _bzCity != null
    &&
    _bzFlyers != null
    &&
    _isLoading == false
    ){
      return true;
    }

    else {
      return false;
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _canBuildWidgets = _canBuild(context);

    return MainLayout(
      key: ValueKey('my_bz_screen_${widget.bzModel.id}'),
        appBarType: AppBarType.basic,
        skyType: SkyType.black,
        pyramidsAreOn: true,
        sectionButtonIsOn: false,
        zoneButtonIsOn: false,
        onBack: _onBack,
        appBarRowWidgets: <Widget>[
          if (_canBuildWidgets == true)
            const BzAppBar(),
        ],
        layoutWidget:
        _canBuildWidgets == true ?
        MyBzScreenView(
          tabController: _tabController,
        )
            :
        const SizedBox()

    );

  }
}
