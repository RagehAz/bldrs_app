import 'dart:async';

import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/helpers/theme/colorz.dart';
import 'package:bldrs/helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/continent_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/user_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
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
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

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

    }

    _loading == true?
    blog('LOADING--------------------------------------') : blog('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _scrollController = ScrollController();

    _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async{

        /// do Futures here
        unawaited(
            _triggerLoading(
                function: (){
                  /// set new values here
                }
            )
        );

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
    final Stream<UserModel> _myUserModelStream = _usersProvider?.myUserModelStream;
    final ZoneModel _currentZone = _zoneProvider?.currentZone;
    final Continent _currentContinent = _zoneProvider?.currentContinent;
    final CountryModel _currentCountry = _zoneProvider?.currentCountry;
    final CityModel _currentCity = _zoneProvider?.currentCity;

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramids: Iconz.pyramidzYellow,
      loading: _loading,
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

                  }
              ),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _myUserModelStream',
                  icon: Iconizer.valueIsNotNull(_myUserModelStream),
                  onTap: () async {

                    unawaited(_triggerLoading());

                    final UserModel _userModelFromStream = await _myUserModelStream.first;

                    _userModelFromStream.printUserModel();

                    unawaited(_triggerLoading());

                  }
              ),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _currentZone',
                  icon: Iconizer.valueIsNotNull(_currentZone),
                  onTap: () async {

                    unawaited(_triggerLoading());

                    _currentZone.printZone();

                    unawaited(_triggerLoading());

                  }
              ),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _currentContinent',
                  icon: Iconizer.valueIsNotNull(_currentContinent),
                  onTap: () async {

                    unawaited(_triggerLoading());

                    _currentContinent.printContinent();

                    unawaited(_triggerLoading());

                  }
              ),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _currentCountry',
                  icon: Iconizer.valueIsNotNull(_currentCountry),
                  onTap: () async {

                    unawaited(_triggerLoading());

                    _currentCountry.printCountry();

                    unawaited(_triggerLoading());

                  }
              ),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _currentCity',
                  icon: Iconizer.valueIsNotNull(_currentCity),
                  onTap: () async {

                    unawaited(_triggerLoading());

                    _currentCity.printCity();

                    unawaited(_triggerLoading());

                  }
              ),

            ],
          ),
        ),
      ),
    );
  }


}
