import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/f_helpers/drafters/text_directionerz.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BottomDialogButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BottomDialogButtons({
    @required this.mapsModels,
    @required this.alignment,
    @required this.buttonTap,
    this.bottomDialogType = BottomDialogType.countries,
    this.dialogHeight,
    this.buttonHeight = 35,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<MapModel> mapsModels;
  final Alignment alignment;
  final ValueChanged<String> buttonTap;
  final BottomDialogType bottomDialogType;
  final double dialogHeight;
  final double buttonHeight;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _dialogClearWidth = BottomDialog.clearWidth(context);
    final double _dialogCleanHeight = BottomDialog.clearHeight(
        context: context,
        draggable: true,
        titleIsOn: true,
        overridingDialogHeight: dialogHeight);
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
        itemBuilder: (BuildContext context, int index) {

          final String _id = mapsModels[index].key;
          final dynamic _value = mapsModels[index].value;

          final String _icon = bottomDialogType == BottomDialogType.countries ?
          Flag.getFlagIconByCountryID(_id)
              :
          null;

          return Align(
            alignment: alignment,
            child: DreamBox(
              height: buttonHeight,
              icon: _icon,
              iconSizeFactor: 0.8,
              verse: _value.toString(),
              bubble: false,
              margins: const EdgeInsets.all(Ratioz.appBarPadding),
              verseScaleFactor: 0.8,
              color: Colorz.white10,
              textDirection: bottomDialogType == BottomDialogType.bottomSheet ?
              textDirectionAsPerAppDirection(context)
                  :
              superInverseTextDirection(context),
              onTap: () => buttonTap(_id),
            ),
          );
        },
      ),
    );
  }
}
