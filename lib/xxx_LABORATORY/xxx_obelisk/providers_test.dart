import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/user_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvidersTestScreen extends StatefulWidget {

  @override
  _ProvidersTestScreenState createState() => _ProvidersTestScreenState();
}

class _ProvidersTestScreenState extends State<ProvidersTestScreen> {

  ScrollController _ScrollController;
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
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _ScrollController = new ScrollController(initialScrollOffset: 0, keepScrollOffset: true);

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

        _triggerLoading(
            function: (){
              /// set new values here
            }
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
    final Zone _currentZone = _zoneProvider?.currentZone;

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      tappingRageh: (){
        print('wtf');
      },

      appBarRowWidgets: <Widget>[

      ],

      layoutWidget: Center(
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: _ScrollController,
            children: <Widget>[

              const Stratosphere(),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _usersProvider.myUserModel',
                  icon: Iconizer.valueIsNotNull(_myUserModel),
                  onTap: () async {

                    _triggerLoading();

                    _myUserModel.printUserModel();
                    
                    _triggerLoading();

                  }
              ),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _myUserModelStream',
                  icon: Iconizer.valueIsNotNull(_myUserModelStream),
                  onTap: () async {

                    _triggerLoading();

                    UserModel _userModelFromStream = await _myUserModelStream.first;

                    _userModelFromStream.printUserModel();

                    _triggerLoading();

                  }
              ),

              WideButton(
                  color: Colorz.black255,
                  verse: 'print _currentZone',
                  icon: Iconizer.valueIsNotNull(_currentZone),
                  onTap: () async {

                    _triggerLoading();

                    _currentZone.printZone();

                    _triggerLoading();

                  }
              ),

            ],
          ),
        ),
      ),
    );
  }


}