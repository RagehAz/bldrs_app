import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/b_views/z_components/buttons/flagbox_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/specs/data_creators/currency_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
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
              final String _number = Numeric.formatNumberWithinDigits(num: index + 1, digits: 3);

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  SuperVerse(
                    verse: _number,
                    labelColor: Colorz.black125,
                    margin: 5,
                  ),

                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colorz.bloodTest,
                        borderRadius: Borderers.superBorderAll(context, 50 * 0.15)
                    ),
                    margin: superInsets(context: context, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        CurrencyButton(
                          width: 300,
                          height: 50,
                          countryID: _currency.countriesIDs.last,
                          currency: _currency,
                          onTap: null,
                        ),

                        if (_currency.countriesIDs.length > 1)
                        SizedBox(
                          width: 300,
                          height: 60,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: _currency.countriesIDs.length,
                              padding: superMargins(margins: 10),
                              itemBuilder: (_, index){

                                final String _countryID = _currency.countriesIDs[index];

                                return FlagBox(
                                  countryID: _countryID,
                                );

                              }
                          ),
                        ),

                      ],

                    ),
                  ),

                ],
              );

            }
        ),
      ),
    );
  }
}
