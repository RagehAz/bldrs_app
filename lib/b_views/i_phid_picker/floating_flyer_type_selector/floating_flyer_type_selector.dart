import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/b_zone_phids_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/b_animated_logo_screen.dart';
import 'package:bldrs/b_views/i_phid_picker/floating_flyer_type_selector/animated_bar.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:filers/filers.dart';
import 'package:layouts/layouts.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:numeric/numeric.dart';
import 'package:scale/scale.dart';

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
  AnimationController _animationController;
  List<Map<String, dynamic>> _linesMaps = <Map<String, dynamic>>[];
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

      final ZonePhidsModel _zonePhidsModel = ChainsProvider.proGetZonePhids(
          context: context,
          listen: false,
      );

      // _zonePhidsModel?.blogZonePhidsModel(invoker: 'floating shit');

      final List<Chain> _bldrsChains = ChainsProvider.proGetBldrsChains(
          context: context,
          onlyUseZoneChains: true,
          listen: false,
      );

      final List<FlyerType> _flyerTypes = ZonePhidsModel.getFlyerTypesByZonePhids(
          zonePhidsModel: _zonePhidsModel,
          bldrsChains: _bldrsChains,
      );

      // blog('FloatingFlyerTypeSelector init : _flyerTypes : $_flyerTypes : _zonePhidsModel : $_zonePhidsModel');

    _linesMaps = <Map<String, dynamic>>[
      ...List.generate(_flyerTypes.length, (index){

        final FlyerType _flyerType = _flyerTypes[index];

        // blog('doing flyerType : $_flyerType');

        return AnimatedLogoScreen.createBeat(
          text: FlyerTyper.cipherFlyerType(_flyerType),
          start: index * 150.0,
          duration: 300,
          color: Colorz.white200,
        );

      }),
    ];

    /// LOGO CONTROLLERS
    _animationController = AnimationController(
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

        await _animationController.forward(from: 0);

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
    _animationController.dispose();

    if (Mapper.checkCanLoopList(_linesControllers) == true){
      for (final CurvedAnimation cont in _linesControllers){
        cont.dispose();
      }
    }

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  List<CurvedAnimation> _initializedLinesAnimations(){

    final List<CurvedAnimation> _animations = <CurvedAnimation>[];
    for (final Map<String, dynamic> map in _linesMaps){
      final CurvedAnimation _curvedAni = CurvedAnimation(
        parent: _animationController,
        curve: Interval(map['first'], map['second'], curve: Curves.easeOut,),
        reverseCurve: Interval(map['first'], map['second'], curve: Curves.easeOut,),
      );
      _animations.add(_curvedAni);
    }

    return _animations;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onFlyerTypeTap({
    @required BuildContext context,
    @required FlyerType flyerType,
  }) async {

    // blog('Floating flyer type selector : onFlyerTypeTap : TAPPED ON $flyerType');

    await _animationController.reverse();
    await Nav.goBack(
      context: context,
      passedData: flyerType,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // Mapper.blogMaps(_linesMaps, invoker: 'FloatingFlyerTypeSelector');

    final double _screenWidth = Scale.screenWidth(context);

    final double hypotenuse = Numeric.pythagorasHypotenuse(
        side:_screenWidth ,
    );

    final double _ltrLeftShift =    (((hypotenuse - _screenWidth) * 0.5)
                                  + (_screenWidth * 0.5))
                                  * -1;

    final double _rtlLeftShift = _ltrLeftShift + Scale.screenWidth(context);
    final bool _appIsLTR = UiProvider.checkAppIsLeftToRight(context);
    final double _horizontalShift = _appIsLTR == true ? _ltrLeftShift : _rtlLeftShift;
    final double _verticalShift   = _ltrLeftShift;

    return SafeArea(
      child: Material(
        color: Colorz.nothing,
        child: GestureDetector(
          onTap: () => _onFlyerTypeTap(
              context: context,
              flyerType: null,
            ),
          child: DismissiblePage(
            onDismissed: () => Nav.goBack(
                context: context,
              ),
            direction: DismissiblePageDismissDirection.endToStart,
            startingOpacity: 0.5,
            minScale: 1,
            child: SizedBox(
              width: _screenWidth,
              height: Scale.screenHeight(context),
              child: Stack(
                alignment: BldrsAligners.superTopAlignment(context),
                children: <Widget>[

                  /// BACKGROUND TRIANGLE
                  Positioned(
                    top: _verticalShift,
                    left: _horizontalShift,
                    child: Transform.rotate(
                      angle: Numeric.degreeToRadian(45),
                      child: Center(
                        child: Container(
                          width:  hypotenuse,
                          height: hypotenuse,
                          color: Colorz.black200,
                        ),
                      ),
                    ),
                  ),

                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  ...List.generate(_linesControllers.length, (index){

                    final FlyerType _flyerType = FlyerTyper.decipherFlyerType(_linesMaps[index]['verse']);
                    final String _phid = FlyerTyper.getFlyerTypePhid(flyerType: _flyerType);
                    final String _translation = Verse.transBake(context, _phid);

                    return AnimatedBar(
                      curvedAnimation: _linesControllers[index],
                      tween: _tween,
                      text: _translation,
                      verseColor: _linesMaps[index]['color'],
                      onTap: () => _onFlyerTypeTap(
                        context: context,
                        flyerType: _flyerType,
                      ),
                      icon: FlyerTyper.flyerTypeIcon(
                          flyerType: _flyerType,
                          isOn: true,
                      ),
                    );

                  }),

                ],

              ),

                ],

              ),
            ),
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
