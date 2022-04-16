import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/bz_profile/appbar/bz_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_0_my_bz_screen_view.dart';
import 'package:bldrs/c_controllers/f_my_bz_screen_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
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
  TabController _tabController;
  UiProvider _uiProvider;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _uiProvider = Provider.of<UiProvider>(context, listen: false);

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

                _uiProvider.triggerLoading(setLoadingTo: true);

                final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
                final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

                final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(
                  context: context,
                  countryID: widget.bzModel.zone.countryID,
                );

                final CityModel _bzCity = await _zoneProvider.fetchCityByID(
                  context: context,
                  cityID: widget.bzModel.zone.cityID,
                );

                _bzzProvider.setActiveBz(
                  bzModel: widget.bzModel,
                  bzCountry: _bzCountry,
                  bzCity: _bzCity,
                  notify: false,
                );

                await _bzzProvider.getsetActiveBzFlyers(
                  context: context,
                  bzID: widget.bzModel.id,
                  notify: true,
                );

                _uiProvider.triggerLoading(setLoadingTo: false);

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
  @override
  Widget build(BuildContext context) {

    final bool _isLoading = _uiProvider.isLoading;

    return MainLayout(

      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidsAreOn: true,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      appBarRowWidgets: <Widget>[
        if (_isLoading == true)
        const BzAppBar(),
      ],
      layoutWidget:
      _isLoading == true ?
          const SizedBox()
      :
      MyBzScreenView(
        tabController: _tabController,
      ),

    );

  }
}
