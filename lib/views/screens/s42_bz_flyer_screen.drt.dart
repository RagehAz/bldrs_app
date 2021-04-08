import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_sheet.dart';
import 'package:bldrs/views/widgets/flyer/aflyer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 's50_flyer_editor_screen.dart';

class BzFlyerScreen extends StatelessWidget {
  final String flyerID;
  final BzModel bzModel;

  BzFlyerScreen({
    @required this.flyerID,
    @required this.bzModel,
});
  // ----------------------------------------------------------------------
  void _slideFlyerOptions(BuildContext context, FlyerModel flyerModel){

    BottomSlider.slideBottomSheet(
      context: context,
      height: (50+10+50+10+50+30).toDouble(),
      draggable: true,
      child: Column(
        children: <Widget>[

          // --- DELETE FLYER
          DreamBox(
            height: 50,
            width: BottomSlider.bottomSheetClearWidth(context),
            icon: Iconz.XSmall,
            iconSizeFactor: 0.5,
            iconColor: Colorz.BloodRed,
            verse: 'Delete Flyer',
            verseScaleFactor: 1.2,
            verseColor: Colorz.BloodRed,
            // verseWeight: VerseWeight.thin,

          ),

          SizedBox(height: 10,),

          // --- UN PUBLISH FLYER
          DreamBox(
            height: 50,
            width: BottomSlider.bottomSheetClearWidth(context),
            icon: Iconz.FlyerScale,
            iconSizeFactor: 0.5,
            verse: 'Un-publish flyer',
            verseScaleFactor: 1.2,
            verseColor: Colorz.White,
          ),

          SizedBox(height: 10,),

          // --- EDIT FLYER
          DreamBox(
            height: 50,
            width: BottomSlider.bottomSheetClearWidth(context),
            icon: Iconz.Gears,
            iconSizeFactor: 0.5,
            verse: 'Edit Flyer',
            verseScaleFactor: 1.2,
            verseColor: Colorz.White,
            boxFunction: (){

              Nav.goToNewScreen(context,
                  FlyerEditorScreen(
                  bzModel: bzModel,
                  firstTimer: false,
                  flyerModel: flyerModel
              ));

            },
          ),


        ],
      ),
    );

  }
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _flyerSizeFactor = 0.75;
    double _flyerZoneWidth = superFlyerZoneWidth(context, _flyerSizeFactor);

    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      appBarBackButton: true,
      sky: Sky.Black,
      layoutWidget: flyerModelBuilder(
        context: context,
        flyerID: flyerID,
        flyerSizeFactor: _flyerSizeFactor,
        builder: (ctx, flyerModel){

          return
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Stratosphere(),

                    // --- PUBLISH TIME AND FLYER TYPE
                    Container(
                      width: _flyerZoneWidth,
                      height: 50,
                      // color: Colorz.BloodTest,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          // --- PUBLISH TIME
                          DreamBox(
                            height: 50,
                            icon: Iconizer.flyerTypeIconOff(flyerModel.flyerType),
                            verse: '${TextGenerator.flyerTypeSingleStringer(context, flyerModel.flyerType)} ${Wordz.flyer(context)}',
                            secondLine: '${TextGenerator.dayMonthYearStringer(context, flyerModel.publishTime)}',
                            iconSizeFactor: 0.6,
                            bubble: false,
                            verseWeight: VerseWeight.thin,
                            verseItalic: true,
                          ),

                          // --- EXPANDER
                          Expanded(child: Container()),

                          // --- MORE BUTTON
                          DreamBox(
                            height: 35,
                            width: 35,
                            icon: Iconz.More,
                            iconSizeFactor: 0.5,
                            bubble: false,
                            boxFunction: () => _slideFlyerOptions(context, flyerModel),
                          ),

                        ],
                      ),
                    ),

                    // --- FLYER PREVIEW
                    AFlyer(
                      flyer: flyerModel,
                      flyerSizeFactor: _flyerSizeFactor,
                    ),

                    // --- KEYWORDS
                    Container(
                      width: _flyerZoneWidth,
                      // height: 300,
                      // color: Colorz.BloodRed,
                      child: WordsBubble(
                        title: 'Flyer Keywords',
                        selectedWords: [],
                        words: flyerModel.keyWords,
                        bubbles: false,
                        verseSize: 2,
                        bubbleColor: null,
                        onTap: (){},
                      ),
                    ),
                  ],

                ),
              );

        }
      ),
    );
  }
}
