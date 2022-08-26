import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class CurrencyButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CurrencyButton({
    @required this.currency,
    @required this.onTap,
    this.countryID,
    this.icon,
    this.width,
    this.height = standardHeight,
    this.highlightController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final CurrencyModel currency;
  final String countryID;
  final Function onTap;
  final String icon;
  final TextEditingController highlightController;
  /// --------------------------------------------------------------------------
  static const double standardHeight = 60 + 10.0;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (currency == null){
      return const SizedBox();
    }

    else {
      return DreamBox(
        height: height,
        width: width ?? PageBubble.clearWidth(context),
        color: Colorz.blackSemi255,
        icon: icon ?? Flag.getFlagIcon(countryID.toLowerCase()),
        verse: '${currency.symbol} . ${xPhrase(context, currency.id)}',
        translateVerse: false,
        // translateSecondLine: false,
        // secondLine: ,
        iconSizeFactor: 0.7,
        verseCentered: false,
        bubble: false,
        onTap: onTap,
        margins: 5,
        verseHighlight: highlightController,
      );
    }


  }
}
