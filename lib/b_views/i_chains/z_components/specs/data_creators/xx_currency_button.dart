import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class CurrencyButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CurrencyButton({
    required this.currency,
    required this.onTap,
    this.countryID,
    this.icon,
    this.width,
    this.height = standardHeight,
    this.highlightController,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final CurrencyModel currency;
  final String countryID;
  final ValueChanged<CurrencyModel> onTap;
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
      return BldrsBox(
        height: height,
        width: width ?? PageBubble.clearWidth(context),
        color: Colorz.blackSemi255,
        icon: icon ?? Flag.getCountryIcon(countryID.toLowerCase()),
        verse: Verse(
          id: '${currency.symbol} . ${xPhrase(currency.id)}',
          translate: false,
        ),
        // translateSecondLine: false,
        // secondLine: ,
        iconSizeFactor: 0.7,
        verseCentered: false,
        bubble: false,
        onTap: onTap == null ? null : () => onTap(currency),
        margins: const EdgeInsets.only(bottom: 5),
        verseHighlight: highlightController,
      );
    }

  }
// --------------------------------------------------------------------------
}
