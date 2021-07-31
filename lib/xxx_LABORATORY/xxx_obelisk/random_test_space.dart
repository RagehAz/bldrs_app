import 'dart:math';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
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
  @override
  void initState() {

    _flyer = SuperFlyer.createViewSuperFlyerFromTinyFlyer(
      context: context,
      flyerZoneWidth: 0.5,
      tinyFlyer: TinyFlyer.dummyTinyFlyers()[1],
      onTinyFlyerTap: _createKeyValue,
      onHeaderTap: _createKeyValue,
      onAnkhTap: setStateFromAnotherFile,
    );

    super.initState();
  }
// -----------------------------------------------------------------------------

  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      // _triggerLoading();

      _thing = Scale.superFlyerTinyMode(context, 15);

      print('thing is : $_thing');

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------

  Future<int> _createKeyValue() async {
    Random _random = new Random();
    int _randomNumber = _random.nextInt(20); // from 0 upto 99 included

    if(_randomNumber == null){
      _randomNumber = await _createKeyValue();
      await Future.delayed(Ratioz.duration150ms, () {
        setState(() {
          _loops++;
        });
      });

      }

    else if (_list.contains(_randomNumber)) {
      _randomNumber = await _createKeyValue();

      await Future.delayed(Ratioz.duration150ms, (){
        setState(() {
          _loops++;
        });
      });

    }

    else {

      setState(() {
        _list.add(_randomNumber);
        _loops = 0;
      });

      return _randomNumber;
    }

    return _randomNumber;
  }

  void setStateFromAnotherFile(){

    print('setting fucking state');

    if (_color == Colorz.BloodTest){
      setState(() {
        _color = Colorz.Cyan50;
      });
    }

    else {
      setState(() {
        _color = Colorz.BloodTest;
      });
    }

  }


  @override
  Widget build(BuildContext context) {


    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      tappingRageh: (){
        print('wtf');
      },
      layoutWidget: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [

            Stratosphere(),

            FinalFlyer(
              flyerZoneWidth: Scale.superFlyerZoneWidth(context, 0.7),
              goesToEditor: false,
              // flyerID: '1eFVUCIodzzX6dTL49FS',
            ),

            SizedBox(
              height: 50,
            ),

            if (_thing != null)
            DreamBox(
              height: 40,
              verse: 'Create new key',
              onTap: () async {

                int _newNumber = await _createKeyValue();

                print('new number is : $_newNumber');

              },
            ),

            // list
            Container(
              width: Scale.superScreenWidth(context),
              child: SuperVerse(
                verse: 'list is :\n${_list.toString()}',
                labelColor: _color,
                size: 3,
                maxLines: 5,
              ),
            ),

            // loops
            Container(
              width: Scale.superScreenWidth(context),
              child: SuperVerse(
                verse: 'loops are : ${_loops.toString()}',
                labelColor: _color,
                size: 3,
                maxLines: 5,
              ),
            ),

            DreamBox(
              height: 50,
              width: 250,
              color: _color,
              verse: 'setState',
              onTap: _flyer.onAnkhTap,
            )

          ],
        ),
      ),
    );
  }
}
