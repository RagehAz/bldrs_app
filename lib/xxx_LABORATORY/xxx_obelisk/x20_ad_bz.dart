import 'package:bldrs/models/enums/enum_bldrs_section.dart';
import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/in_pyramids/in_pyramids_items/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class AddBzScreen2 extends StatefulWidget {
  @override
  _AddBzScreen2State createState() => _AddBzScreen2State();
}

class _AddBzScreen2State extends State<AddBzScreen2> {
  bool bzPageIsOn;
  BldrsSection chosenSection;
  BzType chosenBzType;
  // ----------------------------------------------------------------------
  void initState(){
    super.initState();
    bzPageIsOn = false;
  }
  // ----------------------------------------------------------------------
  void triggerMaxHeader(){
    setState(() {
      bzPageIsOn = !bzPageIsOn;
    });
  }
  // ----------------------------------------------------------------------
  void selectASection(int index){
    setState(() {
      chosenSection = bldrsSectionsList[index];
    });
  }
  // ----------------------------------------------------------------------
void selectBzType(int index){
    setState(() {
      chosenBzType = bzTypesList[index];
    });
}
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidsYellow,
      layoutWidget: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Stratosphere(),

            MultipleChoiceBubble(
                title: 'Sections :',
                buttonsList: sectionsListStrings(context),
                tappingAButton: selectASection,
                chosenButton: sectionStringer(context, chosenSection),
            ),

            // --- CHOOSE BZTYPE
            MultipleChoiceBubble(
              title: 'Account type :',
              buttonsList: bzTypesStrings(context),
              tappingAButton: selectBzType,
              chosenButton: bzTypeSingleStringer(context, chosenBzType),
            )



            // Stack(
            //   children: <Widget>[
            //
            //     // FlyerZone(
            //     //   flyerSizeFactor: 0.8,
            //     //   tappingFlyerZone: (){print('fuckyou');},
            //     //   stackWidgets: <Widget>[
            //     //
            //     //     Header(
            //     //         coBz: null,
            //     //         coAuthor: null,
            //     //         flyerShowsAuthor: true,
            //     //         followIsOn: null,
            //     //         flyerZoneWidth: superFlyerZoneWidth(context, 0.8),
            //     //         bzPageIsOn: bzPageIsOn,
            //     //         tappingHeader: triggerMaxHeader,
            //     //         tappingFollow: null,
            //     //         tappingUnfollow: null,
            //     //     ),
            //     //
            //     //   ],
            //     // ),
            //
            //   ],
            // )

          ],
        ),
      ),
    );
  }
}

class MultipleChoiceBubble extends StatelessWidget {
  final String title;
  final List<String> buttonsList;
  final Function tappingAButton;
  final String chosenButton;

  MultipleChoiceBubble({
    @required this.title,
    @required this.buttonsList,
    @required this.tappingAButton,
    @required this.chosenButton,
});

  @override
  Widget build(BuildContext context) {
    return InPyramidsBubble(
        bubbleColor: Colorz.WhiteAir,
        columnChildren: <Widget>[

          SuperVerse(
            verse: title,
            margin: 5,
          ),

          Wrap(
              spacing: 0,
              runSpacing: 0,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.center,

              children:
              List<Widget>.generate(
                  buttonsList.length,
                      (int index) {
                    return
                      DreamBox(
                        height: 40,
                        verse: buttonsList[index],
                        verseItalic: false,
                        color: chosenButton == buttonsList[index] ? Colorz.Yellow : Colorz.WhiteAir,
                        verseColor: chosenButton == buttonsList[index] ? Colorz.BlackBlack : Colorz.White,
                        verseWeight: chosenButton == buttonsList[index] ? VerseWeight.black :  VerseWeight.bold,
                        verseScaleFactor: 0.6,
                        boxMargins: EdgeInsets.all(5),
                        boxFunction: () => tappingAButton(index),
                      );
                  }
              )


          ),


        ]
    );
  }
}

