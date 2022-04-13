import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/enum_lister/enum_lister.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/question/ask_bubble.dart';
import 'package:flutter/material.dart';

const Map<String, Object> bzTypesMap = <String, dynamic>{
  'Title': 'Business Types',
  'Strings': <String>[
    'developers',
    'brokers',
    'designers',
    'contractors',
    'artisans',
    'manufacturers',
    'suppliers',
  ],
  'Triggers': <bool>[false, false, false, false, false, false, false],
};

class OldAskScreen extends StatefulWidget {
  const OldAskScreen({Key key}) : super(key: key);

  @override
  _OldAskScreenState createState() => _OldAskScreenState();
}

class _OldAskScreenState extends State<OldAskScreen> {
  bool enumListerIsOn = false;

  String enumListTitle = '';
  List<String> enumListerStrings = <String>[''];
  List<bool> enumListerTriggers = <bool>[false];

  void _openEnumLister(Map<String, Object> passedMap) {
    setState(() {
      enumListTitle = passedMap['Title'];
      enumListerStrings = passedMap['Strings'];
      enumListerTriggers = passedMap['Triggers'];
      enumListerIsOn = true;
    });
  }

  void _closeEnumLister() {
    setState(() {
      enumListerIsOn = false;
    });
  }

  void _triggerTile(int index) {
    setState(() {
      // List<bool>  updatedTriggersList = listData['Triggers'];
      enumListerTriggers[index] == false
          ? enumListerTriggers[index] = true
          : enumListerTriggers[index] = false;

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
                      blog('Ask info is tapped aho');
                    },
                  ),

                  DreamBox(
                    height: 80,
                    width: 200,
                    verse: 'tap me',
                    onTap: () => _openEnumLister(bzTypesMap),
                  ),

                  const Horizon(),

                ]),
              ),
            ],
          ),

          if (enumListerIsOn == true)
            EnumLister(
              listTitle: enumListTitle,
              stringsList: enumListerStrings, //listData['Strings'],
              triggersList: enumListerTriggers, //listData['Triggers'],
              triggerTile: _triggerTile,
              closeEnumLister: _closeEnumLister,
            ),

        ],
      ),
    );
  }
}
