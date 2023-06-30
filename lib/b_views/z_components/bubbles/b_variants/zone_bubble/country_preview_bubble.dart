import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/lines/zone_bubble_line.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/lines/zone_name_line.dart';
import 'package:bldrs/b_views/z_components/buttons/flagbox_button.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';

class CountryPreviewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountryPreviewBubble({
    required this.countryID,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String countryID;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Flag? _flag = Flag.getFlagFromFlagsByCountryID(
      flags: allFlags,
      countryID: countryID,
    );

    final CurrencyModel? _currencyModel = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
      currencies: ZoneProvider.proGetAllCurrencies(
        context: context,
        listen: true,
      ),
      countryID: countryID,
    );

    final Phrase? _nameEn = Flag.getCountryPhrase(
      countryID: countryID,
      langCode: 'en',
    );

    final Phrase? _nameAr = Flag.getCountryPhrase(
      countryID: countryID,
      langCode: 'ar',
    );

    final String? _areaNumbers = counterCaliber(_flag?.areaSqKm);
    final String? _population = counterCaliber(_flag?.population);
    final double? _popDensityValue = (_flag?.population ?? 0) / (_flag?.areaSqKm ?? 0);
    final String? _popDensity = Numeric.formatNumToSeparatedKilos(
      number: _popDensityValue,
      fractions: 0,
    );

    final String _areaLine = '$_population person / $_areaNumbers km² = $_popDensity person/km²';

    return Bubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
      ),
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
        ZoneNameLine(name: _nameEn?.value),

        /// COUNTRY NAME AR
        ZoneNameLine(name: _nameAr?.value),

        /// CAPITAL
        ZoneBubbleLine(
          icon: Iconz.star,
          line: _flag?.capital,
        ),

        /// CURRENCY
        ZoneBubbleLine(
          icon: Iconz.dollar,
          line: '${_currencyModel?.symbol} . ${xPhrase(_currencyModel?.id)}',
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
