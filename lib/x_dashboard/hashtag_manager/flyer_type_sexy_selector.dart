import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/b_animated_logo_screen.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/hashtag_manager/animated_bar.dart';
import 'package:flutter/material.dart';

class FlyerTypeSexySelector extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerTypeSexySelector({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _FlyerTypeSexySelectorState createState() => _FlyerTypeSexySelectorState();
/// --------------------------------------------------------------------------
}

class _FlyerTypeSexySelectorState extends State<FlyerTypeSexySelector> with TickerProviderStateMixin {

  List<CurvedAnimation> _linesControllers;
  AnimationController _logoAniController;
  List<Map<String, dynamic>> _linesMap;
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

    _linesMap = <Map<String, dynamic>>[


      ...List.generate(FlyerTyper.flyerTypesList.length, (index){

        final FlyerType _flyerType = FlyerTyper.flyerTypesList[index];

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
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SafeArea(
      child: Material(
        color: Colorz.nothing,
        child: GestureDetector(
          onTap: () => Nav.goBack(context: context),
          child: Container(
            width: Scale.screenWidth(context),
            height: Scale.screenHeight(context),
            color: Colorz.black50,
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
                    onTap: () async {

                      blog('TAPPED ON ${_linesMap[index]['verse']} n');

                      await _logoAniController.reverse();
                      await Nav.goBack(
                        context: context,
                        passedData: _flyerType,
                      );

                    },
                    icon: Iconz.bxDesignsOn,
                  );
                })

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
