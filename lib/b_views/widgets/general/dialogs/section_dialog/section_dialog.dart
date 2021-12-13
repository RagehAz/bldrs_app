import 'package:bldrs/a_models/kw/section_class.dart' as SectionClass;
import 'package:bldrs/b_views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/section_dialog/section_bubble.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/section_dialog/section_button.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SectionDialog extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SectionDialog({
    @required this.dialogHeight,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double dialogHeight;

  /// --------------------------------------------------------------------------
  static Future<void> slideDialog(
      {BuildContext context, double dialogHeight}) async {
    await BottomDialog.showBottomDialog(
      context: context,
      title: 'Select a section',
      height: BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.7),
      draggable: true,
      child: SectionDialog(
        dialogHeight: dialogHeight,
      ),
      // builder: (context, title){
      //   return StatefulBuilder(
      //     builder: (BuildContext context, StateSetter setDialogState){
      //       return
      //         SectionDialog(
      //           dialogHeight: dialogHeight,
      //
      //         );
      //     }
      //   );
      // }
    );
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _bubbleWidth =
        CenterDialog.dialogWidth(context: context) - Ratioz.appBarMargin * 2;
    final double _buttonWidth = _bubbleWidth * 0.9;

    return MaxBounceNavigator(
      boxDistance: BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.7),
      child: SizedBox(
        width: BottomDialog.dialogClearWidth(context),
        // height: _dialogHeight,
        // color: Colorz.BloodTest,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            /// REAL ESTATE
            SectionBubble(
                title: 'RealEstate',
                icon: Iconz.pyramidSingleYellow,
                bubbleWidth: _buttonWidth,
                buttons: <Widget>[
                  SectionDialogButton(
                    section: SectionClass.Section.properties,
                    inActiveMode: false,
                    dialogHeight: dialogHeight,
                  ),
                ]),

            /// Construction
            SectionBubble(
                title: 'Construction',
                icon: Iconz.pyramidSingleYellow,
                bubbleWidth: _buttonWidth,
                buttons: <Widget>[
                  SectionDialogButton(
                    section: SectionClass.Section.designs,
                    inActiveMode: false,
                    dialogHeight: dialogHeight,
                  ),
                  SectionDialogButton(
                    section: SectionClass.Section.projects,
                    inActiveMode: false,
                    dialogHeight: dialogHeight,
                  ),
                  SectionDialogButton(
                    section: SectionClass.Section.crafts,
                    inActiveMode: false,
                    dialogHeight: dialogHeight,
                  ),
                ]),

            /// Construction
            SectionBubble(
              title: 'Supplies',
              icon: Iconz.pyramidSingleYellow,
              bubbleWidth: _buttonWidth,
              buttons: <Widget>[
                SectionDialogButton(
                  section: SectionClass.Section.products,
                  inActiveMode: false,
                  dialogHeight: dialogHeight,
                ),
                SectionDialogButton(
                  section: SectionClass.Section.equipment,
                  inActiveMode: false,
                  dialogHeight: dialogHeight,
                ),
              ],
            ),

            const PyramidsHorizon(
              heightFactor: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}
