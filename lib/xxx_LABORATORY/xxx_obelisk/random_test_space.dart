import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/bz_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/effects/white_gradient_layer.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class RandomTestSpace extends StatefulWidget {
final double flyerZoneWidth;

RandomTestSpace({
  @required this.flyerZoneWidth,
});

  @override
  _RandomTestSpaceState createState() => _RandomTestSpaceState();
}

class _RandomTestSpaceState extends State<RandomTestSpace> {
  List<int> _list = <int>[1,2,3,4,5,6,7,8];
  int _loops = 0;
  Color _color = Colorz.BloodTest;
  SuperFlyer _flyer;
  bool _thing;

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
    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------

    double _gWidth = _screenWidth * 0.4;
    double _gHeight = _screenWidth * 0.6;


    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      tappingRageh: (){
        print('wtf');
      },
      layoutWidget: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[

            Stratosphere(),

            GradientLayer(
              width: _gWidth,
              height: _gHeight,
              isWhite: false,
            ),

            DreamBox(
              width: _gWidth,
              height: _gHeight,
              bubble: true,
              color: Colorz.BloodTest,
              // corners: 0,
              verse: 'add headlines to tiny flyers',
              verseMaxLines: 5,
              verseScaleFactor: 0.7,
              onTap: () async {

                _triggerLoading();

                print('starting ---------- ');

                List<dynamic> _maps = await Fire.readCollectionDocs(FireCollection.flyers);
                List<FlyerModel> _flyers = new List();
                for (var map in _maps){
                  _flyers.add(FlyerModel.decipherFlyerMap(map));
                }

                List<dynamic> _tinyMaps = await Fire.readCollectionDocs(FireCollection.tinyFlyers);
                List<TinyFlyer> _tinyFlyers = new List();
                for (var tinyMap in _tinyMaps){
                  _tinyFlyers.add(TinyFlyer.decipherTinyFlyerMap(tinyMap));
                }


                for (var flyer in _flyers){

                  bool flyersContainThisID = TinyFlyer.tinyFlyersContainThisID(flyerID: flyer.flyerID, tinyFlyers: _tinyFlyers);

                  print('flyerID : ${flyer.flyerID} : flyersContainThisID : $flyersContainThisID');

                }

                print(' DONE isa');

                _triggerLoading();

              },
            ),

            Stratosphere(heightFactor: 2,),

          ],
        ),
      ),
    );
  }

}
