import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/xxx_LABORATORY/ask/enum_lister/enum_lister.dart';
import 'package:bldrs/xxx_LABORATORY/ask/quest/quests_screen.dart';
import 'package:bldrs/xxx_LABORATORY/ask/question/ask_bubble.dart';
import 'package:flutter/material.dart';

/// WE STOPPPEDDDDD HEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEREEEE, GOOD NIGHT
const Map<String, Object> bzTypesMap = {
  'Title' : 'Business Types',
  'Strings' : <String>[
    'developers',
    'brokers',
    'designers',
    'contractors',
    'artisans',
    'manufacturers',
    'suppliers',
  ],
  'Triggers' : <bool>[false, false, false, false, false, false, false],
};

class OldAskScreen extends StatefulWidget {
  const OldAskScreen({Key key}) : super(key: key);

  @override
  _OldAskScreenState createState() => _OldAskScreenState();
}

class _OldAskScreenState extends State<OldAskScreen> {

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

                  const Stratosphere(),

                  QuestionBubble(
                    tappingAskInfo: () {
                      print('Ask info is tapped aho');
                    },
                  ),

                  DreamBox(
                    height: 80,
                    width: 200,
                    verse: 'tap me',
                    onTap: () => _openEnumLister(bzTypesMap),
                  ),

                  DreamBox(
                    height: 80,
                    width: Scale.superScreenWidth(context),
                    verse: 'Go to Questions Screen',
                    onTap: () => Nav.goToNewScreen(context, const QuesScreen()),
                  ),

                  const PyramidsHorizon(),

                ]),
              ),

            ],
          ),

          if (enumListerIsOn == true)
          EnumLister(
            listTitle: enumListTitle,
            stringsList: enumListerStrings,//listData['Strings'],
            triggersList: enumListerTriggers,//listData['Triggers'],
            triggerTile: _triggerTile,
            closeEnumLister: _closeEnumLister,
          ),

        ],
      ),
    );
  }
}
