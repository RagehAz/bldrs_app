import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/ldb_manager/ldb_viewer_screen.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/providers/local_db/bldrs_local_dbs.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LDBViewersScreen extends StatelessWidget {
// -----------------------------------------------------------------------------
  Future<void> goToLDBViewer(BuildContext context, BLDB bldb) async {
    await Nav.goToNewScreen(context, LDBViewerScreen(
      bldb: bldb,
    ));
  }
// -----------------------------------------------------------------------------
  Future<void> _goToAnActivityLog(BuildContext context) async {

    await BottomDialog.showButtonsBottomDialog(
      context: context,
      buttonHeight: 50,
      draggable: true,
      buttons: <Widget>[

        BottomDialog.wideButton(
          context: context,
          verse: 'My follows',
          icon: Iconz.Follow,
          onTap: () => goToLDBViewer(context, BLDB.myFollows,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My calls',
          icon: Iconz.Phone,
          onTap: () => goToLDBViewer(context, BLDB.myCalls,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My shares',
          icon: Iconz.Share,
          onTap: () => goToLDBViewer(context, BLDB.myShares,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My views',
          icon: Iconz.Views,
          onTap: () => goToLDBViewer(context, BLDB.myViews,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My saves',
          icon: Iconz.Save,
          onTap: () => goToLDBViewer(context, BLDB.mySaves,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My reviews',
          icon: Iconz.UTSearching,
          onTap: () => goToLDBViewer(context, BLDB.myReviews,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My questions',
          icon: Iconz.DvGouran,
          onTap: () => goToLDBViewer(context, BLDB.myQuestions,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My answers',
          icon: Iconz.DvGouran,
          onTap: () => goToLDBViewer(context, BLDB.myAnswers,),
        ),

      ],
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
      pageTitle: 'LDB viewers',
        loading: false,
      onBldrsTap: () async {

        print('starting the thing');

        final FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
        List<TinyFlyer> _allTinyFlyers =  _prof.getSavedTinyFlyers;

        print('got tinyflyers from provider');

        List<FlyerModel> _flyers = <FlyerModel>[];

        for (TinyFlyer tinyFlyer in _allTinyFlyers){

          final FlyerModel _flyer = await FlyerOps().readFlyerOps(
            context: context,
            flyerID: tinyFlyer.flyerID,
          );

          _flyers.add(_flyer);

          print('got ${_flyer.flyerID} from firebase');


        }

        // ---

        print('got all saved flyers from firebase');


        List<Map<String, Object>> _maps = FlyerModel.cipherFlyers(_flyers);

        print('starting local insertion');

        await BLDBMethod.insert(
          bldb: BLDB.mySavedFlyers,
          inputs: _maps,
        );

        print('tamam, inserted all,, shoof keda,, thank you lord');


        },

        listWidgets: <Widget>[

          WideButton(
            verse: 'Me & preferences', // notifications prefs, my user model
            onTap: () => goToLDBViewer(context, BLDB.meAndPrefs,),
            icon: Iconz.Users,
          ),

          const BubblesSeparator(),

          WideButton(
            verse: 'My Saved Flyers',
            onTap: () => goToLDBViewer(context, BLDB.mySavedFlyers,),
            icon: Iconz.SavedFlyers,
          ),

          WideButton(
            verse: 'My Followed Businesses',
            onTap: () => goToLDBViewer(context, BLDB.myFollowedBzz,),
            icon: Iconz.Follow,
          ),

          WideButton(
            verse: 'My Activity Logs', // follows, calls, shares, views, saves, reviews, questions, answers
            onTap: () => _goToAnActivityLog(context),
            icon: Iconz.Views,
          ),

          const BubblesSeparator(),

          WideButton(
            verse: 'My Businesses',
            onTap: () => goToLDBViewer(context, BLDB.myBzz,),
            icon: Iconz.Bz,
          ),

          WideButton(
            verse: 'My Businesses Flyers', // includes deactivated flyers and draft flyers
            onTap: () => goToLDBViewer(context, BLDB.myBzzFlyers,),
            icon: Iconz.VerifyFlyer,
          ),

          const BubblesSeparator(),

          WideButton(
            verse: 'Session flyers',
            onTap: () => goToLDBViewer(context, BLDB.myBzzFlyers,),
            icon: Iconz.FlyerGrid,
          ),

          WideButton(
            verse: 'Session bzz',
            onTap: () => goToLDBViewer(context, BLDB.sessionBzz,),
            icon: Iconz.Bz,
          ),

          const BubblesSeparator(),

          WideButton(
            verse: 'Keywords',
            onTap: () => goToLDBViewer(context, BLDB.keywords,),
            icon: Iconz.Keyword,
          ),

          const PyramidsHorizon(),

        ],
    );
  }
}
