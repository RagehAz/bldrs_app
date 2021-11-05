
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/providers/ui_provider.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestLab extends StatefulWidget {

  @override
  _TestLabState createState() => _TestLabState();
}

class _TestLabState extends State<TestLab> with SingleTickerProviderStateMixin{

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
        ///
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
  ValueNotifier<int> _counter = ValueNotifier(0);
  void _incrementCounter(){

    _counter.value += 3;
  }
// -----------------------------------------------------------------------------
//   File _file;

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
//     double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    // double _gWidth = _screenWidth * 0.4;
    // double _gHeight = _screenWidth * 0.6;

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);

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

            children: <Widget>[

              const Stratosphere(),



              /// AVOID SET STATE : WAY # 1
              ValueListenableBuilder<int>(
                  valueListenable: _counter,
                  builder: (ctx, value, child){

                    return

                        DreamBox(
                          height: 50,
                          width: 300,
                          verse: 'increment by 3 : ${value}',
                          verseScaleFactor: 0.6,
                          verseWeight: VerseWeight.black,
                          onTap: _incrementCounter,
                        );

                  }
              ),

              /// AVOID SET STATE : WAY # 2
              Consumer<UiProvider>(
                builder: (ctx, uiProvider, child){
                  final String _name = uiProvider.name;
                  return
                    DreamBox(
                      height: 50,
                      width: 300,
                      verse: 'name is : ${_name}',
                      verseScaleFactor: 0.6,
                      verseWeight: VerseWeight.black,
                      onTap: uiProvider.changeName,
                    );

                },
              ),

              /// AVOID SET STATE : WAY # 3
              Selector<UiProvider, int>(
                selector: (_, uiProvider) => uiProvider.theCounter,
                builder: (ctx, value, child){

                  return
                    DreamBox(
                      height: 50,
                      width: 300,
                      verse: 'increment by 1 : ${value}',
                      verseScaleFactor: 0.6,
                      verseWeight: VerseWeight.black,
                      onTap: _uiProvider.incrementCounter,
                    );

                },
              ),

              /// Builder child pattern
              AnimatedBuilder(
                  animation: _animationController,
                  child:
                  DreamBox(
                    height: 50,
                    width: 50,
                    verse: 'X',
                    verseScaleFactor: 0.6,
                    verseWeight: VerseWeight.black,
                    color: Colorz.bloodTest,
                    onTap: () => _animationController.forward(from: 0),
                  ),
                  builder: (BuildContext ctx, Widget child){

                    return
                      Transform.rotate(
                        angle: _animationController.value * 2.0 * 3.14,
                        child: child, /// passing child here will prevent its rebuilding with each tick


                      );

                  }
                  ),

              /// DON SOMETHING
              WideButton(
                  color: Colorz.bloodTest,
                  verse: 'Do Something',
                  icon: Iconz.Share,
                  onTap: () async {

                    _triggerLoading();

                    _triggerLoading();

                  }
              ),

              /// MANIPULATE LOCAL ASSETS TESTING
              // GestureDetector(
              //   onTap: () async {
              //
              //     _triggerLoading();
              //
              //     File file = await Imagers.getFileFromLocalRasterAsset(
              //       context: context,
              //       width: 200,
              //       localAsset: Iconz.BldrsAppIcon,
              //     );
              //
              //     if (file != null){
              //       setState(() {
              //         _file = file;
              //       });
              //
              //     }
              //
              //     _triggerLoading();
              //   },
              //   child: Container(
              //     width: 100,
              //     height: 100,
              //     color: Colorz.facebook,
              //     alignment: Alignment.center,
              //     child: SuperImage(
              //       _file ?? Iconz.DumAuthorPic,
              //       width: 100,
              //       height: 100,
              //
              //     ),
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  }


}
