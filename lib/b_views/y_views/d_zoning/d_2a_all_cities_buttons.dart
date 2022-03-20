import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_city_button.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AllCitiesButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AllCitiesButtons({
    @required this.cities,
    @required this.onCityChanged,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<CityModel> cities;
  final ValueChanged<String> onCityChanged;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    cities.sort((CityModel a, CityModel b){

      final String _nameA = Phrase.getPhraseByCurrentLangFromPhrases(context: context, phrases: a.names).value;
      final String _nameB = Phrase.getPhraseByCurrentLangFromPhrases(context: context, phrases: b.names).value;

      return _nameA.compareTo(_nameB);
    });

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: cities.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon),
      itemBuilder: (BuildContext context, int index) {

        final CityModel _city = cities[index];

        return WideCityButton(
            city: _city,
            onTap: onCityChanged,
        );

      },
    );
  }
}
