import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/x_2_old_flyer_editor_screen.dart';
import 'package:bldrs/views/widgets/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/words_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog.dart';
import 'package:bldrs/views/widgets/flyer/aflyer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzFlyerScreen extends StatelessWidget {
  final TinyFlyer tinyFlyer;
  final BzModel bzModel;

  BzFlyerScreen({
    @required this.tinyFlyer,
    @required this.bzModel,
});
// -----------------------------------------------------------------------------
  void _unpublishFlyerOnTap(BuildContext context) async {

    Nav.goBack(context);

    /// Task : this should be bool dialog instead
    bool _dialogResult = await superDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to unpublish this flyer ?',
      boolDialog: true,
    );

    /// if user stop
    if (_dialogResult == false) {

      print('cancelled unpublishing flyer');

    }

    /// if user continue
    else {

      /// start delete flyer ops
      await FlyerOps().deactivateFlyerOps(
        context: context,
        bzModel: bzModel,
        flyerID : tinyFlyer.flyerID,
      );

      /// remove tinyFlyer from Local list
      FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
      _prof.removeTinyFlyerFromLocalList(tinyFlyer.flyerID);


    }

    // /// re-route back
    // Nav.goBack(context, argument: true);

  }
// -----------------------------------------------------------------------------
  void _slideFlyerOptions(BuildContext context, FlyerModel flyerModel){

    BottomDialog.slideButtonsBottomDialog(
      context: context,
      // height: (50+10+50+10+50+30).toDouble(),
      draggable: true,
      buttonHeight: 50,
      buttons: <Widget>[

          // --- UNPUBLISH FLYER
          DreamBox(
            height: 50,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.XSmall,
            iconSizeFactor: 0.5,
            iconColor: Colorz.Red255,
            verse: 'Unpublish Flyer',
            verseScaleFactor: 1.2,
            verseColor: Colorz.Red255,
            // verseWeight: VerseWeight.thin,
            onTap: () => _unpublishFlyerOnTap(context),

          ),

          // --- DELETE FLYER
          DreamBox(
            height: 50,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.FlyerScale,
            iconSizeFactor: 0.5,
            verse: 'Delete Flyer',
            verseScaleFactor: 1.2,
            verseColor: Colorz.White255,
            onTap: () async {
              Nav.goBack(context);

              /// Task : this should be bool dialog instead
              bool _dialogResult = await superDialog(
                context: context,
                title: '',
                body: 'Are you sure you want to Delete this flyer and never get it back?',
                boolDialog: true,
              );

              print(_dialogResult);


              /// start delete flyer ops
              await FlyerOps().deleteFlyerOps(
                context: context,
                bzModel: bzModel,
                flyerModel : flyerModel,
              );

              /// remove tinyFlyer from Local list
              FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
              _prof.removeTinyFlyerFromLocalList(tinyFlyer.flyerID);

              /// re-route back
              Nav.goBack(context, argument: true);
            },
          ),

          // --- EDIT FLYER
          DreamBox(
            height: 50,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.Gears,
            iconSizeFactor: 0.5,
            verse: 'Edit Flyer',
            verseScaleFactor: 1.2,
            verseColor: Colorz.White255,
            onTap: (){

              Nav.goToNewScreen(context,
                  OldFlyerEditorScreen(
                  bzModel: bzModel,
                  firstTimer: false,
                  flyerModel: flyerModel
              ));

            },
          ),

        ],

    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _flyerSizeFactor = 0.75;
    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, _flyerSizeFactor);

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      // appBarBackButton: true,
      sky: Sky.Black,
      layoutWidget: flyerStreamBuilder(
        context: context,
        tinyFlyer: tinyFlyer,
        listen: true,
        flyerSizeFactor: _flyerSizeFactor,
        builder: (ctx, flyerModel){

          String _flyerMetaData = '${TextGenerator.zoneStringer(context: context, zone: tinyFlyer.flyerZone)}\n'
              '${TextGenerator.dayMonthYearStringer(context, flyerModel.publishTime)}\n'
              '\n'
              'flyer Keywords :'
              '${flyerModel.keywords.toString()}';

          return
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Stratosphere(),

                    TileBubble(
                      icon: Iconizer.flyerTypeIconOff(flyerModel.flyerType),
                      verse: '${TextGenerator.flyerTypeSingleStringer(context, flyerModel.flyerType)} ${Wordz.flyer(context)}',
                      secondLine: _flyerMetaData,
                      iconSizeFactor: 1,
                      moreBtOnTap: () => _slideFlyerOptions(context, flyerModel),
                    ),

                    TileBubble(
                      verse: 'Show Flyer author',
                      icon: flyerModel.tinyAuthor.pic,
                      iconSizeFactor: 1,
                      switchIsOn: flyerModel.flyerShowsAuthor,
                      switching: (val) async {

                        await FlyerOps().switchFlyerShowsAuthor(
                          context: context,
                          flyerID: flyerModel.flyerID,
                          val: val,
                        );

                      },
                    ),

                    NormalFlyerWidget(
                      flyer: flyerModel,
                      flyerSizeFactor: _flyerSizeFactor,
                    ),

                    SizedBox(height: 10,),

                    // --- KEYWORDS
                    KeywordsBubble(
                      bubbleWidth: _flyerZoneWidth,
                      title: 'Flyer Keywords',
                      selectedWords: [],
                      keywords: flyerModel.keywords,
                      bubbles: false,
                      verseSize: 2,
                      bubbleColor: Colorz.White20,
                      onTap: (){},
                    ),

                    PyramidsHorizon(heightFactor: 5,),

                  ],

                ),
              );

        }
      ),
    );
  }
}
