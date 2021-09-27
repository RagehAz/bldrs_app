import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:flutter/material.dart';

class FlyerStatsDialog extends StatelessWidget {
// -----------------------------------------------------------------------------
  static Future<void> show(BuildContext context) async {
    await BottomDialog.showBottomDialog(
      context: context,
      title: 'things',
      draggable: true,
      child: FlyerStatsDialog(),
    );
  }
// -----------------------------------------------------------------------------
  Widget button({BuildContext context}){
    return
      Container(
        width: Scale.getUniformRowItemWidth(context, 3),
        height: 50,
        decoration: BoxDecoration(
          color: Colorz.BloodTest,
          borderRadius: Borderers.superBorderAll(context, BottomDialog.dialogClearCornerValue()),
        ),
      );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _clearWidth = BottomDialog.dialogClearWidth(context);

    return Container(
      width: _clearWidth,
      height: BottomDialog.dialogClearHeight(context: context, draggable: true, titleIsOn: true),
      // color: Colorz.Yellow80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
            width: _clearWidth,
            height: 50,
            // color: Colorz.Blue125,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                button(
                  context: context,
                ),

                button(
                  context: context,
                ),

                button(
                  context: context,
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
