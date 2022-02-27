import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/section_dialog/section_bubble.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/section_dialog/section_button.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
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
  static Future<void> slideDialog({
    @required BuildContext context,
    double dialogHeight,
  }) async {

    await BottomDialog.showBottomDialog(
      context: context,
      title: 'Select a section',
      height: BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.7),
      draggable: true,
      child: SectionDialog(dialogHeight: dialogHeight,),

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

    final double _bubbleWidth = CenterDialog.dialogWidth(context: context) - Ratioz.appBarMargin * 2;
    final double _buttonWidth = _bubbleWidth * 0.9;

    return OldMaxBounceNavigator(
      boxDistance: BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.7),
      child: SizedBox(
        width: BottomDialog.clearWidth(context),
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
                    flyerType: FlyerType.property,
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
                    flyerType: FlyerType.design,
                    inActiveMode: false,
                    dialogHeight: dialogHeight,
                  ),

                  SectionDialogButton(
                    flyerType: FlyerType.project,
                    inActiveMode: false,
                    dialogHeight: dialogHeight,
                  ),

                  SectionDialogButton(
                    flyerType: FlyerType.craft,
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
                  flyerType: FlyerType.product,
                  inActiveMode: false,
                  dialogHeight: dialogHeight,
                ),

                SectionDialogButton(
                  flyerType: FlyerType.equipment,
                  inActiveMode: false,
                  dialogHeight: dialogHeight,
                ),
              ],
            ),

            const Horizon(
              heightFactor: 0.5,
            ),

          ],
        ),
      ),
    );
  }
}
