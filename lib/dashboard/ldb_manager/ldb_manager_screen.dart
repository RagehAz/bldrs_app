import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/ldb_manager/ldb_viewer_screen.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LDBViewersScreen extends StatelessWidget {
// -----------------------------------------------------------------------------
  Future<void> goToLDBViewer(BuildContext context, String ldbDocName) async {
    await Nav.goToNewScreen(context, LDBViewerScreen(
      ldbDocName: ldbDocName,
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
          onTap: () => goToLDBViewer(context, LDBDoc.myFollows,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My calls',
          icon: Iconz.Phone,
          onTap: () => goToLDBViewer(context, LDBDoc.myCalls,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My shares',
          icon: Iconz.Share,
          onTap: () => goToLDBViewer(context, LDBDoc.myShares,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My views',
          icon: Iconz.Views,
          onTap: () => goToLDBViewer(context, LDBDoc.myViews,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My saves',
          icon: Iconz.Save,
          onTap: () => goToLDBViewer(context, LDBDoc.mySaves,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My reviews',
          icon: Iconz.UTSearching,
          onTap: () => goToLDBViewer(context, LDBDoc.myReviews,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My questions',
          icon: Iconz.DvGouran,
          onTap: () => goToLDBViewer(context, LDBDoc.myQuestions,),
        ),

        BottomDialog.wideButton(
          context: context,
          verse: 'My answers',
          icon: Iconz.DvGouran,
          onTap: () => goToLDBViewer(context, LDBDoc.myAnswers,),
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
        final FlyerModel _flyer = await _prof.fetchFlyerByID(
          context: context,
          flyerID: 'f002',
        );

        _flyer.printFlyer();


        },

        listWidgets: <Widget>[

          WideButton(
            verse: 'Me & preferences', // notifications prefs, my user model
            onTap: () => goToLDBViewer(context, LDBDoc.myUserModel,),
            icon: Iconz.Users,
          ),

          const BubblesSeparator(),

          WideButton(
            verse: 'My Saved Flyers',
            onTap: () => goToLDBViewer(context, LDBDoc.mySavedFlyers,),
            icon: Iconz.SavedFlyers,
          ),

          WideButton(
            verse: 'My Followed Businesses',
            onTap: () => goToLDBViewer(context, LDBDoc.myFollowedBzz,),
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
            onTap: () => goToLDBViewer(context, LDBDoc.myBzz,),
            icon: Iconz.Bz,
          ),

          WideButton(
            verse: 'My Businesses Flyers', // includes deactivated flyers and draft flyers
            onTap: () => goToLDBViewer(context, LDBDoc.myBzzFlyers,),
            icon: Iconz.VerifyFlyer,
          ),

          const BubblesSeparator(),

          WideButton(
            verse: 'Session flyers',
            onTap: () => goToLDBViewer(context, LDBDoc.sessionFlyers,),
            icon: Iconz.FlyerGrid,
          ),

          WideButton(
            verse: 'Session bzz',
            onTap: () => goToLDBViewer(context, LDBDoc.sessionBzz,),
            icon: Iconz.Bz,
          ),

          WideButton(
            verse: 'Session users',
            onTap: () => goToLDBViewer(context, LDBDoc.sessionUsers,),
            icon: Iconz.Users,
          ),

          WideButton(
            verse: 'Session Countries',
            onTap: () => goToLDBViewer(context, LDBDoc.sessionCountries,),
            icon: Iconz.Earth,
          ),

          const BubblesSeparator(),

          WideButton(
            verse: 'Keywords',
            onTap: () => goToLDBViewer(context, LDBDoc.keywords,),
            icon: Iconz.Keyword,
          ),


          const PyramidsHorizon(),

        ],
    );
  }
}
