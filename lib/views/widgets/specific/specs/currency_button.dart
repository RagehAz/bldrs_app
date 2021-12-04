import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/currency_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class CurrencyButton extends StatelessWidget {
  final double width;
  final double height;
  final CurrencyModel currency;
  final String countryID;
  final Function onTap;

  const CurrencyButton({
    @required this.width,
    @required this.currency,
    @required this.countryID,
    @required this.onTap,
    this.height = 60,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        // color: Colorz.blackSemi255,
        borderRadius: Borderers.superBorderAll(context, Ratioz.appBarCorner),
      ),
      margin: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(

        children: <Widget>[

          DreamBox(
            height: height,
            width: width - (height),
            color: Colorz.blackSemi255,
            icon: Flag.getFlagIconByCountryID(countryID.toLowerCase()),
            verse: currency.symbol,
            verseScaleFactor: 0.9,
            verseCentered: false,
            verseMaxLines: 2,
            secondLine: Name.getNameByLingoFromNames(names: currency.names, lingoCode: 'en'),
            bubble: false,
            onTap: onTap,
          ),

          Container(
            width: height,
            height: height,
            alignment: Alignment.center,
            child: SuperVerse(
              verse: currency.nativeSymbol,
              centered: true,
            ),
          ),

        ],
      ),
    );
  }
}
