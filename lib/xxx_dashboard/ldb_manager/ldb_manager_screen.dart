import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/xxx_dashboard/b_views/c_components/layout/dashboard_layout.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_dashboard/ldb_manager/ldb_viewer_screen.dart';
import 'package:bldrs/xxx_dashboard/widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LDBViewersScreen extends StatelessWidget {
  const LDBViewersScreen({Key key}) : super(key: key);

// -----------------------------------------------------------------------------
  Future<void> goToLDBViewer(BuildContext context, String ldbDocName) async {
    await Nav.goToNewScreen(
        context,
        LDBViewerScreen(
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
      onBldrsTap: () async {
        blog('starting the thing');

        final FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
        final FlyerModel _flyer = await _prof.fetchFlyerByID(
          context: context,
          flyerID: 'f002',
        );

        _flyer.blogFlyer();
      },
      listWidgets: <Widget>[
        ...List<Widget>.generate(LDBDoc.allDocs.length, (int index) {
          final String ldbDoc = LDBDoc.allDocs[index];

          return WideButton(
            verse: ldbDoc, // notifications prefs, my user model
            onTap: () => goToLDBViewer(context, ldbDoc),
            icon: Iconz.info,
          );
        }),
      ],
    );
  }
}
