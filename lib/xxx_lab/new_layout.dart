import 'dart:async';

import 'package:bldrs/helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/helpers/theme/colorz.dart';
import 'package:bldrs/helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/chain/chain_properties.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/providers/keywords_provider.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewLayout extends StatefulWidget {
  const NewLayout({Key key}) : super(key: key);


  @override
  _NewLayoutState createState() => _NewLayoutState();
}

class _NewLayoutState extends State<NewLayout> with SingleTickerProviderStateMixin{

  // ScrollController _scrollController;
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
    blog('LOADING--------------------------------------') : blog('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    // _scrollController = ScrollController();

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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  /// VALUE NOTIFIER
  // final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  // void _incrementCounter(){
  //
  //   _counter.value += 3;
  // }
// -----------------------------------------------------------------------------
//   File _file;

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
// -----------------------------------------------------------------------------

    const double _barHeight = 80;
    final double _bodyHeight =
        _screenHeight
            // - Ratioz.stratosphere
            - _barHeight
    ;

    // double _gWidth = _screenWidth * 0.4;
    // double _gHeight = _screenWidth * 0.6;

    // final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);

    const Chain _chain = ChainProperties.chain;

    final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);

    return MainLayout(
      appBarType: AppBarType.non,
      pyramids: Iconz.dvBlankSVG,
      loading: _loading,
      appBarRowWidgets: const<Widget>[],

      layoutWidget: Container(
        width: _screenWidth,
        height: _screenHeight,
        color: Colorz.bloodTest,
        child: Column(
          children: <Widget>[

            // /// STRATOSPHERE
            // Container(
            //   width: _screenWidth,
            //   height: Ratioz.stratosphere,
            //   color: Colorz.bloodTest,
            // ),

            /// BODY
            SizedBox(
              width: _screenWidth,
              height: _bodyHeight,
              child: FinalFlyer(
                flyerBoxWidth: _screenWidth,
                flyerModel: FlyerModel.dummyFlyer(),
                onSwipeFlyer: (){},
              ),
            ),

            /// BAR
            Container(
              width: _screenWidth,
              height: _barHeight,
              color: Colorz.bloodTest,
              child: ListView.builder(
                  itemCount: _chain.sons.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemExtent: _barHeight,
                  itemBuilder: (ctx, index){

                    final KW _keyword = _chain.sons[index];


                    return
                        DreamBox(
                          height: _barHeight - 10,
                          width: _barHeight - 10,
                          icon: _keywordsProvider.getIcon(son: _keyword, context: context),
                          margins: 5,
                        );

                  }
              ),
            ),

          ],
        ),

      ),
    );
  }


}
