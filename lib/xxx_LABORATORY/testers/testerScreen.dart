import 'package:bldrs/models/contact_model.dart';
import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/xxx_LABORATORY/testers/test_subjects.dart' as TestSubjects;

class TesterScreen extends StatefulWidget {
final List<Map<String, Object>> testList;

TesterScreen({
  @required this.testList,
});

  @override
  _TesterScreenState createState() => _TesterScreenState();
}

class _TesterScreenState extends State<TesterScreen> {
  String printResult;
  List<Map<String, Object>> getters; //TestSubjects.dbGetters;

  @override
  void initState(){
    getters = widget.testList;
    super.initState();
  }

  String              flyerID     = TestSubjects.flyerID;
  String              userID      = TestSubjects.userID;
  int                 index       = TestSubjects.index;
  String              authorID    = TestSubjects.authorID;
  String              bzID        = TestSubjects.bzID;
  List<ContactModel>  phonesList  = TestSubjects.phonesList;
  String              slideID     = TestSubjects.slideID;
  String              originID    = TestSubjects.originID;
  FlyerType           flyerType   = TestSubjects.flyerType;


  changeButtonColor(int i){
    getters[i]['color'] == Colorz.Nothing ? getters[i]['color'] = Colorz.Yellow :
    getters[i]['color'] == Colorz.Yellow ? getters[i]['color'] = Colorz.DarkGreen :
    getters[i]['color'] == Colorz.DarkGreen ? getters[i]['color'] = Colorz.BlackBlack :
    getters[i]['color'] = Colorz.Nothing;
  }

  @override
  Widget build(BuildContext context) {



    return MainLayout(
      scrollableAppBar: true,
      appBarRowWidgets: <Widget>[
        SuperVerse(
          verse: '$printResult',
          color: printResult == 'function returns fucking null' ? Colorz.BlackBlack : Colorz.White,
          labelColor: printResult == 'function returns fucking null' ? Colorz.BloodRed : Colorz.BloodRedPlastic,
          shadow: true,
          size: 2,
          margin: 5,
        ),
      ],

      layoutWidget: Stack(
        children: <Widget>[

          ListView.builder(
              itemExtent: 60,
              reverse: false,
              padding: EdgeInsets.symmetric(vertical: Ratioz.stratosphere),
              itemCount: getters.length,
              itemBuilder: (ctx, i) =>
                  Align(
                    alignment: Alignment.centerLeft,
                    child: DreamBox(
                      height: 50,
                      // width: 300,
                      color: getters[i]['color'],
                      verseScaleFactor: 0.5,
                      verseMaxLines: 2,
                      icon: '',
                      verseWeight: (getters[i]['color'])==Colorz.Yellow ? VerseWeight.bold : VerseWeight.thin,
                      verseColor: (getters[i]['color'])==Colorz.Yellow ? Colorz.BlackBlack : Colorz.White,
                      verse: '${getters[i]['fnID']}: ${getters[i]['functionName']}',
                      boxFunction: (){
                        dynamic shit;

                        if (getters[i]['function'] == null)
                        {shit = 'function returns fucking null';}
                        else
                        {shit = getters[i]['function'];}

                        print('$shit');

                        setState(() {
                          printResult = '$shit';
                          changeButtonColor(i);
                        });

                      },
                    ),
                  )
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 240,
              child: SuperVerse(
                verse: '${TestSubjects.returnInputs()}',
                labelColor: Colorz.BlackBlack,
                margin: 5,
                maxLines: 10,
                size: 0,
                weight: VerseWeight.thin,
                labelTap: (){
                  print('Ohh Baby Yeah');
                  setState(() {
                    printResult = 'Ohh Baby Yeah';
                  });
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}
