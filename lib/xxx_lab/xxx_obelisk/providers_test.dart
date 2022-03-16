import 'dart:async';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
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

class _ProvidersTestScreenState extends State<ProvidersTestScreen> with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  UsersProvider _usersProvider;
  ZoneProvider _zoneProvider;
  FlyersProvider _flyersProvider;
  GeneralProvider _generalProvider;
  AnimationController _animationController;
  UiProvider _uiProvider;
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
    _generalProvider = Provider.of<GeneralProvider>(context, listen: false);

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  /// VALUE NOTIFIER
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  void _incrementCounter() {
    _counter.value += 3;
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
//     double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    final UserModel _myUserModel = _usersProvider?.myUserModel;
    final AuthModel _myAuthModel = _usersProvider?.myAuthModel;

    final CountryModel _myUserCountry = _usersProvider?.myUserCountry;
    final CityModel _myUserCity = _usersProvider?.myUserCity;
    // final Stream<UserModel> _myUserModelStream = _usersProvider?.myUserModelStream;
    final ZoneModel _currentZone = _zoneProvider?.currentZone;
    final Continent _currentContinent = _zoneProvider?.currentContinent;
    final CountryModel _currentCountry = _zoneProvider?.currentCountry;
    final CityModel _currentCity = _zoneProvider?.currentCity;
    final List<FlyerModel> _promotedFlyers = _flyersProvider?.promotedFlyers;

    final List<FlyerType> _activeSections = _generalProvider?.appState?.activeSections;

    // final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    // final List<BzModel> _userBzz = _bzzProvider.myBzz;

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      // loading: _loading,
      appBarRowWidgets: const <Widget>[],
      layoutWidget: Center(
        child: OldMaxBounceNavigator(
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

                    _myUserModel.blogUserModel();

                    unawaited(_triggerLoading());
                  }),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _usersProvider._myAuthModel',
                  icon: Iconizer.valueIsNotNull(_myAuthModel),
                  onTap: () async {
                    unawaited(_triggerLoading());

                    _myAuthModel.blogAuthModel();

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
                  verse: 'print _activeSections',
                  icon: Iconizer.valueIsNotNull(_activeSections),
                  onTap: () async {
                    unawaited(_triggerLoading());

                    blog('Active sections : $_activeSections');

                    unawaited(_triggerLoading());
                  }),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _promotedFlyers',
                  icon: Iconizer.valueIsNotNull(_promotedFlyers),
                  onTap: () async {
                    unawaited(_triggerLoading());

                    FlyerModel.blogFlyers(_promotedFlyers);

                    unawaited(_triggerLoading());
                  }),

              const BubblesSeparator(),

              /// AVOID SET STATE : WAY # 1
              ValueListenableBuilder<int>(
                  valueListenable: _counter,
                  child: Container(),
                  builder: (BuildContext ctx, int value, Widget child) {
                    return DreamBox(
                      height: 50,
                      width: 300,
                      verse: 'increment by 3 : $value',
                      verseScaleFactor: 0.6,
                      verseWeight: VerseWeight.black,
                      onTap: _incrementCounter,
                    );
                  }),

              /// AVOID SET STATE : WAY # 2
              Consumer<UiProvider>(
                builder:
                    (BuildContext ctx, UiProvider uiProvider, Widget child) {
                  final bool _loading = uiProvider.isLoading;
                  return DreamBox(
                    height: 50,
                    width: 300,
                    verse: '_loading is : $_loading',
                    verseScaleFactor: 0.6,
                    verseWeight: VerseWeight.black,
                    onTap: uiProvider.triggerLoading,
                  );
                },
              ),

              /// AVOID SET STATE : WAY # 3
              Selector<UiProvider, bool>(
                selector: (_, UiProvider uiProvider) => uiProvider.isLoading,
                builder: (BuildContext ctx, bool isLoading, Widget child){

                  return
                    DreamBox(
                      height: 50,
                      width: 300,
                      verse: 'isLoading is : $isLoading',
                      verseScaleFactor: 0.6,
                      verseWeight: VerseWeight.black,
                      onTap: () => _uiProvider.triggerLoading(),
                    );

                },
              ),

              /// Builder child pattern
              AnimatedBuilder(
                  animation: _animationController,
                  child: DreamBox(
                    height: 50,
                    width: 50,
                    verse: 'X',
                    verseScaleFactor: 0.6,
                    verseWeight: VerseWeight.black,
                    color: Colorz.bloodTest,
                    onTap: () => _animationController.forward(from: 0),
                  ),
                  builder: (BuildContext ctx, Widget child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2.0 * 3.14,
                      child: child,

                      /// passing child here will prevent its rebuilding with each tick
                    );
                  }),

              const BubblesSeparator(),

              const Stratosphere(),

            ],
          ),
        ),
      ),
    );
  }
}
