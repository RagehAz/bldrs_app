import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/ask/ask.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/pyramids/enum_lister.dart';
import 'package:bldrs/views/widgets/space/pyramids_horizon.dart';
import 'package:bldrs/views/widgets/space/stratosphere.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

import 'business_type_maps.dart';

class AskScreen extends StatefulWidget {
  @override
  _AskScreenState createState() => _AskScreenState();
}

class _AskScreenState extends State<AskScreen> {

  bool enumListerIsOn = false;

  String enumListTitle = '';
  List<String> enumListerStrings = [''];
  List<bool> enumListerTriggers = [false];

  void _openEnumLister(Map<String,Object> passedMap){
    setState(() {
      enumListTitle = passedMap['Title'];
      enumListerStrings = passedMap['Strings'];
      enumListerTriggers = passedMap['Triggers'];
      enumListerIsOn = true;
    });
  }

  void _closeEnumLister(){
    setState(() {
      enumListerIsOn = false;
    });
  }

  void _triggerTile(int index) {
    setState(() {

      // List<bool>  updatedTriggersList = listData['Triggers'];
      enumListerTriggers[index] == false ?
      enumListerTriggers[index] = true :
      enumListerTriggers[index] = false;

      // listData['Triggers'] = updatedTriggersList;
    });
  }



  @override
  Widget build(BuildContext context) {
    return MainLayout(

      layoutWidget: Stack(

        children: <Widget>[

          CustomScrollView(
            slivers: <Widget>[

              SliverList(
                // key: ,
                delegate: SliverChildListDelegate(<Widget>[

                  Stratosphere(),

                  SuperVerse(
                    verse: 'Go Bissssooooo Goooo',
                    size: 5,
                    shadow: true,
                    color: Colorz.Yellow,
                    margin: 10,
                    weight: VerseWeight.black,
                    labelColor: Colorz.GreenSmoke,
                  ),

                  SuperVerse(
                    verse: '😇😇😇',
                    size: 5,
                    shadow: true,
                    color: Colorz.Yellow,
                    margin: 10,
                    weight: VerseWeight.black,
                    labelColor: Colorz.GreenSmoke,
                  ),

                  Ask(
                    tappingAskInfo: () {
                      print('Ask info is tapped aho');
                    },
                  ),

                  DreamBox(
                    height: 80,
                    width: 200,
                    verse: 'tap me',
                    boxFunction: () => _openEnumLister(bzTypesMap),
                  ),



                  PyramidsHorizon(heightFactor: 10),
                ]),
              ),

            ],
          ),

          enumListerIsOn == true ?
          EnumLister(
            listTitle: enumListTitle,
            stringsList: enumListerStrings,//listData['Strings'],
            triggersList: enumListerTriggers,//listData['Triggers'],
            triggerTile: _triggerTile,
            closeEnumLister: _closeEnumLister,
          ) : Container(),

        ],
      ),
    );
  }
}
