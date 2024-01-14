import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/z_components/buttons/general_buttons/currency_tile_button.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:flutter/material.dart';

class CurrenciesBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const CurrenciesBuilder({
    required this.currencies,
    required this.selectedCurrency,
    required this.highlightController,
    required this.onTap,
    super.key,
  });
  // --------------------
  final List<CurrencyModel> currencies;
  final CurrencyModel? selectedCurrency;
  final TextEditingController? highlightController;
  final Function(CurrencyModel currency) onTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.getStratosphereSandwich(
        context: context,
        appBarType: AppBarType.search,
      ).copyWith(
        left: 10,
        right: 10,
      ),
      itemCount: currencies.length,
      itemBuilder: (_, int index){

        final CurrencyModel _currency = currencies[index];

        return CurrencyTileButton(
          currencyModel: _currency,
          isSelected: selectedCurrency?.id == _currency.id,
          highlightController: highlightController,
          onTap: () => onTap(_currency),
        );

        },
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
