import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class CurrencyButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CurrencyButton({
    @required this.width,
    @required this.currency,
    @required this.countryID,
    @required this.onTap,
    this.height = 60,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final CurrencyModel currency;
  final String countryID;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: height,
      width: width - height,
      color: Colorz.blackSemi255,
      icon: Flag.getFlagIcon(countryID.toLowerCase()),
      verse: xPhrase(context, currency.id),
      secondLine: currency.symbol,
      iconSizeFactor: 0.7,
      verseCentered: false,
      bubble: false,
      onTap: onTap,
      margins: 5,
    );

  }
}
