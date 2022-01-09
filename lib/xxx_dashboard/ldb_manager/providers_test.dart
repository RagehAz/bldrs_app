import 'dart:async';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/xxx_dashboard/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvidersTestScreen extends StatefulWidget {
  const ProvidersTestScreen({Key key}) : super(key: key);

  @override
  _ProvidersTestScreenState createState() => _ProvidersTestScreenState();
}

class _ProvidersTestScreenState extends State<ProvidersTestScreen> {
  ScrollController _scrollController;
  UsersProvider _usersProvider;
  ZoneProvider _zoneProvider;
  FlyersProvider _flyersProvider;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (mounted) {
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
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _scrollController = ScrollController();

    _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

    super.initState();
  }

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {
        /// do Futures here
        unawaited(_triggerLoading(function: () {
          /// set new values here
        }));
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
//     double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    final UserModel _myUserModel = _usersProvider?.myUserModel;
    final CountryModel _myUserCountry = _usersProvider?.myUserCountry;
    final CityModel _myUserCity = _usersProvider?.myUserCity;
    // final Stream<UserModel> _myUserModelStream = _usersProvider?.myUserModelStream;
    final ZoneModel _currentZone = _zoneProvider?.currentZone;
    final Continent _currentContinent = _zoneProvider?.currentContinent;
    final CountryModel _currentCountry = _zoneProvider?.currentCountry;
    final CityModel _currentCity = _zoneProvider?.currentCity;
    final List<FlyerModel> _promotedFlyers = _flyersProvider?.promotedFlyers;

    // final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    // final List<BzModel> _userBzz = _bzzProvider.myBzz;

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      // loading: _loading,
      appBarRowWidgets: const <Widget>[],
      layoutWidget: Center(
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            children: <Widget>[

              const Stratosphere(),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _usersProvider.myUserModel',
                  icon: Iconizer.valueIsNotNull(_myUserModel),
                  onTap: () async {
                    unawaited(_triggerLoading());

                    _myUserModel.printUserModel();

                    unawaited(_triggerLoading());
                  }),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _myUserCountry',
                  icon: Iconizer.valueIsNotNull(_myUserCountry),
                  onTap: () async {
                    unawaited(_triggerLoading());
                    _myUserCountry.blogCountry();
                    unawaited(_triggerLoading());
                  }),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _myUserCity',
                  icon: Iconizer.valueIsNotNull(_myUserCity),
                  onTap: () async {
                    unawaited(_triggerLoading());
                    _myUserCity.blogCity();
                    unawaited(_triggerLoading());
                  }),

              const BubblesSeparator(),

              // WideButton(
              //     color: Colorz.black255,
              //     verse: 'print _userBzz : ${_userBzz?.length}',
              //     icon: Iconizer.valueIsNotNull(_myUserModelStream),
              //     onTap: () async {
              //       unawaited(_triggerLoading());
              //
              //       BzModel.blogBzz(bzz: _userBzz);
              //
              //       unawaited(_triggerLoading());
              //     }),


              WideButton(
                  color: Colorz.black255,
                  verse: 'print _currentZone',
                  icon: Iconizer.valueIsNotNull(_currentZone),
                  onTap: () async {
                    unawaited(_triggerLoading());

                    _currentZone.blogZone();

                    unawaited(_triggerLoading());
                  }),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _currentContinent',
                  icon: Iconizer.valueIsNotNull(_currentContinent),
                  onTap: () async {
                    unawaited(_triggerLoading());

                    _currentContinent.printContinent();

                    unawaited(_triggerLoading());
                  }),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _currentCountry',
                  icon: Iconizer.valueIsNotNull(_currentCountry),
                  onTap: () async {
                    unawaited(_triggerLoading());

                    _currentCountry.blogCountry();

                    unawaited(_triggerLoading());
                  }),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _currentCity',
                  icon: Iconizer.valueIsNotNull(_currentCity),
                  onTap: () async {
                    unawaited(_triggerLoading());

                    _currentCity.blogCity();

                    unawaited(_triggerLoading());
                  }),

              const BubblesSeparator(),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _promotedFlyers',
                  icon: Iconizer.valueIsNotNull(_promotedFlyers),
                  onTap: () async {
                    unawaited(_triggerLoading());

                    FlyerModel.blogFlyers(_promotedFlyers);

                    unawaited(_triggerLoading());
                  }),

            ],
          ),
        ),
      ),
    );
  }
}
