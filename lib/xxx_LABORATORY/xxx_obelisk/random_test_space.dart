import 'dart:math';

import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class RandomTestSpace extends StatefulWidget {

  @override
  _RandomTestSpaceState createState() => _RandomTestSpaceState();
}

class _RandomTestSpaceState extends State<RandomTestSpace> {
  List<int> _list = <int>[1,2,3,4,5,6,7,8];
  int _loops = 0;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

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
                labelColor: Colorz.BloodTest,
                size: 3,
                maxLines: 5,
              ),
            ),

            // loops
            Container(
              width: Scale.superScreenWidth(context),
              child: SuperVerse(
                verse: 'loops are : ${_loops.toString()}',
                labelColor: Colorz.BloodTest,
                size: 3,
                maxLines: 5,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
