import 'package:bldrs/a_models/d_zone/b_country/all_flags_list.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/lines/zone_bubble_line.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/lines/zone_name_line.dart';
import 'package:bldrs/b_views/z_components/buttons/flagbox_button.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class CountryPreviewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountryPreviewBubble({
    @required this.countryID,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String countryID;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Flag _flag = Flag.getFlagFromFlagsByCountryID(
      flags: allFlags,
      countryID: countryID,
    );

    final CurrencyModel _currencyModel = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
      currencies: ZoneProvider.proGetAllCurrencies(
        context: context,
        listen: true,
      ),
      countryID: countryID,
    );

    final Phrase _nameEn = Flag.getCountryPhrase(
      countryID: countryID,
      langCode: 'en',
    );

    final Phrase _nameAr = Flag.getCountryPhrase(
      countryID: countryID,
      langCode: 'ar',
    );

    final String _areaNumbers = Numeric.formatNumToCounterCaliber(context, _flag.areaSqKm);
    final String _population = Numeric.formatNumToCounterCaliber(context, _flag.population);
    final double _popDensityValue = _flag.population / (_flag.areaSqKm);
    final String _popDensity = Numeric.formatNumToSeparatedKilos(
      number: _popDensityValue,
      fractions: 0,
    );

    final String _areaLine = '$_population person / $_areaNumbers km² = $_popDensity person/km²';

    return Bubble(
      headerViewModel: const BubbleHeaderVM(),
      bubbleColor: Colorz.white20,
      childrenCentered: true,
      columnChildren: <Widget>[

        /// PADDING
        const SizedBox(width: 20, height: 20,),

        /// FLAG
        Center(
          child: FlagBox(
            size: 80,
            countryID: countryID,
            // onTap: _onTap,
          ),
        ),

        /// COUNTRY NAME EN
        ZoneNameLine(name: _nameEn.value,),

        /// COUNTRY NAME AR
        ZoneNameLine(name: _nameAr.value,),

        /// CAPITAL
        ZoneBubbleLine(
          icon: Iconz.star,
          line: _flag.capital,
        ),

        /// CURRENCY
        ZoneBubbleLine(
          icon: Iconz.dollar,
          line: '${_currencyModel?.symbol} . ${xPhrase( context, _currencyModel?.id)}',
        ),

        /// AREA - POPULATION
        ZoneBubbleLine(
          icon: Iconz.users,
          line: _areaLine,
        ),

        /// PADDING
        const SizedBox(width: 20, height: 20,),

      ],

    );

  }
  /// --------------------------------------------------------------------------
}
