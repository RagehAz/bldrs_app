import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;

class CurrencyManagerScreen extends StatelessWidget {

  const CurrencyManagerScreen({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double _screenHeight = superScreenHeightWithoutSafeArea(context);

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final List<CurrencyModel> _currencies = _zoneProvider.allCurrencies;

    return DashBoardLayout(
      pageTitle: 'Currencies',
      listWidgets: <Widget>[

        PageBubble(
          screenHeightWithoutSafeArea: _screenHeight,
          appBarType: AppBarType.basic,
          color: Colorz.white20,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _currencies.length,
              itemBuilder: (_, index){

                  final CurrencyModel _currency = _currencies[index];
                  final String _number = Numeric.getNumberWithinDigits(num: index + 1, digits: 3);
                  final String _currencyName = '$_number - ${_currency.code} : ( ${_currency.nativeSymbol} ) ${_currency.symbol}';

                  return DreamBox(
                    height: 40,
                    width: 300,
                    verseScaleFactor: 1,
                    verseWeight: VerseWeight.thin,
                    verse: _currencyName,
                    verseCentered: false,
                    margins: 5,
                  );

                }
            ),
        ),

      ],
    );
  }
}
