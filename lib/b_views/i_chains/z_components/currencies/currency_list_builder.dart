import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/data_creators/xx_currency_button.dart';
import 'package:flutter/material.dart';

class CurrencyListBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CurrencyListBuilder({
    @required this.width,
    @required this.height,
    @required this.currencies,
    @required this.onCurrencyTap,
    this.searchController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final List<CurrencyModel> currencies;
  final ValueChanged<CurrencyModel> onCurrencyTap;
  final TextEditingController searchController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: ListView.builder(
          itemCount: currencies.length,
          padding: const EdgeInsets.symmetric(vertical: 10),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index){

            final CurrencyModel _currency = currencies[index];

            return CurrencyButton(
              width: width - 20,
              currency: _currency,
              countryID: _currency.countriesIDs.first,
              onTap: onCurrencyTap,
              highlightController: searchController,
            );

          },
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
