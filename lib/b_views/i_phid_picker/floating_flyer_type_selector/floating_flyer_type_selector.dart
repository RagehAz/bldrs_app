import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/b_city_phids_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/b_animated_logo_screen.dart';
import 'package:bldrs/b_views/i_phid_picker/floating_flyer_type_selector/animated_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class FloatingFlyerTypeSelector extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FloatingFlyerTypeSelector({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _FloatingFlyerTypeSelectorState createState() => _FloatingFlyerTypeSelectorState();
/// --------------------------------------------------------------------------
}

class _FloatingFlyerTypeSelectorState extends State<FloatingFlyerTypeSelector> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  List<CurvedAnimation> _linesControllers = <CurvedAnimation>[];
  AnimationController _logoAniController;
  List<Map<String, dynamic>> _linesMap = <Map<String, dynamic>>[];
  final Tween<double> _tween = Tween<double>(begin: 0, end: 1);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

      final CityPhidsModel _cityPhidsModel = ChainsProvider.proGetCityPhids(
          context: context,
          listen: false,
      );

      _cityPhidsModel?.blogCityPhidsModel(invoker: 'floating shit');

      final List<Chain> _bldrsChains = ChainsProvider.proGetBldrsChains(
          context: context,
          onlyUseCityChains: true,
          listen: false,
      );

      final List<FlyerType> _flyerTypes = CityPhidsModel.getFlyerTypesByCityPhids(
          cityPhidsModel: _cityPhidsModel,
          bldrsChains: _bldrsChains,
      );

      blog('_flyerTypes : $_flyerTypes');

    _linesMap = <Map<String, dynamic>>[
      ...List.generate(_flyerTypes.length, (index){

        final FlyerType _flyerType = _flyerTypes[index];

        blog('flyerType : $_flyerType');

        return AnimatedLogoScreen.createBeat(
          text: FlyerTyper.cipherFlyerType(_flyerType),
          start: index * 150.0,
          duration: 300,
          color: Colorz.white200,
        );

      }),
    ];

    /// LOGO CONTROLLERS
    _logoAniController = AnimationController(
      duration: Duration(milliseconds: FlyerTyper.flyerTypesList.length * 300 + 150),
      reverseDuration: Duration(milliseconds: FlyerTyper.flyerTypesList.length * 200 + 150),
      vsync: this,
      // animationBehavior: AnimationBehavior.preserve,
      // lowerBound: 0,
      // upperBound: 1,
      value: 0,
    );

    _linesControllers = _initializedLinesAnimations();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        await _logoAniController.forward(from: 0);

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _logoAniController.dispose();

    if (Mapper.checkCanLoopList(_linesControllers) == true){
      for (final CurvedAnimation cont in _linesControllers){
        cont.dispose();
      }
    }

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  List<CurvedAnimation> _initializedLinesAnimations(){

    final List<CurvedAnimation> _animations = <CurvedAnimation>[];
    for (final Map<String, dynamic> map in _linesMap){
      final CurvedAnimation _curvedAni = CurvedAnimation(
        parent: _logoAniController,
        curve: Interval(map['first'], map['second'], curve: Curves.easeOut,),
        reverseCurve: Interval(map['first'], map['second'], curve: Curves.easeOut,),
      );
      _animations.add(_curvedAni);
    }

    return _animations;
  }
  // -----------------------------------------------------------------------------
  Future<void> _exit({
    @required BuildContext context,
    @required FlyerType flyerType,
  }) async {

    blog('TAPPED ON $flyerType');

    await _logoAniController.reverse();
    await Nav.goBack(
      context: context,
      passedData: flyerType,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SafeArea(
      child: Material(
        color: Colorz.nothing,
        child: GestureDetector(
          onTap: () => _exit(
              context: context,
              flyerType: null,
            ),
          child: DismissiblePage(
            onDismissed: () => Nav.goBack(
                context: context,
              ),
            direction: DismissiblePageDismissDirection.endToStart,
            startingOpacity: 0.5,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  ...List.generate(_linesControllers.length, (index){

                    final FlyerType _flyerType = FlyerTyper.decipherFlyerType(_linesMap[index]['verse']);
                    final String _phid = FlyerTyper.getFlyerTypePhid(flyerType: _flyerType);
                    final String _translation = Verse.transBake(context, _phid);

                    return AnimatedBar(
                      curvedAnimation: _linesControllers[index],
                      tween: _tween,
                      text: _translation,
                      verseColor: _linesMap[index]['color'],
                      onTap: () => _exit(
                        context: context,
                        flyerType: _flyerType,
                      ),
                      icon: FlyerTyper.flyerTypeIcon(flyerType: _flyerType, isOn: true),
                    );

                  }),

                ],

              ),
          ),
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
