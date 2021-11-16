

import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/appbar/bldrs_app_bar.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpecsTextField extends StatefulWidget {

  const SpecsTextField({
    Key key
  }) : super(key: key);

  @override
  State<SpecsTextField> createState() => _SpecsTextFieldState();
}

class _SpecsTextFieldState extends State<SpecsTextField> {

  final TextEditingController controller = TextEditingController();
  String _currency;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    _currency =_zoneProvider.currentCountry.currency;

    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _onCurrencyTap() async {

    await BottomDialog.showBottomDialog(
        context: context,
        draggable: true,
        child: Container(),
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    const double bubbleHeight = 300;
    final double _bubbleWidth = BldrsAppBar.width(context);
    final BorderRadius _bubbleCorners = Borderers.superBorderAll(context, Ratioz.appBarCorner);

    const double _currencyFiledWidth = 100;
    final double _textFieldWidth = _bubbleWidth - _currencyFiledWidth;
    const double _fieldHeight = 100;

    const String _hintText = 'Add price';

    return Container(
      width: _screenWidth,
      height: bubbleHeight,
      alignment: Alignment.center,
      // color: Colorz.red230,
      child: Container(
        width: _bubbleWidth,
        height: bubbleHeight - (2 * Ratioz.appBarMargin),
        decoration: BoxDecoration(
            color: Colorz.white10,
            borderRadius: _bubbleCorners,
        ),
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            SuperTextField(
              width: _textFieldWidth,
              height: _fieldHeight,
              textController: controller,
              hintText: _hintText,
              fieldColor: Colorz.black255,
              centered: true,
              counterIsOn: false,
              inputSize: 4,
              inputWeight: VerseWeight.black,
              corners: Ratioz.appBarCorner,
              keyboardTextInputType: TextInputType.number,
              labelColor: Colorz.blackSemi255,

            ),

            GestureDetector(
              onTap: _onCurrencyTap,
              child: Container(
                width: _currencyFiledWidth,
                height: _fieldHeight,
                child: SuperVerse(
                  verse: _currency,
                  weight: VerseWeight.black,
                  size: 3,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
