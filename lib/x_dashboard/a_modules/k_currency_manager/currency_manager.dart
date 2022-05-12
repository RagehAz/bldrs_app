import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/specs/data_creators/currency_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/k_currency_manager/currency_manager_controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyManagerScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CurrencyManagerScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = superScreenHeightWithoutSafeArea(context) - 10;

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final List<CurrencyModel> _currencies = _zoneProvider.allCurrencies;

    return MainLayout(
      pageTitle: 'Currencies',
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      pyramidsAreOn: true,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: 'Backup',
          onTap: () => onBackupCurrencies(context),
        ),

      ],
      layoutWidget: PageBubble(
        screenHeightWithoutSafeArea: _screenHeight,
        appBarType: AppBarType.basic,
        color: Colorz.white20,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _currencies.length,
            itemBuilder: (_, index){

              final CurrencyModel _currency = _currencies[index];
              final String _number = Numeric.getNumberWithinDigits(num: index + 1, digits: 3);

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  SuperVerse(
                    verse: _number,
                    labelColor: Colorz.black125,
                  ),

                  CurrencyButton(
                    width: 300,
                    height: 50,
                    countryID: _currency.countriesIDs.first,
                    currency: _currency,
                    onTap: null,
                  ),

                ],
              );

            }
        ),
      ),
    );
  }
}
