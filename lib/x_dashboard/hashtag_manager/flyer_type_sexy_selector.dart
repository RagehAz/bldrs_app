import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/b_animated_logo_screen.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
          verse: Verse.transBake(context, FlyerTyper.getFlyerTypePhid(flyerType: _flyerType)),
          start: 100.0 + (index * 40),
          duration: 100,
          color: Colorz.white200,
        );

      }),

    ];


    /// LOGO CONTROLLERS
    _logoAniController = AnimationController(
        duration: const Duration(milliseconds: 8500),
        vsync: this
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
        curve: Interval(map['first'], map['second'], curve: Curves.easeInOutExpo,),
      );
      _animations.add(_curvedAni);
    }

    return _animations;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Material(
      color: Colorz.nothing,
      child: Container(
        width: Scale.screenWidth(context),
        height: Scale.screenHeight(context),
        color: Colorz.bloodTest,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            ...List.generate(_linesControllers.length, (index){
              return AnimatedLine(
                curvedAnimation: _linesControllers[index],
                tween: _tween,
                verse: _linesMap[index]['verse'],
                verseColor: _linesMap[index]['color'],
              );
            })

          ],

        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
