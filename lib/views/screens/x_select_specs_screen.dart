
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/textings/data_strip.dart';
import 'package:flutter/material.dart';

class SpecSelectorScreen extends StatefulWidget {
  final FlyerType flyerType;

  SpecSelectorScreen({
    @required this.flyerType,
});

  @override
  _SpecSelectorScreenState createState() => _SpecSelectorScreenState();
}

class _SpecSelectorScreenState extends State<SpecSelectorScreen> with SingleTickerProviderStateMixin{

  ScrollController _ScrollController;
  AnimationController _animationController;

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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  /// VALUE NOTIFIER
  // ValueNotifier<int> _counter = ValueNotifier(0);
  // void _incrementCounter(){
  //   _counter.value += 3;
  // }
// -----------------------------------------------------------------------------
//   File _file;

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    // double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      tappingRageh: (){
        print('wtf');
      },
      appBarRowWidgets: const<Widget>[],

      layoutWidget: Center(
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            controller: _ScrollController,
            children: const <Widget>[

              const Stratosphere(),

              DataStrip(dataKey: 'Thing', dataValue: 'BOMB'),

            ],
          ),
        ),
      ),
    );
  }


}
