import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/e_db/ldb/sembast_api.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_dashboard/a_modules/ldb_manager/ldb_viewer_screen.dart';
import 'package:bldrs/xxx_dashboard/a_modules/ldb_manager/ldb_viewer_screen.dart';
import 'package:bldrs/xxx_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/xxx_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/xxx_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LDBViewersScreen extends StatelessWidget {
// -----------------------------------------------------------------------------
  const LDBViewersScreen({
    Key key
  }) : super(key: key);
// -----------------------------------------------------------------------------
  Future<void> goToLDBViewer(BuildContext context, String ldbDocName) async {
    await Nav.goToNewScreen(
        context,
        LDBViewerScreen(
          ldbDocName: ldbDocName,
        )
    );
  }
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

        }
        ),
      ],
    );
  }
}

class SmallFuckingButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SmallFuckingButton({
    @required this.verse,
    @required this.onTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _buttonWidth = _screenWidth / 8;

    return DreamBox(
      height: 30,
      width: _buttonWidth,
      color: Colorz.blue80,
      margins: const EdgeInsets.symmetric(horizontal: 1),
      verse: verse,
      verseScaleFactor: 0.4,
      verseWeight: VerseWeight.thin,
      verseMaxLines: 2,
      onTap: onTap,
    );
  }

  /// --------------------------------------------------------------------------
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('verse', verse));
    properties.add(DiagnosticsProperty<Function>('onTap', onTap));
  }

/// --------------------------------------------------------------------------
}
