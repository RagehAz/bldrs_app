import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/kw/chain.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/expansion_tiles/expanding_tile.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:flutter/material.dart';

class ExpansionTilesTest extends StatefulWidget {

  @override
  _ExpansionTilesTestState createState() => _ExpansionTilesTestState();
}

class _ExpansionTilesTestState extends State<ExpansionTilesTest> {
  // List<int> _list = <int>[1,2,3,4,5,6,7,8];
  // int _loops = 0;
  // Color _color = Colorz.BloodTest;
  // SuperFlyer _flyer;
  // bool _thing;
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
//     double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    // double _gWidth = _screenWidth * 0.4;
    // double _gHeight = _screenWidth * 0.6;

    // final double _buttonHeight = 40;
    // final double _buttonWidth = _screenWidth - (2 * Ratioz.appBarMargin);

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      tappingRageh: (){
        print('wtf');
      },

      appBarRowWidgets: <Widget>[

      ],

      layoutWidget: Container(
        width: 300,
        height: Scale.superScreenHeight(context),
        padding: EdgeInsets.only(top: Ratioz.stratosphere),
        child: MaxBounceNavigator(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [

              Container(
                width: 300,
                height: Scale.superScreenHeight(context),
                color: Colorz.bloodTest,
                child: BldrsChains(boxWidth: 300,),
              ),

            ],

          ),
        ),
      ),
    );
  }


}

class Inception extends StatelessWidget {
  final dynamic son;
  final int level;
  final double boxWidth;

  const Inception({
    @required this.son,
    this.level = 0,
    this.boxWidth,
  });

  @override
  Widget build(BuildContext context) {

    final _offset = (2 * Ratioz.appBarMargin) * level;

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _buttonHeight = 60;
    final double _boxWidth = boxWidth ?? _screenWidth - (2 * Ratioz.appBarMargin);
    final double _buttonWidth = _boxWidth - _offset;

    if(son.runtimeType == KW){

      return
        DreamBox(
          width: _buttonWidth,
          height: _buttonHeight,
          icon: Keyword.getImagePath(son.id),
          verse: Name.getNameByCurrentLingoFromNames(context, son.names),
          verseScaleFactor: 0.7,
          verseCentered: false,
          color: Colorz.white20,
          margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
        );

    }

    else if (son.runtimeType == Chain){

      final Chain _chain = son;
      final List<dynamic> _sons = _chain.sons;

      return

        ExpandingTile(
            icon: Keyword.getImagePath(son.id),
            width: _buttonWidth,
            collapsedHeight: _buttonHeight,
            firstHeadline: Name.getNameByCurrentLingoFromNames(context, son.names),
            secondHeadline: null,
            margin: EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
            child: Column(
              children: <Widget>[

                ...List.generate(_sons.length,
                        (index) {
                      dynamic son = _sons[index];

                      return Inception(
                        son: son,
                        level: level + 1,
                        boxWidth: _boxWidth,
                      );
                    }
                ),
              ],

            ),

        );

    }

    else {

      return
        const BldrsName(size: 40);

    }

  }
}

class BldrsChains extends StatelessWidget {
  final double boxWidth;

  const BldrsChains({
  this.boxWidth,
});

  @override
  Widget build(BuildContext context) {

    final Chain _allChains = Chain.bldrsChain;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _allChains.sons.length,
      shrinkWrap: false,
      itemBuilder: (ctx, index){

        dynamic son = _allChains.sons[index];

        return Inception(
          son: son,
          level: 0,
          boxWidth: boxWidth,
        );

      },
    );
  }
}
