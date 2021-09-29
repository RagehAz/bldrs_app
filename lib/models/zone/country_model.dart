import 'city_model.dart';
// -----------------------------------------------------------------------------
class Country{
  final String iso3;
  final String name;
  final String region;
  final String continent;
  final String flag;
  /// manual dashboard switch to deactivate an entire country
  final bool isActivated;
  /// automatic switch when country reaches 'Global target' ~ 10'000 flyers
  /// then country flyers will be visible to other countries users 'bzz & users'
  final bool isGlobal;
  final List<City> cities;
  /// lang codes tiers
  /// A:-
  /// AR:Arabic, ES:Spanish, FR:French, ZH:Chinese, DE:German, IT:Italian,
  /// B:-
  /// HI:Hindi, RU:Russian, TR:Turkish, PT:Portuguese
  /// C:-
  /// ID:Indonesian, BN:Bengali, SW:Swahili, FA: Farsi, JA:Japanese
  /// D:-
  /// UK:Ukrainian, PL:Polish, NL:Dutch, MS:Malay, PA:Punjabi,
  /// E:-
  /// TL:Tagalog, TE:Telugu, MR:Marathi, KO:Korean,
  final String language;

  Country({
    this.iso3,
    this.name,
    this.region,
    this.continent,
    this.flag,
    this.isActivated,
    this.isGlobal,
    this.cities,
    this.language,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'iso3' : iso3,
      'name' : name,
      'region' : region,
      'continent' : continent,
      'flag' : flag,
      'isActivated' : isActivated,
      'isGlobal' : isGlobal,
      'provinces' : City.cipherCities(cities),
      'language' : language,
    };
  }
// -----------------------------------------------------------------------------
  static Country decipherCountryMap(dynamic map){
    return Country(
      iso3 : map['iso3'],
      name : map['name'],
      region : map['region'],
      continent : map['continent'],
      flag : map['flag'],
      isActivated : map['isActivated'],
      isGlobal : map['isGlobal'],
      cities : City.decipherCitiesMaps(map['provinces']),
      language : map['language'],
    );
  }
// -----------------------------------------------------------------------------
  static List<Country> decipherCountriesMaps(List<dynamic> maps){
    List<Country> _countries = [];
    maps?.forEach((map) {
      _countries.add(decipherCountryMap(map));
    });
    return _countries;
  }
// -----------------------------------------------------------------------------

}
