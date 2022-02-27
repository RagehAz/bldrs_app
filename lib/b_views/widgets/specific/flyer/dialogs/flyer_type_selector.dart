import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerTypeSelector extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerTypeSelector({
    @required this.superFlyer,
    @required this.onChangeFlyerType,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final SuperFlyer superFlyer;
  final Function onChangeFlyerType;

  /// --------------------------------------------------------------------------
  @override
  _FlyerTypeSelectorState createState() => _FlyerTypeSelectorState();

  /// --------------------------------------------------------------------------
}

class _FlyerTypeSelectorState extends State<FlyerTypeSelector> {
  @override
  Widget build(BuildContext context) {
    final double _dialogHeight =
        BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.25);

    final List<FlyerTypeClass.FlyerType> _possibleFlyerTypes =
        FlyerTypeClass.concludePossibleFlyerTypesForBz(
            bzType: widget.superFlyer.bz.bzType);
    final int _numberOfButtons = _possibleFlyerTypes.length;
    final double _dialogClearWidth = BottomDialog.clearWidth(context);
    final double _dialogClearHeight = BottomDialog.clearHeight(
        context: context,
        overridingDialogHeight: _dialogHeight,
        titleIsOn: true,
        draggable: true);
    const double _spacing = Ratioz.appBarMargin;
    final double _buttonWidth =
        (_dialogClearWidth - ((_numberOfButtons + 1) * _spacing)) /
            _numberOfButtons;

    return SizedBox(
      width: _dialogClearWidth,
      height: _dialogClearHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ...List<Widget>.generate(_numberOfButtons, (int index) {
            final FlyerTypeClass.FlyerType _flyerType =
                _possibleFlyerTypes[index];
            final String _flyerTypeName =
                TextGen.flyerTypeSingleStringer(context, _flyerType);
            final Color _buttonColor = widget.superFlyer.flyerType == _flyerType
                ? Colorz.yellow255
                : Colorz.white20;
            final Color _verseColor = widget.superFlyer.flyerType == _flyerType
                ? Colorz.black230
                : Colorz.white255;

            return DreamBox(
              height: 60,
              width: _buttonWidth,
              verse: _flyerTypeName,
              verseMaxLines: 2,
              verseScaleFactor: 0.7,
              color: _buttonColor,
              verseColor: _verseColor,
              onTap: () {
                widget.onChangeFlyerType(_flyerType);

                setState(() {
                  widget.superFlyer.flyerType = _flyerType;
                });
              },
            );
          })
        ],
      ),
    );
  }
}
