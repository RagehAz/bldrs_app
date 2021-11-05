import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/bzz_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/keywords_provider.dart';
import 'package:bldrs/providers/user_provider.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/general/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  List<BzModel> _sponsors;
  // bool _canContinue = false;
  double _progress = 0;
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
  void _increaseProgressTo(double percent){
    setState(() {
      _progress = percent;
    });
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // works
    // Provider.of<FlyersProvider>(context,listen: false).fetchAndSetBzz();

    // hack around
    // Future.delayed(Duration.zero).then((_){
    //   Provider.of<FlyersProvider>(context,listen: true).fetchAndSetBzz();
    // });

  }
// -----------------------------------------------------------------------------
  /// this method of fetching provided data allows listening true or false,
  /// both working one  & the one with delay above in initState does not allow listening,
  /// i will go with didChangeDependencies as init supposedly works only at start
  ///
  /// TASK : if device has no connection,, it should detect and notify me
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading();

      final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: true);
      final UserModel _userModel = _userProvider.myUserModel;

      if (FireAuthOps.userIsSignedIn() == true && _userModel != null){

        final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
        final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
        final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
        final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);

        print('x - fetching sponsors');
        _triggerLoading().then((_) async {

          await _generalProvider.getsetAppState(context);

          await _bzzProvider.fetchSponsors(context);


          setState(() {
            _sponsors = _bzzProvider.sponsors;
            _progress = 40;
          });

          await _keywordsProvider.getsetAllKeywords(context);

          print('x - fetching UserBzz');
          await _bzzProvider.fetchMyBzz(context);
          _increaseProgressTo(80);

          // TASK : should get only first 10 saved tiny flyers,, and continue paginating when entering the savedFlyers screen
          await _flyersProvider.getsetSavedFlyers(context);
          _increaseProgressTo(85);

          /// TASK : should get only first 10 followed tiny bzz, then paginate in all when entering followed bzz screen
          await _bzzProvider.fetchFollowedBzz(context);
          _increaseProgressTo(95);

          /// TASK : wallahi mana 3aref hane3mel eh hena
          final Section _currentSection = _generalProvider.currentSection;
          await _flyersProvider.getsetWallFlyersBySection(
              context: context,
              section: _currentSection,
          );
          _increaseProgressTo(99);


          _generalProvider.changeSection(context, _generalProvider.currentSection);

          setState(() {
            // _canContinue = true;
            _progress = 100;
          });

          Nav.goToRoute(context, Routez.Home);

          _triggerLoading();
        });


      } else {

        print('estanna m3ana shwaya');

      }

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {
    print('-------------- Starting Loading screen --------------');

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Non,
      loading: _loading,
      layoutWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[

          const Expander(),

          const LogoSlogan(
            showSlogan: true,
            showTagLine: false,
            sizeFactor: 0.7,
          ),

          // Stratosphere(heightFactor: 0.5),

          BzzBubble(
            bzzModels: _sponsors,
            numberOfRows: 2,
            numberOfColumns: 3,
            title: 'Sponsored by',
            scrollDirection: Axis.vertical,
            corners: Ratioz.appBarCorner * 2,
          ),

          const Expander(),

          /// PROGRESS BAR
          // if(_progress != 0)
          GestureDetector(
            onTap: () => Nav.goBackToUserChecker(context),
            child: Container(
              width: Scale.superScreenWidth(context),
              height: 3,
              color: Colorz.white80,
              alignment: Aligners.superCenterAlignment(context),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 4000),
                width: Scale.superScreenWidth(context) * _progress / 100,
                color: Colorz.yellow255,
              ),
            ),
          ),

          // const PyramidsHorizon(),
        ],
      ),
    );
  }
}
