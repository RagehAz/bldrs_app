import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/secondary_models/map_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:flutter/material.dart';

class BottomDialogButtons extends StatelessWidget {
  final List<MapModel> mapsModels;
  final Alignment alignment;
  final Function buttonTap;
  final BottomDialogType bottomDialogType;
  final double dialogHeight;
  final double buttonHeight;

  const BottomDialogButtons({
    @required this.mapsModels,
    @required this.alignment,
    @required this.buttonTap,
    this.bottomDialogType = BottomDialogType.countries,
    this.dialogHeight,
    this.buttonHeight = 35,
  });

  @override
  Widget build(BuildContext context) {

    final double _dialogClearWidth = BottomDialog.dialogClearWidth(context);
    final double _dialogCleanHeight = BottomDialog.dialogClearHeight(context: context, draggable: true,titleIsOn: true, overridingDialogHeight: dialogHeight);
    final BorderRadius _dialogClearCorners = BottomDialog.dialogClearCorners(context);

    return Container(
      height: _dialogCleanHeight,
      width: _dialogClearWidth,
      margin: const EdgeInsets.only(top: Ratioz.appBarPadding),
      decoration: BoxDecoration(
        color: Colorz.white10,
        borderRadius: _dialogClearCorners,
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: mapsModels.length,
        itemBuilder: (context, index){

          final String id = mapsModels[index].key;
          final dynamic value = mapsModels[index].value;
          final String _icon = bottomDialogType == BottomDialogType.countries ? Flag.getFlagIconByCountryID(id) : null;

          return
            Align(
              alignment: alignment,
              child: DreamBox(
                  height: buttonHeight,
                  icon: _icon,
                  iconSizeFactor: 0.8,
                  verse: value.toString(),
                  bubble: false,
                  margins: const EdgeInsets.all(Ratioz.appBarPadding),
                  verseScaleFactor: 0.8,
                  color: Colorz.white10,
                  textDirection: bottomDialogType == BottomDialogType.bottomSheet? superTextDirection(context) : superInverseTextDirection(context),
                  onTap: () => buttonTap(id),
              ),
            );
        },
      ),

    );
  }
}
