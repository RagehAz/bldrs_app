import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:flutter/material.dart';

class FlyerTypeSelector extends StatefulWidget {
  final SuperFlyer superFlyer;
  final Function onChangeFlyerType;

  const FlyerTypeSelector({
    @required this.superFlyer,
    @required this.onChangeFlyerType,
});

  @override
  _FlyerTypeSelectorState createState() => _FlyerTypeSelectorState();
}

class _FlyerTypeSelectorState extends State<FlyerTypeSelector> {
  @override
  Widget build(BuildContext context) {

    double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.25);

    final List<FlyerType> _possibleFlyerTypes = FlyerTypeClass.concludePossibleFlyerTypesForBz(bzType: widget.superFlyer.bz.bzType);
    final int _numberOfButtons = _possibleFlyerTypes.length;
    final double _dialogClearWidth = BottomDialog.dialogClearWidth(context);
    final double _dialogClearHeight = BottomDialog.dialogClearHeight(context: context, overridingDialogHeight: _dialogHeight, titleIsOn: true, draggable: true);
    final double _spacing = Ratioz.appBarMargin;
    final double _buttonWidth = (_dialogClearWidth - ((_numberOfButtons + 1) * _spacing) ) / _numberOfButtons;


    return Container(
      width: _dialogClearWidth,
      height: _dialogClearHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          ...List.generate(
              _numberOfButtons,
                  (index) {

                FlyerType _flyerType = _possibleFlyerTypes[index];
                String _flyerTypeName = TextGenerator.flyerTypeSingleStringer(context, _flyerType);
                Color _buttonColor = widget.superFlyer.flyerType == _flyerType ? Colorz.Yellow255 : Colorz.White20;
                Color _verseColor = widget.superFlyer.flyerType == _flyerType ? Colorz.Black230 : Colorz.White255;

                return

                  DreamBox(
                    height: 60,
                    width: _buttonWidth,
                    verse: _flyerTypeName,
                    verseMaxLines: 2,
                    verseScaleFactor: 0.7,
                    color: _buttonColor,
                    verseColor: _verseColor,
                    onTap: (){

                      widget.onChangeFlyerType(_flyerType);

                      setState(() {
                        widget.superFlyer.flyerType = _flyerType;
                      });

                    },
                  );

              }

          )

        ],
      ),
    );
  }
}
