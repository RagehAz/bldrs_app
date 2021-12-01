import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/dashboard/ldb_manager/ldb_viewer_screen.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/db/ldb/ldb_ops.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/general/layouts/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LDBViewersScreen extends StatelessWidget {
  const LDBViewersScreen({Key key}) : super(key: key);

// -----------------------------------------------------------------------------
  Future<void> goToLDBViewer(BuildContext context, String ldbDocName) async {
    await Nav.goToNewScreen(context, LDBViewerScreen(
      ldbDocName: ldbDocName,
    ));
  }
// -----------------------------------------------------------------------------
//   Future<void> _goToAnActivityLog(BuildContext context) async {
//
//     await BottomDialog.showButtonsBottomDialog(
//       context: context,
//       buttonHeight: 50,
//       draggable: true,
//       buttons: <Widget>[
//
//         BottomDialog.wideButton(
//           context: context,
//           verse: 'My follows',
//           icon: Iconz.Follow,
//           onTap: () => goToLDBViewer(context, LDBDoc.myFollows,),
//         ),
//
//         BottomDialog.wideButton(
//           context: context,
//           verse: 'My calls',
//           icon: Iconz.Phone,
//           onTap: () => goToLDBViewer(context, LDBDoc.myCalls,),
//         ),
//
//         BottomDialog.wideButton(
//           context: context,
//           verse: 'My shares',
//           icon: Iconz.Share,
//           onTap: () => goToLDBViewer(context, LDBDoc.myShares,),
//         ),
//
//         BottomDialog.wideButton(
//           context: context,
//           verse: 'My views',
//           icon: Iconz.Views,
//           onTap: () => goToLDBViewer(context, LDBDoc.myViews,),
//         ),
//
//         BottomDialog.wideButton(
//           context: context,
//           verse: 'My saves',
//           icon: Iconz.Save,
//           onTap: () => goToLDBViewer(context, LDBDoc.mySaves,),
//         ),
//
//         BottomDialog.wideButton(
//           context: context,
//           verse: 'My reviews',
//           icon: Iconz.UTSearching,
//           onTap: () => goToLDBViewer(context, LDBDoc.myReviews,),
//         ),
//
//         BottomDialog.wideButton(
//           context: context,
//           verse: 'My questions',
//           icon: Iconz.DvGouran,
//           onTap: () => goToLDBViewer(context, LDBDoc.myQuestions,),
//         ),
//
//         BottomDialog.wideButton(
//           context: context,
//           verse: 'My answers',
//           icon: Iconz.DvGouran,
//           onTap: () => goToLDBViewer(context, LDBDoc.myAnswers,),
//         ),
//
//       ],
//     );
//
//   }
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

        listWidgets: [

          ...List.generate(LDBDoc.allDocs.length, (index){

            final String ldbDoc = LDBDoc.allDocs[index];

            return

              WideButton(
                verse: ldbDoc, // notifications prefs, my user model
                onTap: () => goToLDBViewer(context, ldbDoc),
                icon: Iconz.Info,
              );


          }


          ),

        ],
    );
  }
}
