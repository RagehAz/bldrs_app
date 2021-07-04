import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/section_class.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/section_dialog/section_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/section_dialog/section_button.dart';
import 'package:flutter/material.dart';

class SectionDialog extends StatelessWidget {
final double dialogHeight;

SectionDialog({
  @required this.dialogHeight,
});
// -----------------------------------------------------------------------------
  static Future<void> slideDialog({BuildContext context, FlyersProvider pro, double dialogHeight}) async {
    dynamic _result = await superDialog(
      context: context,
      body: 'Select a section',
      height: dialogHeight,
      child: SectionDialog(dialogHeight: dialogHeight,),
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _bubbleWidth = Scale.superDialogWidth(context) - Ratioz.appBarMargin * 2;
    double _buttonWidth = _bubbleWidth * 0.9;

    return Container(
      // height: _dialogHeight,
      // color: Colorz.BloodTest,
      child: Column(
        children: <Widget>[

          /// REAL ESTATE
          SectionBubble(
              title: 'RealEstate',
              icon: Iconz.PyramidSingleYellow,
              bubbleWidth: _buttonWidth,
              buttons: <Widget>[

                SectionDialogButton(
                  section: Section.NewProperties,
                  inActiveMode: false,
                  dialogHeight: dialogHeight,
                ),

                SectionDialogButton(
                  section: Section.ResaleProperties,
                  inActiveMode: false,
                  dialogHeight: dialogHeight,
                ),

                SectionDialogButton(
                  section: Section.RentalProperties,
                  inActiveMode: true,
                  dialogHeight: dialogHeight,
                ),

              ]
          ),

          /// Construction
          SectionBubble(
              title: 'Construction',
              icon: Iconz.PyramidSingleYellow,
              bubbleWidth: _buttonWidth,
              buttons: <Widget>[

                SectionDialogButton(
                  section: Section.Designs,
                  inActiveMode: false,
                  dialogHeight: dialogHeight,
                ),

                SectionDialogButton(
                  section: Section.Projects,
                  inActiveMode: false,
                  dialogHeight: dialogHeight,
                ),

                SectionDialogButton(
                  section: Section.Crafts,
                  inActiveMode: false,
                  dialogHeight: dialogHeight,
                ),

              ]
          ),

          /// Construction
          SectionBubble(
            title: 'Supplies',
            icon: Iconz.PyramidSingleYellow,
            bubbleWidth: _buttonWidth,
            buttons: <Widget>[

              SectionDialogButton(
                section: Section.Products,
                inActiveMode: false,
                dialogHeight: dialogHeight,
              ),

              SectionDialogButton(
                section: Section.Equipment,
                inActiveMode: true,
                dialogHeight: dialogHeight,
              ),

            ],
          ),

        ],
      ),
    );
  }
}
