// ignore_for_file: prefer_single_quotes
import 'package:bldrs/f_helpers/drafters/numeric.dart';
// -----------------------------------------------------------------------------

/// GETTERS

// --------------------
/// GET ISO2
String xGetIso2(String countryID){
  String _iso2;
  final Map<String, dynamic> _map = getInternetCountries().singleWhere((map) => map['ISO3'] == countryID.toUpperCase(), orElse: () => null);
  if (_map != null){
    _iso2 = _map['ISO2'];
  }
  return _iso2;
}
// --------------------
/// GET COUNTRY NAME
String xGetCountryName(String countryID){

  String _countryName;
  final String _iso2 = xGetIso2(countryID);

  if (_iso2 != null){
    final Map<String, dynamic> _map = cocoNameIso2().singleWhere((map) => map['abbreviation'] == _iso2, orElse: () => null);
    if (_map != null){
      _countryName = _map['country'];
    }
  }

  return _countryName;
}
// --------------------
/// GET POPULATION
int xGetPopulation(String countryID){
  int _pop;

  if (countryID != null){

    final String _countryName = xGetCountryName(countryID);

    if (_countryName != null){
      final Map<String, dynamic> _map = cocoNamePopulation().singleWhere((map) => map['country'] == _countryName, orElse: () => null);
      if (_map != null){
        _pop = _map['population'];
      }
    }

  }

  return _pop;
}
// --------------------
/// GET GOV
String xGetGov(String countryID){
  String _gov;

  if (countryID != null){
    final String _countryName = xGetCountryName(countryID);

    if (_countryName != null){
      final Map<String, dynamic> _map = cocoNameGov().singleWhere((map) => map['country'] == _countryName, orElse: () => null);
      if (_map != null){
        _gov = _map['government'];
      }
    }
  }

  return _gov;
}
// --------------------
/// GET LANGUAGES
String xGetLangs(String countryID){
  String _langs;

  if (countryID != null){
    final Map<String, dynamic> _map = getInternetCountries().singleWhere(
            (map) => map['ISO3'] == countryID.toUpperCase(), orElse: () => null);
    if (_map != null){
      _langs = _map['Language Codes'];
    }
  }

  return _langs;
}
// --------------------
/// GET AREA KM
int xGetAreaKM(String countryID){
  int _area;

  if (countryID != null){
    final Map<String, dynamic> _map = getInternetCountries().singleWhere(
            (map) => map['ISO3'] == countryID.toUpperCase(), orElse: () => null);

    if (_map != null){
      _area = _map['Area KM2'];
    }
  }

  return _area;
}
// --------------------
/// GET CAPITAL
String xGetCapital(String countryID){
  String _cap;

  if (countryID != null){
    final Map<String, dynamic> _map = getInternetCountries().singleWhere(
            (map) => map['ISO3'] == countryID.toUpperCase(), orElse: () => null);
    if (_map != null){
      _cap = _map['Capital'];
    }
  }

  return _cap;
}
// --------------------
/// GET PHONE CODE
String xGetPhoneCode(String countryID){
  String code;

  if (countryID != null){

    final Map<String, dynamic> _map = getInternetCountries().singleWhere(
            (map) => map['ISO3'] == countryID.toUpperCase(),
        orElse: ()=> null
    );

    if (_map != null){
      code = '+${_map['Phone Code']}';
    }

  }

  return code;
}
// --------------------
/// GET INTERNET USERS COUNT
int xGetInternetUsers(String countryID){
  int _output;

  if (countryID != null){
    final Map<String, dynamic> _map = getInternetCountries().singleWhere(
            (map) => map['ISO3'] == countryID.toUpperCase(), orElse: () => null);
    if (_map != null){
      _output = Numeric.transformStringToInt(_map['Internet Users'].toString());
    }
  }

  return _output;
}
// --------------------
/// GET GDP
double xGetGDP(String countryID){
  double _output;

  if (countryID != null){
    final Map<String, dynamic> _map = getInternetCountries().singleWhere(
            (map) => map['ISO3'] == countryID.toUpperCase(), orElse: () => null);
    if (_map != null){
      _output = Numeric.roundFractions(_map['GDP'] / 1000000, 2);
    }
  }

  return _output;
}
// -----------------------------------------------------------------------------

/// COUNTRIES MAPS

// --------------------
/// COUNTRIES BIG MAP
List<Map<String, dynamic>> getInternetCountries (){

  const List<Map<String, dynamic>> _list = [
    {
      "Country Name": "Afghanistan",
      "ISO2": "AF",
      "ISO3": "AFG",
      "Top Level Domain": "af",
      "FIPS": "AF",
      "ISO Numeric": "004",
      "GeoNameID": 1149361,
      "E164": 93,
      "Phone Code": 93,
      "Continent": "Asia",
      "Capital": "Kabul",
      "Time Zone in Capital": "Asia/Kabul",
      "Currency": "Afghani",
      "Language Codes": "fa-AF,ps,uz-AF,tk",
      "Languages": "Afghan Persian or Dari (official) 50%, Pashto (official) 35%, Turkic languages (primarily Uzbek and Turkmen) 11%, 30 minor languages (primarily Balochi and Pashai) 4%, much bilingualism, but Dari functions as the lingua franca",
      "Area KM2": 647500,
      "Internet Hosts": 223,
      "Internet Users": 1000000,
      "Phones (Mobile)": 18000000,
      "Phones (Landline)": 13500,
      "GDP": 20650000000
    },
    {
      "Country Name": "Albania",
      "ISO2": "AL",
      "ISO3": "ALB",
      "Top Level Domain": "al",
      "FIPS": "AL",
      "ISO Numeric": "008",
      "GeoNameID": 783754,
      "E164": 355,
      "Phone Code": 355,
      "Continent": "Europe",
      "Capital": "Tirana",
      "Time Zone in Capital": "Europe/Tirane",
      "Currency": "Lek",
      "Language Codes": "sq,el",
      "Languages": "Albanian 98.8% (official - derived from Tosk dialect), Greek 0.5%, other 0.6% (including Macedonian, Roma, Vlach, Turkish, Italian, and Serbo-Croatian), unspecified 0.1% (2011 est.)",
      "Area KM2": 28748,
      "Internet Hosts": 15528,
      "Internet Users": 1300000,
      "Phones (Mobile)": 3500000,
      "Phones (Landline)": 312000,
      "GDP": 12800000000
    },
    {
      "Country Name": "Algeria",
      "ISO2": "DZ",
      "ISO3": "DZA",
      "Top Level Domain": "dz",
      "FIPS": "AG",
      "ISO Numeric": "012",
      "GeoNameID": 2589581,
      "E164": 213,
      "Phone Code": 213,
      "Continent": "Africa",
      "Capital": "Algiers",
      "Time Zone in Capital": "Africa/Algiers",
      "Currency": "Dinar",
      "Language Codes": "ar-DZ",
      "Languages": "Arabic (official), French (lingua franca), Berber dialects: Kabylie Berber (Tamazight), Chaouia Berber (Tachawit), Mzab Berber, Tuareg Berber (Tamahaq)",
      "Area KM2": 2381740,
      "Internet Hosts": 676,
      "Internet Users": 4700000,
      "Phones (Mobile)": 37692000,
      "Phones (Landline)": 3200000,
      "GDP": 215700000000
    },
    {
      "Country Name": "American Samoa",
      "ISO2": "AS",
      "ISO3": "ASM",
      "Top Level Domain": "as",
      "FIPS": "AQ",
      "ISO Numeric": "016",
      "GeoNameID": 5880801,
      "E164": 1,
      "Phone Code": "1-684",
      "Continent": "Oceania",
      "Capital": "Pago Pago",
      "Time Zone in Capital": "Pacific/Pago_Pago",
      "Currency": "Dollar",
      "Language Codes": "en-AS,sm,to",
      "Languages": "Samoan 90.6% (closely related to Hawaiian and other Polynesian languages), English 2.9%, Tongan 2.4%, other Pacific islander 2.1%, other 2%",
      "Area KM2": 199,
      "Internet Hosts": 2387,
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": 10000,
      "GDP": 462200000
    },
    {
      "Country Name": "Andorra",
      "ISO2": "AD",
      "ISO3": "AND",
      "Top Level Domain": "ad",
      "FIPS": "AN",
      "ISO Numeric": "020",
      "GeoNameID": 3041565,
      "E164": 376,
      "Phone Code": 376,
      "Continent": "Europe",
      "Capital": "Andorra la Vella",
      "Time Zone in Capital": "Europe/Andorra",
      "Currency": "Euro",
      "Language Codes": "ca",
      "Languages": "Catalan (official), French, Castilian, Portuguese",
      "Area KM2": 468,
      "Internet Hosts": 28383,
      "Internet Users": 67100,
      "Phones (Mobile)": 65000,
      "Phones (Landline)": 39000,
      "GDP": 4800000000
    },
    {
      "Country Name": "Angola",
      "ISO2": "AO",
      "ISO3": "AGO",
      "Top Level Domain": "ao",
      "FIPS": "AO",
      "ISO Numeric": "024",
      "GeoNameID": 3351879,
      "E164": 244,
      "Phone Code": 244,
      "Continent": "Africa",
      "Capital": "Luanda",
      "Time Zone in Capital": "Africa/Lagos",
      "Currency": "Kwanza",
      "Language Codes": "pt-AO",
      "Languages": "Portuguese (official), Bantu and other African languages",
      "Area KM2": 1246700,
      "Internet Hosts": 20703,
      "Internet Users": 606700,
      "Phones (Mobile)": 9800000,
      "Phones (Landline)": 303000,
      "GDP": 124000000000
    },
    {
      "Country Name": "Anguilla",
      "ISO2": "AI",
      "ISO3": "AIA",
      "Top Level Domain": "ai",
      "FIPS": "AV",
      "ISO Numeric": 660,
      "GeoNameID": 3573511,
      "E164": 1,
      "Phone Code": "1-264",
      "Continent": "North America",
      "Capital": "The Valley",
      "Time Zone in Capital": "America/Port_of_Spain",
      "Currency": "Dollar",
      "Language Codes": "en-AI",
      "Languages": "English (official)",
      "Area KM2": 102,
      "Internet Hosts": 269,
      "Internet Users": 3700,
      "Phones (Mobile)": 26000,
      "Phones (Landline)": 6000,
      "GDP": 175400000
    },
    {
      "Country Name": "Antarctica",
      "ISO2": "AQ",
      "ISO3": "ATA",
      "Top Level Domain": "aq",
      "FIPS": "AY",
      "ISO Numeric": "010",
      "GeoNameID": 6697173,
      "E164": 672,
      "Phone Code": 672,
      "Continent": "Antarctica",
      "Capital": "",
      "Time Zone in Capital": "Antarctica/Troll",
      "Currency": "",
      "Language Codes": "",
      "Languages": "",
      "Area KM2": 14000000,
      "Internet Hosts": 7764,
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Antigua and Barbuda",
      "ISO2": "AG",
      "ISO3": "ATG",
      "Top Level Domain": "ag",
      "FIPS": "AC",
      "ISO Numeric": "028",
      "GeoNameID": 3576396,
      "E164": 1,
      "Phone Code": "1-268",
      "Continent": "North America",
      "Capital": "St. John's",
      "Time Zone in Capital": "America/Antigua",
      "Currency": "Dollar",
      "Language Codes": "en-AG",
      "Languages": "English (official), local dialects",
      "Area KM2": 443,
      "Internet Hosts": 11532,
      "Internet Users": 65000,
      "Phones (Mobile)": 179800,
      "Phones (Landline)": 35000,
      "GDP": 1220000000
    },
    {
      "Country Name": "Argentina",
      "ISO2": "AR",
      "ISO3": "ARG",
      "Top Level Domain": "ar",
      "FIPS": "AR",
      "ISO Numeric": "032",
      "GeoNameID": 3865483,
      "E164": 54,
      "Phone Code": 54,
      "Continent": "South America",
      "Capital": "Buenos Aires",
      "Time Zone in Capital": "America/Argentina/Buenos_Aires",
      "Currency": "Peso",
      "Language Codes": "es-AR,en,it,de,fr,gn",
      "Languages": "Spanish (official), Italian, English, German, French, indigenous (Mapudungun, Quechua)",
      "Area KM2": 2766890,
      "Internet Hosts": 11232000,
      "Internet Users": 13694000,
      "Phones (Mobile)": 58600000,
      "Phones (Landline)": 1,
      "GDP": 484600000000
    },
    {
      "Country Name": "Armenia",
      "ISO2": "AM",
      "ISO3": "ARM",
      "Top Level Domain": "am",
      "FIPS": "AM",
      "ISO Numeric": "051",
      "GeoNameID": 174982,
      "E164": 374,
      "Phone Code": 374,
      "Continent": "Asia",
      "Capital": "Yerevan",
      "Time Zone in Capital": "Asia/Yerevan",
      "Currency": "Dram",
      "Language Codes": "hy",
      "Languages": "Armenian (official) 97.9%, Kurdish (spoken by Yezidi minority) 1%, other 1% (2011 est.)",
      "Area KM2": 29800,
      "Internet Hosts": 194142,
      "Internet Users": 208200,
      "Phones (Mobile)": 3223000,
      "Phones (Landline)": 584000,
      "GDP": 10440000000
    },
    {
      "Country Name": "Aruba",
      "ISO2": "AW",
      "ISO3": "ABW",
      "Top Level Domain": "aw",
      "FIPS": "AA",
      "ISO Numeric": 533,
      "GeoNameID": 3577279,
      "E164": 297,
      "Phone Code": 297,
      "Continent": "North America",
      "Capital": "Oranjestad",
      "Time Zone in Capital": "America/Curacao",
      "Currency": "Guilder",
      "Language Codes": "nl-AW,es,en",
      "Languages": "Papiamento (a Spanish-Portuguese-Dutch-English dialect) 69.4%, Spanish 13.7%, English (widely spoken) 7.1%, Dutch (official) 6.1%, Chinese 1.5%, other 1.7%, unspecified 0.4% (2010 est.)",
      "Area KM2": 193,
      "Internet Hosts": 40560,
      "Internet Users": 24000,
      "Phones (Mobile)": 135000,
      "Phones (Landline)": 43000,
      "GDP": 2516000000
    },
    {
      "Country Name": "Australia",
      "ISO2": "AU",
      "ISO3": "AUS",
      "Top Level Domain": "au",
      "FIPS": "AS",
      "ISO Numeric": "036",
      "GeoNameID": 2077456,
      "E164": 61,
      "Phone Code": 61,
      "Continent": "Oceania",
      "Capital": "Canberra",
      "Time Zone in Capital": "Australia/Sydney",
      "Currency": "Dollar",
      "Language Codes": "en-AU",
      "Languages": "English 76.8%, Mandarin 1.6%, Italian 1.4%, Arabic 1.3%, Greek 1.2%, Cantonese 1.2%, Vietnamese 1.1%, other 10.4%, unspecified 5% (2011 est.)",
      "Area KM2": 7686850,
      "Internet Hosts": 17081000,
      "Internet Users": 15810000,
      "Phones (Mobile)": 24400000,
      "Phones (Landline)": 10470000,
      "GDP": 1488000000000
    },
    {
      "Country Name": "Austria",
      "ISO2": "AT",
      "ISO3": "AUT",
      "Top Level Domain": "at",
      "FIPS": "AU",
      "ISO Numeric": "040",
      "GeoNameID": 2782113,
      "E164": 43,
      "Phone Code": 43,
      "Continent": "Europe",
      "Capital": "Vienna",
      "Time Zone in Capital": "Europe/Vienna",
      "Currency": "Euro",
      "Language Codes": "de-AT,hr,hu,sl",
      "Languages": "German (official nationwide) 88.6%, Turkish 2.3%, Serbian 2.2%, Croatian (official in Burgenland) 1.6%, other (includes Slovene, official in Carinthia, and Hungarian, official in Burgenland) 5.3% (2001 census)",
      "Area KM2": 83858,
      "Internet Hosts": 3512000,
      "Internet Users": 6143000,
      "Phones (Mobile)": 13590000,
      "Phones (Landline)": 3342000,
      "GDP": 417900000000
    },
    {
      "Country Name": "Azerbaijan",
      "ISO2": "AZ",
      "ISO3": "AZE",
      "Top Level Domain": "az",
      "FIPS": "AJ",
      "ISO Numeric": "031",
      "GeoNameID": 587116,
      "E164": 994,
      "Phone Code": 994,
      "Continent": "Asia",
      "Capital": "Baku",
      "Time Zone in Capital": "Asia/Baku",
      "Currency": "Manat",
      "Language Codes": "az,ru,hy",
      "Languages": "Azerbaijani (Azeri) (official) 92.5%, Russian 1.4%, Armenian 1.4%, other 4.7% (2009 est.)",
      "Area KM2": 86600,
      "Internet Hosts": 46856,
      "Internet Users": 2420000,
      "Phones (Mobile)": 10125000,
      "Phones (Landline)": 1734000,
      "GDP": 76010000000
    },
    {
      "Country Name": "Bahamas",
      "ISO2": "BS",
      "ISO3": "BHS",
      "Top Level Domain": "bs",
      "FIPS": "BF",
      "ISO Numeric": "044",
      "GeoNameID": 3572887,
      "E164": 1,
      "Phone Code": "1-242",
      "Continent": "North America",
      "Capital": "Nassau",
      "Time Zone in Capital": "America/Nassau",
      "Currency": "Dollar",
      "Language Codes": "en-BS",
      "Languages": "English (official), Creole (among Haitian immigrants)",
      "Area KM2": 13940,
      "Internet Hosts": 20661,
      "Internet Users": 115800,
      "Phones (Mobile)": 254000,
      "Phones (Landline)": 137000,
      "GDP": 8373000000
    },
    {
      "Country Name": "Bahrain",
      "ISO2": "BH",
      "ISO3": "BHR",
      "Top Level Domain": "bh",
      "FIPS": "BA",
      "ISO Numeric": "048",
      "GeoNameID": 290291,
      "E164": 973,
      "Phone Code": 973,
      "Continent": "Asia",
      "Capital": "Manama",
      "Time Zone in Capital": "Asia/Bahrain",
      "Currency": "Dinar",
      "Language Codes": "ar-BH,en,fa,ur",
      "Languages": "Arabic (official), English, Farsi, Urdu",
      "Area KM2": 665,
      "Internet Hosts": 47727,
      "Internet Users": 419500,
      "Phones (Mobile)": 2125000,
      "Phones (Landline)": 290000,
      "GDP": 28360000000
    },
    {
      "Country Name": "Bangladesh",
      "ISO2": "BD",
      "ISO3": "BGD",
      "Top Level Domain": "bd",
      "FIPS": "BG",
      "ISO Numeric": "050",
      "GeoNameID": 1210997,
      "E164": 880,
      "Phone Code": 880,
      "Continent": "Asia",
      "Capital": "Dhaka",
      "Time Zone in Capital": "Asia/Dhaka",
      "Currency": "Taka",
      "Language Codes": "bn-BD,en",
      "Languages": "Bangla (official, also known as Bengali), English",
      "Area KM2": 144000,
      "Internet Hosts": 71164,
      "Internet Users": 617300,
      "Phones (Mobile)": 97180000,
      "Phones (Landline)": 962000,
      "GDP": 140200000000
    },
    {
      "Country Name": "Barbados",
      "ISO2": "BB",
      "ISO3": "BRB",
      "Top Level Domain": "bb",
      "FIPS": "BB",
      "ISO Numeric": "052",
      "GeoNameID": 3374084,
      "E164": 1,
      "Phone Code": "1-246",
      "Continent": "North America",
      "Capital": "Bridgetown",
      "Time Zone in Capital": "America/Barbados",
      "Currency": "Dollar",
      "Language Codes": "en-BB",
      "Languages": "English (official), Bajan (English-based creole language, widely spoken in informal settings)",
      "Area KM2": 431,
      "Internet Hosts": 1524,
      "Internet Users": 188000,
      "Phones (Mobile)": 347000,
      "Phones (Landline)": 144000,
      "GDP": 4262000000
    },
    {
      "Country Name": "Belarus",
      "ISO2": "BY",
      "ISO3": "BLR",
      "Top Level Domain": "by",
      "FIPS": "BO",
      "ISO Numeric": 112,
      "GeoNameID": 630336,
      "E164": 375,
      "Phone Code": 375,
      "Continent": "Europe",
      "Capital": "Minsk",
      "Time Zone in Capital": "Europe/Minsk",
      "Currency": "Ruble",
      "Language Codes": "be,ru",
      "Languages": "Belarusian (official) 23.4%, Russian (official) 70.2%, other 3.1% (includes small Polish- and Ukrainian-speaking minorities), unspecified 3.3% (2009 est.)",
      "Area KM2": 207600,
      "Internet Hosts": 295217,
      "Internet Users": 2643000,
      "Phones (Mobile)": 10675000,
      "Phones (Landline)": 4407000,
      "GDP": 69240000000
    },
    {
      "Country Name": "Belgium",
      "ISO2": "BE",
      "ISO3": "BEL",
      "Top Level Domain": "be",
      "FIPS": "BE",
      "ISO Numeric": "056",
      "GeoNameID": 2802361,
      "E164": 32,
      "Phone Code": 32,
      "Continent": "Europe",
      "Capital": "Brussels",
      "Time Zone in Capital": "Europe/Brussels",
      "Currency": "Euro",
      "Language Codes": "nl-BE,fr-BE,de-BE",
      "Languages": "Dutch (official) 60%, French (official) 40%, German (official) less than 1%, legally bilingual (Dutch and French)",
      "Area KM2": 30510,
      "Internet Hosts": 5192000,
      "Internet Users": 8113000,
      "Phones (Mobile)": 12880000,
      "Phones (Landline)": 4631000,
      "GDP": 507400000000
    },
    {
      "Country Name": "Belize",
      "ISO2": "BZ",
      "ISO3": "BLZ",
      "Top Level Domain": "bz",
      "FIPS": "BH",
      "ISO Numeric": "084",
      "GeoNameID": 3582678,
      "E164": 501,
      "Phone Code": 501,
      "Continent": "North America",
      "Capital": "Belmopan",
      "Time Zone in Capital": "America/Belize",
      "Currency": "Dollar",
      "Language Codes": "en-BZ,es",
      "Languages": "Spanish 46%, Creole 32.9%, Mayan dialects 8.9%, English 3.9% (official), Garifuna 3.4% (Carib), German 3.3%, other 1.4%, unknown 0.2% (2000 census)",
      "Area KM2": 22966,
      "Internet Hosts": 3392,
      "Internet Users": 36000,
      "Phones (Mobile)": 164200,
      "Phones (Landline)": 25400,
      "GDP": 1637000000
    },
    {
      "Country Name": "Benin",
      "ISO2": "BJ",
      "ISO3": "BEN",
      "Top Level Domain": "bj",
      "FIPS": "BN",
      "ISO Numeric": 204,
      "GeoNameID": 2395170,
      "E164": 229,
      "Phone Code": 229,
      "Continent": "Africa",
      "Capital": "Porto-Novo",
      "Time Zone in Capital": "Africa/Lagos",
      "Currency": "Franc",
      "Language Codes": "fr-BJ",
      "Languages": "French (official), Fon and Yoruba (most common vernaculars in south), tribal languages (at least six major ones in north)",
      "Area KM2": 112620,
      "Internet Hosts": 491,
      "Internet Users": 200100,
      "Phones (Mobile)": 8408000,
      "Phones (Landline)": 156700,
      "GDP": 8359000000
    },
    {
      "Country Name": "Bermuda",
      "ISO2": "BM",
      "ISO3": "BMU",
      "Top Level Domain": "bm",
      "FIPS": "BD",
      "ISO Numeric": "060",
      "GeoNameID": 3573345,
      "E164": 1,
      "Phone Code": "1-441",
      "Continent": "North America",
      "Capital": "Hamilton",
      "Time Zone in Capital": "Atlantic/Bermuda",
      "Currency": "Dollar",
      "Language Codes": "en-BM,pt",
      "Languages": "English (official), Portuguese",
      "Area KM2": 53,
      "Internet Hosts": 20040,
      "Internet Users": 54000,
      "Phones (Mobile)": 91000,
      "Phones (Landline)": 69000,
      "GDP": 5600000000
    },
    {
      "Country Name": "Bhutan",
      "ISO2": "BT",
      "ISO3": "BTN",
      "Top Level Domain": "bt",
      "FIPS": "BT",
      "ISO Numeric": "064",
      "GeoNameID": 1252634,
      "E164": 975,
      "Phone Code": 975,
      "Continent": "Asia",
      "Capital": "Thimphu",
      "Time Zone in Capital": "Asia/Thimphu",
      "Currency": "Ngultrum",
      "Language Codes": "dz",
      "Languages": "Sharchhopka 28%, Dzongkha (official) 24%, Lhotshamkha 22%, other 26% (includes foreign languages) (2005 est.)",
      "Area KM2": 47000,
      "Internet Hosts": 14590,
      "Internet Users": 50000,
      "Phones (Mobile)": 560000,
      "Phones (Landline)": 27000,
      "GDP": 2133000000
    },
    {
      "Country Name": "Bolivia",
      "ISO2": "BO",
      "ISO3": "BOL",
      "Top Level Domain": "bo",
      "FIPS": "BL",
      "ISO Numeric": "068",
      "GeoNameID": 3923057,
      "E164": 591,
      "Phone Code": 591,
      "Continent": "South America",
      "Capital": "Sucre",
      "Time Zone in Capital": "America/La_Paz",
      "Currency": "Boliviano",
      "Language Codes": "es-BO,qu,ay",
      "Languages": "Spanish (official) 60.7%, Quechua (official) 21.2%, Aymara (official) 14.6%, Guarani (official), foreign languages 2.4%, other 1.2%",
      "Area KM2": 1098580,
      "Internet Hosts": 180988,
      "Internet Users": 1103000,
      "Phones (Mobile)": 9494000,
      "Phones (Landline)": 880600,
      "GDP": 30790000000
    },
    {
      "Country Name": "Bosnia and Herzegovina",
      "ISO2": "BA",
      "ISO3": "BIH",
      "Top Level Domain": "ba",
      "FIPS": "BK",
      "ISO Numeric": "070",
      "GeoNameID": 3277605,
      "E164": 387,
      "Phone Code": 387,
      "Continent": "Europe",
      "Capital": "Sarajevo",
      "Time Zone in Capital": "Europe/Belgrade",
      "Currency": "Marka",
      "Language Codes": "bs,hr-BA,sr-BA",
      "Languages": "Bosnian (official), Croatian (official), Serbian (official)",
      "Area KM2": 51129,
      "Internet Hosts": 155252,
      "Internet Users": 1422000,
      "Phones (Mobile)": 3350000,
      "Phones (Landline)": 878000,
      "GDP": 18870000000
    },
    {
      "Country Name": "Botswana",
      "ISO2": "BW",
      "ISO3": "BWA",
      "Top Level Domain": "bw",
      "FIPS": "BC",
      "ISO Numeric": "072",
      "GeoNameID": 933860,
      "E164": 267,
      "Phone Code": 267,
      "Continent": "Africa",
      "Capital": "Gaborone",
      "Time Zone in Capital": "Africa/Maputo",
      "Currency": "Pula",
      "Language Codes": "en-BW,tn-BW",
      "Languages": "Setswana 78.2%, Kalanga 7.9%, Sekgalagadi 2.8%, English (official) 2.1%, other 8.6%, unspecified 0.4% (2001 census)",
      "Area KM2": 600370,
      "Internet Hosts": 1806,
      "Internet Users": 120000,
      "Phones (Mobile)": 3082000,
      "Phones (Landline)": 160500,
      "GDP": 15530000000
    },
    {
      "Country Name": "Brazil",
      "ISO2": "BR",
      "ISO3": "BRA",
      "Top Level Domain": "br",
      "FIPS": "BR",
      "ISO Numeric": "076",
      "GeoNameID": 3469034,
      "E164": 55,
      "Phone Code": 55,
      "Continent": "South America",
      "Capital": "Brasilia",
      "Time Zone in Capital": "America/Sao_Paulo",
      "Currency": "Real",
      "Language Codes": "pt-BR,es,en,fr",
      "Languages": "Portuguese (official and most widely spoken language)",
      "Area KM2": 8511965,
      "Internet Hosts": 26577000,
      "Internet Users": 75982000,
      "Phones (Mobile)": 248324000,
      "Phones (Landline)": 44300000,
      "GDP": 2190000000000
    },
    {
      "Country Name": "British Indian Ocean Territory",
      "ISO2": "IO",
      "ISO3": "IOT",
      "Top Level Domain": "io",
      "FIPS": "IO",
      "ISO Numeric": "086",
      "GeoNameID": 1282588,
      "E164": 246,
      "Phone Code": 246,
      "Continent": "Asia",
      "Capital": "Diego Garcia",
      "Time Zone in Capital": "Indian/Chagos",
      "Currency": "Dollar",
      "Language Codes": "en-IO",
      "Languages": "English",
      "Area KM2": 60,
      "Internet Hosts": 75006,
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "British Virgin Islands",
      "ISO2": "VG",
      "ISO3": "VGB",
      "Top Level Domain": "vg",
      "FIPS": "VI",
      "ISO Numeric": "092",
      "GeoNameID": 3577718,
      "E164": 1,
      "Phone Code": "1-284",
      "Continent": "North America",
      "Capital": "Road Town",
      "Time Zone in Capital": "America/Port_of_Spain",
      "Currency": "Dollar",
      "Language Codes": "en-VG",
      "Languages": "English (official)",
      "Area KM2": 153,
      "Internet Hosts": 505,
      "Internet Users": 4000,
      "Phones (Mobile)": 48700,
      "Phones (Landline)": 12268,
      "GDP": 1095000000
    },
    {
      "Country Name": "Brunei",
      "ISO2": "BN",
      "ISO3": "BRN",
      "Top Level Domain": "bn",
      "FIPS": "BX",
      "ISO Numeric": "096",
      "GeoNameID": 1820814,
      "E164": 673,
      "Phone Code": 673,
      "Continent": "Asia",
      "Capital": "Bandar Seri Begawan",
      "Time Zone in Capital": "Asia/Brunei",
      "Currency": "Dollar",
      "Language Codes": "ms-BN,en-BN",
      "Languages": "Malay (official), English, Chinese",
      "Area KM2": 5770,
      "Internet Hosts": 49457,
      "Internet Users": 314900,
      "Phones (Mobile)": 469700,
      "Phones (Landline)": 70933,
      "GDP": 16560000000
    },
    {
      "Country Name": "Bulgaria",
      "ISO2": "BG",
      "ISO3": "BGR",
      "Top Level Domain": "bg",
      "FIPS": "BU",
      "ISO Numeric": 100,
      "GeoNameID": 732800,
      "E164": 359,
      "Phone Code": 359,
      "Continent": "Europe",
      "Capital": "Sofia",
      "Time Zone in Capital": "Europe/Sofia",
      "Currency": "Lev",
      "Language Codes": "bg,tr-BG",
      "Languages": "Bulgarian (official) 76.8%, Turkish 8.2%, Roma 3.8%, other 0.7%, unspecified 10.5% (2011 est.)",
      "Area KM2": 110910,
      "Internet Hosts": 976277,
      "Internet Users": 3395000,
      "Phones (Mobile)": 10780000,
      "Phones (Landline)": 2253000,
      "GDP": 53700000000
    },
    {
      "Country Name": "Burkina Faso",
      "ISO2": "BF",
      "ISO3": "BFA",
      "Top Level Domain": "bf",
      "FIPS": "UV",
      "ISO Numeric": 854,
      "GeoNameID": 2361809,
      "E164": 226,
      "Phone Code": 226,
      "Continent": "Africa",
      "Capital": "Ouagadougou",
      "Time Zone in Capital": "Africa/Abidjan",
      "Currency": "Franc",
      "Language Codes": "fr-BF",
      "Languages": "French (official), native African languages belonging to Sudanic family spoken by 90% of the population",
      "Area KM2": 274200,
      "Internet Hosts": 1795,
      "Internet Users": 178100,
      "Phones (Mobile)": 9980000,
      "Phones (Landline)": 141400,
      "GDP": 12130000000
    },
    {
      "Country Name": "Burundi",
      "ISO2": "BI",
      "ISO3": "BDI",
      "Top Level Domain": "bi",
      "FIPS": "BY",
      "ISO Numeric": 108,
      "GeoNameID": 433561,
      "E164": 257,
      "Phone Code": 257,
      "Continent": "Africa",
      "Capital": "Bujumbura",
      "Time Zone in Capital": "Africa/Maputo",
      "Currency": "Franc",
      "Language Codes": "fr-BI,rn",
      "Languages": "Kirundi 29.7% (official), Kirundi and other language 9.1%, French (official) and French and other language 0.3%, Swahili and Swahili and other language 0.2% (along Lake Tanganyika and in the Bujumbura area), English and English and other language 0.06%, more than 2 languages 3.7%, unspecified 56.9% (2008 est.)",
      "Area KM2": 27830,
      "Internet Hosts": 229,
      "Internet Users": 157800,
      "Phones (Mobile)": 2247000,
      "Phones (Landline)": 17400,
      "GDP": 2676000000
    },
    {
      "Country Name": "Cambodia",
      "ISO2": "KH",
      "ISO3": "KHM",
      "Top Level Domain": "kh",
      "FIPS": "CB",
      "ISO Numeric": 116,
      "GeoNameID": 1831722,
      "E164": 855,
      "Phone Code": 855,
      "Continent": "Asia",
      "Capital": "Phnom Penh",
      "Time Zone in Capital": "Asia/Phnom_Penh",
      "Currency": "Riels",
      "Language Codes": "km,fr,en",
      "Languages": "Khmer (official) 96.3%, other 3.7% (2008 est.)",
      "Area KM2": 181040,
      "Internet Hosts": 13784,
      "Internet Users": 78500,
      "Phones (Mobile)": 19100000,
      "Phones (Landline)": 584000,
      "GDP": 15640000000
    },
    {
      "Country Name": "Cameroon",
      "ISO2": "CM",
      "ISO3": "CMR",
      "Top Level Domain": "cm",
      "FIPS": "CM",
      "ISO Numeric": 120,
      "GeoNameID": 2233387,
      "E164": 237,
      "Phone Code": 237,
      "Continent": "Africa",
      "Capital": "Yaounde",
      "Time Zone in Capital": "Africa/Lagos",
      "Currency": "Franc",
      "Language Codes": "en-CM,fr-CM",
      "Languages": "24 major African language groups, English (official), French (official)",
      "Area KM2": 475440,
      "Internet Hosts": 10207,
      "Internet Users": 749600,
      "Phones (Mobile)": 13100000,
      "Phones (Landline)": 737400,
      "GDP": 27880000000
    },
    {
      "Country Name": "Canada",
      "ISO2": "CA",
      "ISO3": "CAN",
      "Top Level Domain": "ca",
      "FIPS": "CA",
      "ISO Numeric": 124,
      "GeoNameID": 6251999,
      "E164": 1,
      "Phone Code": 1,
      "Continent": "North America",
      "Capital": "Ottawa",
      "Time Zone in Capital": "America/Toronto",
      "Currency": "Dollar",
      "Language Codes": "en-CA,fr-CA,iu",
      "Languages": "English (official) 58.7%, French (official) 22%, Punjabi 1.4%, Italian 1.3%, Spanish 1.3%, German 1.3%, Cantonese 1.2%, Tagalog 1.2%, Arabic 1.1%, other 10.5% (2011 est.)",
      "Area KM2": 9984670,
      "Internet Hosts": 8743000,
      "Internet Users": 26960000,
      "Phones (Mobile)": 26263000,
      "Phones (Landline)": 18010000,
      "GDP": 1825000000000
    },
    {
      "Country Name": "Cape Verde",
      "ISO2": "CV",
      "ISO3": "CPV",
      "Top Level Domain": "cv",
      "FIPS": "CV",
      "ISO Numeric": 132,
      "GeoNameID": 3374766,
      "E164": 238,
      "Phone Code": 238,
      "Continent": "Africa",
      "Capital": "Praia",
      "Time Zone in Capital": "Atlantic/Cape_Verde",
      "Currency": "Escudo",
      "Language Codes": "pt-CV",
      "Languages": "Portuguese (official), Crioulo (a blend of Portuguese and West African words)",
      "Area KM2": 4033,
      "Internet Hosts": 38,
      "Internet Users": 150000,
      "Phones (Mobile)": 425300,
      "Phones (Landline)": 70200,
      "GDP": 1955000000
    },
    {
      "Country Name": "Cayman Islands",
      "ISO2": "KY",
      "ISO3": "CYM",
      "Top Level Domain": "ky",
      "FIPS": "CJ",
      "ISO Numeric": 136,
      "GeoNameID": 3580718,
      "E164": 1,
      "Phone Code": "1-345",
      "Continent": "North America",
      "Capital": "George Town",
      "Time Zone in Capital": "America/Cayman",
      "Currency": "Dollar",
      "Language Codes": "en-KY",
      "Languages": "English (official) 90.9%, Spanish 4%, Filipino 3.3%, other 1.7%, unspecified 0.1% (2010 est.)",
      "Area KM2": 262,
      "Internet Hosts": 23472,
      "Internet Users": 23000,
      "Phones (Mobile)": 96300,
      "Phones (Landline)": 37400,
      "GDP": 2250000000
    },
    {
      "Country Name": "Central African Republic",
      "ISO2": "CF",
      "ISO3": "CAF",
      "Top Level Domain": "cf",
      "FIPS": "CT",
      "ISO Numeric": 140,
      "GeoNameID": 239880,
      "E164": 236,
      "Phone Code": 236,
      "Continent": "Africa",
      "Capital": "Bangui",
      "Time Zone in Capital": "Africa/Lagos",
      "Currency": "Franc",
      "Language Codes": "fr-CF,sg,ln,kg",
      "Languages": "French (official), Sangho (lingua franca and national language), tribal languages",
      "Area KM2": 622984,
      "Internet Hosts": 20,
      "Internet Users": 22600,
      "Phones (Mobile)": 1070000,
      "Phones (Landline)": 5600,
      "GDP": 2050000000
    },
    {
      "Country Name": "Chad",
      "ISO2": "TD",
      "ISO3": "TCD",
      "Top Level Domain": "td",
      "FIPS": "CD",
      "ISO Numeric": 148,
      "GeoNameID": 2434508,
      "E164": 235,
      "Phone Code": 235,
      "Continent": "Africa",
      "Capital": "N'Djamena",
      "Time Zone in Capital": "Africa/Ndjamena",
      "Currency": "Franc",
      "Language Codes": "fr-TD,ar-TD,sre",
      "Languages": "French (official), Arabic (official), Sara (in south), more than 120 different languages and dialects",
      "Area KM2": 1284000,
      "Internet Hosts": 6,
      "Internet Users": 168100,
      "Phones (Mobile)": 4200000,
      "Phones (Landline)": 29900,
      "GDP": 13590000000
    },
    {
      "Country Name": "Chile",
      "ISO2": "CL",
      "ISO3": "CHL",
      "Top Level Domain": "cl",
      "FIPS": "CI",
      "ISO Numeric": 152,
      "GeoNameID": 3895114,
      "E164": 56,
      "Phone Code": 56,
      "Continent": "South America",
      "Capital": "Santiago",
      "Time Zone in Capital": "America/Santiago",
      "Currency": "Peso",
      "Language Codes": "es-CL",
      "Languages": "Spanish 99.5% (official), English 10.2%, indigenous 1% (includes Mapudungun, Aymara, Quechua, Rapa Nui), other 2.3%, unspecified 0.2%",
      "Area KM2": 756950,
      "Internet Hosts": 2152000,
      "Internet Users": 7009000,
      "Phones (Mobile)": 24130000,
      "Phones (Landline)": 3276000,
      "GDP": 281700000000
    },
    {
      "Country Name": "China",
      "ISO2": "CN",
      "ISO3": "CHN",
      "Top Level Domain": "cn",
      "FIPS": "CH",
      "ISO Numeric": 156,
      "GeoNameID": 1814991,
      "E164": 86,
      "Phone Code": 86,
      "Continent": "Asia",
      "Capital": "Beijing",
      "Time Zone in Capital": "Asia/Shanghai",
      "Currency": "Yuan Renminbi",
      "Language Codes": "zh-CN,yue,wuu,dta,ug,za",
      "Languages": "Standard Chinese or Mandarin (official; Putonghua, based on the Beijing dialect), Yue (Cantonese), Wu (Shanghainese), Minbei (Fuzhou), Minnan (Hokkien-Taiwanese), Xiang, Gan, Hakka dialects, minority languages",
      "Area KM2": 9596960,
      "Internet Hosts": 20602000,
      "Internet Users": 389000000,
      "Phones (Mobile)": 1100000000,
      "Phones (Landline)": 278860000,
      "GDP": 9330000000000
    },
    {
      "Country Name": "Christmas Island",
      "ISO2": "CX",
      "ISO3": "CXR",
      "Top Level Domain": "cx",
      "FIPS": "KT",
      "ISO Numeric": 162,
      "GeoNameID": 2078138,
      "E164": 61,
      "Phone Code": 61,
      "Continent": "Asia",
      "Capital": "Flying Fish Cove",
      "Time Zone in Capital": "Indian/Christmas",
      "Currency": "Dollar",
      "Language Codes": "en,zh,ms-CC",
      "Languages": "English (official), Chinese, Malay",
      "Area KM2": 135,
      "Internet Hosts": 3028,
      "Internet Users": 464,
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Cocos Islands",
      "ISO2": "CC",
      "ISO3": "CCK",
      "Top Level Domain": "cc",
      "FIPS": "CK",
      "ISO Numeric": 166,
      "GeoNameID": 1547376,
      "E164": 61,
      "Phone Code": 61,
      "Continent": "Asia",
      "Capital": "West Island",
      "Time Zone in Capital": "Indian/Cocos",
      "Currency": "Dollar",
      "Language Codes": "ms-CC,en",
      "Languages": "Malay (Cocos dialect), English",
      "Area KM2": 14,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Colombia",
      "ISO2": "CO",
      "ISO3": "COL",
      "Top Level Domain": "co",
      "FIPS": "CO",
      "ISO Numeric": 170,
      "GeoNameID": 3686110,
      "E164": 57,
      "Phone Code": 57,
      "Continent": "South America",
      "Capital": "Bogota",
      "Time Zone in Capital": "America/Bogota",
      "Currency": "Peso",
      "Language Codes": "es-CO",
      "Languages": "Spanish (official)",
      "Area KM2": 1138910,
      "Internet Hosts": 4410000,
      "Internet Users": 22538000,
      "Phones (Mobile)": 49066000,
      "Phones (Landline)": 6291000,
      "GDP": 369200000000
    },
    {
      "Country Name": "Comoros",
      "ISO2": "KM",
      "ISO3": "COM",
      "Top Level Domain": "km",
      "FIPS": "CN",
      "ISO Numeric": 174,
      "GeoNameID": 921929,
      "E164": 269,
      "Phone Code": 269,
      "Continent": "Africa",
      "Capital": "Moroni",
      "Time Zone in Capital": "Indian/Comoro",
      "Currency": "Franc",
      "Language Codes": "ar,fr-KM",
      "Languages": "Arabic (official), French (official), Shikomoro (a blend of Swahili and Arabic)",
      "Area KM2": 2170,
      "Internet Hosts": 14,
      "Internet Users": 24300,
      "Phones (Mobile)": 250000,
      "Phones (Landline)": 24000,
      "GDP": 658000000
    },
    {
      "Country Name": "Cook Islands",
      "ISO2": "CK",
      "ISO3": "COK",
      "Top Level Domain": "ck",
      "FIPS": "CW",
      "ISO Numeric": 184,
      "GeoNameID": 1899402,
      "E164": 682,
      "Phone Code": 682,
      "Continent": "Oceania",
      "Capital": "Avarua",
      "Time Zone in Capital": "Pacific/Rarotonga",
      "Currency": "Dollar",
      "Language Codes": "en-CK,mi",
      "Languages": "English (official) 86.4%, Cook Islands Maori (Rarotongan) (official) 76.2%, other 8.3%",
      "Area KM2": 240,
      "Internet Hosts": 3562,
      "Internet Users": 6000,
      "Phones (Mobile)": 7800,
      "Phones (Landline)": 7200,
      "GDP": 183200000
    },
    {
      "Country Name": "Costa Rica",
      "ISO2": "CR",
      "ISO3": "CRI",
      "Top Level Domain": "cr",
      "FIPS": "CS",
      "ISO Numeric": 188,
      "GeoNameID": 3624060,
      "E164": 506,
      "Phone Code": 506,
      "Continent": "North America",
      "Capital": "San Jose",
      "Time Zone in Capital": "America/Costa_Rica",
      "Currency": "Colon",
      "Language Codes": "es-CR,en",
      "Languages": "Spanish (official), English",
      "Area KM2": 51100,
      "Internet Hosts": 147258,
      "Internet Users": 1485000,
      "Phones (Mobile)": 6151000,
      "Phones (Landline)": 1018000,
      "GDP": 48510000000
    },
    {
      "Country Name": "Croatia",
      "ISO2": "HR",
      "ISO3": "HRV",
      "Top Level Domain": "hr",
      "FIPS": "HR",
      "ISO Numeric": 191,
      "GeoNameID": 3202326,
      "E164": 385,
      "Phone Code": 385,
      "Continent": "Europe",
      "Capital": "Zagreb",
      "Time Zone in Capital": "Europe/Belgrade",
      "Currency": "Kuna",
      "Language Codes": "hr-HR,sr",
      "Languages": "Croatian (official) 95.6%, Serbian 1.2%, other 3% (including Hungarian, Czech, Slovak, and Albanian), unspecified 0.2% (2011 est.)",
      "Area KM2": 56542,
      "Internet Hosts": 729420,
      "Internet Users": 2234000,
      "Phones (Mobile)": 4970000,
      "Phones (Landline)": 1640000,
      "GDP": 59140000000
    },
    {
      "Country Name": "Cuba",
      "ISO2": "CU",
      "ISO3": "CUB",
      "Top Level Domain": "cu",
      "FIPS": "CU",
      "ISO Numeric": 192,
      "GeoNameID": 3562981,
      "E164": 53,
      "Phone Code": 53,
      "Continent": "North America",
      "Capital": "Havana",
      "Time Zone in Capital": "America/Havana",
      "Currency": "Peso",
      "Language Codes": "es-CU",
      "Languages": "Spanish (official)",
      "Area KM2": 110860,
      "Internet Hosts": 3244,
      "Internet Users": 1606000,
      "Phones (Mobile)": 1682000,
      "Phones (Landline)": 1217000,
      "GDP": 72300000000
    },
    {
      "Country Name": "Curacao",
      "ISO2": "CW",
      "ISO3": "CUW",
      "Top Level Domain": "cw",
      "FIPS": "UC",
      "ISO Numeric": 531,
      "GeoNameID": 7626836,
      "E164": 599,
      "Phone Code": 599,
      "Continent": "North America",
      "Capital": "Willemstad",
      "Time Zone in Capital": "America/Curacao",
      "Currency": "Guilder",
      "Language Codes": "nl,pap",
      "Languages": "Papiamentu (a Spanish-Portuguese-Dutch-English dialect) 81.2%, Dutch (official) 8%, Spanish 4%, English 2.9%, other 3.9% (2001 census)",
      "Area KM2": 444,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 5600000000
    },
    {
      "Country Name": "Cyprus",
      "ISO2": "CY",
      "ISO3": "CYP",
      "Top Level Domain": "cy",
      "FIPS": "CY",
      "ISO Numeric": 196,
      "GeoNameID": 146669,
      "E164": 357,
      "Phone Code": 357,
      "Continent": "Europe",
      "Capital": "Nicosia",
      "Time Zone in Capital": "Asia/Nicosia",
      "Currency": "Euro",
      "Language Codes": "el-CY,tr-CY,en",
      "Languages": "Greek (official) 80.9%, Turkish (official) 0.2%, English 4.1%, Romanian 2.9%, Russian 2.5%, Bulgarian 2.2%, Arabic 1.2%, Filippino 1.1%, other 4.3%, unspecified 0.6% (2011 est.)",
      "Area KM2": 9250,
      "Internet Hosts": 252013,
      "Internet Users": 433900,
      "Phones (Mobile)": 1110000,
      "Phones (Landline)": 373200,
      "GDP": 21780000000
    },
    {
      "Country Name": "Czech Republic",
      "ISO2": "CZ",
      "ISO3": "CZE",
      "Top Level Domain": "cz",
      "FIPS": "EZ",
      "ISO Numeric": 203,
      "GeoNameID": 3077311,
      "E164": 420,
      "Phone Code": 420,
      "Continent": "Europe",
      "Capital": "Prague",
      "Time Zone in Capital": "Europe/Prague",
      "Currency": "Koruna",
      "Language Codes": "cs,sk",
      "Languages": "Czech 95.4%, Slovak 1.6%, other 3% (2011 census)",
      "Area KM2": 78866,
      "Internet Hosts": 4148000,
      "Internet Users": 6681000,
      "Phones (Mobile)": 12973000,
      "Phones (Landline)": 2100000,
      "GDP": 194800000000
    },
    {
      "Country Name": "Democratic Republic of the Congo",
      "ISO2": "CD",
      "ISO3": "COD",
      "Top Level Domain": "cd",
      "FIPS": "CG",
      "ISO Numeric": 180,
      "GeoNameID": 203312,
      "E164": 243,
      "Phone Code": 243,
      "Continent": "Africa",
      "Capital": "Kinshasa",
      "Time Zone in Capital": "Africa/Lagos",
      "Currency": "Franc",
      "Language Codes": "fr-CD,ln,kg",
      "Languages": "French (official), Lingala (a lingua franca trade language), Kingwana (a dialect of Kiswahili or Swahili), Kikongo, Tshiluba",
      "Area KM2": 2345410,
      "Internet Hosts": 2515,
      "Internet Users": 290000,
      "Phones (Mobile)": 19487000,
      "Phones (Landline)": 58200,
      "GDP": 18560000000
    },
    {
      "Country Name": "Denmark",
      "ISO2": "DK",
      "ISO3": "DNK",
      "Top Level Domain": "dk",
      "FIPS": "DA",
      "ISO Numeric": 208,
      "GeoNameID": 2623032,
      "E164": 45,
      "Phone Code": 45,
      "Continent": "Europe",
      "Capital": "Copenhagen",
      "Time Zone in Capital": "Europe/Copenhagen",
      "Currency": "Krone",
      "Language Codes": "da-DK,en,fo,de-DK",
      "Languages": "Danish, Faroese, Greenlandic (an Inuit dialect), German (small minority)",
      "Area KM2": 43094,
      "Internet Hosts": 4297000,
      "Internet Users": 4750000,
      "Phones (Mobile)": 6600000,
      "Phones (Landline)": 2431000,
      "GDP": 324300000000
    },
    {
      "Country Name": "Djibouti",
      "ISO2": "DJ",
      "ISO3": "DJI",
      "Top Level Domain": "dj",
      "FIPS": "DJ",
      "ISO Numeric": 262,
      "GeoNameID": 223816,
      "E164": 253,
      "Phone Code": 253,
      "Continent": "Africa",
      "Capital": "Djibouti",
      "Time Zone in Capital": "Africa/Djibouti",
      "Currency": "Franc",
      "Language Codes": "fr-DJ,ar,so-DJ,aa",
      "Languages": "French (official), Arabic (official), Somali, Afar",
      "Area KM2": 23000,
      "Internet Hosts": 215,
      "Internet Users": 25900,
      "Phones (Mobile)": 209000,
      "Phones (Landline)": 18000,
      "GDP": 1459000000
    },
    {
      "Country Name": "Dominica",
      "ISO2": "DM",
      "ISO3": "DMA",
      "Top Level Domain": "dm",
      "FIPS": "DO",
      "ISO Numeric": 212,
      "GeoNameID": 3575830,
      "E164": 1,
      "Phone Code": "1-767",
      "Continent": "North America",
      "Capital": "Roseau",
      "Time Zone in Capital": "America/Port_of_Spain",
      "Currency": "Dollar",
      "Language Codes": "en-DM",
      "Languages": "English (official), French patois",
      "Area KM2": 754,
      "Internet Hosts": 723,
      "Internet Users": 28000,
      "Phones (Mobile)": 109300,
      "Phones (Landline)": 14600,
      "GDP": 495000000
    },
    {
      "Country Name": "Dominican Republic",
      "ISO2": "DO",
      "ISO3": "DOM",
      "Top Level Domain": "do",
      "FIPS": "DR",
      "ISO Numeric": 214,
      "GeoNameID": 3508796,
      "E164": 1,
      "Phone Code": "1-809, 1-829, 1-849",
      "Continent": "North America",
      "Capital": "Santo Domingo",
      "Time Zone in Capital": "America/Santo_Domingo",
      "Currency": "Peso",
      "Language Codes": "es-DO",
      "Languages": "Spanish (official)",
      "Area KM2": 48730,
      "Internet Hosts": 404500,
      "Internet Users": 2701000,
      "Phones (Mobile)": 9038000,
      "Phones (Landline)": 1065000,
      "GDP": 59270000000
    },
    {
      "Country Name": "East Timor",
      "ISO2": "TL",
      "ISO3": "TLS",
      "Top Level Domain": "tl",
      "FIPS": "TT",
      "ISO Numeric": 626,
      "GeoNameID": 1966436,
      "E164": 670,
      "Phone Code": 670,
      "Continent": "Oceania",
      "Capital": "Dili",
      "Time Zone in Capital": "Asia/Dili",
      "Currency": "Dollar",
      "Language Codes": "tet,pt-TL,id,en",
      "Languages": "Tetum (official), Portuguese (official), Indonesian, English",
      "Area KM2": 15007,
      "Internet Hosts": 252,
      "Internet Users": 2100,
      "Phones (Mobile)": 621000,
      "Phones (Landline)": 3000,
      "GDP": 6129000000
    },
    {
      "Country Name": "Ecuador",
      "ISO2": "EC",
      "ISO3": "ECU",
      "Top Level Domain": "ec",
      "FIPS": "EC",
      "ISO Numeric": 218,
      "GeoNameID": 3658394,
      "E164": 593,
      "Phone Code": 593,
      "Continent": "South America",
      "Capital": "Quito",
      "Time Zone in Capital": "America/Guayaquil",
      "Currency": "Dollar",
      "Language Codes": "es-EC",
      "Languages": "Spanish (Castillian) 93% (official), Quechua 4.1%, other indigenous 0.7%, foreign 2.2%",
      "Area KM2": 283560,
      "Internet Hosts": 170538,
      "Internet Users": 3352000,
      "Phones (Mobile)": 16457000,
      "Phones (Landline)": 2310000,
      "GDP": 91410000000
    },
    {
      "Country Name": "Egypt",
      "ISO2": "EG",
      "ISO3": "EGY",
      "Top Level Domain": "eg",
      "FIPS": "EG",
      "ISO Numeric": 818,
      "GeoNameID": 357994,
      "E164": 20,
      "Phone Code": 20,
      "Continent": "Africa",
      "Capital": "Cairo",
      "Time Zone in Capital": "Africa/Cairo",
      "Currency": "Pound",
      "Language Codes": "ar-EG,en,fr",
      "Languages": "Arabic (official), English and French widely understood by educated classes",
      "Area KM2": 1001450,
      "Internet Hosts": 200430,
      "Internet Users": 20136000,
      "Phones (Mobile)": 96800000,
      "Phones (Landline)": 8557000,
      "GDP": 262000000000
    },
    {
      "Country Name": "El Salvador",
      "ISO2": "SV",
      "ISO3": "SLV",
      "Top Level Domain": "sv",
      "FIPS": "ES",
      "ISO Numeric": 222,
      "GeoNameID": 3585968,
      "E164": 503,
      "Phone Code": 503,
      "Continent": "North America",
      "Capital": "San Salvador",
      "Time Zone in Capital": "America/El_Salvador",
      "Currency": "Dollar",
      "Language Codes": "es-SV",
      "Languages": "Spanish (official), Nahua (among some Amerindians)",
      "Area KM2": 21040,
      "Internet Hosts": 24070,
      "Internet Users": 746000,
      "Phones (Mobile)": 8650000,
      "Phones (Landline)": 1060000,
      "GDP": 24670000000
    },
    {
      "Country Name": "Equatorial Guinea",
      "ISO2": "GQ",
      "ISO3": "GNQ",
      "Top Level Domain": "gq",
      "FIPS": "EK",
      "ISO Numeric": 226,
      "GeoNameID": 2309096,
      "E164": 240,
      "Phone Code": 240,
      "Continent": "Africa",
      "Capital": "Malabo",
      "Time Zone in Capital": "Africa/Lagos",
      "Currency": "Franc",
      "Language Codes": "es-GQ,fr",
      "Languages": "Spanish (official) 67.6%, other (includes French (official), Fang, Bubi) 32.4% (1994 census)",
      "Area KM2": 28051,
      "Internet Hosts": 7,
      "Internet Users": 14400,
      "Phones (Mobile)": 501000,
      "Phones (Landline)": 14900,
      "GDP": 17080000000
    },
    {
      "Country Name": "Eritrea",
      "ISO2": "ER",
      "ISO3": "ERI",
      "Top Level Domain": "er",
      "FIPS": "ER",
      "ISO Numeric": 232,
      "GeoNameID": 338010,
      "E164": 291,
      "Phone Code": 291,
      "Continent": "Africa",
      "Capital": "Asmara",
      "Time Zone in Capital": "Africa/Asmara",
      "Currency": "Nakfa",
      "Language Codes": "aa-ER,ar,tig,kun,ti-ER",
      "Languages": "Tigrinya (official), Arabic (official), English (official), Tigre, Kunama, Afar, other Cushitic languages",
      "Area KM2": 121320,
      "Internet Hosts": 701,
      "Internet Users": 200000,
      "Phones (Mobile)": 305300,
      "Phones (Landline)": 60000,
      "GDP": 3438000000
    },
    {
      "Country Name": "Estonia",
      "ISO2": "EE",
      "ISO3": "EST",
      "Top Level Domain": "ee",
      "FIPS": "EN",
      "ISO Numeric": 233,
      "GeoNameID": 453733,
      "E164": 372,
      "Phone Code": 372,
      "Continent": "Europe",
      "Capital": "Tallinn",
      "Time Zone in Capital": "Europe/Tallinn",
      "Currency": "Euro",
      "Language Codes": "et,ru",
      "Languages": "Estonian (official) 68.5%, Russian 29.6%, Ukrainian 0.6%, other 1.2%, unspecified 0.1% (2011 est.)",
      "Area KM2": 45226,
      "Internet Hosts": 865494,
      "Internet Users": 971700,
      "Phones (Mobile)": 2070000,
      "Phones (Landline)": 448200,
      "GDP": 24280000000
    },
    {
      "Country Name": "Ethiopia",
      "ISO2": "ET",
      "ISO3": "ETH",
      "Top Level Domain": "et",
      "FIPS": "ET",
      "ISO Numeric": 231,
      "GeoNameID": 337996,
      "E164": 251,
      "Phone Code": 251,
      "Continent": "Africa",
      "Capital": "Addis Ababa",
      "Time Zone in Capital": "Africa/Addis_Ababa",
      "Currency": "Birr",
      "Language Codes": "am,en-ET,om-ET,ti-ET,so-ET,sid",
      "Languages": "Oromo (official working language in the State of Oromiya) 33.8%, Amharic (official national language) 29.3%, Somali (official working language of the State of Sumale) 6.2%, Tigrigna (Tigrinya) (official working language of the State of Tigray) 5.9%, Sidamo 4%, Wolaytta 2.2%, Gurage 2%, Afar (official working language of the State of Afar) 1.7%, Hadiyya 1.7%, Gamo 1.5%, Gedeo 1.3%, Opuuo 1.2%, Kafa 1.1%, other 8.1%, English (major foreign language taught in schools), Arabic (2007 est.)",
      "Area KM2": 1127127,
      "Internet Hosts": 179,
      "Internet Users": 447300,
      "Phones (Mobile)": 20524000,
      "Phones (Landline)": 797500,
      "GDP": 47340000000
    },
    {
      "Country Name": "Falkland Islands",
      "ISO2": "FK",
      "ISO3": "FLK",
      "Top Level Domain": "fk",
      "FIPS": "FK",
      "ISO Numeric": 238,
      "GeoNameID": 3474414,
      "E164": 500,
      "Phone Code": 500,
      "Continent": "South America",
      "Capital": "Stanley",
      "Time Zone in Capital": "Atlantic/Stanley",
      "Currency": "Pound",
      "Language Codes": "en-FK",
      "Languages": "English 89%, Spanish 7.7%, other 3.3% (2006 est.)",
      "Area KM2": 12173,
      "Internet Hosts": 110,
      "Internet Users": 2900,
      "Phones (Mobile)": 3450,
      "Phones (Landline)": 1980,
      "GDP": 164500000
    },
    {
      "Country Name": "Faroe Islands",
      "ISO2": "FO",
      "ISO3": "FRO",
      "Top Level Domain": "fo",
      "FIPS": "FO",
      "ISO Numeric": 234,
      "GeoNameID": 2622320,
      "E164": 298,
      "Phone Code": 298,
      "Continent": "Europe",
      "Capital": "Torshavn",
      "Time Zone in Capital": "Atlantic/Faroe",
      "Currency": "Krone",
      "Language Codes": "fo,da-FO",
      "Languages": "Faroese (derived from Old Norse), Danish",
      "Area KM2": 1399,
      "Internet Hosts": 7575,
      "Internet Users": 37500,
      "Phones (Mobile)": 61000,
      "Phones (Landline)": 24000,
      "GDP": 2320000000
    },
    {
      "Country Name": "Fiji",
      "ISO2": "FJ",
      "ISO3": "FJI",
      "Top Level Domain": "fj",
      "FIPS": "FJ",
      "ISO Numeric": 242,
      "GeoNameID": 2205218,
      "E164": 679,
      "Phone Code": 679,
      "Continent": "Oceania",
      "Capital": "Suva",
      "Time Zone in Capital": "Pacific/Fiji",
      "Currency": "Dollar",
      "Language Codes": "en-FJ,fj",
      "Languages": "English (official), Fijian (official), Hindustani",
      "Area KM2": 18270,
      "Internet Hosts": 21739,
      "Internet Users": 114200,
      "Phones (Mobile)": 858800,
      "Phones (Landline)": 88400,
      "GDP": 4218000000
    },
    {
      "Country Name": "Finland",
      "ISO2": "FI",
      "ISO3": "FIN",
      "Top Level Domain": "fi",
      "FIPS": "FI",
      "ISO Numeric": 246,
      "GeoNameID": 660013,
      "E164": 358,
      "Phone Code": 358,
      "Continent": "Europe",
      "Capital": "Helsinki",
      "Time Zone in Capital": "Europe/Helsinki",
      "Currency": "Euro",
      "Language Codes": "fi-FI,sv-FI,smn",
      "Languages": "Finnish (official) 94.2%, Swedish (official) 5.5%, other (small Sami- and Russian-speaking minorities) 0.2% (2012 est.)",
      "Area KM2": 337030,
      "Internet Hosts": 4763000,
      "Internet Users": 4393000,
      "Phones (Mobile)": 9320000,
      "Phones (Landline)": 890000,
      "GDP": 259600000000
    },
    {
      "Country Name": "France",
      "ISO2": "FR",
      "ISO3": "FRA",
      "Top Level Domain": "fr",
      "FIPS": "FR",
      "ISO Numeric": 250,
      "GeoNameID": 3017382,
      "E164": 33,
      "Phone Code": 33,
      "Continent": "Europe",
      "Capital": "Paris",
      "Time Zone in Capital": "Europe/Paris",
      "Currency": "Euro",
      "Language Codes": "fr-FR,frp,br,co,ca,eu,oc",
      "Languages": "French (official) 100%, rapidly declining regional dialects and languages (Provencal, Breton, Alsatian, Corsican, Catalan, Basque, Flemish)",
      "Area KM2": 547030,
      "Internet Hosts": 17266000,
      "Internet Users": 45262000,
      "Phones (Mobile)": 62280000,
      "Phones (Landline)": 39290000,
      "GDP": 2739000000000
    },
    {
      "Country Name": "French Polynesia",
      "ISO2": "PF",
      "ISO3": "PYF",
      "Top Level Domain": "pf",
      "FIPS": "FP",
      "ISO Numeric": 258,
      "GeoNameID": 4030656,
      "E164": 689,
      "Phone Code": 689,
      "Continent": "Oceania",
      "Capital": "Papeete",
      "Time Zone in Capital": "Pacific/Tahiti",
      "Currency": "Franc",
      "Language Codes": "fr-PF,ty",
      "Languages": "French (official) 61.1%, Polynesian (official) 31.4%, Asian languages 1.2%, other 0.3%, unspecified 6% (2002 census)",
      "Area KM2": 4167,
      "Internet Hosts": 37949,
      "Internet Users": 120000,
      "Phones (Mobile)": 226000,
      "Phones (Landline)": 55000,
      "GDP": 5650000000
    },
    {
      "Country Name": "Gabon",
      "ISO2": "GA",
      "ISO3": "GAB",
      "Top Level Domain": "ga",
      "FIPS": "GB",
      "ISO Numeric": 266,
      "GeoNameID": 2400553,
      "E164": 241,
      "Phone Code": 241,
      "Continent": "Africa",
      "Capital": "Libreville",
      "Time Zone in Capital": "Africa/Lagos",
      "Currency": "Franc",
      "Language Codes": "fr-GA",
      "Languages": "French (official), Fang, Myene, Nzebi, Bapounou/Eschira, Bandjabi",
      "Area KM2": 267667,
      "Internet Hosts": 127,
      "Internet Users": 98800,
      "Phones (Mobile)": 2930000,
      "Phones (Landline)": 17000,
      "GDP": 19970000000
    },
    {
      "Country Name": "Gambia",
      "ISO2": "GM",
      "ISO3": "GMB",
      "Top Level Domain": "gm",
      "FIPS": "GA",
      "ISO Numeric": 270,
      "GeoNameID": 2413451,
      "E164": 220,
      "Phone Code": 220,
      "Continent": "Africa",
      "Capital": "Banjul",
      "Time Zone in Capital": "Africa/Abidjan",
      "Currency": "Dalasi",
      "Language Codes": "en-GM,mnk,wof,wo,ff",
      "Languages": "English (official), Mandinka, Wolof, Fula, other indigenous vernaculars",
      "Area KM2": 11300,
      "Internet Hosts": 656,
      "Internet Users": 130100,
      "Phones (Mobile)": 1526000,
      "Phones (Landline)": 64200,
      "GDP": 896000000
    },
    {
      "Country Name": "Georgia",
      "ISO2": "GE",
      "ISO3": "GEO",
      "Top Level Domain": "ge",
      "FIPS": "GG",
      "ISO Numeric": 268,
      "GeoNameID": 614540,
      "E164": 995,
      "Phone Code": 995,
      "Continent": "Asia",
      "Capital": "Tbilisi",
      "Time Zone in Capital": "Asia/Tbilisi",
      "Currency": "Lari",
      "Language Codes": "ka,ru,hy,az",
      "Languages": "Georgian (official) 71%, Russian 9%, Armenian 7%, Azeri 6%, other 7%",
      "Area KM2": 69700,
      "Internet Hosts": 357864,
      "Internet Users": 1300000,
      "Phones (Mobile)": 4699000,
      "Phones (Landline)": 1276000,
      "GDP": 15950000000
    },
    {
      "Country Name": "Germany",
      "ISO2": "DE",
      "ISO3": "DEU",
      "Top Level Domain": "de",
      "FIPS": "GM",
      "ISO Numeric": 276,
      "GeoNameID": 2921044,
      "E164": 49,
      "Phone Code": 49,
      "Continent": "Europe",
      "Capital": "Berlin",
      "Time Zone in Capital": "Europe/Berlin",
      "Currency": "Euro",
      "Language Codes": "de",
      "Languages": "German (official)",
      "Area KM2": 357021,
      "Internet Hosts": 20043000,
      "Internet Users": 65125000,
      "Phones (Mobile)": 107700000,
      "Phones (Landline)": 50700000,
      "GDP": 3593000000000
    },
    {
      "Country Name": "Ghana",
      "ISO2": "GH",
      "ISO3": "GHA",
      "Top Level Domain": "gh",
      "FIPS": "GH",
      "ISO Numeric": 288,
      "GeoNameID": 2300660,
      "E164": 233,
      "Phone Code": 233,
      "Continent": "Africa",
      "Capital": "Accra",
      "Time Zone in Capital": "Africa/Accra",
      "Currency": "Cedi",
      "Language Codes": "en-GH,ak,ee,tw",
      "Languages": "Asante 14.8%, Ewe 12.7%, Fante 9.9%, Boron (Brong) 4.6%, Dagomba 4.3%, Dangme 4.3%, Dagarte (Dagaba) 3.7%, Akyem 3.4%, Ga 3.4%, Akuapem 2.9%, other (includes English (official)) 36.1% (2000 census)",
      "Area KM2": 239460,
      "Internet Hosts": 59086,
      "Internet Users": 1297000,
      "Phones (Mobile)": 25618000,
      "Phones (Landline)": 285000,
      "GDP": 45550000000
    },
    {
      "Country Name": "Gibraltar",
      "ISO2": "GI",
      "ISO3": "GIB",
      "Top Level Domain": "gi",
      "FIPS": "GI",
      "ISO Numeric": 292,
      "GeoNameID": 2411586,
      "E164": 350,
      "Phone Code": 350,
      "Continent": "Europe",
      "Capital": "Gibraltar",
      "Time Zone in Capital": "Europe/Gibraltar",
      "Currency": "Pound",
      "Language Codes": "en-GI,es,it,pt",
      "Languages": "English (used in schools and for official purposes), Spanish, Italian, Portuguese",
      "Area KM2": 7,
      "Internet Hosts": 3509,
      "Internet Users": 20200,
      "Phones (Mobile)": 34750,
      "Phones (Landline)": 23100,
      "GDP": 1106000000
    },
    {
      "Country Name": "Greece",
      "ISO2": "GR",
      "ISO3": "GRC",
      "Top Level Domain": "gr",
      "FIPS": "GR",
      "ISO Numeric": 300,
      "GeoNameID": 390903,
      "E164": 30,
      "Phone Code": 30,
      "Continent": "Europe",
      "Capital": "Athens",
      "Time Zone in Capital": "Europe/Athens",
      "Currency": "Euro",
      "Language Codes": "el-GR,en,fr",
      "Languages": "Greek (official) 99%, other (includes English and French) 1%",
      "Area KM2": 131940,
      "Internet Hosts": 3201000,
      "Internet Users": 4971000,
      "Phones (Mobile)": 13354000,
      "Phones (Landline)": 5461000,
      "GDP": 243300000000
    },
    {
      "Country Name": "Greenland",
      "ISO2": "GL",
      "ISO3": "GRL",
      "Top Level Domain": "gl",
      "FIPS": "GL",
      "ISO Numeric": 304,
      "GeoNameID": 3425505,
      "E164": 299,
      "Phone Code": 299,
      "Continent": "North America",
      "Capital": "Nuuk",
      "Time Zone in Capital": "America/Godthab",
      "Currency": "Krone",
      "Language Codes": "kl,da-GL,en",
      "Languages": "Greenlandic (East Inuit) (official), Danish (official), English",
      "Area KM2": 2166086,
      "Internet Hosts": 15645,
      "Internet Users": 36000,
      "Phones (Mobile)": 59455,
      "Phones (Landline)": 18900,
      "GDP": 2160000000
    },
    {
      "Country Name": "Grenada",
      "ISO2": "GD",
      "ISO3": "GRD",
      "Top Level Domain": "gd",
      "FIPS": "GJ",
      "ISO Numeric": 308,
      "GeoNameID": 3580239,
      "E164": 1,
      "Phone Code": "1-473",
      "Continent": "North America",
      "Capital": "St. George's",
      "Time Zone in Capital": "America/Port_of_Spain",
      "Currency": "Dollar",
      "Language Codes": "en-GD",
      "Languages": "English (official), French patois",
      "Area KM2": 344,
      "Internet Hosts": 80,
      "Internet Users": 25000,
      "Phones (Mobile)": 128000,
      "Phones (Landline)": 28500,
      "GDP": 811000000
    },
    {
      "Country Name": "Guam",
      "ISO2": "GU",
      "ISO3": "GUM",
      "Top Level Domain": "gu",
      "FIPS": "GQ",
      "ISO Numeric": 316,
      "GeoNameID": 4043988,
      "E164": 1,
      "Phone Code": "1-671",
      "Continent": "Oceania",
      "Capital": "Hagatna",
      "Time Zone in Capital": "Pacific/Guam",
      "Currency": "Dollar",
      "Language Codes": "en-GU,ch-GU",
      "Languages": "English 43.6%, Filipino 21.2%, Chamorro 17.8%, other Pacific island languages 10%, Asian languages 6.3%, other 1.1% (2010 est.)",
      "Area KM2": 549,
      "Internet Hosts": 23,
      "Internet Users": 90000,
      "Phones (Mobile)": 98000,
      "Phones (Landline)": 67000,
      "GDP": 4600000000
    },
    {
      "Country Name": "Guatemala",
      "ISO2": "GT",
      "ISO3": "GTM",
      "Top Level Domain": "gt",
      "FIPS": "GT",
      "ISO Numeric": 320,
      "GeoNameID": 3595528,
      "E164": 502,
      "Phone Code": 502,
      "Continent": "North America",
      "Capital": "Guatemala City",
      "Time Zone in Capital": "America/Guatemala",
      "Currency": "Quetzal",
      "Language Codes": "es-GT",
      "Languages": "Spanish (official) 60%, Amerindian languages 40%",
      "Area KM2": 108890,
      "Internet Hosts": 357552,
      "Internet Users": 2279000,
      "Phones (Mobile)": 20787000,
      "Phones (Landline)": 1744000,
      "GDP": 53900000000
    },
    {
      "Country Name": "Guernsey",
      "ISO2": "GG",
      "ISO3": "GGY",
      "Top Level Domain": "gg",
      "FIPS": "GK",
      "ISO Numeric": 831,
      "GeoNameID": 3042362,
      "E164": 44,
      "Phone Code": "44-1481",
      "Continent": "Europe",
      "Capital": "St Peter Port",
      "Time Zone in Capital": "Europe/London",
      "Currency": "Pound",
      "Language Codes": "en,fr",
      "Languages": "English, French, Norman-French dialect spoken in country districts",
      "Area KM2": 78,
      "Internet Hosts": 239,
      "Internet Users": 48300,
      "Phones (Mobile)": 43800,
      "Phones (Landline)": 45100,
      "GDP": 2742000000
    },
    {
      "Country Name": "Guinea",
      "ISO2": "GN",
      "ISO3": "GIN",
      "Top Level Domain": "gn",
      "FIPS": "GV",
      "ISO Numeric": 324,
      "GeoNameID": 2420477,
      "E164": 224,
      "Phone Code": 224,
      "Continent": "Africa",
      "Capital": "Conakry",
      "Time Zone in Capital": "Africa/Abidjan",
      "Currency": "Franc",
      "Language Codes": "fr-GN",
      "Languages": "French (official)",
      "Area KM2": 245857,
      "Internet Hosts": 15,
      "Internet Users": 95000,
      "Phones (Mobile)": 4781000,
      "Phones (Landline)": 18000,
      "GDP": 6544000000
    },
    {
      "Country Name": "Guinea-Bissau",
      "ISO2": "GW",
      "ISO3": "GNB",
      "Top Level Domain": "gw",
      "FIPS": "PU",
      "ISO Numeric": 624,
      "GeoNameID": 2372248,
      "E164": 245,
      "Phone Code": 245,
      "Continent": "Africa",
      "Capital": "Bissau",
      "Time Zone in Capital": "Africa/Bissau",
      "Currency": "Franc",
      "Language Codes": "pt-GW,pov",
      "Languages": "Portuguese (official), Crioulo, African languages",
      "Area KM2": 36120,
      "Internet Hosts": 90,
      "Internet Users": 37100,
      "Phones (Mobile)": 1100000,
      "Phones (Landline)": 5000,
      "GDP": 880000000
    },
    {
      "Country Name": "Guyana",
      "ISO2": "GY",
      "ISO3": "GUY",
      "Top Level Domain": "gy",
      "FIPS": "GY",
      "ISO Numeric": 328,
      "GeoNameID": 3378535,
      "E164": 592,
      "Phone Code": 592,
      "Continent": "South America",
      "Capital": "Georgetown",
      "Time Zone in Capital": "America/Guyana",
      "Currency": "Dollar",
      "Language Codes": "en-GY",
      "Languages": "English, Amerindian dialects, Creole, Caribbean Hindustani (a dialect of Hindi), Urdu",
      "Area KM2": 214970,
      "Internet Hosts": 24936,
      "Internet Users": 189600,
      "Phones (Mobile)": 547000,
      "Phones (Landline)": 154200,
      "GDP": 3020000000
    },
    {
      "Country Name": "Haiti",
      "ISO2": "HT",
      "ISO3": "HTI",
      "Top Level Domain": "ht",
      "FIPS": "HA",
      "ISO Numeric": 332,
      "GeoNameID": 3723988,
      "E164": 509,
      "Phone Code": 509,
      "Continent": "North America",
      "Capital": "Port-au-Prince",
      "Time Zone in Capital": "America/Port-au-Prince",
      "Currency": "Gourde",
      "Language Codes": "ht,fr-HT",
      "Languages": "French (official), Creole (official)",
      "Area KM2": 27750,
      "Internet Hosts": 555,
      "Internet Users": 1000000,
      "Phones (Mobile)": 6095000,
      "Phones (Landline)": 50000,
      "GDP": 8287000000
    },
    {
      "Country Name": "Honduras",
      "ISO2": "HN",
      "ISO3": "HND",
      "Top Level Domain": "hn",
      "FIPS": "HO",
      "ISO Numeric": 340,
      "GeoNameID": 3608932,
      "E164": 504,
      "Phone Code": 504,
      "Continent": "North America",
      "Capital": "Tegucigalpa",
      "Time Zone in Capital": "America/Tegucigalpa",
      "Currency": "Lempira",
      "Language Codes": "es-HN",
      "Languages": "Spanish (official), Amerindian dialects",
      "Area KM2": 112090,
      "Internet Hosts": 30955,
      "Internet Users": 731700,
      "Phones (Mobile)": 7370000,
      "Phones (Landline)": 610000,
      "GDP": 18880000000
    },
    {
      "Country Name": "Hong Kong",
      "ISO2": "HK",
      "ISO3": "HKG",
      "Top Level Domain": "hk",
      "FIPS": "HK",
      "ISO Numeric": 344,
      "GeoNameID": 1819730,
      "E164": 852,
      "Phone Code": 852,
      "Continent": "Asia",
      "Capital": "Hong Kong",
      "Time Zone in Capital": "Asia/Hong_Kong",
      "Currency": "Dollar",
      "Language Codes": "zh-HK,yue,zh,en",
      "Languages": "Cantonese (official) 89.5%, English (official) 3.5%, Putonghua (Mandarin) 1.4%, other Chinese dialects 4%, other 1.6% (2011 est.)",
      "Area KM2": 1092,
      "Internet Hosts": 870041,
      "Internet Users": 4873000,
      "Phones (Mobile)": 16403000,
      "Phones (Landline)": 4362000,
      "GDP": 272100000000
    },
    {
      "Country Name": "Hungary",
      "ISO2": "HU",
      "ISO3": "HUN",
      "Top Level Domain": "hu",
      "FIPS": "HU",
      "ISO Numeric": 348,
      "GeoNameID": 719819,
      "E164": 36,
      "Phone Code": 36,
      "Continent": "Europe",
      "Capital": "Budapest",
      "Time Zone in Capital": "Europe/Budapest",
      "Currency": "Forint",
      "Language Codes": "hu-HU",
      "Languages": "Hungarian (official) 99.6%, English 16%, German 11.2%, Russian 1.6%, Romanian 1.3%, French 1.2%, other 4.2%",
      "Area KM2": 93030,
      "Internet Hosts": 3145000,
      "Internet Users": 6176000,
      "Phones (Mobile)": 11580000,
      "Phones (Landline)": 2960000,
      "GDP": 130600000000
    },
    {
      "Country Name": "Iceland",
      "ISO2": "IS",
      "ISO3": "ISL",
      "Top Level Domain": "is",
      "FIPS": "IC",
      "ISO Numeric": 352,
      "GeoNameID": 2629691,
      "E164": 354,
      "Phone Code": 354,
      "Continent": "Europe",
      "Capital": "Reykjavik",
      "Time Zone in Capital": "Atlantic/Reykjavik",
      "Currency": "Krona",
      "Language Codes": "is,en,de,da,sv,no",
      "Languages": "Icelandic, English, Nordic languages, German widely spoken",
      "Area KM2": 103000,
      "Internet Hosts": 369969,
      "Internet Users": 301600,
      "Phones (Mobile)": 346000,
      "Phones (Landline)": 189000,
      "GDP": 14590000000
    },
    {
      "Country Name": "India",
      "ISO2": "IN",
      "ISO3": "IND",
      "Top Level Domain": "in",
      "FIPS": "IN",
      "ISO Numeric": 356,
      "GeoNameID": 1269750,
      "E164": 91,
      "Phone Code": 91,
      "Continent": "Asia",
      "Capital": "New Delhi",
      "Time Zone in Capital": "Asia/Kolkata",
      "Currency": "Rupee",
      "Language Codes": "en-IN,hi,bn,te,mr,ta,ur,gu,kn,ml,or,pa,as,bh,sat,ks,ne,sd,kok,doi,mni,sit,sa,fr,lus,inc",
      "Languages": "Hindi 41%, Bengali 8.1%, Telugu 7.2%, Marathi 7%, Tamil 5.9%, Urdu 5%, Gujarati 4.5%, Kannada 3.7%, Malayalam 3.2%, Oriya 3.2%, Punjabi 2.8%, Assamese 1.3%, Maithili 1.2%, other 5.9%",
      "Area KM2": 3287590,
      "Internet Hosts": 6746000,
      "Internet Users": 61338000,
      "Phones (Mobile)": 893862000,
      "Phones (Landline)": 31080000,
      "GDP": 1670000000000
    },
    {
      "Country Name": "Indonesia",
      "ISO2": "ID",
      "ISO3": "IDN",
      "Top Level Domain": "id",
      "FIPS": "ID",
      "ISO Numeric": 360,
      "GeoNameID": 1643084,
      "E164": 62,
      "Phone Code": 62,
      "Continent": "Asia",
      "Capital": "Jakarta",
      "Time Zone in Capital": "Asia/Jakarta",
      "Currency": "Rupiah",
      "Language Codes": "id,en,nl,jv",
      "Languages": "Bahasa Indonesia (official, modified form of Malay), English, Dutch, local dialects (of which the most widely spoken is Javanese)",
      "Area KM2": 1919440,
      "Internet Hosts": 1344000,
      "Internet Users": 20000000,
      "Phones (Mobile)": 281960000,
      "Phones (Landline)": 37983000,
      "GDP": 867500000000
    },
    {
      "Country Name": "Iran",
      "ISO2": "IR",
      "ISO3": "IRN",
      "Top Level Domain": "ir",
      "FIPS": "IR",
      "ISO Numeric": 364,
      "GeoNameID": 130758,
      "E164": 98,
      "Phone Code": 98,
      "Continent": "Asia",
      "Capital": "Tehran",
      "Time Zone in Capital": "Asia/Tehran",
      "Currency": "Rial",
      "Language Codes": "fa-IR,ku",
      "Languages": "Persian (official) 53%, Azeri Turkic and Turkic dialects 18%, Kurdish 10%, Gilaki and Mazandarani 7%, Luri 6%, Balochi 2%, Arabic 2%, other 2%",
      "Area KM2": 1648000,
      "Internet Hosts": 197804,
      "Internet Users": 8214000,
      "Phones (Mobile)": 58160000,
      "Phones (Landline)": 28760000,
      "GDP": 411900000000
    },
    {
      "Country Name": "Iraq",
      "ISO2": "IQ",
      "ISO3": "IRQ",
      "Top Level Domain": "iq",
      "FIPS": "IZ",
      "ISO Numeric": 368,
      "GeoNameID": 99237,
      "E164": 964,
      "Phone Code": 964,
      "Continent": "Asia",
      "Capital": "Baghdad",
      "Time Zone in Capital": "Asia/Baghdad",
      "Currency": "Dinar",
      "Language Codes": "ar-IQ,ku,hy",
      "Languages": "Arabic (official), Kurdish (official), Turkmen (a Turkish dialect) and Assyrian (Neo-Aramaic) are official in areas where they constitute a majority of the population), Armenian",
      "Area KM2": 437072,
      "Internet Hosts": 26,
      "Internet Users": 325900,
      "Phones (Mobile)": 26760000,
      "Phones (Landline)": 1870000,
      "GDP": 221800000000
    },
    {
      "Country Name": "Ireland",
      "ISO2": "IE",
      "ISO3": "IRL",
      "Top Level Domain": "ie",
      "FIPS": "EI",
      "ISO Numeric": 372,
      "GeoNameID": 2963597,
      "E164": 353,
      "Phone Code": 353,
      "Continent": "Europe",
      "Capital": "Dublin",
      "Time Zone in Capital": "Europe/Dublin",
      "Currency": "Euro",
      "Language Codes": "en-IE,ga-IE",
      "Languages": "English (official, the language generally used), Irish (Gaelic or Gaeilge) (official, spoken mainly in areas along the western coast)",
      "Area KM2": 70280,
      "Internet Hosts": 1387000,
      "Internet Users": 3042000,
      "Phones (Mobile)": 4906000,
      "Phones (Landline)": 2007000,
      "GDP": 220900000000
    },
    {
      "Country Name": "Isle of Man",
      "ISO2": "IM",
      "ISO3": "IMN",
      "Top Level Domain": "im",
      "FIPS": "IM",
      "ISO Numeric": 833,
      "GeoNameID": 3042225,
      "E164": 44,
      "Phone Code": "44-1624",
      "Continent": "Europe",
      "Capital": "Douglas, Isle of Man",
      "Time Zone in Capital": "Europe/London",
      "Currency": "Pound",
      "Language Codes": "en,gv",
      "Languages": "English, Manx Gaelic (about 2% of the population has some knowledge)",
      "Area KM2": 572,
      "Internet Hosts": 895,
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 4076000000
    },
    {
      "Country Name": "Israel",
      "ISO2": "IL",
      "ISO3": "ISR",
      "Top Level Domain": "il",
      "FIPS": "IS",
      "ISO Numeric": 376,
      "GeoNameID": 294640,
      "E164": 972,
      "Phone Code": 972,
      "Continent": "Asia",
      "Capital": "Jerusalem",
      "Time Zone in Capital": "Asia/Jerusalem",
      "Currency": "Shekel",
      "Language Codes": "he,ar-IL,en-IL,",
      "Languages": "Hebrew (official), Arabic (used officially for Arab minority), English (most commonly used foreign language)",
      "Area KM2": 20770,
      "Internet Hosts": 2483000,
      "Internet Users": 4525000,
      "Phones (Mobile)": 9225000,
      "Phones (Landline)": 3594000,
      "GDP": 272700000000
    },
    {
      "Country Name": "Italy",
      "ISO2": "IT",
      "ISO3": "ITA",
      "Top Level Domain": "it",
      "FIPS": "IT",
      "ISO Numeric": 380,
      "GeoNameID": 3175395,
      "E164": 39,
      "Phone Code": 39,
      "Continent": "Europe",
      "Capital": "Rome",
      "Time Zone in Capital": "Europe/Rome",
      "Currency": "Euro",
      "Language Codes": "it-IT,de-IT,fr-IT,sc,ca,co,sl",
      "Languages": "Italian (official), German (parts of Trentino-Alto Adige region are predominantly German-speaking), French (small French-speaking minority in Valle d'Aosta region), Slovene (Slovene-speaking minority in the Trieste-Gorizia area)",
      "Area KM2": 301230,
      "Internet Hosts": 25662000,
      "Internet Users": 29235000,
      "Phones (Mobile)": 97225000,
      "Phones (Landline)": 21656000,
      "GDP": 2068000000000
    },
    {
      "Country Name": "Ivory Coast",
      "ISO2": "CI",
      "ISO3": "CIV",
      "Top Level Domain": "ci",
      "FIPS": "IV",
      "ISO Numeric": 384,
      "GeoNameID": 2287781,
      "E164": 225,
      "Phone Code": 225,
      "Continent": "Africa",
      "Capital": "Yamoussoukro",
      "Time Zone in Capital": "Africa/Abidjan",
      "Currency": "Franc",
      "Language Codes": "fr-CI",
      "Languages": "French (official), 60 native dialects of which Dioula is the most widely spoken",
      "Area KM2": 322460,
      "Internet Hosts": 9115,
      "Internet Users": 967300,
      "Phones (Mobile)": 19827000,
      "Phones (Landline)": 268000,
      "GDP": 28280000000
    },
    {
      "Country Name": "Jamaica",
      "ISO2": "JM",
      "ISO3": "JAM",
      "Top Level Domain": "jm",
      "FIPS": "JM",
      "ISO Numeric": 388,
      "GeoNameID": 3489940,
      "E164": 1,
      "Phone Code": "1-876",
      "Continent": "North America",
      "Capital": "Kingston",
      "Time Zone in Capital": "America/Jamaica",
      "Currency": "Dollar",
      "Language Codes": "en-JM",
      "Languages": "English, English patois",
      "Area KM2": 10991,
      "Internet Hosts": 3906,
      "Internet Users": 1581000,
      "Phones (Mobile)": 2665000,
      "Phones (Landline)": 265000,
      "GDP": 14390000000
    },
    {
      "Country Name": "Japan",
      "ISO2": "JP",
      "ISO3": "JPN",
      "Top Level Domain": "jp",
      "FIPS": "JA",
      "ISO Numeric": 392,
      "GeoNameID": 1861060,
      "E164": 81,
      "Phone Code": 81,
      "Continent": "Asia",
      "Capital": "Tokyo",
      "Time Zone in Capital": "Asia/Tokyo",
      "Currency": "Yen",
      "Language Codes": "ja",
      "Languages": "Japanese",
      "Area KM2": 377835,
      "Internet Hosts": 64453000,
      "Internet Users": 99182000,
      "Phones (Mobile)": 138363000,
      "Phones (Landline)": 64273000,
      "GDP": 5007000000000
    },
    {
      "Country Name": "Jersey",
      "ISO2": "JE",
      "ISO3": "JEY",
      "Top Level Domain": "je",
      "FIPS": "JE",
      "ISO Numeric": 832,
      "GeoNameID": 3042142,
      "E164": 44,
      "Phone Code": "44-1534",
      "Continent": "Europe",
      "Capital": "Saint Helier",
      "Time Zone in Capital": "Europe/London",
      "Currency": "Pound",
      "Language Codes": "en,pt",
      "Languages": "English 94.5% (official), Portuguese 4.6%, other 0.9% (2001 census)",
      "Area KM2": 116,
      "Internet Hosts": 264,
      "Internet Users": 29500,
      "Phones (Mobile)": 108000,
      "Phones (Landline)": 73800,
      "GDP": 5100000000
    },
    {
      "Country Name": "Jordan",
      "ISO2": "JO",
      "ISO3": "JOR",
      "Top Level Domain": "jo",
      "FIPS": "JO",
      "ISO Numeric": 400,
      "GeoNameID": 248816,
      "E164": 962,
      "Phone Code": 962,
      "Continent": "Asia",
      "Capital": "Amman",
      "Time Zone in Capital": "Asia/Amman",
      "Currency": "Dinar",
      "Language Codes": "ar-JO,en",
      "Languages": "Arabic (official), English (widely understood among upper and middle classes)",
      "Area KM2": 92300,
      "Internet Hosts": 69473,
      "Internet Users": 1642000,
      "Phones (Mobile)": 8984000,
      "Phones (Landline)": 435000,
      "GDP": 34080000000
    },
    {
      "Country Name": "Kazakhstan",
      "ISO2": "KZ",
      "ISO3": "KAZ",
      "Top Level Domain": "kz",
      "FIPS": "KZ",
      "ISO Numeric": 398,
      "GeoNameID": 1522867,
      "E164": 7,
      "Phone Code": 7,
      "Continent": "Asia",
      "Capital": "Astana",
      "Time Zone in Capital": "Asia/Almaty",
      "Currency": "Tenge",
      "Language Codes": "kk,ru",
      "Languages": 'Kazakh (official, Qazaq) 64.4%, Russian (official, used in everyday business, designated the "language of interethnic communication") 95% (2001 est.)',
      "Area KM2": 2717300,
      "Internet Hosts": 67464,
      "Internet Users": 5299000,
      "Phones (Mobile)": 28731000,
      "Phones (Landline)": 4340000,
      "GDP": 224900000000
    },
    {
      "Country Name": "Kenya",
      "ISO2": "KE",
      "ISO3": "KEN",
      "Top Level Domain": "ke",
      "FIPS": "KE",
      "ISO Numeric": 404,
      "GeoNameID": 192950,
      "E164": 254,
      "Phone Code": 254,
      "Continent": "Africa",
      "Capital": "Nairobi",
      "Time Zone in Capital": "Africa/Nairobi",
      "Currency": "Shilling",
      "Language Codes": "en-KE,sw-KE",
      "Languages": "English (official), Kiswahili (official), numerous indigenous languages",
      "Area KM2": 582650,
      "Internet Hosts": 71018,
      "Internet Users": 3996000,
      "Phones (Mobile)": 30732000,
      "Phones (Landline)": 251600,
      "GDP": 45310000000
    },
    {
      "Country Name": "Kiribati",
      "ISO2": "KI",
      "ISO3": "KIR",
      "Top Level Domain": "ki",
      "FIPS": "KR",
      "ISO Numeric": 296,
      "GeoNameID": 4030945,
      "E164": 686,
      "Phone Code": 686,
      "Continent": "Oceania",
      "Capital": "Tarawa",
      "Time Zone in Capital": "Pacific/Tarawa",
      "Currency": "Dollar",
      "Language Codes": "en-KI,gil",
      "Languages": "I-Kiribati, English (official)",
      "Area KM2": 811,
      "Internet Hosts": 327,
      "Internet Users": 7800,
      "Phones (Mobile)": 16000,
      "Phones (Landline)": 9000,
      "GDP": 173000000
    },
    {
      "Country Name": "Kosovo",
      "ISO2": "XK",
      "ISO3": "XKX",
      "Top Level Domain": "",
      "FIPS": "KV",
      "ISO Numeric": 0,
      "GeoNameID": 831053,
      "E164": 383,
      "Phone Code": 383,
      "Continent": "Europe",
      "Capital": "Pristina",
      "Time Zone in Capital": "Europe/Belgrade",
      "Currency": "Euro",
      "Language Codes": "sq,sr",
      "Languages": "Albanian (official), Serbian (official), Bosnian, Turkish, Roma",
      "Area KM2": 10887,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": 562000,
      "Phones (Landline)": 106300,
      "GDP": 7150000000
    },
    {
      "Country Name": "Kuwait",
      "ISO2": "KW",
      "ISO3": "KWT",
      "Top Level Domain": "kw",
      "FIPS": "KU",
      "ISO Numeric": 414,
      "GeoNameID": 285570,
      "E164": 965,
      "Phone Code": 965,
      "Continent": "Asia",
      "Capital": "Kuwait City",
      "Time Zone in Capital": "Asia/Kuwait",
      "Currency": "Dinar",
      "Language Codes": "ar-KW,en",
      "Languages": "Arabic (official), English widely spoken",
      "Area KM2": 17820,
      "Internet Hosts": 2771,
      "Internet Users": 1100000,
      "Phones (Mobile)": 5526000,
      "Phones (Landline)": 510000,
      "GDP": 179500000000
    },
    {
      "Country Name": "Kyrgyzstan",
      "ISO2": "KG",
      "ISO3": "KGZ",
      "Top Level Domain": "kg",
      "FIPS": "KG",
      "ISO Numeric": 417,
      "GeoNameID": 1527747,
      "E164": 996,
      "Phone Code": 996,
      "Continent": "Asia",
      "Capital": "Bishkek",
      "Time Zone in Capital": "Asia/Bishkek",
      "Currency": "Som",
      "Language Codes": "ky,uz,ru",
      "Languages": "Kyrgyz (official) 64.7%, Uzbek 13.6%, Russian (official) 12.5%, Dungun 1%, other 8.2% (1999 census)",
      "Area KM2": 198500,
      "Internet Hosts": 115573,
      "Internet Users": 2195000,
      "Phones (Mobile)": 6800000,
      "Phones (Landline)": 489000,
      "GDP": 7234000000
    },
    {
      "Country Name": "Laos",
      "ISO2": "LA",
      "ISO3": "LAO",
      "Top Level Domain": "la",
      "FIPS": "LA",
      "ISO Numeric": 418,
      "GeoNameID": 1655842,
      "E164": 856,
      "Phone Code": 856,
      "Continent": "Asia",
      "Capital": "Vientiane",
      "Time Zone in Capital": "Asia/Vientiane",
      "Currency": "Kip",
      "Language Codes": "lo,fr,en",
      "Languages": "Lao (official), French, English, various ethnic languages",
      "Area KM2": 236800,
      "Internet Hosts": 1532,
      "Internet Users": 300000,
      "Phones (Mobile)": 6492000,
      "Phones (Landline)": 112000,
      "GDP": 10100000000
    },
    {
      "Country Name": "Latvia",
      "ISO2": "LV",
      "ISO3": "LVA",
      "Top Level Domain": "lv",
      "FIPS": "LG",
      "ISO Numeric": 428,
      "GeoNameID": 458258,
      "E164": 371,
      "Phone Code": 371,
      "Continent": "Europe",
      "Capital": "Riga",
      "Time Zone in Capital": "Europe/Riga",
      "Currency": "Euro",
      "Language Codes": "lv,ru,lt",
      "Languages": "Latvian (official) 56.3%, Russian 33.8%, other 0.6% (includes Polish, Ukrainian, and Belarusian), unspecified 9.4% (2011 est.)",
      "Area KM2": 64589,
      "Internet Hosts": 359604,
      "Internet Users": 1504000,
      "Phones (Mobile)": 2310000,
      "Phones (Landline)": 501000,
      "GDP": 30380000000
    },
    {
      "Country Name": "Lebanon",
      "ISO2": "LB",
      "ISO3": "LBN",
      "Top Level Domain": "lb",
      "FIPS": "LE",
      "ISO Numeric": 422,
      "GeoNameID": 272103,
      "E164": 961,
      "Phone Code": 961,
      "Continent": "Asia",
      "Capital": "Beirut",
      "Time Zone in Capital": "Asia/Beirut",
      "Currency": "Pound",
      "Language Codes": "ar-LB,fr-LB,en,hy",
      "Languages": "Arabic (official), French, English, Armenian",
      "Area KM2": 10400,
      "Internet Hosts": 64926,
      "Internet Users": 1000000,
      "Phones (Mobile)": 4000000,
      "Phones (Landline)": 878000,
      "GDP": 43490000000
    },
    {
      "Country Name": "Lesotho",
      "ISO2": "LS",
      "ISO3": "LSO",
      "Top Level Domain": "ls",
      "FIPS": "LT",
      "ISO Numeric": 426,
      "GeoNameID": 932692,
      "E164": 266,
      "Phone Code": 266,
      "Continent": "Africa",
      "Capital": "Maseru",
      "Time Zone in Capital": "Africa/Johannesburg",
      "Currency": "Loti",
      "Language Codes": "en-LS,st,zu,xh",
      "Languages": "Sesotho (official) (southern Sotho), English (official), Zulu, Xhosa",
      "Area KM2": 30355,
      "Internet Hosts": 11030,
      "Internet Users": 76800,
      "Phones (Mobile)": 1312000,
      "Phones (Landline)": 43100,
      "GDP": 2457000000
    },
    {
      "Country Name": "Liberia",
      "ISO2": "LR",
      "ISO3": "LBR",
      "Top Level Domain": "lr",
      "FIPS": "LI",
      "ISO Numeric": 430,
      "GeoNameID": 2275384,
      "E164": 231,
      "Phone Code": 231,
      "Continent": "Africa",
      "Capital": "Monrovia",
      "Time Zone in Capital": "Africa/Monrovia",
      "Currency": "Dollar",
      "Language Codes": "en-LR",
      "Languages": "English 20% (official), some 20 ethnic group languages few of which can be written or used in correspondence",
      "Area KM2": 111370,
      "Internet Hosts": 7,
      "Internet Users": 20000,
      "Phones (Mobile)": 2394000,
      "Phones (Landline)": 3200,
      "GDP": 1977000000
    },
    {
      "Country Name": "Libya",
      "ISO2": "LY",
      "ISO3": "LBY",
      "Top Level Domain": "ly",
      "FIPS": "LY",
      "ISO Numeric": 434,
      "GeoNameID": 2215636,
      "E164": 218,
      "Phone Code": 218,
      "Continent": "Africa",
      "Capital": "Tripolis",
      "Time Zone in Capital": "Africa/Tripoli",
      "Currency": "Dinar",
      "Language Codes": "ar-LY,it,en",
      "Languages": "Arabic (official), Italian, English (all widely understood in the major cities); Berber (Nafusi, Ghadamis, Suknah, Awjilah, Tamasheq)",
      "Area KM2": 1759540,
      "Internet Hosts": 17926,
      "Internet Users": 353900,
      "Phones (Mobile)": 9590000,
      "Phones (Landline)": 814000,
      "GDP": 70920000000
    },
    {
      "Country Name": "Liechtenstein",
      "ISO2": "LI",
      "ISO3": "LIE",
      "Top Level Domain": "li",
      "FIPS": "LS",
      "ISO Numeric": 438,
      "GeoNameID": 3042058,
      "E164": 423,
      "Phone Code": 423,
      "Continent": "Europe",
      "Capital": "Vaduz",
      "Time Zone in Capital": "Europe/Zurich",
      "Currency": "Franc",
      "Language Codes": "de-LI",
      "Languages": "German 94.5% (official) (Alemannic is the main dialect), Italian 1.1%, other 4.3% (2010 est.)",
      "Area KM2": 160,
      "Internet Hosts": 14278,
      "Internet Users": 23000,
      "Phones (Mobile)": 38000,
      "Phones (Landline)": 20000,
      "GDP": 5113000000
    },
    {
      "Country Name": "Lithuania",
      "ISO2": "LT",
      "ISO3": "LTU",
      "Top Level Domain": "lt",
      "FIPS": "LH",
      "ISO Numeric": 440,
      "GeoNameID": 597427,
      "E164": 370,
      "Phone Code": 370,
      "Continent": "Europe",
      "Capital": "Vilnius",
      "Time Zone in Capital": "Europe/Vilnius",
      "Currency": "Euro",
      "Language Codes": "lt,ru,pl",
      "Languages": "Lithuanian (official) 82%, Russian 8%, Polish 5.6%, other 0.9%, unspecified 3.5% (2011 est.)",
      "Area KM2": 65200,
      "Internet Hosts": 1205000,
      "Internet Users": 1964000,
      "Phones (Mobile)": 5000000,
      "Phones (Landline)": 667300,
      "GDP": 46710000000
    },
    {
      "Country Name": "Luxembourg",
      "ISO2": "LU",
      "ISO3": "LUX",
      "Top Level Domain": "lu",
      "FIPS": "LU",
      "ISO Numeric": 442,
      "GeoNameID": 2960313,
      "E164": 352,
      "Phone Code": 352,
      "Continent": "Europe",
      "Capital": "Luxembourg",
      "Time Zone in Capital": "Europe/Luxembourg",
      "Currency": "Euro",
      "Language Codes": "lb,de-LU,fr-LU",
      "Languages": "Luxembourgish (official administrative language and national language (spoken vernacular)), French (official administrative language), German (official administrative language)",
      "Area KM2": 2586,
      "Internet Hosts": 250900,
      "Internet Users": 424500,
      "Phones (Mobile)": 761300,
      "Phones (Landline)": 266700,
      "GDP": 60540000000
    },
    {
      "Country Name": "Macau",
      "ISO2": "MO",
      "ISO3": "MAC",
      "Top Level Domain": "mo",
      "FIPS": "MC",
      "ISO Numeric": 446,
      "GeoNameID": 1821275,
      "E164": 853,
      "Phone Code": 853,
      "Continent": "Asia",
      "Capital": "Macao",
      "Time Zone in Capital": "Asia/Macau",
      "Currency": "Pataca",
      "Language Codes": "zh,zh-MO,pt",
      "Languages": "Cantonese 83.3%, Mandarin 5%, Hokkien 3.7%, English 2.3%, other Chinese dialects 2%, Tagalog 1.7%, Portuguese 0.7%, other 1.3%",
      "Area KM2": 254,
      "Internet Hosts": 327,
      "Internet Users": 270200,
      "Phones (Mobile)": 1613000,
      "Phones (Landline)": 162500,
      "GDP": 51680000000
    },
    {
      "Country Name": "Macedonia",
      "ISO2": "MK",
      "ISO3": "MKD",
      "Top Level Domain": "mk",
      "FIPS": "MK",
      "ISO Numeric": 807,
      "GeoNameID": 718075,
      "E164": 389,
      "Phone Code": 389,
      "Continent": "Europe",
      "Capital": "Skopje",
      "Time Zone in Capital": "Europe/Belgrade",
      "Currency": "Denar",
      "Language Codes": "mk,sq,tr,rmm,sr",
      "Languages": "Macedonian (official) 66.5%, Albanian (official) 25.1%, Turkish 3.5%, Roma 1.9%, Serbian 1.2%, other 1.8% (2002 census)",
      "Area KM2": 25333,
      "Internet Hosts": 62826,
      "Internet Users": 1057000,
      "Phones (Mobile)": 2235000,
      "Phones (Landline)": 407900,
      "GDP": 10650000000
    },
    {
      "Country Name": "Madagascar",
      "ISO2": "MG",
      "ISO3": "MDG",
      "Top Level Domain": "mg",
      "FIPS": "MA",
      "ISO Numeric": 450,
      "GeoNameID": 1062947,
      "E164": 261,
      "Phone Code": 261,
      "Continent": "Africa",
      "Capital": "Antananarivo",
      "Time Zone in Capital": "Indian/Antananarivo",
      "Currency": "Ariary",
      "Language Codes": "fr-MG,mg",
      "Languages": "French (official), Malagasy (official), English",
      "Area KM2": 587040,
      "Internet Hosts": 38392,
      "Internet Users": 319900,
      "Phones (Mobile)": 8564000,
      "Phones (Landline)": 143700,
      "GDP": 10530000000
    },
    {
      "Country Name": "Malawi",
      "ISO2": "MW",
      "ISO3": "MWI",
      "Top Level Domain": "mw",
      "FIPS": "MI",
      "ISO Numeric": 454,
      "GeoNameID": 927384,
      "E164": 265,
      "Phone Code": 265,
      "Continent": "Africa",
      "Capital": "Lilongwe",
      "Time Zone in Capital": "Africa/Maputo",
      "Currency": "Kwacha",
      "Language Codes": "ny,yao,tum,swk",
      "Languages": "English (official), Chichewa (common), Chinyanja, Chiyao, Chitumbuka, Chilomwe, Chinkhonde, Chingoni, Chisena, Chitonga, Chinyakyusa, Chilambya",
      "Area KM2": 118480,
      "Internet Hosts": 1099,
      "Internet Users": 716400,
      "Phones (Mobile)": 4420000,
      "Phones (Landline)": 227300,
      "GDP": 3683000000
    },
    {
      "Country Name": "Malaysia",
      "ISO2": "MY",
      "ISO3": "MYS",
      "Top Level Domain": "my",
      "FIPS": "MY",
      "ISO Numeric": 458,
      "GeoNameID": 1733045,
      "E164": 60,
      "Phone Code": 60,
      "Continent": "Asia",
      "Capital": "Kuala Lumpur",
      "Time Zone in Capital": "Asia/Kuala_Lumpur",
      "Currency": "Ringgit",
      "Language Codes": "ms-MY,en,zh,ta,te,ml,pa,th",
      "Languages": "Bahasa Malaysia (official), English, Chinese (Cantonese, Mandarin, Hokkien, Hakka, Hainan, Foochow), Tamil, Telugu, Malayalam, Panjabi, Thai",
      "Area KM2": 329750,
      "Internet Hosts": 422470,
      "Internet Users": 15355000,
      "Phones (Mobile)": 41325000,
      "Phones (Landline)": 4589000,
      "GDP": 312400000000
    },
    {
      "Country Name": "Maldives",
      "ISO2": "MV",
      "ISO3": "MDV",
      "Top Level Domain": "mv",
      "FIPS": "MV",
      "ISO Numeric": 462,
      "GeoNameID": 1282028,
      "E164": 960,
      "Phone Code": 960,
      "Continent": "Asia",
      "Capital": "Male",
      "Time Zone in Capital": "Indian/Maldives",
      "Currency": "Rufiyaa",
      "Language Codes": "dv,en",
      "Languages": "Dhivehi (official, dialect of Sinhala, script derived from Arabic), English (spoken by most government officials)",
      "Area KM2": 300,
      "Internet Hosts": 3296,
      "Internet Users": 86400,
      "Phones (Mobile)": 560000,
      "Phones (Landline)": 23140,
      "GDP": 2270000000
    },
    {
      "Country Name": "Mali",
      "ISO2": "ML",
      "ISO3": "MLI",
      "Top Level Domain": "ml",
      "FIPS": "ML",
      "ISO Numeric": 466,
      "GeoNameID": 2453866,
      "E164": 223,
      "Phone Code": 223,
      "Continent": "Africa",
      "Capital": "Bamako",
      "Time Zone in Capital": "Africa/Abidjan",
      "Currency": "Franc",
      "Language Codes": "fr-ML,bm",
      "Languages": "French (official), Bambara 46.3%, Peul/foulfoulbe 9.4%, Dogon 7.2%, Maraka/soninke 6.4%, Malinke 5.6%, Sonrhai/djerma 5.6%, Minianka 4.3%, Tamacheq 3.5%, Senoufo 2.6%, unspecified 0.6%, other 8.5%",
      "Area KM2": 1240000,
      "Internet Hosts": 437,
      "Internet Users": 249800,
      "Phones (Mobile)": 14613000,
      "Phones (Landline)": 112000,
      "GDP": 11370000000
    },
    {
      "Country Name": "Malta",
      "ISO2": "MT",
      "ISO3": "MLT",
      "Top Level Domain": "mt",
      "FIPS": "MT",
      "ISO Numeric": 470,
      "GeoNameID": 2562770,
      "E164": 356,
      "Phone Code": 356,
      "Continent": "Europe",
      "Capital": "Valletta",
      "Time Zone in Capital": "Europe/Malta",
      "Currency": "Euro",
      "Language Codes": "mt,en-MT",
      "Languages": "Maltese (official) 90.1%, English (official) 6%, multilingual 3%, other 0.9% (2005 est.)",
      "Area KM2": 316,
      "Internet Hosts": 14754,
      "Internet Users": 240600,
      "Phones (Mobile)": 539500,
      "Phones (Landline)": 229700,
      "GDP": 9541000000
    },
    {
      "Country Name": "Marshall Islands",
      "ISO2": "MH",
      "ISO3": "MHL",
      "Top Level Domain": "mh",
      "FIPS": "RM",
      "ISO Numeric": 584,
      "GeoNameID": 2080185,
      "E164": 692,
      "Phone Code": 692,
      "Continent": "Oceania",
      "Capital": "Majuro",
      "Time Zone in Capital": "Pacific/Majuro",
      "Currency": "Dollar",
      "Language Codes": "mh,en-MH",
      "Languages": "Marshallese (official) 98.2%, other languages 1.8% (1999 census)",
      "Area KM2": 181,
      "Internet Hosts": 3,
      "Internet Users": 2200,
      "Phones (Mobile)": 3800,
      "Phones (Landline)": 4400,
      "GDP": 193000000
    },
    {
      "Country Name": "Mauritania",
      "ISO2": "MR",
      "ISO3": "MRT",
      "Top Level Domain": "mr",
      "FIPS": "MR",
      "ISO Numeric": 478,
      "GeoNameID": 2378080,
      "E164": 222,
      "Phone Code": 222,
      "Continent": "Africa",
      "Capital": "Nouakchott",
      "Time Zone in Capital": "Africa/Abidjan",
      "Currency": "Ouguiya",
      "Language Codes": "ar-MR,fuc,snk,fr,mey,wo",
      "Languages": "Arabic (official and national), Pulaar, Soninke, Wolof (all national languages), French, Hassaniya (a variety of Arabic)",
      "Area KM2": 1030700,
      "Internet Hosts": 22,
      "Internet Users": 75000,
      "Phones (Mobile)": 4024000,
      "Phones (Landline)": 65100,
      "GDP": 4183000000
    },
    {
      "Country Name": "Mauritius",
      "ISO2": "MU",
      "ISO3": "MUS",
      "Top Level Domain": "mu",
      "FIPS": "MP",
      "ISO Numeric": 480,
      "GeoNameID": 934292,
      "E164": 230,
      "Phone Code": 230,
      "Continent": "Africa",
      "Capital": "Port Louis",
      "Time Zone in Capital": "Indian/Mauritius",
      "Currency": "Rupee",
      "Language Codes": "en-MU,bho,fr",
      "Languages": "Creole 86.5%, Bhojpuri 5.3%, French 4.1%, two languages 1.4%, other 2.6% (includes English, the official language, which is spoken by less than 1% of the population), unspecified 0.1% (2011 est.)",
      "Area KM2": 2040,
      "Internet Hosts": 51139,
      "Internet Users": 290000,
      "Phones (Mobile)": 1485000,
      "Phones (Landline)": 349100,
      "GDP": 11900000000
    },
    {
      "Country Name": "Mayotte",
      "ISO2": "YT",
      "ISO3": "MYT",
      "Top Level Domain": "yt",
      "FIPS": "MF",
      "ISO Numeric": 175,
      "GeoNameID": 1024031,
      "E164": 262,
      "Phone Code": 262,
      "Continent": "Africa",
      "Capital": "Mamoudzou",
      "Time Zone in Capital": "Indian/Mayotte",
      "Currency": "Euro",
      "Language Codes": "fr-YT",
      "Languages": "French",
      "Area KM2": 374,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Mexico",
      "ISO2": "MX",
      "ISO3": "MEX",
      "Top Level Domain": "mx",
      "FIPS": "MX",
      "ISO Numeric": 484,
      "GeoNameID": 3996063,
      "E164": 52,
      "Phone Code": 52,
      "Continent": "North America",
      "Capital": "Mexico City",
      "Time Zone in Capital": "America/Mexico_City",
      "Currency": "Peso",
      "Language Codes": "es-MX",
      "Languages": "Spanish only 92.7%, Spanish and indigenous languages 5.7%, indigenous only 0.8%, unspecified 0.8%",
      "Area KM2": 1972550,
      "Internet Hosts": 16233000,
      "Internet Users": 31020000,
      "Phones (Mobile)": 100786000,
      "Phones (Landline)": 20220000,
      "GDP": 1327000000000
    },
    {
      "Country Name": "Micronesia",
      "ISO2": "FM",
      "ISO3": "FSM",
      "Top Level Domain": "fm",
      "FIPS": "FM",
      "ISO Numeric": 583,
      "GeoNameID": 2081918,
      "E164": 691,
      "Phone Code": 691,
      "Continent": "Oceania",
      "Capital": "Palikir",
      "Time Zone in Capital": "Pacific/Pohnpei",
      "Currency": "Dollar",
      "Language Codes": "en-FM,chk,pon,yap,kos,uli,woe,nkr,kpg",
      "Languages": "English (official and common language), Chuukese, Kosrean, Pohnpeian, Yapese, Ulithian, Woleaian, Nukuoro, Kapingamarangi",
      "Area KM2": 702,
      "Internet Hosts": 4668,
      "Internet Users": 17000,
      "Phones (Mobile)": 27600,
      "Phones (Landline)": 8400,
      "GDP": 339000000
    },
    {
      "Country Name": "Moldova",
      "ISO2": "MD",
      "ISO3": "MDA",
      "Top Level Domain": "md",
      "FIPS": "MD",
      "ISO Numeric": 498,
      "GeoNameID": 617790,
      "E164": 373,
      "Phone Code": 373,
      "Continent": "Europe",
      "Capital": "Chisinau",
      "Time Zone in Capital": "Europe/Chisinau",
      "Currency": "Leu",
      "Language Codes": "ro,ru,gag,tr",
      "Languages": "Moldovan 58.8% (official; virtually the same as the Romanian language), Romanian 16.4%, Russian 16%, Ukrainian 3.8%, Gagauz 3.1% (a Turkish language), Bulgarian 1.1%, other 0.3%, unspecified 0.4%",
      "Area KM2": 33843,
      "Internet Hosts": 711564,
      "Internet Users": 1333000,
      "Phones (Mobile)": 4080000,
      "Phones (Landline)": 1206000,
      "GDP": 7932000000
    },
    {
      "Country Name": "Monaco",
      "ISO2": "MC",
      "ISO3": "MCO",
      "Top Level Domain": "mc",
      "FIPS": "MN",
      "ISO Numeric": 492,
      "GeoNameID": 2993457,
      "E164": 377,
      "Phone Code": 377,
      "Continent": "Europe",
      "Capital": "Monaco",
      "Time Zone in Capital": "Europe/Monaco",
      "Currency": "Euro",
      "Language Codes": "fr-MC,en,it",
      "Languages": "French (official), English, Italian, Monegasque",
      "Area KM2": 2,
      "Internet Hosts": 26009,
      "Internet Users": 23000,
      "Phones (Mobile)": 33200,
      "Phones (Landline)": 44500,
      "GDP": 5748000000
    },
    {
      "Country Name": "Mongolia",
      "ISO2": "MN",
      "ISO3": "MNG",
      "Top Level Domain": "mn",
      "FIPS": "MG",
      "ISO Numeric": 496,
      "GeoNameID": 2029969,
      "E164": 976,
      "Phone Code": 976,
      "Continent": "Asia",
      "Capital": "Ulan Bator",
      "Time Zone in Capital": "Asia/Ulaanbaatar",
      "Currency": "Tugrik",
      "Language Codes": "mn,ru",
      "Languages": "Khalkha Mongol 90% (official), Turkic, Russian (1999)",
      "Area KM2": 1565000,
      "Internet Hosts": 20084,
      "Internet Users": 330000,
      "Phones (Mobile)": 3375000,
      "Phones (Landline)": 176700,
      "GDP": 11140000000
    },
    {
      "Country Name": "Montenegro",
      "ISO2": "ME",
      "ISO3": "MNE",
      "Top Level Domain": "me",
      "FIPS": "MJ",
      "ISO Numeric": 499,
      "GeoNameID": 3194884,
      "E164": 382,
      "Phone Code": 382,
      "Continent": "Europe",
      "Capital": "Podgorica",
      "Time Zone in Capital": "Europe/Belgrade",
      "Currency": "Euro",
      "Language Codes": "sr,hu,bs,sq,hr,rom",
      "Languages": "Serbian 42.9%, Montenegrin (official) 37%, Bosnian 5.3%, Albanian 5.3%, Serbo-Croat 2%, other 3.5%, unspecified 4% (2011 est.)",
      "Area KM2": 14026,
      "Internet Hosts": 10088,
      "Internet Users": 280000,
      "Phones (Mobile)": 1126000,
      "Phones (Landline)": 163000,
      "GDP": 4518000000
    },
    {
      "Country Name": "Montserrat",
      "ISO2": "MS",
      "ISO3": "MSR",
      "Top Level Domain": "ms",
      "FIPS": "MH",
      "ISO Numeric": 500,
      "GeoNameID": 3578097,
      "E164": 1,
      "Phone Code": "1-664",
      "Continent": "North America",
      "Capital": "Plymouth",
      "Time Zone in Capital": "America/Port_of_Spain",
      "Currency": "Dollar",
      "Language Codes": "en-MS",
      "Languages": "English",
      "Area KM2": 102,
      "Internet Hosts": 2431,
      "Internet Users": 1200,
      "Phones (Mobile)": 4000,
      "Phones (Landline)": 3000,
      "GDP": 0
    },
    {
      "Country Name": "Morocco",
      "ISO2": "MA",
      "ISO3": "MAR",
      "Top Level Domain": "ma",
      "FIPS": "MO",
      "ISO Numeric": 504,
      "GeoNameID": 2542007,
      "E164": 212,
      "Phone Code": 212,
      "Continent": "Africa",
      "Capital": "Rabat",
      "Time Zone in Capital": "Africa/Casablanca",
      "Currency": "Dirham",
      "Language Codes": "ar-MA,fr",
      "Languages": "Arabic (official), Berber languages (Tamazight (official), Tachelhit, Tarifit), French (often the language of business, government, and diplomacy)",
      "Area KM2": 446550,
      "Internet Hosts": 277338,
      "Internet Users": 13213000,
      "Phones (Mobile)": 39016000,
      "Phones (Landline)": 3280000,
      "GDP": 104800000000
    },
    {
      "Country Name": "Mozambique",
      "ISO2": "MZ",
      "ISO3": "MOZ",
      "Top Level Domain": "mz",
      "FIPS": "MZ",
      "ISO Numeric": 508,
      "GeoNameID": 1036973,
      "E164": 258,
      "Phone Code": 258,
      "Continent": "Africa",
      "Capital": "Maputo",
      "Time Zone in Capital": "Africa/Maputo",
      "Currency": "Metical",
      "Language Codes": "pt-MZ,vmw",
      "Languages": "Emakhuwa 25.3%, Portuguese (official) 10.7%, Xichangana 10.3%, Cisena 7.5%, Elomwe 7%, Echuwabo 5.1%, other Mozambican languages 30.1%, other 4% (1997 census)",
      "Area KM2": 801590,
      "Internet Hosts": 89737,
      "Internet Users": 613600,
      "Phones (Mobile)": 8108000,
      "Phones (Landline)": 88100,
      "GDP": 14670000000
    },
    {
      "Country Name": "Myanmar",
      "ISO2": "MM",
      "ISO3": "MMR",
      "Top Level Domain": "mm",
      "FIPS": "BM",
      "ISO Numeric": 104,
      "GeoNameID": 1327865,
      "E164": 95,
      "Phone Code": 95,
      "Continent": "Asia",
      "Capital": "Nay Pyi Taw",
      "Time Zone in Capital": "Asia/Rangoon",
      "Currency": "Kyat",
      "Language Codes": "my",
      "Languages": "Burmese (official)",
      "Area KM2": 678500,
      "Internet Hosts": 1055,
      "Internet Users": 110000,
      "Phones (Mobile)": 5440000,
      "Phones (Landline)": 556000,
      "GDP": 59430000000
    },
    {
      "Country Name": "Namibia",
      "ISO2": "NA",
      "ISO3": "NAM",
      "Top Level Domain": "na",
      "FIPS": "WA",
      "ISO Numeric": 516,
      "GeoNameID": 3355338,
      "E164": 264,
      "Phone Code": 264,
      "Continent": "Africa",
      "Capital": "Windhoek",
      "Time Zone in Capital": "Africa/Windhoek",
      "Currency": "Dollar",
      "Language Codes": "en-NA,af,de,hz,naq",
      "Languages": "Oshiwambo languages 48.9%, Nama/Damara 11.3%, Afrikaans 10.4% (common language of most of the population and about 60% of the white population), Otjiherero languages 8.6%, Kavango languages 8.5%, Caprivi languages 4.8%, English (official) 3.4%, other African languages 2.3%, other 1.7%",
      "Area KM2": 825418,
      "Internet Hosts": 78280,
      "Internet Users": 127500,
      "Phones (Mobile)": 2435000,
      "Phones (Landline)": 171000,
      "GDP": 12300000000
    },
    {
      "Country Name": "Nauru",
      "ISO2": "NR",
      "ISO3": "NRU",
      "Top Level Domain": "nr",
      "FIPS": "NR",
      "ISO Numeric": 520,
      "GeoNameID": 2110425,
      "E164": 674,
      "Phone Code": 674,
      "Continent": "Oceania",
      "Capital": "Yaren",
      "Time Zone in Capital": "Pacific/Nauru",
      "Currency": "Dollar",
      "Language Codes": "na,en-NR",
      "Languages": "Nauruan 93% (official, a distinct Pacific Island language), English 2% (widely understood, spoken, and used for most government and commercial purposes), other 5% (includes I-Kiribati 2% and Chinese 2%)",
      "Area KM2": 21,
      "Internet Hosts": 8162,
      "Internet Users": "",
      "Phones (Mobile)": 6800,
      "Phones (Landline)": 1900,
      "GDP": 0
    },
    {
      "Country Name": "Nepal",
      "ISO2": "NP",
      "ISO3": "NPL",
      "Top Level Domain": "np",
      "FIPS": "NP",
      "ISO Numeric": 524,
      "GeoNameID": 1282988,
      "E164": 977,
      "Phone Code": 977,
      "Continent": "Asia",
      "Capital": "Kathmandu",
      "Time Zone in Capital": "Asia/Kathmandu",
      "Currency": "Rupee",
      "Language Codes": "ne,en",
      "Languages": "Nepali (official) 44.6%, Maithali 11.7%, Bhojpuri 6%, Tharu 5.8%, Tamang 5.1%, Newar 3.2%, Magar 3%, Bajjika 3%, Urdu 2.6%, Avadhi 1.9%, Limbu 1.3%, Gurung 1.2%, other 10.4%, unspecified 0.2%",
      "Area KM2": 140800,
      "Internet Hosts": 41256,
      "Internet Users": 577800,
      "Phones (Mobile)": 18138000,
      "Phones (Landline)": 834000,
      "GDP": 19340000000
    },
    {
      "Country Name": "Netherlands",
      "ISO2": "NL",
      "ISO3": "NLD",
      "Top Level Domain": "nl",
      "FIPS": "NL",
      "ISO Numeric": 528,
      "GeoNameID": 2750405,
      "E164": 31,
      "Phone Code": 31,
      "Continent": "Europe",
      "Capital": "Amsterdam",
      "Time Zone in Capital": "Europe/Amsterdam",
      "Currency": "Euro",
      "Language Codes": "nl-NL,fy-NL",
      "Languages": "Dutch (official)",
      "Area KM2": 41526,
      "Internet Hosts": 13699000,
      "Internet Users": 14872000,
      "Phones (Mobile)": 19643000,
      "Phones (Landline)": 7086000,
      "GDP": 722300000000
    },
    {
      "Country Name": "Netherlands Antilles",
      "ISO2": "AN",
      "ISO3": "ANT",
      "Top Level Domain": "an",
      "FIPS": "NT",
      "ISO Numeric": 530,
      "GeoNameID": "",
      "E164": 599,
      "Phone Code": 599,
      "Continent": "North America",
      "Capital": "Willemstad",
      "Time Zone in Capital": "America/Curacao",
      "Currency": "Guilder",
      "Language Codes": "nl-AN,en,es",
      "Languages": "Dutch, English, Spanish",
      "Area KM2": 960,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "New Caledonia",
      "ISO2": "NC",
      "ISO3": "NCL",
      "Top Level Domain": "nc",
      "FIPS": "NC",
      "ISO Numeric": 540,
      "GeoNameID": 2139685,
      "E164": 687,
      "Phone Code": 687,
      "Continent": "Oceania",
      "Capital": "Noumea",
      "Time Zone in Capital": "Pacific/Noumea",
      "Currency": "Franc",
      "Language Codes": "fr-NC",
      "Languages": "French (official), 33 Melanesian-Polynesian dialects",
      "Area KM2": 19060,
      "Internet Hosts": 34231,
      "Internet Users": 85000,
      "Phones (Mobile)": 231000,
      "Phones (Landline)": 80000,
      "GDP": 9280000000
    },
    {
      "Country Name": "New Zealand",
      "ISO2": "NZ",
      "ISO3": "NZL",
      "Top Level Domain": "nz",
      "FIPS": "NZ",
      "ISO Numeric": 554,
      "GeoNameID": 2186224,
      "E164": 64,
      "Phone Code": 64,
      "Continent": "Oceania",
      "Capital": "Wellington",
      "Time Zone in Capital": "Pacific/Auckland",
      "Currency": "Dollar",
      "Language Codes": "en-NZ,mi",
      "Languages": "English (de facto official) 89.8%, Maori (de jure official) 3.5%, Samoan 2%, Hindi 1.6%, French 1.2%, Northern Chinese 1.2%, Yue 1%, Other or not stated 20.5%, New Zealand Sign Language (de jure official)",
      "Area KM2": 268680,
      "Internet Hosts": 3026000,
      "Internet Users": 3400000,
      "Phones (Mobile)": 4922000,
      "Phones (Landline)": 1880000,
      "GDP": 181100000000
    },
    {
      "Country Name": "Nicaragua",
      "ISO2": "NI",
      "ISO3": "NIC",
      "Top Level Domain": "ni",
      "FIPS": "NU",
      "ISO Numeric": 558,
      "GeoNameID": 3617476,
      "E164": 505,
      "Phone Code": 505,
      "Continent": "North America",
      "Capital": "Managua",
      "Time Zone in Capital": "America/Managua",
      "Currency": "Cordoba",
      "Language Codes": "es-NI,en",
      "Languages": "Spanish (official) 95.3%, Miskito 2.2%, Mestizo of the Caribbean coast 2%, other 0.5%",
      "Area KM2": 129494,
      "Internet Hosts": 296068,
      "Internet Users": 199800,
      "Phones (Mobile)": 5346000,
      "Phones (Landline)": 320000,
      "GDP": 11260000000
    },
    {
      "Country Name": "Niger",
      "ISO2": "NE",
      "ISO3": "NER",
      "Top Level Domain": "ne",
      "FIPS": "NG",
      "ISO Numeric": 562,
      "GeoNameID": 2440476,
      "E164": 227,
      "Phone Code": 227,
      "Continent": "Africa",
      "Capital": "Niamey",
      "Time Zone in Capital": "Africa/Lagos",
      "Currency": "Franc",
      "Language Codes": "fr-NE,ha,kr,dje",
      "Languages": "French (official), Hausa, Djerma",
      "Area KM2": 1267000,
      "Internet Hosts": 454,
      "Internet Users": 115900,
      "Phones (Mobile)": 5400000,
      "Phones (Landline)": 100500,
      "GDP": 7304000000
    },
    {
      "Country Name": "Nigeria",
      "ISO2": "NG",
      "ISO3": "NGA",
      "Top Level Domain": "ng",
      "FIPS": "NI",
      "ISO Numeric": 566,
      "GeoNameID": 2328926,
      "E164": 234,
      "Phone Code": 234,
      "Continent": "Africa",
      "Capital": "Abuja",
      "Time Zone in Capital": "Africa/Lagos",
      "Currency": "Naira",
      "Language Codes": "en-NG,ha,yo,ig,ff",
      "Languages": "English (official), Hausa, Yoruba, Igbo (Ibo), Fulani, over 500 additional indigenous languages",
      "Area KM2": 923768,
      "Internet Hosts": 1234,
      "Internet Users": 43989000,
      "Phones (Mobile)": 112780000,
      "Phones (Landline)": 418200,
      "GDP": 502000000000
    },
    {
      "Country Name": "Niue",
      "ISO2": "NU",
      "ISO3": "NIU",
      "Top Level Domain": "nu",
      "FIPS": "NE",
      "ISO Numeric": 570,
      "GeoNameID": 4036232,
      "E164": 683,
      "Phone Code": 683,
      "Continent": "Oceania",
      "Capital": "Alofi",
      "Time Zone in Capital": "Pacific/Niue",
      "Currency": "Dollar",
      "Language Codes": "niu,en-NU",
      "Languages": "Niuean (official) 46% (a Polynesian language closely related to Tongan and Samoan), Niuean and English 32%, English (official) 11%, Niuean and others 5%, other 6% (2011 est.)",
      "Area KM2": 260,
      "Internet Hosts": 79508,
      "Internet Users": 1100,
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 10010000
    },
    {
      "Country Name": "North Korea",
      "ISO2": "KP",
      "ISO3": "PRK",
      "Top Level Domain": "kp",
      "FIPS": "KN",
      "ISO Numeric": 408,
      "GeoNameID": 1873107,
      "E164": 850,
      "Phone Code": 850,
      "Continent": "Asia",
      "Capital": "Pyongyang",
      "Time Zone in Capital": "Asia/Pyongyang",
      "Currency": "Won",
      "Language Codes": "ko-KP",
      "Languages": "Korean",
      "Area KM2": 120540,
      "Internet Hosts": 8,
      "Internet Users": "",
      "Phones (Mobile)": 1700000,
      "Phones (Landline)": 1180000,
      "GDP": 28000000000
    },
    {
      "Country Name": "Northern Mariana Islands",
      "ISO2": "MP",
      "ISO3": "MNP",
      "Top Level Domain": "mp",
      "FIPS": "CQ",
      "ISO Numeric": 580,
      "GeoNameID": 4041468,
      "E164": 1,
      "Phone Code": "1-670",
      "Continent": "Oceania",
      "Capital": "Saipan",
      "Time Zone in Capital": "Pacific/Saipan",
      "Currency": "Dollar",
      "Language Codes": "fil,tl,zh,ch-MP,en-MP",
      "Languages": "Philippine languages 32.8%, Chamorro (official) 24.1%, English (official) 17%, other Pacific island languages 10.1%, Chinese 6.8%, other Asian languages 7.3%, other 1.9% (2010 est.)",
      "Area KM2": 477,
      "Internet Hosts": 17,
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 733000000
    },
    {
      "Country Name": "Norway",
      "ISO2": "NO",
      "ISO3": "NOR",
      "Top Level Domain": "no",
      "FIPS": "NO",
      "ISO Numeric": 578,
      "GeoNameID": 3144096,
      "E164": 47,
      "Phone Code": 47,
      "Continent": "Europe",
      "Capital": "Oslo",
      "Time Zone in Capital": "Europe/Oslo",
      "Currency": "Krone",
      "Language Codes": "no,nb,nn,se,fi",
      "Languages": "Bokmal Norwegian (official), Nynorsk Norwegian (official), small Sami- and Finnish-speaking minorities",
      "Area KM2": 324220,
      "Internet Hosts": 3588000,
      "Internet Users": 4431000,
      "Phones (Mobile)": 5732000,
      "Phones (Landline)": 1465000,
      "GDP": 515800000000
    },
    {
      "Country Name": "Oman",
      "ISO2": "OM",
      "ISO3": "OMN",
      "Top Level Domain": "om",
      "FIPS": "MU",
      "ISO Numeric": 512,
      "GeoNameID": 286963,
      "E164": 968,
      "Phone Code": 968,
      "Continent": "Asia",
      "Capital": "Muscat",
      "Time Zone in Capital": "Asia/Muscat",
      "Currency": "Rial",
      "Language Codes": "ar-OM,en,bal,ur",
      "Languages": "Arabic (official), English, Baluchi, Urdu, Indian dialects",
      "Area KM2": 212460,
      "Internet Hosts": 14531,
      "Internet Users": 1465000,
      "Phones (Mobile)": 5278000,
      "Phones (Landline)": 305000,
      "GDP": 81950000000
    },
    {
      "Country Name": "Pakistan",
      "ISO2": "PK",
      "ISO3": "PAK",
      "Top Level Domain": "pk",
      "FIPS": "PK",
      "ISO Numeric": 586,
      "GeoNameID": 1168579,
      "E164": 92,
      "Phone Code": 92,
      "Continent": "Asia",
      "Capital": "Islamabad",
      "Time Zone in Capital": "Asia/Karachi",
      "Currency": "Rupee",
      "Language Codes": "ur-PK,en-PK,pa,sd,ps,brh",
      "Languages": "Punjabi 48%, Sindhi 12%, Saraiki (a Punjabi variant) 10%, Pashto (alternate name, Pashtu) 8%, Urdu (official) 8%, Balochi 3%, Hindko 2%, Brahui 1%, English (official; lingua franca of Pakistani elite and most government ministries), Burushaski, and other 8%",
      "Area KM2": 803940,
      "Internet Hosts": 365813,
      "Internet Users": 20431000,
      "Phones (Mobile)": 125000000,
      "Phones (Landline)": 5803000,
      "GDP": 236500000000
    },
    {
      "Country Name": "Palau",
      "ISO2": "PW",
      "ISO3": "PLW",
      "Top Level Domain": "pw",
      "FIPS": "PS",
      "ISO Numeric": 585,
      "GeoNameID": 1559582,
      "E164": 680,
      "Phone Code": 680,
      "Continent": "Oceania",
      "Capital": "Melekeok",
      "Time Zone in Capital": "Pacific/Palau",
      "Currency": "Dollar",
      "Language Codes": "pau,sov,en-PW,tox,ja,fil,zh",
      "Languages": "Palauan (official on most islands) 66.6%, Carolinian 0.7%, other Micronesian 0.7%, English (official) 15.5%, Filipino 10.8%, Chinese 1.8%, other Asian 2.6%, other 1.3%",
      "Area KM2": 458,
      "Internet Hosts": 4,
      "Internet Users": "",
      "Phones (Mobile)": 17150,
      "Phones (Landline)": 7300,
      "GDP": 221000000
    },
    {
      "Country Name": "Palestine",
      "ISO2": "PS",
      "ISO3": "PSE",
      "Top Level Domain": "ps",
      "FIPS": "WE",
      "ISO Numeric": 275,
      "GeoNameID": 6254930,
      "E164": 970,
      "Phone Code": 970,
      "Continent": "Asia",
      "Capital": "East Jerusalem",
      "Time Zone in Capital": "Asia/Hebron",
      "Currency": "Shekel",
      "Language Codes": "ar-PS",
      "Languages": "Arabic, Hebrew, English",
      "Area KM2": 5970,
      "Internet Hosts": "",
      "Internet Users": 1379000,
      "Phones (Mobile)": 3041000,
      "Phones (Landline)": 406000,
      "GDP": 6641000000
    },
    {
      "Country Name": "Panama",
      "ISO2": "PA",
      "ISO3": "PAN",
      "Top Level Domain": "pa",
      "FIPS": "PM",
      "ISO Numeric": 591,
      "GeoNameID": 3703430,
      "E164": 507,
      "Phone Code": 507,
      "Continent": "North America",
      "Capital": "Panama City",
      "Time Zone in Capital": "America/Panama",
      "Currency": "Balboa",
      "Language Codes": "es-PA,en",
      "Languages": "Spanish (official), English 14%",
      "Area KM2": 78200,
      "Internet Hosts": 11022,
      "Internet Users": 959800,
      "Phones (Mobile)": 6770000,
      "Phones (Landline)": 640000,
      "GDP": 40620000000
    },
    {
      "Country Name": "Papua New Guinea",
      "ISO2": "PG",
      "ISO3": "PNG",
      "Top Level Domain": "pg",
      "FIPS": "PP",
      "ISO Numeric": 598,
      "GeoNameID": 2088628,
      "E164": 675,
      "Phone Code": 675,
      "Continent": "Oceania",
      "Capital": "Port Moresby",
      "Time Zone in Capital": "Pacific/Port_Moresby",
      "Currency": "Kina",
      "Language Codes": "en-PG,ho,meu,tpi",
      "Languages": "Tok Pisin (official), English (official), Hiri Motu (official), some 836 indigenous languages spoken (about 12% of the world's total); most languages have fewer than 1,000 speakers",
      "Area KM2": 462840,
      "Internet Hosts": 5006,
      "Internet Users": 125000,
      "Phones (Mobile)": 2709000,
      "Phones (Landline)": 139000,
      "GDP": 16100000000
    },
    {
      "Country Name": "Paraguay",
      "ISO2": "PY",
      "ISO3": "PRY",
      "Top Level Domain": "py",
      "FIPS": "PA",
      "ISO Numeric": 600,
      "GeoNameID": 3437598,
      "E164": 595,
      "Phone Code": 595,
      "Continent": "South America",
      "Capital": "Asuncion",
      "Time Zone in Capital": "America/Asuncion",
      "Currency": "Guarani",
      "Language Codes": "es-PY,gn",
      "Languages": "Spanish (official), Guarani (official)",
      "Area KM2": 406750,
      "Internet Hosts": 280658,
      "Internet Users": 1105000,
      "Phones (Mobile)": 6790000,
      "Phones (Landline)": 376000,
      "GDP": 30560000000
    },
    {
      "Country Name": "Peru",
      "ISO2": "PE",
      "ISO3": "PER",
      "Top Level Domain": "pe",
      "FIPS": "PE",
      "ISO Numeric": 604,
      "GeoNameID": 3932488,
      "E164": 51,
      "Phone Code": 51,
      "Continent": "South America",
      "Capital": "Lima",
      "Time Zone in Capital": "America/Lima",
      "Currency": "Sol",
      "Language Codes": "es-PE,qu,ay",
      "Languages": "Spanish (official) 84.1%, Quechua (official) 13%, Aymara (official) 1.7%, Ashaninka 0.3%, other native languages (includes a large number of minor Amazonian languages) 0.7%, other (includes foreign languages and sign language) 0.2% (2007 est.)",
      "Area KM2": 1285220,
      "Internet Hosts": 234102,
      "Internet Users": 9158000,
      "Phones (Mobile)": 29400000,
      "Phones (Landline)": 3420000,
      "GDP": 210300000000
    },
    {
      "Country Name": "Philippines",
      "ISO2": "PH",
      "ISO3": "PHL",
      "Top Level Domain": "ph",
      "FIPS": "RP",
      "ISO Numeric": 608,
      "GeoNameID": 1694008,
      "E164": 63,
      "Phone Code": 63,
      "Continent": "Asia",
      "Capital": "Manila",
      "Time Zone in Capital": "Asia/Manila",
      "Currency": "Peso",
      "Language Codes": "tl,en-PH,fil",
      "Languages": "Filipino (official; based on Tagalog) and English (official); eight major dialects - Tagalog, Cebuano, Ilocano, Hiligaynon or Ilonggo, Bicol, Waray, Pampango, and Pangasinan",
      "Area KM2": 300000,
      "Internet Hosts": 425812,
      "Internet Users": 8278000,
      "Phones (Mobile)": 103000000,
      "Phones (Landline)": 3939000,
      "GDP": 272200000000
    },
    {
      "Country Name": "Pitcairn",
      "ISO2": "PN",
      "ISO3": "PCN",
      "Top Level Domain": "pn",
      "FIPS": "PC",
      "ISO Numeric": 612,
      "GeoNameID": 4030699,
      "E164": 64,
      "Phone Code": 64,
      "Continent": "Oceania",
      "Capital": "Adamstown",
      "Time Zone in Capital": "Pacific/Pitcairn",
      "Currency": "Dollar",
      "Language Codes": "en-PN",
      "Languages": "English",
      "Area KM2": 47,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Poland",
      "ISO2": "PL",
      "ISO3": "POL",
      "Top Level Domain": "pl",
      "FIPS": "PL",
      "ISO Numeric": 616,
      "GeoNameID": 798544,
      "E164": 48,
      "Phone Code": 48,
      "Continent": "Europe",
      "Capital": "Warsaw",
      "Time Zone in Capital": "Europe/Warsaw",
      "Currency": "Zloty",
      "Language Codes": "pl",
      "Languages": "Polish (official) 96.2%, Polish and non-Polish 2%, non-Polish 0.5%, unspecified 1.3%",
      "Area KM2": 312685,
      "Internet Hosts": 13265000,
      "Internet Users": 22452000,
      "Phones (Mobile)": 50840000,
      "Phones (Landline)": 6125000,
      "GDP": 513900000000
    },
    {
      "Country Name": "Portugal",
      "ISO2": "PT",
      "ISO3": "PRT",
      "Top Level Domain": "pt",
      "FIPS": "PO",
      "ISO Numeric": 620,
      "GeoNameID": 2264397,
      "E164": 351,
      "Phone Code": 351,
      "Continent": "Europe",
      "Capital": "Lisbon",
      "Time Zone in Capital": "Europe/Lisbon",
      "Currency": "Euro",
      "Language Codes": "pt-PT,mwl",
      "Languages": "Portuguese (official), Mirandese (official, but locally used)",
      "Area KM2": 92391,
      "Internet Hosts": 3748000,
      "Internet Users": 5168000,
      "Phones (Mobile)": 12312000,
      "Phones (Landline)": 4558000,
      "GDP": 219300000000
    },
    {
      "Country Name": "Puerto Rico",
      "ISO2": "PR",
      "ISO3": "PRI",
      "Top Level Domain": "pr",
      "FIPS": "RQ",
      "ISO Numeric": 630,
      "GeoNameID": 4566966,
      "E164": 1,
      "Phone Code": "1-787, 1-939",
      "Continent": "North America",
      "Capital": "San Juan",
      "Time Zone in Capital": "America/Puerto_Rico",
      "Currency": "Dollar",
      "Language Codes": "en-PR,es-PR",
      "Languages": "Spanish, English",
      "Area KM2": 9104,
      "Internet Hosts": 469,
      "Internet Users": 1000000,
      "Phones (Mobile)": 3060000,
      "Phones (Landline)": 780200,
      "GDP": 93520000000
    },
    {
      "Country Name": "Qatar",
      "ISO2": "QA",
      "ISO3": "QAT",
      "Top Level Domain": "qa",
      "FIPS": "QA",
      "ISO Numeric": 634,
      "GeoNameID": 289688,
      "E164": 974,
      "Phone Code": 974,
      "Continent": "Asia",
      "Capital": "Doha",
      "Time Zone in Capital": "Asia/Qatar",
      "Currency": "Rial",
      "Language Codes": "ar-QA,es",
      "Languages": "Arabic (official), English commonly used as a second language",
      "Area KM2": 11437,
      "Internet Hosts": 897,
      "Internet Users": 563800,
      "Phones (Mobile)": 2600000,
      "Phones (Landline)": 327000,
      "GDP": 213100000000
    },
    {
      "Country Name": "Republic of the Congo",
      "ISO2": "CG",
      "ISO3": "COG",
      "Top Level Domain": "cg",
      "FIPS": "CF",
      "ISO Numeric": 178,
      "GeoNameID": 2260494,
      "E164": 242,
      "Phone Code": 242,
      "Continent": "Africa",
      "Capital": "Brazzaville",
      "Time Zone in Capital": "Africa/Lagos",
      "Currency": "Franc",
      "Language Codes": "fr-CG,kg,ln-CG",
      "Languages": "French (official), Lingala and Monokutuba (lingua franca trade languages), many local languages and dialects (of which Kikongo is the most widespread)",
      "Area KM2": 342000,
      "Internet Hosts": 45,
      "Internet Users": 245200,
      "Phones (Mobile)": 4283000,
      "Phones (Landline)": 14900,
      "GDP": 14250000000
    },
    {
      "Country Name": "Reunion",
      "ISO2": "RE",
      "ISO3": "REU",
      "Top Level Domain": "re",
      "FIPS": "RE",
      "ISO Numeric": 638,
      "GeoNameID": 935317,
      "E164": 262,
      "Phone Code": 262,
      "Continent": "Africa",
      "Capital": "Saint-Denis",
      "Time Zone in Capital": "Indian/Reunion",
      "Currency": "Euro",
      "Language Codes": "fr-RE",
      "Languages": "French",
      "Area KM2": 2517,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Romania",
      "ISO2": "RO",
      "ISO3": "ROU",
      "Top Level Domain": "ro",
      "FIPS": "RO",
      "ISO Numeric": 642,
      "GeoNameID": 798549,
      "E164": 40,
      "Phone Code": 40,
      "Continent": "Europe",
      "Capital": "Bucharest",
      "Time Zone in Capital": "Europe/Bucharest",
      "Currency": "Leu",
      "Language Codes": "ro,hu,rom",
      "Languages": "Romanian (official) 85.4%, Hungarian 6.3%, Romany (Gypsy) 1.2%, other 1%, unspecified 6.1% (2011 est.)",
      "Area KM2": 237500,
      "Internet Hosts": 2667000,
      "Internet Users": 7787000,
      "Phones (Mobile)": 22700000,
      "Phones (Landline)": 4680000,
      "GDP": 188900000000
    },
    {
      "Country Name": "Russia",
      "ISO2": "RU",
      "ISO3": "RUS",
      "Top Level Domain": "ru",
      "FIPS": "RS",
      "ISO Numeric": 643,
      "GeoNameID": 2017370,
      "E164": 7,
      "Phone Code": 7,
      "Continent": "Europe",
      "Capital": "Moscow",
      "Time Zone in Capital": "Europe/Moscow",
      "Currency": "Ruble",
      "Language Codes": "ru,tt,xal,cau,ady,kv,ce,tyv,cv,udm,tut,mns,bua,myv,mdf,chm,ba,inh,tut,kbd,krc,ava,sah,nog",
      "Languages": "Russian (official) 96.3%, Dolgang 5.3%, German 1.5%, Chechen 1%, Tatar 3%, other 10.3%",
      "Area KM2": 17100000,
      "Internet Hosts": 14865000,
      "Internet Users": 40853000,
      "Phones (Mobile)": 261900000,
      "Phones (Landline)": 42900000,
      "GDP": 2113000000000
    },
    {
      "Country Name": "Rwanda",
      "ISO2": "RW",
      "ISO3": "RWA",
      "Top Level Domain": "rw",
      "FIPS": "RW",
      "ISO Numeric": 646,
      "GeoNameID": 49518,
      "E164": 250,
      "Phone Code": 250,
      "Continent": "Africa",
      "Capital": "Kigali",
      "Time Zone in Capital": "Africa/Maputo",
      "Currency": "Franc",
      "Language Codes": "rw,en-RW,fr-RW,sw",
      "Languages": "Kinyarwanda only (official, universal Bantu vernacular) 93.2%, Kinyarwanda and other language(s) 6.2%, French (official) and other language(s) 0.1%, English (official) and other language(s) 0.1%, Swahili (or Kiswahili, used in commercial centers) 0.02%, other 0.03%, unspecified 0.3% (2002 est.)",
      "Area KM2": 26338,
      "Internet Hosts": 1447,
      "Internet Users": 450000,
      "Phones (Mobile)": 5690000,
      "Phones (Landline)": 44400,
      "GDP": 7700000000
    },
    {
      "Country Name": "Saint Barthelemy",
      "ISO2": "BL",
      "ISO3": "BLM",
      "Top Level Domain": "gp",
      "FIPS": "TB",
      "ISO Numeric": 652,
      "GeoNameID": 3578476,
      "E164": 590,
      "Phone Code": 590,
      "Continent": "North America",
      "Capital": "Gustavia",
      "Time Zone in Capital": "America/Port_of_Spain",
      "Currency": "Euro",
      "Language Codes": "fr",
      "Languages": "French (primary), English",
      "Area KM2": 21,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Saint Helena",
      "ISO2": "SH",
      "ISO3": "SHN",
      "Top Level Domain": "sh",
      "FIPS": "SH",
      "ISO Numeric": 654,
      "GeoNameID": 3370751,
      "E164": 290,
      "Phone Code": 290,
      "Continent": "Africa",
      "Capital": "Jamestown",
      "Time Zone in Capital": "Africa/Abidjan",
      "Currency": "Pound",
      "Language Codes": "en-SH",
      "Languages": "English",
      "Area KM2": 410,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Saint Kitts and Nevis",
      "ISO2": "KN",
      "ISO3": "KNA",
      "Top Level Domain": "kn",
      "FIPS": "SC",
      "ISO Numeric": 659,
      "GeoNameID": 3575174,
      "E164": 1,
      "Phone Code": "1-869",
      "Continent": "North America",
      "Capital": "Basseterre",
      "Time Zone in Capital": "America/Port_of_Spain",
      "Currency": "Dollar",
      "Language Codes": "en-KN",
      "Languages": "English (official)",
      "Area KM2": 261,
      "Internet Hosts": 54,
      "Internet Users": 17000,
      "Phones (Mobile)": 84000,
      "Phones (Landline)": 20000,
      "GDP": 767000000
    },
    {
      "Country Name": "Saint Lucia",
      "ISO2": "LC",
      "ISO3": "LCA",
      "Top Level Domain": "lc",
      "FIPS": "ST",
      "ISO Numeric": 662,
      "GeoNameID": 3576468,
      "E164": 1,
      "Phone Code": "1-758",
      "Continent": "North America",
      "Capital": "Castries",
      "Time Zone in Capital": "America/Port_of_Spain",
      "Currency": "Dollar",
      "Language Codes": "en-LC",
      "Languages": "English (official), French patois",
      "Area KM2": 616,
      "Internet Hosts": 100,
      "Internet Users": 142900,
      "Phones (Mobile)": 227000,
      "Phones (Landline)": 36800,
      "GDP": 1377000000
    },
    {
      "Country Name": "Saint Martin",
      "ISO2": "MF",
      "ISO3": "MAF",
      "Top Level Domain": "gp",
      "FIPS": "RN",
      "ISO Numeric": 663,
      "GeoNameID": 3578421,
      "E164": 1,
      "Phone Code": 590,
      "Continent": "North America",
      "Capital": "Marigot",
      "Time Zone in Capital": "America/Port_of_Spain",
      "Currency": "Euro",
      "Language Codes": "fr",
      "Languages": "French (official), English, Dutch, French Patois, Spanish, Papiamento (dialect of Netherlands Antilles)",
      "Area KM2": 53,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 561500000
    },
    {
      "Country Name": "Saint Pierre and Miquelon",
      "ISO2": "PM",
      "ISO3": "SPM",
      "Top Level Domain": "pm",
      "FIPS": "SB",
      "ISO Numeric": 666,
      "GeoNameID": 3424932,
      "E164": 508,
      "Phone Code": 508,
      "Continent": "North America",
      "Capital": "Saint-Pierre",
      "Time Zone in Capital": "America/Miquelon",
      "Currency": "Euro",
      "Language Codes": "fr-PM",
      "Languages": "French (official)",
      "Area KM2": 242,
      "Internet Hosts": 15,
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": 4800,
      "GDP": 215300000
    },
    {
      "Country Name": "Saint Vincent and the Grenadines",
      "ISO2": "VC",
      "ISO3": "VCT",
      "Top Level Domain": "vc",
      "FIPS": "VC",
      "ISO Numeric": 670,
      "GeoNameID": 3577815,
      "E164": 1,
      "Phone Code": "1-784",
      "Continent": "North America",
      "Capital": "Kingstown",
      "Time Zone in Capital": "America/Port_of_Spain",
      "Currency": "Dollar",
      "Language Codes": "en-VC,fr",
      "Languages": "English, French patois",
      "Area KM2": 389,
      "Internet Hosts": 305,
      "Internet Users": 76000,
      "Phones (Mobile)": 135500,
      "Phones (Landline)": 19400,
      "GDP": 742000000
    },
    {
      "Country Name": "Samoa",
      "ISO2": "WS",
      "ISO3": "WSM",
      "Top Level Domain": "ws",
      "FIPS": "WS",
      "ISO Numeric": 882,
      "GeoNameID": 4034894,
      "E164": 685,
      "Phone Code": 685,
      "Continent": "Oceania",
      "Capital": "Apia",
      "Time Zone in Capital": "Pacific/Apia",
      "Currency": "Tala",
      "Language Codes": "sm,en-WS",
      "Languages": "Samoan (Polynesian) (official), English",
      "Area KM2": 2944,
      "Internet Hosts": 18013,
      "Internet Users": 9000,
      "Phones (Mobile)": 167400,
      "Phones (Landline)": 35300,
      "GDP": 705000000
    },
    {
      "Country Name": "San Marino",
      "ISO2": "SM",
      "ISO3": "SMR",
      "Top Level Domain": "sm",
      "FIPS": "SM",
      "ISO Numeric": 674,
      "GeoNameID": 3168068,
      "E164": 378,
      "Phone Code": 378,
      "Continent": "Europe",
      "Capital": "San Marino",
      "Time Zone in Capital": "Europe/Rome",
      "Currency": "Euro",
      "Language Codes": "it-SM",
      "Languages": "Italian",
      "Area KM2": 61,
      "Internet Hosts": 11015,
      "Internet Users": 17000,
      "Phones (Mobile)": 36000,
      "Phones (Landline)": 18700,
      "GDP": 1866000000
    },
    {
      "Country Name": "Sao Tome and Principe",
      "ISO2": "ST",
      "ISO3": "STP",
      "Top Level Domain": "st",
      "FIPS": "TP",
      "ISO Numeric": 678,
      "GeoNameID": 2410758,
      "E164": 239,
      "Phone Code": 239,
      "Continent": "Africa",
      "Capital": "Sao Tome",
      "Time Zone in Capital": "Africa/Abidjan",
      "Currency": "Dobra",
      "Language Codes": "pt-ST",
      "Languages": "Portuguese 98.4% (official), Forro 36.2%, Cabo Verdian 8.5%, French 6.8%, Angolar 6.6%, English 4.9%, Lunguie 1%, other (including sign language) 2.4%",
      "Area KM2": 1001,
      "Internet Hosts": 1678,
      "Internet Users": 26700,
      "Phones (Mobile)": 122000,
      "Phones (Landline)": 8000,
      "GDP": 311000000
    },
    {
      "Country Name": "Saudi Arabia",
      "ISO2": "SA",
      "ISO3": "SAU",
      "Top Level Domain": "sa",
      "FIPS": "SA",
      "ISO Numeric": 682,
      "GeoNameID": 102358,
      "E164": 966,
      "Phone Code": 966,
      "Continent": "Asia",
      "Capital": "Riyadh",
      "Time Zone in Capital": "Asia/Riyadh",
      "Currency": "Rial",
      "Language Codes": "ar-SA",
      "Languages": "Arabic (official)",
      "Area KM2": 1960582,
      "Internet Hosts": 145941,
      "Internet Users": 9774000,
      "Phones (Mobile)": 53000000,
      "Phones (Landline)": 4800000,
      "GDP": 718500000000
    },
    {
      "Country Name": "Senegal",
      "ISO2": "SN",
      "ISO3": "SEN",
      "Top Level Domain": "sn",
      "FIPS": "SG",
      "ISO Numeric": 686,
      "GeoNameID": 2245662,
      "E164": 221,
      "Phone Code": 221,
      "Continent": "Africa",
      "Capital": "Dakar",
      "Time Zone in Capital": "Africa/Abidjan",
      "Currency": "Franc",
      "Language Codes": "fr-SN,wo,fuc,mnk",
      "Languages": "French (official), Wolof, Pulaar, Jola, Mandinka",
      "Area KM2": 196190,
      "Internet Hosts": 237,
      "Internet Users": 1818000,
      "Phones (Mobile)": 11470000,
      "Phones (Landline)": 338200,
      "GDP": 15360000000
    },
    {
      "Country Name": "Serbia",
      "ISO2": "RS",
      "ISO3": "SRB",
      "Top Level Domain": "rs",
      "FIPS": "RI",
      "ISO Numeric": 688,
      "GeoNameID": 6290252,
      "E164": 381,
      "Phone Code": 381,
      "Continent": "Europe",
      "Capital": "Belgrade",
      "Time Zone in Capital": "Europe/Belgrade",
      "Currency": "Dinar",
      "Language Codes": "sr,hu,bs,rom",
      "Languages": "Serbian (official) 88.1%, Hungarian 3.4%, Bosnian 1.9%, Romany 1.4%, other 3.4%, undeclared or unknown 1.8%",
      "Area KM2": 88361,
      "Internet Hosts": 1102000,
      "Internet Users": 4107000,
      "Phones (Mobile)": 9138000,
      "Phones (Landline)": 2977000,
      "GDP": 43680000000
    },
    {
      "Country Name": "Seychelles",
      "ISO2": "SC",
      "ISO3": "SYC",
      "Top Level Domain": "sc",
      "FIPS": "SE",
      "ISO Numeric": 690,
      "GeoNameID": 241170,
      "E164": 248,
      "Phone Code": 248,
      "Continent": "Africa",
      "Capital": "Victoria",
      "Time Zone in Capital": "Indian/Mahe",
      "Currency": "Rupee",
      "Language Codes": "en-SC,fr-SC",
      "Languages": "Seychellois Creole (official) 89.1%, English (official) 5.1%, French (official) 0.7%, other 3.8%, unspecified 1.4% (2010 est.)",
      "Area KM2": 455,
      "Internet Hosts": 247,
      "Internet Users": 32000,
      "Phones (Mobile)": 138300,
      "Phones (Landline)": 28900,
      "GDP": 1271000000
    },
    {
      "Country Name": "Sierra Leone",
      "ISO2": "SL",
      "ISO3": "SLE",
      "Top Level Domain": "sl",
      "FIPS": "SL",
      "ISO Numeric": 694,
      "GeoNameID": 2403846,
      "E164": 232,
      "Phone Code": 232,
      "Continent": "Africa",
      "Capital": "Freetown",
      "Time Zone in Capital": "Africa/Abidjan",
      "Currency": "Leone",
      "Language Codes": "en-SL,men,tem",
      "Languages": "English (official, regular use limited to literate minority), Mende (principal vernacular in the south), Temne (principal vernacular in the north), Krio (English-based Creole, spoken by the descendants of freed Jamaican slaves who were settled in the Freetown area, a lingua franca and a first language for 10% of the population but understood by 95%)",
      "Area KM2": 71740,
      "Internet Hosts": 282,
      "Internet Users": 14900,
      "Phones (Mobile)": 2210000,
      "Phones (Landline)": 18000,
      "GDP": 4607000000
    },
    {
      "Country Name": "Singapore",
      "ISO2": "SG",
      "ISO3": "SGP",
      "Top Level Domain": "sg",
      "FIPS": "SN",
      "ISO Numeric": 702,
      "GeoNameID": 1880251,
      "E164": 65,
      "Phone Code": 65,
      "Continent": "Asia",
      "Capital": "Singapore",
      "Time Zone in Capital": "Asia/Singapore",
      "Currency": "Dollar",
      "Language Codes": "cmn,en-SG,ms-SG,ta-SG,zh-SG",
      "Languages": "Mandarin (official) 36.3%, English (official) 29.8%, Malay (official) 11.9%, Hokkien 8.1%, Tamil (official) 4.4%, Cantonese 4.1%, Teochew 3.2%, other Indian languages 1.2%, other Chinese dialects 1.1%, other 1.1% (2010 est.)",
      "Area KM2": 693,
      "Internet Hosts": 1960000,
      "Internet Users": 3235000,
      "Phones (Mobile)": 8063000,
      "Phones (Landline)": 1990000,
      "GDP": 295700000000
    },
    {
      "Country Name": "Sint Maarten",
      "ISO2": "SX",
      "ISO3": "SXM",
      "Top Level Domain": "sx",
      "FIPS": "NN",
      "ISO Numeric": 534,
      "GeoNameID": 7609695,
      "E164": 1,
      "Phone Code": "1-721",
      "Continent": "North America",
      "Capital": "Philipsburg",
      "Time Zone in Capital": "America/Curacao",
      "Currency": "Guilder",
      "Language Codes": "nl,en",
      "Languages": "English (official) 67.5%, Spanish 12.9%, Creole 8.2%, Dutch (official) 4.2%, Papiamento (a Spanish-Portuguese-Dutch-English dialect) 2.2%, French 1.5%, other 3.5% (2001 census)",
      "Area KM2": 34,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 794700000
    },
    {
      "Country Name": "Slovakia",
      "ISO2": "SK",
      "ISO3": "SVK",
      "Top Level Domain": "sk",
      "FIPS": "LO",
      "ISO Numeric": 703,
      "GeoNameID": 3057568,
      "E164": 421,
      "Phone Code": 421,
      "Continent": "Europe",
      "Capital": "Bratislava",
      "Time Zone in Capital": "Europe/Prague",
      "Currency": "Euro",
      "Language Codes": "sk,hu",
      "Languages": "Slovak (official) 78.6%, Hungarian 9.4%, Roma 2.3%, Ruthenian 1%, other or unspecified 8.8% (2011 est.)",
      "Area KM2": 48845,
      "Internet Hosts": 1384000,
      "Internet Users": 4063000,
      "Phones (Mobile)": 6095000,
      "Phones (Landline)": 975000,
      "GDP": 96960000000
    },
    {
      "Country Name": "Slovenia",
      "ISO2": "SI",
      "ISO3": "SVN",
      "Top Level Domain": "si",
      "FIPS": "SI",
      "ISO Numeric": 705,
      "GeoNameID": 3190538,
      "E164": 386,
      "Phone Code": 386,
      "Continent": "Europe",
      "Capital": "Ljubljana",
      "Time Zone in Capital": "Europe/Belgrade",
      "Currency": "Euro",
      "Language Codes": "sl,sh",
      "Languages": "Slovenian (official) 91.1%, Serbo-Croatian 4.5%, other or unspecified 4.4%, Italian (official, only in municipalities where Italian national communities reside), Hungarian (official, only in municipalities where Hungarian national communities reside) (2002 census)",
      "Area KM2": 20273,
      "Internet Hosts": 415581,
      "Internet Users": 1298000,
      "Phones (Mobile)": 2246000,
      "Phones (Landline)": 825000,
      "GDP": 46820000000
    },
    {
      "Country Name": "Solomon Islands",
      "ISO2": "SB",
      "ISO3": "SLB",
      "Top Level Domain": "sb",
      "FIPS": "BP",
      "ISO Numeric": "090",
      "GeoNameID": 2103350,
      "E164": 677,
      "Phone Code": 677,
      "Continent": "Oceania",
      "Capital": "Honiara",
      "Time Zone in Capital": "Pacific/Guadalcanal",
      "Currency": "Dollar",
      "Language Codes": "en-SB,tpi",
      "Languages": "Melanesian pidgin (in much of the country is lingua franca), English (official but spoken by only 1%-2% of the population), 120 indigenous languages",
      "Area KM2": 28450,
      "Internet Hosts": 4370,
      "Internet Users": 10000,
      "Phones (Mobile)": 302100,
      "Phones (Landline)": 8060,
      "GDP": 1099000000
    },
    {
      "Country Name": "Somalia",
      "ISO2": "SO",
      "ISO3": "SOM",
      "Top Level Domain": "so",
      "FIPS": "SO",
      "ISO Numeric": 706,
      "GeoNameID": 51537,
      "E164": 252,
      "Phone Code": 252,
      "Continent": "Africa",
      "Capital": "Mogadishu",
      "Time Zone in Capital": "Africa/Mogadishu",
      "Currency": "Shilling",
      "Language Codes": "so-SO,ar-SO,it,en-SO",
      "Languages": "Somali (official), Arabic (official, according to the Transitional Federal Charter), Italian, English",
      "Area KM2": 637657,
      "Internet Hosts": 186,
      "Internet Users": 106000,
      "Phones (Mobile)": 658000,
      "Phones (Landline)": 100000,
      "GDP": 2372000000
    },
    {
      "Country Name": "South Africa",
      "ISO2": "ZA",
      "ISO3": "ZAF",
      "Top Level Domain": "za",
      "FIPS": "SF",
      "ISO Numeric": 710,
      "GeoNameID": 953987,
      "E164": 27,
      "Phone Code": 27,
      "Continent": "Africa",
      "Capital": "Pretoria",
      "Time Zone in Capital": "Africa/Johannesburg",
      "Currency": "Rand",
      "Language Codes": "zu,xh,af,nso,en-ZA,tn,st,ts,ss,ve,nr",
      "Languages": "IsiZulu (official) 22.7%, IsiXhosa (official) 16%, Afrikaans (official) 13.5%, English (official) 9.6%, Sepedi (official) 9.1%, Setswana (official) 8%, Sesotho (official) 7.6%, Xitsonga (official) 4.5%, siSwati (official) 2.5%, Tshivenda (official) 2.4%, isiNdebele (official) 2.1%, sign language 0.5%, other 1.6% (2011 est.)",
      "Area KM2": 1219912,
      "Internet Hosts": 4761000,
      "Internet Users": 4420000,
      "Phones (Mobile)": 68400000,
      "Phones (Landline)": 4030000,
      "GDP": 353900000000
    },
    {
      "Country Name": "South Korea",
      "ISO2": "KR",
      "ISO3": "KOR",
      "Top Level Domain": "kr",
      "FIPS": "KS",
      "ISO Numeric": 410,
      "GeoNameID": 1835841,
      "E164": 82,
      "Phone Code": 82,
      "Continent": "Asia",
      "Capital": "Seoul",
      "Time Zone in Capital": "Asia/Seoul",
      "Currency": "Won",
      "Language Codes": "ko-KR,en",
      "Languages": "Korean, English (widely taught in junior high and high school)",
      "Area KM2": 98480,
      "Internet Hosts": 315697,
      "Internet Users": 39400000,
      "Phones (Mobile)": 53625000,
      "Phones (Landline)": 30100000,
      "GDP": 1198000000000
    },
    {
      "Country Name": "South Sudan",
      "ISO2": "SS",
      "ISO3": "SSD",
      "Top Level Domain": "ss",
      "FIPS": "OD",
      "ISO Numeric": 728,
      "GeoNameID": 7909807,
      "E164": 211,
      "Phone Code": 211,
      "Continent": "Africa",
      "Capital": "Juba",
      "Time Zone in Capital": "Africa/Khartoum",
      "Currency": "Pound",
      "Language Codes": "en",
      "Languages": "English (official), Arabic (includes Juba and Sudanese variants), regional languages include Dinka, Nuer, Bari, Zande, Shilluk",
      "Area KM2": 644329,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": 2000000,
      "Phones (Landline)": 2200,
      "GDP": 11770000000
    },
    {
      "Country Name": "Spain",
      "ISO2": "ES",
      "ISO3": "ESP",
      "Top Level Domain": "es",
      "FIPS": "SP",
      "ISO Numeric": 724,
      "GeoNameID": 2510769,
      "E164": 34,
      "Phone Code": 34,
      "Continent": "Europe",
      "Capital": "Madrid",
      "Time Zone in Capital": "Europe/Madrid",
      "Currency": "Euro",
      "Language Codes": "es-ES,ca,gl,eu,oc",
      "Languages": "Castilian Spanish (official) 74%, Catalan 17%, Galician 7%, and Basque 2%",
      "Area KM2": 504782,
      "Internet Hosts": 4228000,
      "Internet Users": 28119000,
      "Phones (Mobile)": 50663000,
      "Phones (Landline)": 19220000,
      "GDP": 1356000000000
    },
    {
      "Country Name": "Sri Lanka",
      "ISO2": "LK",
      "ISO3": "LKA",
      "Top Level Domain": "lk",
      "FIPS": "CE",
      "ISO Numeric": 144,
      "GeoNameID": 1227603,
      "E164": 94,
      "Phone Code": 94,
      "Continent": "Asia",
      "Capital": "Colombo",
      "Time Zone in Capital": "Asia/Colombo",
      "Currency": "Rupee",
      "Language Codes": "si,ta,en",
      "Languages": "Sinhala (official and national language) 74%, Tamil (national language) 18%, other 8%",
      "Area KM2": 65610,
      "Internet Hosts": 9552,
      "Internet Users": 1777000,
      "Phones (Mobile)": 19533000,
      "Phones (Landline)": 2796000,
      "GDP": 65120000000
    },
    {
      "Country Name": "Sudan",
      "ISO2": "SD",
      "ISO3": "SDN",
      "Top Level Domain": "sd",
      "FIPS": "SU",
      "ISO Numeric": 729,
      "GeoNameID": 366755,
      "E164": 249,
      "Phone Code": 249,
      "Continent": "Africa",
      "Capital": "Khartoum",
      "Time Zone in Capital": "Africa/Khartoum",
      "Currency": "Pound",
      "Language Codes": "ar-SD,en,fia",
      "Languages": "Arabic (official), English (official), Nubian, Ta Bedawie, Fur",
      "Area KM2": 1861484,
      "Internet Hosts": 99,
      "Internet Users": 4200000,
      "Phones (Mobile)": 27659000,
      "Phones (Landline)": 425000,
      "GDP": 52500000000
    },
    {
      "Country Name": "Suriname",
      "ISO2": "SR",
      "ISO3": "SUR",
      "Top Level Domain": "sr",
      "FIPS": "NS",
      "ISO Numeric": 740,
      "GeoNameID": 3382998,
      "E164": 597,
      "Phone Code": 597,
      "Continent": "South America",
      "Capital": "Paramaribo",
      "Time Zone in Capital": "America/Paramaribo",
      "Currency": "Dollar",
      "Language Codes": "nl-SR,en,srn,hns,jv",
      "Languages": "Dutch (official), English (widely spoken), Sranang Tongo (Surinamese, sometimes called Taki-Taki, is native language of Creoles and much of the younger population and is lingua franca among others), Caribbean Hindustani (a dialect of Hindi), Javanese",
      "Area KM2": 163270,
      "Internet Hosts": 188,
      "Internet Users": 163000,
      "Phones (Mobile)": 977000,
      "Phones (Landline)": 83000,
      "GDP": 5009000000
    },
    {
      "Country Name": "Svalbard and Jan Mayen",
      "ISO2": "SJ",
      "ISO3": "SJM",
      "Top Level Domain": "sj",
      "FIPS": "SV",
      "ISO Numeric": 744,
      "GeoNameID": 607072,
      "E164": 47,
      "Phone Code": 47,
      "Continent": "Europe",
      "Capital": "Longyearbyen",
      "Time Zone in Capital": "Europe/Oslo",
      "Currency": "Krone",
      "Language Codes": "no,ru",
      "Languages": "Norwegian, Russian",
      "Area KM2": 62049,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Swaziland",
      "ISO2": "SZ",
      "ISO3": "SWZ",
      "Top Level Domain": "sz",
      "FIPS": "WZ",
      "ISO Numeric": 748,
      "GeoNameID": 934841,
      "E164": 268,
      "Phone Code": 268,
      "Continent": "Africa",
      "Capital": "Mbabane",
      "Time Zone in Capital": "Africa/Johannesburg",
      "Currency": "Lilangeni",
      "Language Codes": "en-SZ,ss-SZ",
      "Languages": "English (official, used for government business), siSwati (official)",
      "Area KM2": 17363,
      "Internet Hosts": 2744,
      "Internet Users": 90100,
      "Phones (Mobile)": 805000,
      "Phones (Landline)": 48600,
      "GDP": 3807000000
    },
    {
      "Country Name": "Sweden",
      "ISO2": "SE",
      "ISO3": "SWE",
      "Top Level Domain": "se",
      "FIPS": "SW",
      "ISO Numeric": 752,
      "GeoNameID": 2661886,
      "E164": 46,
      "Phone Code": 46,
      "Continent": "Europe",
      "Capital": "Stockholm",
      "Time Zone in Capital": "Europe/Stockholm",
      "Currency": "Krona",
      "Language Codes": "sv-SE,se,sma,fi-SE",
      "Languages": "Swedish (official), small Sami- and Finnish-speaking minorities",
      "Area KM2": 449964,
      "Internet Hosts": 5978000,
      "Internet Users": 8398000,
      "Phones (Mobile)": 11643000,
      "Phones (Landline)": 4321000,
      "GDP": 552000000000
    },
    {
      "Country Name": "Switzerland",
      "ISO2": "CH",
      "ISO3": "CHE",
      "Top Level Domain": "ch",
      "FIPS": "SZ",
      "ISO Numeric": 756,
      "GeoNameID": 2658434,
      "E164": 41,
      "Phone Code": 41,
      "Continent": "Europe",
      "Capital": "Berne",
      "Time Zone in Capital": "Europe/Zurich",
      "Currency": "Franc",
      "Language Codes": "de-CH,fr-CH,it-CH,rm",
      "Languages": "German (official) 64.9%, French (official) 22.6%, Italian (official) 8.3%, Serbo-Croatian 2.5%, Albanian 2.6%, Portuguese 3.4%, Spanish 2.2%, English 4.6%, Romansch (official) 0.5%, other 5.1%",
      "Area KM2": 41290,
      "Internet Hosts": 5301000,
      "Internet Users": 6152000,
      "Phones (Mobile)": 10460000,
      "Phones (Landline)": 4382000,
      "GDP": 646200000000
    },
    {
      "Country Name": "Syria",
      "ISO2": "SY",
      "ISO3": "SYR",
      "Top Level Domain": "sy",
      "FIPS": "SY",
      "ISO Numeric": 760,
      "GeoNameID": 163843,
      "E164": 963,
      "Phone Code": 963,
      "Continent": "Asia",
      "Capital": "Damascus",
      "Time Zone in Capital": "Asia/Damascus",
      "Currency": "Pound",
      "Language Codes": "ar-SY,ku,hy,arc,fr,en",
      "Languages": "Arabic (official), Kurdish, Armenian, Aramaic, Circassian (widely understood); French, English (somewhat understood)",
      "Area KM2": 185180,
      "Internet Hosts": 416,
      "Internet Users": 4469000,
      "Phones (Mobile)": 12928000,
      "Phones (Landline)": 4425000,
      "GDP": 64700000000
    },
    {
      "Country Name": "Taiwan",
      "ISO2": "TW",
      "ISO3": "TWN",
      "Top Level Domain": "tw",
      "FIPS": "TW",
      "ISO Numeric": 158,
      "GeoNameID": 1668284,
      "E164": 886,
      "Phone Code": 886,
      "Continent": "Asia",
      "Capital": "Taipei",
      "Time Zone in Capital": "Asia/Taipei",
      "Currency": "Dollar",
      "Language Codes": "zh-TW,zh,nan,hak",
      "Languages": "Mandarin Chinese (official), Taiwanese (Min), Hakka dialects",
      "Area KM2": 35980,
      "Internet Hosts": 6272000,
      "Internet Users": 16147000,
      "Phones (Mobile)": 29455000,
      "Phones (Landline)": 15998000,
      "GDP": 484700000000
    },
    {
      "Country Name": "Tajikistan",
      "ISO2": "TJ",
      "ISO3": "TJK",
      "Top Level Domain": "tj",
      "FIPS": "TI",
      "ISO Numeric": 762,
      "GeoNameID": 1220409,
      "E164": 992,
      "Phone Code": 992,
      "Continent": "Asia",
      "Capital": "Dushanbe",
      "Time Zone in Capital": "Asia/Dushanbe",
      "Currency": "Somoni",
      "Language Codes": "tg,ru",
      "Languages": "Tajik (official), Russian widely used in government and business",
      "Area KM2": 143100,
      "Internet Hosts": 6258,
      "Internet Users": 700000,
      "Phones (Mobile)": 6528000,
      "Phones (Landline)": 393000,
      "GDP": 8513000000
    },
    {
      "Country Name": "Tanzania",
      "ISO2": "TZ",
      "ISO3": "TZA",
      "Top Level Domain": "tz",
      "FIPS": "TZ",
      "ISO Numeric": 834,
      "GeoNameID": 149590,
      "E164": 255,
      "Phone Code": 255,
      "Continent": "Africa",
      "Capital": "Dodoma",
      "Time Zone in Capital": "Africa/Dar_es_Salaam",
      "Currency": "Shilling",
      "Language Codes": "sw-TZ,en,ar",
      "Languages": "Kiswahili or Swahili (official), Kiunguja (name for Swahili in Zanzibar), English (official, primary language of commerce, administration, and higher education), Arabic (widely spoken in Zanzibar), many local languages",
      "Area KM2": 945087,
      "Internet Hosts": 26074,
      "Internet Users": 678000,
      "Phones (Mobile)": 27220000,
      "Phones (Landline)": 161100,
      "GDP": 31940000000
    },
    {
      "Country Name": "Thailand",
      "ISO2": "TH",
      "ISO3": "THA",
      "Top Level Domain": "th",
      "FIPS": "TH",
      "ISO Numeric": 764,
      "GeoNameID": 1605651,
      "E164": 66,
      "Phone Code": 66,
      "Continent": "Asia",
      "Capital": "Bangkok",
      "Time Zone in Capital": "Asia/Bangkok",
      "Currency": "Baht",
      "Language Codes": "th,en",
      "Languages": "Thai (official) 90.7%, Burmese 1.3%, other 8%",
      "Area KM2": 514000,
      "Internet Hosts": 3399000,
      "Internet Users": 17483000,
      "Phones (Mobile)": 84075000,
      "Phones (Landline)": 6391000,
      "GDP": 400900000000
    },
    {
      "Country Name": "Togo",
      "ISO2": "TG",
      "ISO3": "TGO",
      "Top Level Domain": "tg",
      "FIPS": "TO",
      "ISO Numeric": 768,
      "GeoNameID": 2363686,
      "E164": 228,
      "Phone Code": 228,
      "Continent": "Africa",
      "Capital": "Lome",
      "Time Zone in Capital": "Africa/Abidjan",
      "Currency": "Franc",
      "Language Codes": "fr-TG,ee,hna,kbp,dag,ha",
      "Languages": "French (official, the language of commerce), Ewe and Mina (the two major African languages in the south), Kabye (sometimes spelled Kabiye) and Dagomba (the two major African languages in the north)",
      "Area KM2": 56785,
      "Internet Hosts": 1168,
      "Internet Users": 356300,
      "Phones (Mobile)": 3518000,
      "Phones (Landline)": 225000,
      "GDP": 4299000000
    },
    {
      "Country Name": "Tokelau",
      "ISO2": "TK",
      "ISO3": "TKL",
      "Top Level Domain": "tk",
      "FIPS": "TL",
      "ISO Numeric": 772,
      "GeoNameID": 4031074,
      "E164": 690,
      "Phone Code": 690,
      "Continent": "Oceania",
      "Capital": "",
      "Time Zone in Capital": "Pacific/Fakaofo",
      "Currency": "Dollar",
      "Language Codes": "tkl,en-TK",
      "Languages": "Tokelauan 93.5% (a Polynesian language), English 58.9%, Samoan 45.5%, Tuvaluan 11.6%, Kiribati 2.7%, other 2.5%, none 4.1%, unspecified 0.6%",
      "Area KM2": 10,
      "Internet Hosts": 2069,
      "Internet Users": 800,
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Tonga",
      "ISO2": "TO",
      "ISO3": "TON",
      "Top Level Domain": "to",
      "FIPS": "TN",
      "ISO Numeric": 776,
      "GeoNameID": 4032283,
      "E164": 676,
      "Phone Code": 676,
      "Continent": "Oceania",
      "Capital": "Nuku'alofa",
      "Time Zone in Capital": "Pacific/Tongatapu",
      "Currency": "Pa'anga",
      "Language Codes": "to,en-TO",
      "Languages": "English and Tongan 87%, Tongan (official) 10.7%, English (official) 1.2%, other 1.1%, uspecified 0.03% (2006 est.)",
      "Area KM2": 748,
      "Internet Hosts": 5367,
      "Internet Users": 8400,
      "Phones (Mobile)": 56000,
      "Phones (Landline)": 30000,
      "GDP": 477000000
    },
    {
      "Country Name": "Trinidad and Tobago",
      "ISO2": "TT",
      "ISO3": "TTO",
      "Top Level Domain": "tt",
      "FIPS": "TD",
      "ISO Numeric": 780,
      "GeoNameID": 3573591,
      "E164": 1,
      "Phone Code": "1-868",
      "Continent": "North America",
      "Capital": "Port of Spain",
      "Time Zone in Capital": "America/Port_of_Spain",
      "Currency": "Dollar",
      "Language Codes": "en-TT,hns,fr,es,zh",
      "Languages": "English (official), Caribbean Hindustani (a dialect of Hindi), French, Spanish, Chinese",
      "Area KM2": 5128,
      "Internet Hosts": 241690,
      "Internet Users": 593000,
      "Phones (Mobile)": 1884000,
      "Phones (Landline)": 287000,
      "GDP": 27130000000
    },
    {
      "Country Name": "Tunisia",
      "ISO2": "TN",
      "ISO3": "TUN",
      "Top Level Domain": "tn",
      "FIPS": "TS",
      "ISO Numeric": 788,
      "GeoNameID": 2464461,
      "E164": 216,
      "Phone Code": 216,
      "Continent": "Africa",
      "Capital": "Tunis",
      "Time Zone in Capital": "Africa/Tunis",
      "Currency": "Dinar",
      "Language Codes": "ar-TN,fr",
      "Languages": "Arabic (official, one of the languages of commerce), French (commerce), Berber (Tamazight)",
      "Area KM2": 163610,
      "Internet Hosts": 576,
      "Internet Users": 3500000,
      "Phones (Mobile)": 12840000,
      "Phones (Landline)": 1105000,
      "GDP": 48380000000
    },
    {
      "Country Name": "Turkey",
      "ISO2": "TR",
      "ISO3": "TUR",
      "Top Level Domain": "tr",
      "FIPS": "TU",
      "ISO Numeric": 792,
      "GeoNameID": 298795,
      "E164": 90,
      "Phone Code": 90,
      "Continent": "Asia",
      "Capital": "Ankara",
      "Time Zone in Capital": "Europe/Istanbul",
      "Currency": "Lira",
      "Language Codes": "tr-TR,ku,diq,az,av",
      "Languages": "Turkish (official), Kurdish, other minority languages",
      "Area KM2": 780580,
      "Internet Hosts": 7093000,
      "Internet Users": 27233000,
      "Phones (Mobile)": 67680000,
      "Phones (Landline)": 13860000,
      "GDP": 821800000000
    },
    {
      "Country Name": "Turkmenistan",
      "ISO2": "TM",
      "ISO3": "TKM",
      "Top Level Domain": "tm",
      "FIPS": "TX",
      "ISO Numeric": 795,
      "GeoNameID": 1218197,
      "E164": 993,
      "Phone Code": 993,
      "Continent": "Asia",
      "Capital": "Ashgabat",
      "Time Zone in Capital": "Asia/Ashgabat",
      "Currency": "Manat",
      "Language Codes": "tk,ru,uz",
      "Languages": "Turkmen (official) 72%, Russian 12%, Uzbek 9%, other 7%",
      "Area KM2": 488100,
      "Internet Hosts": 714,
      "Internet Users": 80400,
      "Phones (Mobile)": 3953000,
      "Phones (Landline)": 575000,
      "GDP": 40560000000
    },
    {
      "Country Name": "Turks and Caicos Islands",
      "ISO2": "TC",
      "ISO3": "TCA",
      "Top Level Domain": "tc",
      "FIPS": "TK",
      "ISO Numeric": 796,
      "GeoNameID": 3576916,
      "E164": 1,
      "Phone Code": "1-649",
      "Continent": "North America",
      "Capital": "Cockburn Town",
      "Time Zone in Capital": "America/Grand_Turk",
      "Currency": "Dollar",
      "Language Codes": "en-TC",
      "Languages": "English (official)",
      "Area KM2": 430,
      "Internet Hosts": 73217,
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Tuvalu",
      "ISO2": "TV",
      "ISO3": "TUV",
      "Top Level Domain": "tv",
      "FIPS": "TV",
      "ISO Numeric": 798,
      "GeoNameID": 2110297,
      "E164": 688,
      "Phone Code": 688,
      "Continent": "Oceania",
      "Capital": "Funafuti",
      "Time Zone in Capital": "Pacific/Funafuti",
      "Currency": "Dollar",
      "Language Codes": "tvl,en,sm,gil",
      "Languages": "Tuvaluan (official), English (official), Samoan, Kiribati (on the island of Nui)",
      "Area KM2": 26,
      "Internet Hosts": 145158,
      "Internet Users": 4200,
      "Phones (Mobile)": 2800,
      "Phones (Landline)": 1450,
      "GDP": 38000000
    },
    {
      "Country Name": "U.S. Virgin Islands",
      "ISO2": "VI",
      "ISO3": "VIR",
      "Top Level Domain": "vi",
      "FIPS": "VQ",
      "ISO Numeric": 850,
      "GeoNameID": 4796775,
      "E164": 1,
      "Phone Code": "1-340",
      "Continent": "North America",
      "Capital": "Charlotte Amalie",
      "Time Zone in Capital": "America/Port_of_Spain",
      "Currency": "Dollar",
      "Language Codes": "en-VI",
      "Languages": "English 74.7%, Spanish or Spanish Creole 16.8%, French or French Creole 6.6%, other 1.9% (2000 census)",
      "Area KM2": 352,
      "Internet Hosts": 4790,
      "Internet Users": 30000,
      "Phones (Mobile)": 80300,
      "Phones (Landline)": 75800,
      "GDP": 0
    },
    {
      "Country Name": "Uganda",
      "ISO2": "UG",
      "ISO3": "UGA",
      "Top Level Domain": "ug",
      "FIPS": "UG",
      "ISO Numeric": 800,
      "GeoNameID": 226074,
      "E164": 256,
      "Phone Code": 256,
      "Continent": "Africa",
      "Capital": "Kampala",
      "Time Zone in Capital": "Africa/Kampala",
      "Currency": "Shilling",
      "Language Codes": "en-UG,lg,sw,ar",
      "Languages": "English (official national language, taught in grade schools, used in courts of law and by most newspapers and some radio broadcasts), Ganda or Luganda (most widely used of the Niger-Congo languages, preferred for native language publications in the capital and may be taught in school), other Niger-Congo languages, Nilo-Saharan languages, Swahili, Arabic",
      "Area KM2": 236040,
      "Internet Hosts": 32683,
      "Internet Users": 3200000,
      "Phones (Mobile)": 16355000,
      "Phones (Landline)": 315000,
      "GDP": 22600000000
    },
    {
      "Country Name": "Ukraine",
      "ISO2": "UA",
      "ISO3": "UKR",
      "Top Level Domain": "ua",
      "FIPS": "UP",
      "ISO Numeric": 804,
      "GeoNameID": 690791,
      "E164": 380,
      "Phone Code": 380,
      "Continent": "Europe",
      "Capital": "Kiev",
      "Time Zone in Capital": "Europe/Kiev",
      "Currency": "Hryvnia",
      "Language Codes": "uk,ru-UA,rom,pl,hu",
      "Languages": "Ukrainian (official) 67%, Russian (regional language) 24%, other (includes small Romanian-, Polish-, and Hungarian-speaking minorities) 9%",
      "Area KM2": 603700,
      "Internet Hosts": 2173000,
      "Internet Users": 7770000,
      "Phones (Mobile)": 59344000,
      "Phones (Landline)": 12182000,
      "GDP": 175500000000
    },
    {
      "Country Name": "United Arab Emirates",
      "ISO2": "AE",
      "ISO3": "ARE",
      "Top Level Domain": "ae",
      "FIPS": "AE",
      "ISO Numeric": 784,
      "GeoNameID": 290557,
      "E164": 971,
      "Phone Code": 971,
      "Continent": "Asia",
      "Capital": "Abu Dhabi",
      "Time Zone in Capital": "Asia/Dubai",
      "Currency": "Dirham",
      "Language Codes": "ar-AE,fa,en,hi,ur",
      "Languages": "Arabic (official), Persian, English, Hindi, Urdu",
      "Area KM2": 82880,
      "Internet Hosts": 337804,
      "Internet Users": 3449000,
      "Phones (Mobile)": 13775000,
      "Phones (Landline)": 1967000,
      "GDP": 390000000000
    },
    {
      "Country Name": "United Kingdom",
      "ISO2": "GB",
      "ISO3": "GBR",
      "Top Level Domain": "uk",
      "FIPS": "UK",
      "ISO Numeric": 826,
      "GeoNameID": 2635167,
      "E164": 44,
      "Phone Code": 44,
      "Continent": "Europe",
      "Capital": "London",
      "Time Zone in Capital": "Europe/London",
      "Currency": "Pound",
      "Language Codes": "en-GB,cy-GB,gd",
      "Languages": "English",
      "Area KM2": 244820,
      "Internet Hosts": 8107000,
      "Internet Users": 51444000,
      "Phones (Mobile)": 82109000,
      "Phones (Landline)": 33010000,
      "GDP": 2490000000000
    },
    {
      "Country Name": "United States",
      "ISO2": "US",
      "ISO3": "USA",
      "Top Level Domain": "us",
      "FIPS": "US",
      "ISO Numeric": 840,
      "GeoNameID": 6252001,
      "E164": 1,
      "Phone Code": 1,
      "Continent": "North America",
      "Capital": "Washington",
      "Time Zone in Capital": "America/New_York",
      "Currency": "Dollar",
      "Language Codes": "en-US,es-US,haw,fr",
      "Languages": "English 82.1%, Spanish 10.7%, other Indo-European 3.8%, Asian and Pacific island 2.7%, other 0.7% (2000 census)",
      "Area KM2": 9629091,
      "Internet Hosts": 505000000,
      "Internet Users": 245000000,
      "Phones (Mobile)": 310000000,
      "Phones (Landline)": 139000000,
      "GDP": 16720000000000
    },
    {
      "Country Name": "Uruguay",
      "ISO2": "UY",
      "ISO3": "URY",
      "Top Level Domain": "uy",
      "FIPS": "UY",
      "ISO Numeric": 858,
      "GeoNameID": 3439705,
      "E164": 598,
      "Phone Code": 598,
      "Continent": "South America",
      "Capital": "Montevideo",
      "Time Zone in Capital": "America/Montevideo",
      "Currency": "Peso",
      "Language Codes": "es-UY",
      "Languages": "Spanish (official), Portunol, Brazilero (Portuguese-Spanish mix on the Brazilian frontier)",
      "Area KM2": 176220,
      "Internet Hosts": 1036000,
      "Internet Users": 1405000,
      "Phones (Mobile)": 5000000,
      "Phones (Landline)": 1010000,
      "GDP": 57110000000
    },
    {
      "Country Name": "Uzbekistan",
      "ISO2": "UZ",
      "ISO3": "UZB",
      "Top Level Domain": "uz",
      "FIPS": "UZ",
      "ISO Numeric": 860,
      "GeoNameID": 1512440,
      "E164": 998,
      "Phone Code": 998,
      "Continent": "Asia",
      "Capital": "Tashkent",
      "Time Zone in Capital": "Asia/Tashkent",
      "Currency": "Som",
      "Language Codes": "uz,ru,tg",
      "Languages": "Uzbek (official) 74.3%, Russian 14.2%, Tajik 4.4%, other 7.1%",
      "Area KM2": 447400,
      "Internet Hosts": 56075,
      "Internet Users": 4689000,
      "Phones (Mobile)": 20274000,
      "Phones (Landline)": 1963000,
      "GDP": 55180000000
    },
    {
      "Country Name": "Vanuatu",
      "ISO2": "VU",
      "ISO3": "VUT",
      "Top Level Domain": "vu",
      "FIPS": "NH",
      "ISO Numeric": 548,
      "GeoNameID": 2134431,
      "E164": 678,
      "Phone Code": 678,
      "Continent": "Oceania",
      "Capital": "Port Vila",
      "Time Zone in Capital": "Pacific/Efate",
      "Currency": "Vatu",
      "Language Codes": "bi,en-VU,fr-VU",
      "Languages": "local languages (more than 100) 63.2%, Bislama (official; creole) 33.7%, English (official) 2%, French (official) 0.6%, other 0.5% (2009 est.)",
      "Area KM2": 12200,
      "Internet Hosts": 5655,
      "Internet Users": 17000,
      "Phones (Mobile)": 137000,
      "Phones (Landline)": 5800,
      "GDP": 828000000
    },
    {
      "Country Name": "Vatican",
      "ISO2": "VA",
      "ISO3": "VAT",
      "Top Level Domain": "va",
      "FIPS": "VT",
      "ISO Numeric": 336,
      "GeoNameID": 3164670,
      "E164": 39,
      "Phone Code": 379,
      "Continent": "Europe",
      "Capital": "Vatican City",
      "Time Zone in Capital": "Europe/Rome",
      "Currency": "Euro",
      "Language Codes": "la,it,fr",
      "Languages": "Latin, Italian, French",
      "Area KM2": 0,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Venezuela",
      "ISO2": "VE",
      "ISO3": "VEN",
      "Top Level Domain": "ve",
      "FIPS": "VE",
      "ISO Numeric": 862,
      "GeoNameID": 3625428,
      "E164": 58,
      "Phone Code": 58,
      "Continent": "South America",
      "Capital": "Caracas",
      "Time Zone in Capital": "America/Caracas",
      "Currency": "Bolivar",
      "Language Codes": "es-VE",
      "Languages": "Spanish (official), numerous indigenous dialects",
      "Area KM2": 912050,
      "Internet Hosts": 1016000,
      "Internet Users": 8918000,
      "Phones (Mobile)": 30520000,
      "Phones (Landline)": 7650000,
      "GDP": 367500000000
    },
    {
      "Country Name": "Vietnam",
      "ISO2": "VN",
      "ISO3": "VNM",
      "Top Level Domain": "vn",
      "FIPS": "VM",
      "ISO Numeric": 704,
      "GeoNameID": 1562822,
      "E164": 84,
      "Phone Code": 84,
      "Continent": "Asia",
      "Capital": "Hanoi",
      "Time Zone in Capital": "Asia/Ho_Chi_Minh",
      "Currency": "Dong",
      "Language Codes": "vi,en,fr,zh,km",
      "Languages": "Vietnamese (official), English (increasingly favored as a second language), some French, Chinese, and Khmer, mountain area languages (Mon-Khmer and Malayo-Polynesian)",
      "Area KM2": 329560,
      "Internet Hosts": 189553,
      "Internet Users": 23382000,
      "Phones (Mobile)": 134066000,
      "Phones (Landline)": 10191000,
      "GDP": 170000000000
    },
    {
      "Country Name": "Wallis and Futuna",
      "ISO2": "WF",
      "ISO3": "WLF",
      "Top Level Domain": "wf",
      "FIPS": "WF",
      "ISO Numeric": 876,
      "GeoNameID": 4034749,
      "E164": 681,
      "Phone Code": 681,
      "Continent": "Oceania",
      "Capital": "Mata Utu",
      "Time Zone in Capital": "Pacific/Wallis",
      "Currency": "Franc",
      "Language Codes": "wls,fud,fr-WF",
      "Languages": "Wallisian (indigenous Polynesian language) 58.9%, Futunian 30.1%, French (official) 10.8%, other 0.2% (2003 census)",
      "Area KM2": 274,
      "Internet Hosts": 2760,
      "Internet Users": 1300,
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Western Sahara",
      "ISO2": "EH",
      "ISO3": "ESH",
      "Top Level Domain": "eh",
      "FIPS": "WI",
      "ISO Numeric": 732,
      "GeoNameID": 2461445,
      "E164": 212,
      "Phone Code": 212,
      "Continent": "Africa",
      "Capital": "El-Aaiun",
      "Time Zone in Capital": "Africa/El_Aaiun",
      "Currency": "Dirham",
      "Language Codes": "ar,mey",
      "Languages": "Standard Arabic (national), Hassaniya Arabic, Moroccan Arabic",
      "Area KM2": 266000,
      "Internet Hosts": "",
      "Internet Users": "",
      "Phones (Mobile)": "",
      "Phones (Landline)": "",
      "GDP": 0
    },
    {
      "Country Name": "Yemen",
      "ISO2": "YE",
      "ISO3": "YEM",
      "Top Level Domain": "ye",
      "FIPS": "YM",
      "ISO Numeric": 887,
      "GeoNameID": 69543,
      "E164": 967,
      "Phone Code": 967,
      "Continent": "Asia",
      "Capital": "Sanaa",
      "Time Zone in Capital": "Asia/Aden",
      "Currency": "Rial",
      "Language Codes": "ar-YE",
      "Languages": "Arabic (official)",
      "Area KM2": 527970,
      "Internet Hosts": 33206,
      "Internet Users": 2349000,
      "Phones (Mobile)": 13900000,
      "Phones (Landline)": 1100000,
      "GDP": 43890000000
    },
    {
      "Country Name": "Zambia",
      "ISO2": "ZM",
      "ISO3": "ZMB",
      "Top Level Domain": "zm",
      "FIPS": "ZA",
      "ISO Numeric": 894,
      "GeoNameID": 895949,
      "E164": 260,
      "Phone Code": 260,
      "Continent": "Africa",
      "Capital": "Lusaka",
      "Time Zone in Capital": "Africa/Maputo",
      "Currency": "Kwacha",
      "Language Codes": "en-ZM,bem,loz,lun,lue,ny,toi",
      "Languages": "Bembe 33.4%, Nyanja 14.7%, Tonga 11.4%, Lozi 5.5%, Chewa 4.5%, Nsenga 2.9%, Tumbuka 2.5%, Lunda (North Western) 1.9%, Kaonde 1.8%, Lala 1.8%, Lamba 1.8%, English (official) 1.7%, Luvale 1.5%, Mambwe 1.3%, Namwanga 1.2%, Lenje 1.1%, Bisa 1%, other 9.2%, unspecified 0.4%",
      "Area KM2": 752614,
      "Internet Hosts": 16571,
      "Internet Users": 816200,
      "Phones (Mobile)": 10525000,
      "Phones (Landline)": 82500,
      "GDP": 22240000000
    },
    {
      "Country Name": "Zimbabwe",
      "ISO2": "ZW",
      "ISO3": "ZWE",
      "Top Level Domain": "zw",
      "FIPS": "ZI",
      "ISO Numeric": 716,
      "GeoNameID": 878675,
      "E164": 263,
      "Phone Code": 263,
      "Continent": "Africa",
      "Capital": "Harare",
      "Time Zone in Capital": "Africa/Maputo",
      "Currency": "Dollar",
      "Language Codes": "en-ZW,sn,nr,nd",
      "Languages": "English (official), Shona, Sindebele (the language of the Ndebele, sometimes called Ndebele), numerous but minor tribal dialects",
      "Area KM2": 390580,
      "Internet Hosts": 30615,
      "Internet Users": 1423000,
      "Phones (Mobile)": 12614000,
      "Phones (Landline)": 301600,
      "GDP": 10480000000
    }
  ];

  return _list;
}
// --------------------
/// COUNTRY NAME - ISO2
List<Map<String, dynamic>> cocoNameIso2(){

  return [
    {
      "country": "Afghanistan",
      "abbreviation": "AF"
    },
    {
      "country": "Albania",
      "abbreviation": "AL"
    },
    {
      "country": "Algeria",
      "abbreviation": "DZ"
    },
    {
      "country": "American Samoa",
      "abbreviation": "AS"
    },
    {
      "country": "Andorra",
      "abbreviation": "AD"
    },
    {
      "country": "Angola",
      "abbreviation": "AO"
    },
    {
      "country": "Anguilla",
      "abbreviation": "AI"
    },
    {
      "country": "Antarctica",
      "abbreviation": "AQ"
    },
    {
      "country": "Antigua and Barbuda",
      "abbreviation": "AG"
    },
    {
      "country": "Argentina",
      "abbreviation": "AR"
    },
    {
      "country": "Armenia",
      "abbreviation": "AM"
    },
    {
      "country": "Aruba",
      "abbreviation": "AW"
    },
    {
      "country": "Australia",
      "abbreviation": "AU"
    },
    {
      "country": "Austria",
      "abbreviation": "AT"
    },
    {
      "country": "Azerbaijan",
      "abbreviation": "AZ"
    },
    {
      "country": "Bahamas",
      "abbreviation": "BS"
    },
    {
      "country": "Bahrain",
      "abbreviation": "BH"
    },
    {
      "country": "Bangladesh",
      "abbreviation": "BD"
    },
    {
      "country": "Barbados",
      "abbreviation": "BB"
    },
    {
      "country": "Belarus",
      "abbreviation": "BY"
    },
    {
      "country": "Belgium",
      "abbreviation": "BE"
    },
    {
      "country": "Belize",
      "abbreviation": "BZ"
    },
    {
      "country": "Benin",
      "abbreviation": "BJ"
    },
    {
      "country": "Bermuda",
      "abbreviation": "BM"
    },
    {
      "country": "Bhutan",
      "abbreviation": "BT"
    },
    {
      "country": "Bolivia",
      "abbreviation": "BO"
    },
    {
      "country": "Bosnia and Herzegovina",
      "abbreviation": "BA"
    },
    {
      "country": "Botswana",
      "abbreviation": "BW"
    },
    {
      "country": "Bouvet Island",
      "abbreviation": "BV"
    },
    {
      "country": "Brazil",
      "abbreviation": "BR"
    },
    {
      "country": "British Indian Ocean Territory",
      "abbreviation": "IO"
    },
    {
      "country": "Brunei",
      "abbreviation": "BN"
    },
    {
      "country": "Bulgaria",
      "abbreviation": "BG"
    },
    {
      "country": "Burkina Faso",
      "abbreviation": "BF"
    },
    {
      "country": "Burundi",
      "abbreviation": "BI"
    },
    {
      "country": "Cambodia",
      "abbreviation": "KH"
    },
    {
      "country": "Cameroon",
      "abbreviation": "CM"
    },
    {
      "country": "Canada",
      "abbreviation": "CA"
    },
    {
      "country": "Cape Verde",
      "abbreviation": "CV"
    },
    {
      "country": "Cayman Islands",
      "abbreviation": "KY"
    },
    {
      "country": "Central African Republic",
      "abbreviation": "CF"
    },
    {
      "country": "Chad",
      "abbreviation": "TD"
    },
    {
      "country": "Chile",
      "abbreviation": "CL"
    },
    {
      "country": "China",
      "abbreviation": "CN"
    },
    {
      "country": "Christmas Island",
      "abbreviation": "CX"
    },
    {
      "country": "Cocos (Keeling) Islands",
      "abbreviation": "CC"
    },
    {
      "country": "Colombia",
      "abbreviation": "CO"
    },
    {
      "country": "Comoros",
      "abbreviation": "KM"
    },
    {
      "country": "Congo",
      "abbreviation": "CG"
    },
    {
      "country": "Cook Islands",
      "abbreviation": "CK"
    },
    {
      "country": "Costa Rica",
      "abbreviation": "CR"
    },
    {
      "country": "Croatia",
      "abbreviation": "HR"
    },
    {
      "country": "Cuba",
      "abbreviation": "CU"
    },
    {
      "country": "Cyprus",
      "abbreviation": "CY"
    },
    {
      "country": "Czech Republic",
      "abbreviation": "CZ"
    },
    {
      "country": "Denmark",
      "abbreviation": "DK"
    },
    {
      "country": "Djibouti",
      "abbreviation": "DJ"
    },
    {
      "country": "Dominica",
      "abbreviation": "DM"
    },
    {
      "country": "Dominican Republic",
      "abbreviation": "DO"
    },
    {
      "country": "East Timor",
      "abbreviation": "TP"
    },
    {
      "country": "Ecuador",
      "abbreviation": "EC"
    },
    {
      "country": "Egypt",
      "abbreviation": "EG"
    },
    {
      "country": "El Salvador",
      "abbreviation": "SV"
    },
    {
      "country": "Equatorial Guinea",
      "abbreviation": "GQ"
    },
    {
      "country": "Eritrea",
      "abbreviation": "ER"
    },
    {
      "country": "Estonia",
      "abbreviation": "EE"
    },
    {
      "country": "Ethiopia",
      "abbreviation": "ET"
    },
    {
      "country": "Falkland Islands",
      "abbreviation": "FK"
    },
    {
      "country": "Faroe Islands",
      "abbreviation": "FO"
    },
    {
      "country": "Fiji Islands",
      "abbreviation": "FJ"
    },
    {
      "country": "Finland",
      "abbreviation": "FI"
    },
    {
      "country": "France",
      "abbreviation": "FR"
    },
    {
      "country": "French Guiana",
      "abbreviation": "GF"
    },
    {
      "country": "French Polynesia",
      "abbreviation": "PF"
    },
    {
      "country": "French Southern territories",
      "abbreviation": "TF"
    },
    {
      "country": "Gabon",
      "abbreviation": "GA"
    },
    {
      "country": "Gambia",
      "abbreviation": "GM"
    },
    {
      "country": "Georgia",
      "abbreviation": "GE"
    },
    {
      "country": "Germany",
      "abbreviation": "DE"
    },
    {
      "country": "Ghana",
      "abbreviation": "GH"
    },
    {
      "country": "Gibraltar",
      "abbreviation": "GI"
    },
    {
      "country": "Greece",
      "abbreviation": "GR"
    },
    {
      "country": "Greenland",
      "abbreviation": "GL"
    },
    {
      "country": "Grenada",
      "abbreviation": "GD"
    },
    {
      "country": "Guadeloupe",
      "abbreviation": "GP"
    },
    {
      "country": "Guam",
      "abbreviation": "GU"
    },
    {
      "country": "Guatemala",
      "abbreviation": "GT"
    },
    {
      "country": "Guernsey",
      "abbreviation": "GG"
    },
    {
      "country": "Guinea",
      "abbreviation": "GN"
    },
    {
      "country": "Guinea-Bissau",
      "abbreviation": "GW"
    },
    {
      "country": "Guyana",
      "abbreviation": "GY"
    },
    {
      "country": "Haiti",
      "abbreviation": "HT"
    },
    {
      "country": "Heard Island and McDonald Islands",
      "abbreviation": "HM"
    },
    {
      "country": "Holy See (Vatican City State)",
      "abbreviation": "VA"
    },
    {
      "country": "Honduras",
      "abbreviation": "HN"
    },
    {
      "country": "Hong Kong",
      "abbreviation": "HK"
    },
    {
      "country": "Hungary",
      "abbreviation": "HU"
    },
    {
      "country": "Iceland",
      "abbreviation": "IS"
    },
    {
      "country": "India",
      "abbreviation": "IN"
    },
    {
      "country": "Indonesia",
      "abbreviation": "ID"
    },
    {
      "country": "Iran",
      "abbreviation": "IR"
    },
    {
      "country": "Iraq",
      "abbreviation": "IQ"
    },
    {
      "country": "Ireland",
      "abbreviation": "IE"
    },
    {
      "country": "Isle of Man",
      "abbreviation": "IM"
    },
    {
      "country": "Israel",
      "abbreviation": "IL"
    },
    {
      "country": "Italy",
      "abbreviation": "IT"
    },
    {
      "country": "Ivory Coast",
      "abbreviation": "CI"
    },
    {
      "country": "Jamaica",
      "abbreviation": "JM"
    },
    {
      "country": "Japan",
      "abbreviation": "JP"
    },
    {
      "country": "Jersey",
      "abbreviation": "JE"
    },
    {
      "country": "Jordan",
      "abbreviation": "JO"
    },
    {
      "country": "Kazakhstan",
      "abbreviation": "KZ"
    },
    {
      "country": "Kenya",
      "abbreviation": "KE"
    },
    {
      "country": "Kiribati",
      "abbreviation": "KI"
    },
    {
      "country": "Kuwait",
      "abbreviation": "KW"
    },
    {
      "country": "Kyrgyzstan",
      "abbreviation": "KG"
    },
    {
      "country": "Laos",
      "abbreviation": "LA"
    },
    {
      "country": "Latvia",
      "abbreviation": "LV"
    },
    {
      "country": "Lebanon",
      "abbreviation": "LB"
    },
    {
      "country": "Lesotho",
      "abbreviation": "LS"
    },
    {
      "country": "Liberia",
      "abbreviation": "LR"
    },
    {
      "country": "Libyan Arab Jamahiriya",
      "abbreviation": "LY"
    },
    {
      "country": "Liechtenstein",
      "abbreviation": "LI"
    },
    {
      "country": "Lithuania",
      "abbreviation": "LT"
    },
    {
      "country": "Luxembourg",
      "abbreviation": "LU"
    },
    {
      "country": "Macao",
      "abbreviation": "MO"
    },
    {
      "country": "North Macedonia",
      "abbreviation": "MK"
    },
    {
      "country": "Madagascar",
      "abbreviation": "MG"
    },
    {
      "country": "Malawi",
      "abbreviation": "MW"
    },
    {
      "country": "Malaysia",
      "abbreviation": "MY"
    },
    {
      "country": "Maldives",
      "abbreviation": "MV"
    },
    {
      "country": "Mali",
      "abbreviation": "ML"
    },
    {
      "country": "Malta",
      "abbreviation": "MT"
    },
    {
      "country": "Marshall Islands",
      "abbreviation": "MH"
    },
    {
      "country": "Martinique",
      "abbreviation": "MQ"
    },
    {
      "country": "Mauritania",
      "abbreviation": "MR"
    },
    {
      "country": "Mauritius",
      "abbreviation": "MU"
    },
    {
      "country": "Mayotte",
      "abbreviation": "YT"
    },
    {
      "country": "Mexico",
      "abbreviation": "MX"
    },
    {
      "country": "Micronesia, Federated States of",
      "abbreviation": "FM"
    },
    {
      "country": "Moldova",
      "abbreviation": "MD"
    },
    {
      "country": "Monaco",
      "abbreviation": "MC"
    },
    {
      "country": "Mongolia",
      "abbreviation": "MN"
    },
    {
      "country": "Montenegro",
      "abbreviation": "ME"
    },
    {
      "country": "Montserrat",
      "abbreviation": "MS"
    },
    {
      "country": "Morocco",
      "abbreviation": "MA"
    },
    {
      "country": "Mozambique",
      "abbreviation": "MZ"
    },
    {
      "country": "Myanmar",
      "abbreviation": "MM"
    },
    {
      "country": "Namibia",
      "abbreviation": "NA"
    },
    {
      "country": "Nauru",
      "abbreviation": "NR"
    },
    {
      "country": "Nepal",
      "abbreviation": "NP"
    },
    {
      "country": "Netherlands",
      "abbreviation": "NL"
    },
    {
      "country": "Netherlands Antilles",
      "abbreviation": "AN"
    },
    {
      "country": "New Caledonia",
      "abbreviation": "NC"
    },
    {
      "country": "New Zealand",
      "abbreviation": "NZ"
    },
    {
      "country": "Nicaragua",
      "abbreviation": "NI"
    },
    {
      "country": "Niger",
      "abbreviation": "NE"
    },
    {
      "country": "Nigeria",
      "abbreviation": "NG"
    },
    {
      "country": "Niue",
      "abbreviation": "NU"
    },
    {
      "country": "Norfolk Island",
      "abbreviation": "NF"
    },
    {
      "country": "North Korea",
      "abbreviation": "KP"
    },
    {
      "country": "Northern Ireland",
      "abbreviation": "GB"
    },
    {
      "country": "Northern Mariana Islands",
      "abbreviation": "MP"
    },
    {
      "country": "Norway",
      "abbreviation": "NO"
    },
    {
      "country": "Oman",
      "abbreviation": "OM"
    },
    {
      "country": "Pakistan",
      "abbreviation": "PK"
    },
    {
      "country": "Palau",
      "abbreviation": "PW"
    },
    {
      "country": "Palestine",
      "abbreviation": "PS"
    },
    {
      "country": "Panama",
      "abbreviation": "PA"
    },
    {
      "country": "Papua New Guinea",
      "abbreviation": "PG"
    },
    {
      "country": "Paraguay",
      "abbreviation": "PY"
    },
    {
      "country": "Peru",
      "abbreviation": "PE"
    },
    {
      "country": "Philippines",
      "abbreviation": "PH"
    },
    {
      "country": "Pitcairn",
      "abbreviation": "PN"
    },
    {
      "country": "Poland",
      "abbreviation": "PL"
    },
    {
      "country": "Portugal",
      "abbreviation": "PT"
    },
    {
      "country": "Puerto Rico",
      "abbreviation": "PR"
    },
    {
      "country": "Qatar",
      "abbreviation": "QA"
    },
    {
      "country": "Reunion",
      "abbreviation": "RE"
    },
    {
      "country": "Romania",
      "abbreviation": "RO"
    },
    {
      "country": "Russian Federation",
      "abbreviation": "RU"
    },
    {
      "country": "Rwanda",
      "abbreviation": "RW"
    },
    {
      "country": "Saint Helena",
      "abbreviation": "SH"
    },
    {
      "country": "Saint Kitts and Nevis",
      "abbreviation": "KN"
    },
    {
      "country": "Saint Lucia",
      "abbreviation": "LC"
    },
    {
      "country": "Saint Pierre and Miquelon",
      "abbreviation": "PM"
    },
    {
      "country": "Saint Vincent and the Grenadines",
      "abbreviation": "VC"
    },
    {
      "country": "Samoa",
      "abbreviation": "WS"
    },
    {
      "country": "San Marino",
      "abbreviation": "SM"
    },
    {
      "country": "Sao Tome and Principe",
      "abbreviation": "ST"
    },
    {
      "country": "Saudi Arabia",
      "abbreviation": "SA"
    },
    {
      "country": "Senegal",
      "abbreviation": "SN"
    },
    {
      "country": "Serbia",
      "abbreviation": "RS"
    },
    {
      "country": "Seychelles",
      "abbreviation": "SC"
    },
    {
      "country": "Sierra Leone",
      "abbreviation": "SL"
    },
    {
      "country": "Singapore",
      "abbreviation": "SG"
    },
    {
      "country": "Slovakia",
      "abbreviation": "SK"
    },
    {
      "country": "Slovenia",
      "abbreviation": "SI"
    },
    {
      "country": "Solomon Islands",
      "abbreviation": "SB"
    },
    {
      "country": "Somalia",
      "abbreviation": "SO"
    },
    {
      "country": "South Africa",
      "abbreviation": "ZA"
    },
    {
      "country": "South Georgia and the South Sandwich Islands",
      "abbreviation": "GS"
    },
    {
      "country": "South Korea",
      "abbreviation": "KR"
    },
    {
      "country": "South Sudan",
      "abbreviation": "SS"
    },
    {
      "country": "Spain",
      "abbreviation": "ES"
    },
    {
      "country": "Sri Lanka",
      "abbreviation": "LK"
    },
    {
      "country": "Sudan",
      "abbreviation": "SD"
    },
    {
      "country": "Suriname",
      "abbreviation": "SR"
    },
    {
      "country": "Svalbard and Jan Mayen",
      "abbreviation": "SJ"
    },
    {
      "country": "Swaziland",
      "abbreviation": "SZ"
    },
    {
      "country": "Sweden",
      "abbreviation": "SE"
    },
    {
      "country": "Switzerland",
      "abbreviation": "CH"
    },
    {
      "country": "Syria",
      "abbreviation": "SY"
    },
    {
      "country": "Tajikistan",
      "abbreviation": "TJ"
    },
    {
      "country": "Tanzania",
      "abbreviation": "TZ"
    },
    {
      "country": "Thailand",
      "abbreviation": "TH"
    },
    {
      "country": "The Democratic Republic of Congo",
      "abbreviation": "CD"
    },
    {
      "country": "Timor-Leste",
      "abbreviation": "TL"
    },
    {
      "country": "Togo",
      "abbreviation": "TG"
    },
    {
      "country": "Tokelau",
      "abbreviation": "TK"
    },
    {
      "country": "Tonga",
      "abbreviation": "TO"
    },
    {
      "country": "Trinidad and Tobago",
      "abbreviation": "TT"
    },
    {
      "country": "Tunisia",
      "abbreviation": "TN"
    },
    {
      "country": "Turkey",
      "abbreviation": "TR"
    },
    {
      "country": "Turkmenistan",
      "abbreviation": "TM"
    },
    {
      "country": "Turks and Caicos Islands",
      "abbreviation": "TC"
    },
    {
      "country": "Tuvalu",
      "abbreviation": "TV"
    },
    {
      "country": "Uganda",
      "abbreviation": "UG"
    },
    {
      "country": "Ukraine",
      "abbreviation": "UA"
    },
    {
      "country": "United Arab Emirates",
      "abbreviation": "AE"
    },
    {
      "country": "United Kingdom",
      "abbreviation": "UK"
    },
    {
      "country": "United States",
      "abbreviation": "US"
    },
    {
      "country": "United States Minor Outlying Islands",
      "abbreviation": "UM"
    },
    {
      "country": "Uruguay",
      "abbreviation": "UY"
    },
    {
      "country": "Uzbekistan",
      "abbreviation": "UZ"
    },
    {
      "country": "Vanuatu",
      "abbreviation": "VU"
    },
    {
      "country": "Venezuela",
      "abbreviation": "VE"
    },
    {
      "country": "Vietnam",
      "abbreviation": "VN"
    },
    {
      "country": "Virgin Islands, British",
      "abbreviation": "VG"
    },
    {
      "country": "Virgin Islands, U.S.",
      "abbreviation": "VI"
    },
    {
      "country": "Wallis and Futuna",
      "abbreviation": "WF"
    },
    {
      "country": "Western Sahara",
      "abbreviation": "EH"
    },
    {
      "country": "Yemen",
      "abbreviation": "YE"
    },
    {
      "country": "Zambia",
      "abbreviation": "ZM"
    },
    {
      "country": "Zimbabwe",
      "abbreviation": "ZW"
    }
  ];

}
// --------------------
/// COUNTRY NAME - POPULATION
List<Map<String, dynamic>> cocoNamePopulation(){
  return [
    {
      "country": "Afghanistan",
      "population": 37172386
    },
    {
      "country": "Albania",
      "population": 2866376
    },
    {
      "country": "Algeria",
      "population": 42228429
    },
    {
      "country": "American Samoa",
      "population": 55465
    },
    {
      "country": "Andorra",
      "population": 77006
    },
    {
      "country": "Angola",
      "population": 30809762
    },
    {
      "country": "Anguilla",
      "population": 15094
    },
    {
      "country": "Antarctica",
      "population": 1106
    },
    {
      "country": "Antigua and Barbuda",
      "population": 96286
    },
    {
      "country": "Argentina",
      "population": 44494502
    },
    {
      "country": "Armenia",
      "population": 2951776
    },
    {
      "country": "Aruba",
      "population": 105845
    },
    {
      "country": "Australia",
      "population": 24982688
    },
    {
      "country": "Austria",
      "population": 8840521
    },
    {
      "country": "Azerbaijan",
      "population": 9939800
    },
    {
      "country": "Bahamas",
      "population": 385640
    },
    {
      "country": "Bahrain",
      "population": 1569439
    },
    {
      "country": "Bangladesh",
      "population": 161356039
    },
    {
      "country": "Barbados",
      "population": 286641
    },
    {
      "country": "Belarus",
      "population": 9483499
    },
    {
      "country": "Belgium",
      "population": 11433256
    },
    {
      "country": "Belize",
      "population": 383071
    },
    {
      "country": "Benin",
      "population": 11485048
    },
    {
      "country": "Bermuda",
      "population": 63973
    },
    {
      "country": "Bhutan",
      "population": 754394
    },
    {
      "country": "Bolivia",
      "population": 11353142
    },
    {
      "country": "Bosnia and Herzegovina",
      "population": 3323929
    },
    {
      "country": "Botswana",
      "population": 2254126
    },
    {
      "country": "Bouvet Island",
      "population": 0
    },
    {
      "country": "Brazil",
      "population": 209469333
    },
    {
      "country": "British Indian Ocean Territory",
      "population": 0
    },
    {
      "country": "Brunei",
      "population": 428962
    },
    {
      "country": "Bulgaria",
      "population": 7025037
    },
    {
      "country": "Burkina Faso",
      "population": 19751535
    },
    {
      "country": "Burundi",
      "population": 11175378
    },
    {
      "country": "Cambodia",
      "population": 16249798
    },
    {
      "country": "Cameroon",
      "population": 25216237
    },
    {
      "country": "Canada",
      "population": 37057765
    },
    {
      "country": "Cape Verde",
      "population": 543767
    },
    {
      "country": "Cayman Islands",
      "population": 64174
    },
    {
      "country": "Central African Republic",
      "population": 4666377
    },
    {
      "country": "Chad",
      "population": 15477751
    },
    {
      "country": "Chile",
      "population": 18729160
    },
    {
      "country": "China",
      "population": 1392730000
    },
    {
      "country": "Christmas Island",
      "population": 1402
    },
    {
      "country": "Cocos (Keeling) Islands",
      "population": 596
    },
    {
      "country": "Colombia",
      "population": 49648685
    },
    {
      "country": "Comoros",
      "population": 832322
    },
    {
      "country": "Congo",
      "population": 5244363
    },
    {
      "country": "Cook Islands",
      "population": 17379
    },
    {
      "country": "Costa Rica",
      "population": 4999441
    },
    {
      "country": "Croatia",
      "population": 4087843
    },
    {
      "country": "Cuba",
      "population": 11338138
    },
    {
      "country": "Cyprus",
      "population": 1189265
    },
    {
      "country": "Czech Republic",
      "population": 10629928
    },
    {
      "country": "Denmark",
      "population": 5793636
    },
    {
      "country": "Djibouti",
      "population": 958920
    },
    {
      "country": "Dominica",
      "population": 71625
    },
    {
      "country": "Dominican Republic",
      "population": 10627165
    },
    {
      "country": "East Timor",
      "population": 1267972
    },
    {
      "country": "Ecuador",
      "population": 17084357
    },
    {
      "country": "Egypt",
      "population": 98423595
    },
    {
      "country": "El Salvador",
      "population": 6420744
    },
    {
      "country": "England",
      "population": 55619400
    },
    {
      "country": "Equatorial Guinea",
      "population": 1308974
    },
    {
      "country": "Eritrea",
      "population": 6213972
    },
    {
      "country": "Estonia",
      "population": 1321977
    },
    {
      "country": "Ethiopia",
      "population": 109224559
    },
    {
      "country": "Falkland Islands",
      "population": 2840
    },
    {
      "country": "Faroe Islands",
      "population": 48497
    },
    {
      "country": "Fiji Islands",
      "population": 883483
    },
    {
      "country": "Finland",
      "population": 5515525
    },
    {
      "country": "France",
      "population": 66977107
    },
    {
      "country": "French Guiana",
      "population": 290691
    },
    {
      "country": "French Polynesia",
      "population": 277679
    },
    {
      "country": "French Southern territories",
      "population": 0
    },
    {
      "country": "Gabon",
      "population": 2119275
    },
    {
      "country": "Gambia",
      "population": 2280102
    },
    {
      "country": "Georgia",
      "population": 3726549
    },
    {
      "country": "Germany",
      "population": 82905782
    },
    {
      "country": "Ghana",
      "population": 29767108
    },
    {
      "country": "Gibraltar",
      "population": 33718
    },
    {
      "country": "Greece",
      "population": 10731726
    },
    {
      "country": "Greenland",
      "population": 56025
    },
    {
      "country": "Grenada",
      "population": 111454
    },
    {
      "country": "Guadeloupe",
      "population": 395700
    },
    {
      "country": "Guam",
      "population": 165768
    },
    {
      "country": "Guatemala",
      "population": 17247807
    },
    {
      "country": "Guinea",
      "population": 12414318
    },
    {
      "country": "Guinea-Bissau",
      "population": 1874309
    },
    {
      "country": "Guyana",
      "population": 779004
    },
    {
      "country": "Haiti",
      "population": 11123176
    },
    {
      "country": "Heard Island and McDonald Islands",
      "population": 0
    },
    {
      "country": "Holy See (Vatican City State)",
      "population": 825
    },
    {
      "country": "Honduras",
      "population": 9587522
    },
    {
      "country": "Hong Kong",
      "population": 7451000
    },
    {
      "country": "Hungary",
      "population": 9775564
    },
    {
      "country": "Iceland",
      "population": 352721
    },
    {
      "country": "India",
      "population": 1352617328
    },
    {
      "country": "Indonesia",
      "population": 267663435
    },
    {
      "country": "Iran",
      "population": 81800269
    },
    {
      "country": "Iraq",
      "population": 38433600
    },
    {
      "country": "Ireland",
      "population": 4867309
    },
    {
      "country": "Israel",
      "population": 8882800
    },
    {
      "country": "Italy",
      "population": 60421760
    },
    {
      "country": "Ivory Coast",
      "population": 25069229
    },
    {
      "country": "Jamaica",
      "population": 2934855
    },
    {
      "country": "Japan",
      "population": 126529100
    },
    {
      "country": "Jordan",
      "population": 9956011
    },
    {
      "country": "Kazakhstan",
      "population": 18272430
    },
    {
      "country": "Kenya",
      "population": 51393010
    },
    {
      "country": "Kiribati",
      "population": 115847
    },
    {
      "country": "Kuwait",
      "population": 4137309
    },
    {
      "country": "Kyrgyzstan",
      "population": 6322800
    },
    {
      "country": "Laos",
      "population": 7061507
    },
    {
      "country": "Latvia",
      "population": 1927174
    },
    {
      "country": "Lebanon",
      "population": 6848925
    },
    {
      "country": "Lesotho",
      "population": 2108132
    },
    {
      "country": "Liberia",
      "population": 4818977
    },
    {
      "country": "Libyan Arab Jamahiriya",
      "population": 6678567
    },
    {
      "country": "Liechtenstein",
      "population": 37910
    },
    {
      "country": "Lithuania",
      "population": 2801543
    },
    {
      "country": "Luxembourg",
      "population": 607950
    },
    {
      "country": "Macao",
      "population": 631636
    },
    {
      "country": "North Macedonia",
      "population": 2084367
    },
    {
      "country": "Madagascar",
      "population": 26262368
    },
    {
      "country": "Malawi",
      "population": 18143315
    },
    {
      "country": "Malaysia",
      "population": 31528585
    },
    {
      "country": "Maldives",
      "population": 515696
    },
    {
      "country": "Mali",
      "population": 19077690
    },
    {
      "country": "Malta",
      "population": 484630
    },
    {
      "country": "Marshall Islands",
      "population": 58413
    },
    {
      "country": "Martinique",
      "population": 376480
    },
    {
      "country": "Mauritania",
      "population": 4403319
    },
    {
      "country": "Mauritius",
      "population": 1265303
    },
    {
      "country": "Mayotte",
      "population": 270372
    },
    {
      "country": "Mexico",
      "population": 126190788
    },
    {
      "country": "Micronesia, Federated States of",
      "population": 112640
    },
    {
      "country": "Moldova",
      "population": 2706049
    },
    {
      "country": "Monaco",
      "population": 38682
    },
    {
      "country": "Mongolia",
      "population": 3170208
    },
    {
      "country": "Montenegro",
      "population": 631219
    },
    {
      "country": "Montserrat",
      "population": 5900
    },
    {
      "country": "Morocco",
      "population": 36029138
    },
    {
      "country": "Mozambique",
      "population": 29495962
    },
    {
      "country": "Myanmar",
      "population": 53708395
    },
    {
      "country": "Namibia",
      "population": 2448255
    },
    {
      "country": "Nauru",
      "population": 12704
    },
    {
      "country": "Nepal",
      "population": 28087871
    },
    {
      "country": "Netherlands",
      "population": 17231624
    },
    {
      "country": "Netherlands Antilles",
      "population": 227049
    },
    {
      "country": "New Caledonia",
      "population": 284060
    },
    {
      "country": "New Zealand",
      "population": 4841000
    },
    {
      "country": "Nicaragua",
      "population": 6465513
    },
    {
      "country": "Niger",
      "population": 22442948
    },
    {
      "country": "Nigeria",
      "population": 195874740
    },
    {
      "country": "Niue",
      "population": 1624
    },
    {
      "country": "Norfolk Island",
      "population": 2169
    },
    {
      "country": "North Korea",
      "population": 25549819
    },
    {
      "country": "Northern Ireland",
      "population": 1885400
    },
    {
      "country": "Northern Mariana Islands",
      "population": 56882
    },
    {
      "country": "Norway",
      "population": 5311916
    },
    {
      "country": "Oman",
      "population": 4829483
    },
    {
      "country": "Pakistan",
      "population": 212215030
    },
    {
      "country": "Palau",
      "population": 17907
    },
    {
      "country": "Palestine",
      "population": 4569087
    },
    {
      "country": "Panama",
      "population": 4176873
    },
    {
      "country": "Papua New Guinea",
      "population": 8606316
    },
    {
      "country": "Paraguay",
      "population": 6956071
    },
    {
      "country": "Peru",
      "population": 31989256
    },
    {
      "country": "Philippines",
      "population": 106651922
    },
    {
      "country": "Pitcairn",
      "population": 67
    },
    {
      "country": "Poland",
      "population": 37974750
    },
    {
      "country": "Portugal",
      "population": 10283822
    },
    {
      "country": "Puerto Rico",
      "population": 3195153
    },
    {
      "country": "Qatar",
      "population": 2781677
    },
    {
      "country": "Reunion",
      "population": 859959
    },
    {
      "country": "Romania",
      "population": 19466145
    },
    {
      "country": "Russian Federation",
      "population": 144478050
    },
    {
      "country": "Rwanda",
      "population": 12301939
    },
    {
      "country": "Saint Helena",
      "population": 6600
    },
    {
      "country": "Saint Kitts and Nevis",
      "population": 52441
    },
    {
      "country": "Saint Lucia",
      "population": 181889
    },
    {
      "country": "Saint Pierre and Miquelon",
      "population": 5888
    },
    {
      "country": "Saint Vincent and the Grenadines",
      "population": 110210
    },
    {
      "country": "Samoa",
      "population": 196130
    },
    {
      "country": "San Marino",
      "population": 33785
    },
    {
      "country": "Sao Tome and Principe",
      "population": 211028
    },
    {
      "country": "Saudi Arabia",
      "population": 33699947
    },
    {
      "country": "Scotland",
      "population": 5424800
    },
    {
      "country": "Senegal",
      "population": 15854360
    },
    {
      "country": "Serbia",
      "population": 6963764
    },
    {
      "country": "Seychelles",
      "population": 96762
    },
    {
      "country": "Sierra Leone",
      "population": 7650154
    },
    {
      "country": "Singapore",
      "population": 5638676
    },
    {
      "country": "Slovakia",
      "population": 5446771
    },
    {
      "country": "Slovenia",
      "population": 2073894
    },
    {
      "country": "Solomon Islands",
      "population": 652858
    },
    {
      "country": "Somalia",
      "population": 15008154
    },
    {
      "country": "South Africa",
      "population": 57779622
    },
    {
      "country": "South Georgia and the South Sandwich Islands",
      "population": 30
    },
    {
      "country": "South Korea",
      "population": 51606633
    },
    {
      "country": "South Sudan",
      "population": 10975920
    },
    {
      "country": "Spain",
      "population": 46796540
    },
    {
      "country": "Sri Lanka",
      "population": 21670000
    },
    {
      "country": "Sudan",
      "population": 41801533
    },
    {
      "country": "Suriname",
      "population": 575991
    },
    {
      "country": "Svalbard and Jan Mayen",
      "population": 2572
    },
    {
      "country": "Swaziland",
      "population": 1136191
    },
    {
      "country": "Sweden",
      "population": 10175214
    },
    {
      "country": "Switzerland",
      "population": 8513227
    },
    {
      "country": "Syria",
      "population": 16906283
    },
    {
      "country": "Tajikistan",
      "population": 9100837
    },
    {
      "country": "Tanzania",
      "population": 56318348
    },
    {
      "country": "Thailand",
      "population": 69428524
    },
    {
      "country": "The Democratic Republic of Congo",
      "population": 84068091
    },
    {
      "country": "Togo",
      "population": 7889094
    },
    {
      "country": "Tokelau",
      "population": 1411
    },
    {
      "country": "Tonga",
      "population": 103197
    },
    {
      "country": "Trinidad and Tobago",
      "population": 1389858
    },
    {
      "country": "Tunisia",
      "population": 11565204
    },
    {
      "country": "Turkey",
      "population": 82319724
    },
    {
      "country": "Turkmenistan",
      "population": 5850908
    },
    {
      "country": "Turks and Caicos Islands",
      "population": 37665
    },
    {
      "country": "Tuvalu",
      "population": 11508
    },
    {
      "country": "Uganda",
      "population": 42723139
    },
    {
      "country": "Ukraine",
      "population": 44622516
    },
    {
      "country": "United Arab Emirates",
      "population": 9630959
    },
    {
      "country": "United Kingdom",
      "population": 66460344
    },
    {
      "country": "United States",
      "population": 326687501
    },
    {
      "country": "United States Minor Outlying Islands",
      "population": 300
    },
    {
      "country": "Uruguay",
      "population": 3449299
    },
    {
      "country": "Uzbekistan",
      "population": 32955400
    },
    {
      "country": "Vanuatu",
      "population": 292680
    },
    {
      "country": "Venezuela",
      "population": 28870195
    },
    {
      "country": "Vietnam",
      "population": 95540395
    },
    {
      "country": "Virgin Islands, British",
      "population": 29802
    },
    {
      "country": "Virgin Islands, U.S.",
      "population": 106977
    },
    {
      "country": "Wales",
      "population": 3139000
    },
    {
      "country": "Wallis and Futuna",
      "population": 15289
    },
    {
      "country": "Western Sahara",
      "population": 652271
    },
    {
      "country": "Yemen",
      "population": 28498687
    },
    {
      "country": "Zambia",
      "population": 17351822
    },
    {
      "country": "Zimbabwe",
      "population": 14439018
    }
  ];
}
// --------------------
/// COUNTRY NAME - GOV
List<Map<String, dynamic>> cocoNameGov(){
  return [
    {
      "country": "Afghanistan",
      "government": "Islamic Emirate"
    },
    {
      "country": "Albania",
      "government": "Republic"
    },
    {
      "country": "Algeria",
      "government": "Republic"
    },
    {
      "country": "American Samoa",
      "government": "US Territory"
    },
    {
      "country": "Andorra",
      "government": "Parliamentary Coprincipality"
    },
    {
      "country": "Angola",
      "government": "Republic"
    },
    {
      "country": "Anguilla",
      "government": "Dependent Territory of the UK"
    },
    {
      "country": "Antarctica",
      "government": "Co-administrated"
    },
    {
      "country": "Antigua and Barbuda",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Argentina",
      "government": "Federal Republic"
    },
    {
      "country": "Armenia",
      "government": "Republic"
    },
    {
      "country": "Aruba",
      "government": "Nonmetropolitan Territory of The Netherlands"
    },
    {
      "country": "Australia",
      "government": "Federation Constitutional Monarchy"
    },
    {
      "country": "Austria",
      "government": "Federal Republic"
    },
    {
      "country": "Azerbaijan",
      "government": "Federal Republic"
    },
    {
      "country": "Bahamas",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Bahrain",
      "government": "Monarchy (Emirate)"
    },
    {
      "country": "Bangladesh",
      "government": "Republic"
    },
    {
      "country": "Barbados",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Belarus",
      "government": "Republic"
    },
    {
      "country": "Belgium",
      "government": "Federation Constitutional Monarchy"
    },
    {
      "country": "Belize",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Benin",
      "government": "Republic"
    },
    {
      "country": "Bermuda",
      "government": "Dependent Territory of the UK"
    },
    {
      "country": "Bhutan",
      "government": "Monarchy"
    },
    {
      "country": "Bolivia",
      "government": "Republic"
    },
    {
      "country": "Bosnia and Herzegovina",
      "government": "Federal Republic"
    },
    {
      "country": "Botswana",
      "government": "Republic"
    },
    {
      "country": "Bouvet Island",
      "government": "Dependent Territory of Norway"
    },
    {
      "country": "Brazil",
      "government": "Federal Republic"
    },
    {
      "country": "British Indian Ocean Territory",
      "government": "Dependent Territory of the UK"
    },
    {
      "country": "Brunei",
      "government": "Monarchy (Sultanate)"
    },
    {
      "country": "Bulgaria",
      "government": "Republic"
    },
    {
      "country": "Burkina Faso",
      "government": "Republic"
    },
    {
      "country": "Burundi",
      "government": "Republic"
    },
    {
      "country": "Cambodia",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Cameroon",
      "government": "Republic"
    },
    {
      "country": "Canada",
      "government": "Constitutional Monarchy, Federation"
    },
    {
      "country": "Cape Verde",
      "government": "Republic"
    },
    {
      "country": "Cayman Islands",
      "government": "Dependent Territory of the UK"
    },
    {
      "country": "Central African Republic",
      "government": "Republic"
    },
    {
      "country": "Chad",
      "government": "Republic"
    },
    {
      "country": "Chile",
      "government": "Republic"
    },
    {
      "country": "China",
      "government": "People's Republic"
    },
    {
      "country": "Christmas Island",
      "government": "Territory of Australia"
    },
    {
      "country": "Cocos (Keeling) Islands",
      "government": "Territory of Australia"
    },
    {
      "country": "Colombia",
      "government": "Republic"
    },
    {
      "country": "Comoros",
      "government": "Republic"
    },
    {
      "country": "Congo",
      "government": "Republic"
    },
    {
      "country": "Cook Islands",
      "government": "Nonmetropolitan Territory of New Zealand"
    },
    {
      "country": "Costa Rica",
      "government": "Republic"
    },
    {
      "country": "Croatia",
      "government": "Republic"
    },
    {
      "country": "Cuba",
      "government": "Socialistic Republic"
    },
    {
      "country": "Cyprus",
      "government": "Republic"
    },
    {
      "country": "Czech Republic",
      "government": "Republic"
    },
    {
      "country": "Denmark",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Djibouti",
      "government": "Republic"
    },
    {
      "country": "Dominica",
      "government": "Republic"
    },
    {
      "country": "Dominican Republic",
      "government": "Republic"
    },
    {
      "country": "East Timor",
      "government": "Administrated by the UN"
    },
    {
      "country": "Ecuador",
      "government": "Republic"
    },
    {
      "country": "Egypt",
      "government": "Republic"
    },
    {
      "country": "El Salvador",
      "government": "Republic"
    },
    {
      "country": "England",
      "government": null
    },
    {
      "country": "Equatorial Guinea",
      "government": "Republic"
    },
    {
      "country": "Eritrea",
      "government": "Republic"
    },
    {
      "country": "Estonia",
      "government": "Republic"
    },
    {
      "country": "Ethiopia",
      "government": "Republic"
    },
    {
      "country": "Falkland Islands",
      "government": "Dependent Territory of the UK"
    },
    {
      "country": "Faroe Islands",
      "government": "Part of Denmark"
    },
    {
      "country": "Fiji Islands",
      "government": "Republic"
    },
    {
      "country": "Finland",
      "government": "Republic"
    },
    {
      "country": "France",
      "government": "Republic"
    },
    {
      "country": "French Guiana",
      "government": "Overseas Department of France"
    },
    {
      "country": "French Polynesia",
      "government": "Nonmetropolitan Territory of France"
    },
    {
      "country": "French Southern territories",
      "government": "Nonmetropolitan Territory of France"
    },
    {
      "country": "Gabon",
      "government": "Republic"
    },
    {
      "country": "Gambia",
      "government": "Republic"
    },
    {
      "country": "Georgia",
      "government": "Republic"
    },
    {
      "country": "Germany",
      "government": "Federal Republic"
    },
    {
      "country": "Ghana",
      "government": "Republic"
    },
    {
      "country": "Gibraltar",
      "government": "Dependent Territory of the UK"
    },
    {
      "country": "Greece",
      "government": "Republic"
    },
    {
      "country": "Greenland",
      "government": "Part of Denmark"
    },
    {
      "country": "Grenada",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Guadeloupe",
      "government": "Overseas Department of France"
    },
    {
      "country": "Guam",
      "government": "US Territory"
    },
    {
      "country": "Guatemala",
      "government": "Republic"
    },
    {
      "country": "Guinea",
      "government": "Republic"
    },
    {
      "country": "Guinea-Bissau",
      "government": "Republic"
    },
    {
      "country": "Guyana",
      "government": "Republic"
    },
    {
      "country": "Haiti",
      "government": "Republic"
    },
    {
      "country": "Heard Island and McDonald Islands",
      "government": "Territory of Australia"
    },
    {
      "country": "Holy See (Vatican City State)",
      "government": "Independent Church State"
    },
    {
      "country": "Honduras",
      "government": "Republic"
    },
    {
      "country": "Hong Kong",
      "government": "Special Administrative Region of China"
    },
    {
      "country": "Hungary",
      "government": "Republic"
    },
    {
      "country": "Iceland",
      "government": "Republic"
    },
    {
      "country": "India",
      "government": "Federal Republic"
    },
    {
      "country": "Indonesia",
      "government": "Republic"
    },
    {
      "country": "Iran",
      "government": "Islamic Republic"
    },
    {
      "country": "Iraq",
      "government": "Republic"
    },
    {
      "country": "Ireland",
      "government": "Republic"
    },
    {
      "country": "Israel",
      "government": "Republic"
    },
    {
      "country": "Italy",
      "government": "Republic"
    },
    {
      "country": "Ivory Coast",
      "government": "Republic"
    },
    {
      "country": "Jamaica",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Japan",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Jordan",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Kazakhstan",
      "government": "Republic"
    },
    {
      "country": "Kenya",
      "government": "Republic"
    },
    {
      "country": "Kiribati",
      "government": "Republic"
    },
    {
      "country": "Kuwait",
      "government": "Constitutional Monarchy (Emirate)"
    },
    {
      "country": "Kyrgyzstan",
      "government": "Republic"
    },
    {
      "country": "Laos",
      "government": "Republic"
    },
    {
      "country": "Latvia",
      "government": "Republic"
    },
    {
      "country": "Lebanon",
      "government": "Republic"
    },
    {
      "country": "Lesotho",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Liberia",
      "government": "Republic"
    },
    {
      "country": "Libyan Arab Jamahiriya",
      "government": "Socialistic State"
    },
    {
      "country": "Liechtenstein",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Lithuania",
      "government": "Republic"
    },
    {
      "country": "Luxembourg",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Macao",
      "government": "Special Administrative Region of China"
    },
    {
      "country": "North Macedonia",
      "government": "Republic"
    },
    {
      "country": "Madagascar",
      "government": "Federal Republic"
    },
    {
      "country": "Malawi",
      "government": "Republic"
    },
    {
      "country": "Malaysia",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Maldives",
      "government": "Republic"
    },
    {
      "country": "Mali",
      "government": "Republic"
    },
    {
      "country": "Malta",
      "government": "Republic"
    },
    {
      "country": "Marshall Islands",
      "government": "Republic"
    },
    {
      "country": "Martinique",
      "government": "Overseas Department of France"
    },
    {
      "country": "Mauritania",
      "government": "Republic"
    },
    {
      "country": "Mauritius",
      "government": "Republic"
    },
    {
      "country": "Mayotte",
      "government": "Territorial Collectivity of France"
    },
    {
      "country": "Mexico",
      "government": "Federal Republic"
    },
    {
      "country": "Micronesia, Federated States of",
      "government": "Federal Republic"
    },
    {
      "country": "Moldova",
      "government": "Republic"
    },
    {
      "country": "Monaco",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Mongolia",
      "government": "Republic"
    },
    {
      "country": "Montserrat",
      "government": "Dependent Territory of the UK"
    },
    {
      "country": "Morocco",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Mozambique",
      "government": "Republic"
    },
    {
      "country": "Myanmar",
      "government": "Republic"
    },
    {
      "country": "Namibia",
      "government": "Republic"
    },
    {
      "country": "Nauru",
      "government": "Republic"
    },
    {
      "country": "Nepal",
      "government": "Federal parliamentary republic"
    },
    {
      "country": "Netherlands",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Netherlands Antilles",
      "government": "Nonmetropolitan Territory of The Netherlands"
    },
    {
      "country": "New Caledonia",
      "government": "Nonmetropolitan Territory of France"
    },
    {
      "country": "New Zealand",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Nicaragua",
      "government": "Republic"
    },
    {
      "country": "Niger",
      "government": "Republic"
    },
    {
      "country": "Nigeria",
      "government": "Federal Republic"
    },
    {
      "country": "Niue",
      "government": "Nonmetropolitan Territory of New Zealand"
    },
    {
      "country": "Norfolk Island",
      "government": "Territory of Australia"
    },
    {
      "country": "North Korea",
      "government": "Socialistic Republic"
    },
    {
      "country": "Northern Ireland",
      "government": null
    },
    {
      "country": "Northern Mariana Islands",
      "government": "Commonwealth of the US"
    },
    {
      "country": "Norway",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Oman",
      "government": "Monarchy (Sultanate)"
    },
    {
      "country": "Pakistan",
      "government": "Republic"
    },
    {
      "country": "Palau",
      "government": "Republic"
    },
    {
      "country": "Palestine",
      "government": "Autonomous Area"
    },
    {
      "country": "Panama",
      "government": "Republic"
    },
    {
      "country": "Papua New Guinea",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Paraguay",
      "government": "Republic"
    },
    {
      "country": "Peru",
      "government": "Republic"
    },
    {
      "country": "Philippines",
      "government": "Republic"
    },
    {
      "country": "Pitcairn",
      "government": "Dependent Territory of the UK"
    },
    {
      "country": "Poland",
      "government": "Republic"
    },
    {
      "country": "Portugal",
      "government": "Republic"
    },
    {
      "country": "Puerto Rico",
      "government": "Commonwealth of the US"
    },
    {
      "country": "Qatar",
      "government": "Monarchy"
    },
    {
      "country": "Reunion",
      "government": "Overseas Department of France"
    },
    {
      "country": "Romania",
      "government": "Republic"
    },
    {
      "country": "Russian Federation",
      "government": "Federal Republic"
    },
    {
      "country": "Rwanda",
      "government": "Republic"
    },
    {
      "country": "Saint Helena",
      "government": "Dependent Territory of the UK"
    },
    {
      "country": "Saint Kitts and Nevis",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Saint Lucia",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Saint Pierre and Miquelon",
      "government": "Territorial Collectivity of France"
    },
    {
      "country": "Saint Vincent and the Grenadines",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Samoa",
      "government": "Parlementary Monarchy"
    },
    {
      "country": "San Marino",
      "government": "Republic"
    },
    {
      "country": "Sao Tome and Principe",
      "government": "Republic"
    },
    {
      "country": "Saudi Arabia",
      "government": "Monarchy"
    },
    {
      "country": "Scotland",
      "government": null
    },
    {
      "country": "Senegal",
      "government": "Republic"
    },
    {
      "country": "Serbia",
      "government": "Republic"
    },
    {
      "country": "Seychelles",
      "government": "Republic"
    },
    {
      "country": "Sierra Leone",
      "government": "Republic"
    },
    {
      "country": "Singapore",
      "government": "Republic"
    },
    {
      "country": "Slovakia",
      "government": "Republic"
    },
    {
      "country": "Slovenia",
      "government": "Republic"
    },
    {
      "country": "Solomon Islands",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Somalia",
      "government": "Republic"
    },
    {
      "country": "South Africa",
      "government": "Republic"
    },
    {
      "country": "South Georgia and the South Sandwich Islands",
      "government": "Dependent Territory of the UK"
    },
    {
      "country": "South Korea",
      "government": "Republic"
    },
    {
      "country": "South Sudan",
      "government": null
    },
    {
      "country": "Spain",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Sri Lanka",
      "government": null
    },
    {
      "country": "Sudan",
      "government": "Islamic Republic"
    },
    {
      "country": "Suriname",
      "government": "Republic"
    },
    {
      "country": "Svalbard and Jan Mayen",
      "government": "Dependent Territory of Norway"
    },
    {
      "country": "Swaziland",
      "government": "Monarchy"
    },
    {
      "country": "Sweden",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Switzerland",
      "government": "Federation"
    },
    {
      "country": "Syria",
      "government": "Republic"
    },
    {
      "country": "Tajikistan",
      "government": "Republic"
    },
    {
      "country": "Tanzania",
      "government": "Republic"
    },
    {
      "country": "Thailand",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "The Democratic Republic of Congo",
      "government": "Republic"
    },
    {
      "country": "Togo",
      "government": "Republic"
    },
    {
      "country": "Tokelau",
      "government": "Nonmetropolitan Territory of New Zealand"
    },
    {
      "country": "Tonga",
      "government": "Monarchy"
    },
    {
      "country": "Trinidad and Tobago",
      "government": "Republic"
    },
    {
      "country": "Tunisia",
      "government": "Republic"
    },
    {
      "country": "Turkey",
      "government": "Republic"
    },
    {
      "country": "Turkmenistan",
      "government": "Republic"
    },
    {
      "country": "Turks and Caicos Islands",
      "government": "Dependent Territory of the UK"
    },
    {
      "country": "Tuvalu",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "Uganda",
      "government": "Republic"
    },
    {
      "country": "Ukraine",
      "government": "Republic"
    },
    {
      "country": "United Arab Emirates",
      "government": "Emirate Federation"
    },
    {
      "country": "United Kingdom",
      "government": "Constitutional Monarchy"
    },
    {
      "country": "United States",
      "government": "Federal Republic"
    },
    {
      "country": "United States Minor Outlying Islands",
      "government": "Dependent Territory of the US"
    },
    {
      "country": "Uruguay",
      "government": "Republic"
    },
    {
      "country": "Uzbekistan",
      "government": "Republic"
    },
    {
      "country": "Vanuatu",
      "government": "Republic"
    },
    {
      "country": "Venezuela",
      "government": "Federal Republic"
    },
    {
      "country": "Vietnam",
      "government": "Socialistic Republic"
    },
    {
      "country": "Virgin Islands, British",
      "government": null
    },
    {
      "country": "Virgin Islands, U.S.",
      "government": null
    },
    {
      "country": "Wales",
      "government": null
    },
    {
      "country": "Wallis and Futuna",
      "government": "Nonmetropolitan Territory of France"
    },
    {
      "country": "Western Sahara",
      "government": "Occupied by Marocco"
    },
    {
      "country": "Yemen",
      "government": "Republic"
    },
    {
      "country": "Zambia",
      "government": "Republic"
    },
    {
      "country": "Zimbabwe",
      "government": "Republic"
    }
  ];
}
// --------------------
/// COUNTRY NAME - LANGUAGES
/*
List<Map<String, dynamic>> cocoNameLangs(){
  return [
    {
      "country": "Aruba",
      "languages": [
        "Dutch",
        "English",
        "Papiamento",
        "Spanish"
      ]
    },
    {
      "country": "Afghanistan",
      "languages": [
        "Balochi",
        "Dari",
        "Pashto",
        "Turkmenian",
        "Uzbek"
      ]
    },
    {
      "country": "Angola",
      "languages": [
        "Ambo",
        "Chokwe",
        "Kongo",
        "Luchazi",
        "Luimbe-nganguela",
        "Luvale",
        "Mbundu",
        "Nyaneka-nkhumbi",
        "Ovimbundu"
      ]
    },
    {
      "country": "Anguilla",
      "languages": [
        "English"
      ]
    },
    {
      "country": "Albania",
      "languages": [
        "Albaniana",
        "Greek",
        "Macedonian"
      ]
    },
    {
      "country": "Andorra",
      "languages": [
        "Catalan",
        "French",
        "Portuguese",
        "Spanish"
      ]
    },
    {
      "country": "Netherlands Antilles",
      "languages": [
        "Dutch",
        "English",
        "Papiamento"
      ]
    },
    {
      "country": "United Arab Emirates",
      "languages": [
        "Arabic",
        "Hindi"
      ]
    },
    {
      "country": "Argentina",
      "languages": [
        "Indian Languages",
        "Italian",
        "Spanish"
      ]
    },
    {
      "country": "Armenia",
      "languages": [
        "Armenian",
        "Azerbaijani"
      ]
    },
    {
      "country": "American Samoa",
      "languages": [
        "English",
        "Samoan",
        "Tongan"
      ]
    },
    {
      "country": "Antigua and Barbuda",
      "languages": [
        "Creole English",
        "English"
      ]
    },
    {
      "country": "Australia",
      "languages": [
        "Arabic",
        "Canton Chinese",
        "English",
        "German",
        "Greek",
        "Italian",
        "Serbo-Croatian",
        "Vietnamese"
      ]
    },
    {
      "country": "Austria",
      "languages": [
        "Czech",
        "German",
        "Hungarian",
        "Polish",
        "Romanian",
        "Serbo-Croatian",
        "Slovene",
        "Turkish"
      ]
    },
    {
      "country": "Azerbaijan",
      "languages": [
        "Armenian",
        "Azerbaijani",
        "Lezgian",
        "Russian"
      ]
    },
    {
      "country": "Burundi",
      "languages": [
        "French",
        "Kirundi",
        "Swahili"
      ]
    },
    {
      "country": "Belgium",
      "languages": [
        "Arabic",
        "Dutch",
        "French",
        "German",
        "Italian",
        "Turkish"
      ]
    },
    {
      "country": "Benin",
      "languages": [
        "Adja",
        "Aizo",
        "Bariba",
        "Fon",
        "Ful",
        "Joruba",
        "Somba"
      ]
    },
    {
      "country": "Burkina Faso",
      "languages": [
        "Busansi",
        "Dagara",
        "Dyula",
        "Ful",
        "Gurma",
        "Mossi"
      ]
    },
    {
      "country": "Bangladesh",
      "languages": [
        "Bengali",
        "Chakma",
        "Garo",
        "Khasi",
        "Marma",
        "Santhali",
        "Tripuri"
      ]
    },
    {
      "country": "Bulgaria",
      "languages": [
        "Bulgariana",
        "Macedonian",
        "Romani",
        "Turkish"
      ]
    },
    {
      "country": "Bahrain",
      "languages": [
        "Arabic",
        "English"
      ]
    },
    {
      "country": "Bahamas",
      "languages": [
        "Creole English",
        "Creole French"
      ]
    },
    {
      "country": "Bosnia and Herzegovina",
      "languages": [
        "Bosnian"
      ]
    },
    {
      "country": "Belarus",
      "languages": [
        "Belorussian",
        "Polish",
        "Russian",
        "Ukrainian"
      ]
    },
    {
      "country": "Belize",
      "languages": [
        "English",
        "Garifuna",
        "Maya Languages",
        "Spanish"
      ]
    },
    {
      "country": "Bermuda",
      "languages": [
        "English"
      ]
    },
    {
      "country": "Bolivia",
      "languages": [
        "Aimar√°",
        "Guaran√≠",
        "Ket¬öua",
        "Spanish"
      ]
    },
    {
      "country": "Brazil",
      "languages": [
        "German",
        "Indian Languages",
        "Italian",
        "Japanese",
        "Portuguese"
      ]
    },
    {
      "country": "Barbados",
      "languages": [
        "Bajan",
        "English"
      ]
    },
    {
      "country": "Brunei",
      "languages": [
        "Chinese",
        "English",
        "Malay",
        "Malay-English"
      ]
    },
    {
      "country": "Bhutan",
      "languages": [
        "Asami",
        "Dzongkha",
        "Nepali"
      ]
    },
    {
      "country": "Botswana",
      "languages": [
        "Khoekhoe",
        "Ndebele",
        "San",
        "Shona",
        "Tswana"
      ]
    },
    {
      "country": "Central African Republic",
      "languages": [
        "Banda",
        "Gbaya",
        "Mandjia",
        "Mbum",
        "Ngbaka",
        "Sara"
      ]
    },
    {
      "country": "Canada",
      "languages": [
        "Chinese",
        "Dutch",
        "English",
        "Eskimo Languages",
        "French",
        "German",
        "Italian",
        "Polish",
        "Portuguese",
        "Punjabi",
        "Spanish",
        "Ukrainian"
      ]
    },
    {
      "country": "Cocos (Keeling) Islands",
      "languages": [
        "English",
        "Malay"
      ]
    },
    {
      "country": "Switzerland",
      "languages": [
        "French",
        "German",
        "Italian",
        "Romansh"
      ]
    },
    {
      "country": "Chile",
      "languages": [
        "Aimar√°",
        "Araucan",
        "Rapa nui",
        "Spanish"
      ]
    },
    {
      "country": "China",
      "languages": [
        "Chinese",
        "Dong",
        "Hui",
        "Mant¬öu",
        "Miao",
        "Mongolian",
        "Puyi",
        "Tibetan",
        "Tujia",
        "Uighur",
        "Yi",
        "Zhuang"
      ]
    },
    {
      "country": "Ivory Coast",
      "languages": [
        "Akan",
        "Gur",
        "Kru",
        "Malinke",
        "[South]Mande"
      ]
    },
    {
      "country": "Cameroon",
      "languages": [
        "Bamileke-bamum",
        "Duala",
        "Fang",
        "Ful",
        "Maka",
        "Mandara",
        "Masana",
        "Tikar"
      ]
    },
    {
      "country": "Congo, The Democratic Republic of the",
      "languages": [
        "Lingala",
        "Kikongo",
        "Swahili",
        "Tshiluba"
      ]
    },
    {
      "country": "Congo",
      "languages": [
        "Kongo",
        "Mbete",
        "Mboshi",
        "Punu",
        "Sango",
        "Teke"
      ]
    },
    {
      "country": "Cook Islands",
      "languages": [
        "English",
        "Maori"
      ]
    },
    {
      "country": "Colombia",
      "languages": [
        "Arawakan",
        "Caribbean",
        "Chibcha",
        "Creole English",
        "Spanish"
      ]
    },
    {
      "country": "Comoros",
      "languages": [
        "Comorian",
        "Comorian-Arabic",
        "Comorian-French",
        "Comorian-madagassi",
        "Comorian-Swahili"
      ]
    },
    {
      "country": "Cape Verde",
      "languages": [
        "Crioulo",
        "Portuguese"
      ]
    },
    {
      "country": "Costa Rica",
      "languages": [
        "Chibcha",
        "Chinese",
        "Creole English",
        "Spanish"
      ]
    },
    {
      "country": "Cuba",
      "languages": [
        "Spanish"
      ]
    },
    {
      "country": "Christmas Island",
      "languages": [
        "Chinese",
        "English"
      ]
    },
    {
      "country": "Cayman Islands",
      "languages": [
        "English"
      ]
    },
    {
      "country": "Cyprus",
      "languages": [
        "Greek",
        "Turkish"
      ]
    },
    {
      "country": "Czech Republic",
      "languages": [
        "Czech",
        "German",
        "Hungarian",
        "Moravian",
        "Polish",
        "Romani",
        "Silesiana",
        "Slovak"
      ]
    },
    {
      "country": "Germany",
      "languages": [
        "German",
        "Greek",
        "Italian",
        "Polish",
        "Southern Slavic Languages",
        "Turkish"
      ]
    },
    {
      "country": "Djibouti",
      "languages": [
        "Afar",
        "Arabic",
        "Somali"
      ]
    },
    {
      "country": "Dominica",
      "languages": [
        "Creole English",
        "Creole French"
      ]
    },
    {
      "country": "Denmark",
      "languages": [
        "Arabic",
        "Danish",
        "English",
        "German",
        "Norwegian",
        "Swedish",
        "Turkish"
      ]
    },
    {
      "country": "Dominican Republic",
      "languages": [
        "Creole French",
        "Spanish"
      ]
    },
    {
      "country": "Algeria",
      "languages": [
        "Arabic",
        "Berberi"
      ]
    },
    {
      "country": "Ecuador",
      "languages": [
        "Ket¬öua",
        "Spanish"
      ]
    },
    {
      "country": "Egypt",
      "languages": [
        "Arabic",
        "Sinaberberi"
      ]
    },
    {
      "country": "Eritrea",
      "languages": [
        "Afar",
        "Bilin",
        "Hadareb",
        "Saho",
        "Tigre",
        "Tigrigna"
      ]
    },
    {
      "country": "Western Sahara",
      "languages": [
        "Arabic"
      ]
    },
    {
      "country": "Spain",
      "languages": [
        "Basque",
        "Catalan",
        "Galecian",
        "Spanish"
      ]
    },
    {
      "country": "Estonia",
      "languages": [
        "Belorussian",
        "Estonian",
        "Finnish",
        "Russian",
        "Ukrainian"
      ]
    },
    {
      "country": "Ethiopia",
      "languages": [
        "Amharic",
        "Gurage",
        "Oromo",
        "Sidamo",
        "Somali",
        "Tigrigna",
        "Walaita"
      ]
    },
    {
      "country": "Finland",
      "languages": [
        "Estonian",
        "Finnish",
        "Russian",
        "Saame",
        "Swedish"
      ]
    },
    {
      "country": "Fiji Islands",
      "languages": [
        "Fijian",
        "Hindi"
      ]
    },
    {
      "country": "Falkland Islands",
      "languages": [
        "English"
      ]
    },
    {
      "country": "France",
      "languages": [
        "Arabic",
        "French",
        "Italian",
        "Portuguese",
        "Spanish",
        "Turkish"
      ]
    },
    {
      "country": "Faroe Islands",
      "languages": [
        "Danish",
        "Faroese"
      ]
    },
    {
      "country": "Micronesia, Federated States of",
      "languages": [
        "Kosrean",
        "Mortlock",
        "Pohnpei",
        "Trukese",
        "Wolea",
        "Yap"
      ]
    },
    {
      "country": "Gabon",
      "languages": [
        "Fang",
        "Mbete",
        "Mpongwe",
        "Punu-sira-nzebi"
      ]
    },
    {
      "country": "United Kingdom",
      "languages": [
        "English",
        "Gaeli",
        "Kymri"
      ]
    },
    {
      "country": "Georgia",
      "languages": [
        "Abhyasi",
        "Armenian",
        "Azerbaijani",
        "Georgiana",
        "Osseetti",
        "Russian"
      ]
    },
    {
      "country": "Ghana",
      "languages": [
        "Akan",
        "Ewe",
        "Ga-adangme",
        "Gurma",
        "Joruba",
        "Mossi"
      ]
    },
    {
      "country": "Gibraltar",
      "languages": [
        "Arabic",
        "English"
      ]
    },
    {
      "country": "Guinea",
      "languages": [
        "Ful",
        "Kissi",
        "Kpelle",
        "Loma",
        "Malinke",
        "Susu",
        "Yalunka"
      ]
    },
    {
      "country": "Guadeloupe",
      "languages": [
        "Creole French",
        "French"
      ]
    },
    {
      "country": "Gambia",
      "languages": [
        "Diola",
        "Ful",
        "Malinke",
        "Soninke",
        "Wolof"
      ]
    },
    {
      "country": "Guinea-Bissau",
      "languages": [
        "Balante",
        "Crioulo",
        "Ful",
        "Malinke",
        "Mandyako",
        "Portuguese"
      ]
    },
    {
      "country": "Equatorial Guinea",
      "languages": [
        "Bubi",
        "Fang"
      ]
    },
    {
      "country": "Greece",
      "languages": [
        "Greek",
        "Turkish"
      ]
    },
    {
      "country": "Grenada",
      "languages": [
        "Creole English"
      ]
    },
    {
      "country": "Greenland",
      "languages": [
        "Danish",
        "Greenlandic"
      ]
    },
    {
      "country": "Guatemala",
      "languages": [
        "Cakchiquel",
        "Kekch√≠",
        "Mam",
        "Quich√©",
        "Spanish"
      ]
    },
    {
      "country": "French Guiana",
      "languages": [
        "Creole French",
        "Indian Languages"
      ]
    },
    {
      "country": "Guam",
      "languages": [
        "Chamorro",
        "English",
        "Japanese",
        "Korean",
        "Philippene Languages"
      ]
    },
    {
      "country": "Guyana",
      "languages": [
        "Arawakan",
        "Caribbean",
        "Creole English"
      ]
    },
    {
      "country": "Hong Kong",
      "languages": [
        "Canton Chinese",
        "Chiu chau",
        "English",
        "Fukien",
        "Hakka"
      ]
    },
    {
      "country": "Honduras",
      "languages": [
        "Creole English",
        "Garifuna",
        "Miskito",
        "Spanish"
      ]
    },
    {
      "country": "Croatia",
      "languages": [
        "Serbo-Croatian",
        "Slovene"
      ]
    },
    {
      "country": "Haiti",
      "languages": [
        "French",
        "Haiti Creole"
      ]
    },
    {
      "country": "Hungary",
      "languages": [
        "German",
        "Hungarian",
        "Romani",
        "Romanian",
        "Serbo-Croatian",
        "Slovak"
      ]
    },
    {
      "country": "Indonesia",
      "languages": [
        "Bahasa",
        "Bali",
        "Banja",
        "Batakki",
        "Bugi",
        "Javanese",
        "Madura",
        "Malay",
        "Minangkabau",
        "Sunda"
      ]
    },
    {
      "country": "India",
      "languages": [
        "Asami",
        "Bengali",
        "Gujarati",
        "Hindi",
        "Kannada",
        "Malayalam",
        "Marathi",
        "Odia",
        "Punjabi",
        "Tamil",
        "Telugu",
        "Urdu",
        "Sanskrit",
        "English",
        "Konkani",
        "Nepali",
        "Bodo",
        "Kashmiri",
        "Maithili",
        "Santali",
        "Sindhi"
      ]
    },
    {
      "country": "Ireland",
      "languages": [
        "English",
        "Irish"
      ]
    },
    {
      "country": "Iran",
      "languages": [
        "Arabic",
        "Azerbaijani",
        "Bakhtyari",
        "Balochi",
        "Gilaki",
        "Kurdish",
        "Luri",
        "Mazandarani",
        "Persian",
        "Turkmenian"
      ]
    },
    {
      "country": "Iraq",
      "languages": [
        "Arabic",
        "Assyrian",
        "Azerbaijani",
        "Kurdish",
        "Persian"
      ]
    },
    {
      "country": "Iceland",
      "languages": [
        "English",
        "Icelandic"
      ]
    },
    {
      "country": "Israel",
      "languages": [
        "Arabic",
        "Hebrew",
        "Russian"
      ]
    },
    {
      "country": "Italy",
      "languages": [
        "Albaniana",
        "French",
        "Friuli",
        "German",
        "Italian",
        "Romani",
        "Sardinian",
        "Slovene"
      ]
    },
    {
      "country": "Jamaica",
      "languages": [
        "Creole English",
        "Hindi"
      ]
    },
    {
      "country": "Jordan",
      "languages": [
        "Arabic",
        "Armenian",
        "Circassian"
      ]
    },
    {
      "country": "Japan",
      "languages": [
        "Ainu",
        "Chinese",
        "English",
        "Japanese",
        "Korean",
        "Philippene Languages"
      ]
    },
    {
      "country": "Kazakhstan",
      "languages": [
        "German",
        "Kazakh",
        "Russian",
        "Tatar",
        "Ukrainian",
        "Uzbek"
      ]
    },
    {
      "country": "Kenya",
      "languages": [
        "Gusii",
        "Kalenjin",
        "Kamba",
        "Kikuyu",
        "Luhya",
        "Luo",
        "Masai",
        "Meru",
        "Nyika",
        "Turkana"
      ]
    },
    {
      "country": "Kyrgyzstan",
      "languages": [
        "Kazakh",
        "Kirgiz",
        "Russian",
        "Tadzhik",
        "Tatar",
        "Ukrainian",
        "Uzbek"
      ]
    },
    {
      "country": "Cambodia",
      "languages": [
        "Chinese",
        "Khmer",
        "T¬öam",
        "Vietnamese"
      ]
    },
    {
      "country": "Kiribati",
      "languages": [
        "Kiribati",
        "Tuvalu"
      ]
    },
    {
      "country": "Saint Kitts and Nevis",
      "languages": [
        "Creole English",
        "English"
      ]
    },
    {
      "country": "South Korea",
      "languages": [
        "Chinese",
        "Korean"
      ]
    },
    {
      "country": "Kuwait",
      "languages": [
        "Arabic",
        "English"
      ]
    },
    {
      "country": "Laos",
      "languages": [
        "Lao",
        "Lao-Soung",
        "Mon-khmer",
        "Thai"
      ]
    },
    {
      "country": "Lebanon",
      "languages": [
        "Arabic",
        "Armenian",
        "French"
      ]
    },
    {
      "country": "Liberia",
      "languages": [
        "Bassa",
        "Gio",
        "Grebo",
        "Kpelle",
        "Kru",
        "Loma",
        "Malinke",
        "Mano"
      ]
    },
    {
      "country": "Libyan Arab Jamahiriya",
      "languages": [
        "Arabic",
        "Berberi"
      ]
    },
    {
      "country": "Saint Lucia",
      "languages": [
        "Creole French",
        "English"
      ]
    },
    {
      "country": "Liechtenstein",
      "languages": [
        "German",
        "Italian",
        "Turkish"
      ]
    },
    {
      "country": "Sri Lanka",
      "languages": [
        "Mixed Languages",
        "Singali",
        "Tamil"
      ]
    },
    {
      "country": "Lesotho",
      "languages": [
        "English",
        "Sotho",
        "Zulu"
      ]
    },
    {
      "country": "Lithuania",
      "languages": [
        "Belorussian",
        "Lithuanian",
        "Polish",
        "Russian",
        "Ukrainian"
      ]
    },
    {
      "country": "Luxembourg",
      "languages": [
        "French",
        "German",
        "Italian",
        "Luxembourgish",
        "Portuguese"
      ]
    },
    {
      "country": "Latvia",
      "languages": [
        "Belorussian",
        "Latvian",
        "Lithuanian",
        "Polish",
        "Russian",
        "Ukrainian"
      ]
    },
    {
      "country": "Macao",
      "languages": [
        "Canton Chinese",
        "English",
        "Mandarin Chinese",
        "Portuguese"
      ]
    },
    {
      "country": "Morocco",
      "languages": [
        "Arabic",
        "Berberi"
      ]
    },
    {
      "country": "Monaco",
      "languages": [
        "English",
        "French",
        "Italian",
        "Monegasque"
      ]
    },
    {
      "country": "Moldova",
      "languages": [
        "Bulgariana",
        "Gagauzi",
        "Romanian",
        "Russian",
        "Ukrainian"
      ]
    },
    {
      "country": "Madagascar",
      "languages": [
        "French",
        "Malagasy"
      ]
    },
    {
      "country": "Maldives",
      "languages": [
        "Dhivehi",
        "English"
      ]
    },
    {
      "country": "Mexico",
      "languages": [
        "Mixtec",
        "N√°huatl",
        "Otom√≠",
        "Spanish",
        "Yucatec",
        "Zapotec"
      ]
    },
    {
      "country": "Marshall Islands",
      "languages": [
        "English",
        "Marshallese"
      ]
    },
    {
      "country": "Macedonia",
      "languages": [
        "Albaniana",
        "Macedonian",
        "Romani",
        "Serbo-Croatian",
        "Turkish"
      ]
    },
    {
      "country": "Mali",
      "languages": [
        "Bambara",
        "Ful",
        "Senufo and Minianka",
        "Songhai",
        "Soninke",
        "Tamashek"
      ]
    },
    {
      "country": "Malta",
      "languages": [
        "English",
        "Maltese"
      ]
    },
    {
      "country": "Myanmar",
      "languages": [
        "Burmese",
        "Chin",
        "Kachin",
        "Karen",
        "Kayah",
        "Mon",
        "Rakhine",
        "Shan"
      ]
    },
    {
      "country": "Mongolia",
      "languages": [
        "Bajad",
        "Buryat",
        "Dariganga",
        "Dorbet",
        "Kazakh",
        "Mongolian"
      ]
    },
    {
      "country": "Northern Mariana Islands",
      "languages": [
        "Carolinian",
        "Chamorro",
        "Chinese",
        "English",
        "Korean",
        "Philippene Languages"
      ]
    },
    {
      "country": "Mozambique",
      "languages": [
        "Chuabo",
        "Lomwe",
        "Makua",
        "Marendje",
        "Nyanja",
        "Ronga",
        "Sena",
        "Shona",
        "Tsonga",
        "Tswa"
      ]
    },
    {
      "country": "Mauritania",
      "languages": [
        "Ful",
        "Hassaniya",
        "Soninke",
        "Tukulor",
        "Wolof",
        "Zenaga"
      ]
    },
    {
      "country": "Montserrat",
      "languages": [
        "English"
      ]
    },
    {
      "country": "Martinique",
      "languages": [
        "Creole French",
        "French"
      ]
    },
    {
      "country": "Mauritius",
      "languages": [
        "Bhojpuri",
        "Creole French",
        "French",
        "Hindi",
        "Marathi",
        "Tamil"
      ]
    },
    {
      "country": "Malawi",
      "languages": [
        "Chichewa",
        "Lomwe",
        "Ngoni",
        "Yao"
      ]
    },
    {
      "country": "Malaysia",
      "languages": [
        "Chinese",
        "Dusun",
        "English",
        "Iban",
        "Malay",
        "Tamil"
      ]
    },
    {
      "country": "Mayotte",
      "languages": [
        "French",
        "Mahor√©",
        "Malagasy"
      ]
    },
    {
      "country": "Namibia",
      "languages": [
        "Afrikaans",
        "Caprivi",
        "German",
        "Herero",
        "Kavango",
        "Nama",
        "Ovambo",
        "San"
      ]
    },
    {
      "country": "New Caledonia",
      "languages": [
        "French",
        "Malenasian Languages",
        "Polynesian Languages"
      ]
    },
    {
      "country": "Niger",
      "languages": [
        "Ful",
        "Hausa",
        "Kanuri",
        "Songhai-zerma",
        "Tamashek"
      ]
    },
    {
      "country": "Norfolk Island",
      "languages": [
        "English"
      ]
    },
    {
      "country": "Nigeria",
      "languages": [
        "Bura",
        "Edo",
        "Ful",
        "Hausa",
        "Ibibio",
        "Ibo",
        "Ijo",
        "Joruba",
        "Kanuri",
        "Tiv"
      ]
    },
    {
      "country": "Nicaragua",
      "languages": [
        "Creole English",
        "Miskito",
        "Spanish",
        "Sumo"
      ]
    },
    {
      "country": "Niue",
      "languages": [
        "English",
        "Niue"
      ]
    },
    {
      "country": "Netherlands",
      "languages": [
        "Arabic",
        "Dutch",
        "Fries",
        "Turkish"
      ]
    },
    {
      "country": "Norway",
      "languages": [
        "Danish",
        "English",
        "Norwegian",
        "Saame",
        "Swedish"
      ]
    },
    {
      "country": "Nepal",
      "languages": [
        "Bhojpuri",
        "Hindi",
        "Maithili",
        "Nepali",
        "Newari",
        "Tamang",
        "Tharu"
      ]
    },
    {
      "country": "Nauru",
      "languages": [
        "Chinese",
        "English",
        "Kiribati",
        "Nauru",
        "Tuvalu"
      ]
    },
    {
      "country": "New Zealand",
      "languages": [
        "English",
        "Maori"
      ]
    },
    {
      "country": "Oman",
      "languages": [
        "Arabic",
        "Balochi"
      ]
    },
    {
      "country": "Pakistan",
      "languages": [
        "Balochi",
        "Brahui",
        "Hindko",
        "Pashto",
        "Punjabi",
        "Saraiki",
        "Sindhi",
        "Urdu"
      ]
    },
    {
      "country": "Panama",
      "languages": [
        "Arabic",
        "Creole English",
        "Cuna",
        "Embera",
        "Guaym√≠",
        "Spanish"
      ]
    },
    {
      "country": "Pitcairn",
      "languages": [
        "Pitcairnese"
      ]
    },
    {
      "country": "Peru",
      "languages": [
        "Aimar√°",
        "Ket¬öua",
        "Spanish"
      ]
    },
    {
      "country": "Philippines",
      "languages": [
        "Bicol",
        "Cebuano",
        "Hiligaynon",
        "Ilocano",
        "Maguindanao",
        "Maranao",
        "Pampango",
        "Pangasinan",
        "Pilipino",
        "Waray-waray"
      ]
    },
    {
      "country": "Palau",
      "languages": [
        "Chinese",
        "English",
        "Palau",
        "Philippene Languages"
      ]
    },
    {
      "country": "Papua New Guinea",
      "languages": [
        "Malenasian Languages",
        "Papuan Languages"
      ]
    },
    {
      "country": "Poland",
      "languages": [
        "Belorussian",
        "German",
        "Polish",
        "Ukrainian"
      ]
    },
    {
      "country": "Puerto Rico",
      "languages": [
        "English",
        "Spanish"
      ]
    },
    {
      "country": "North Korea",
      "languages": [
        "Chinese",
        "Korean"
      ]
    },
    {
      "country": "Portugal",
      "languages": [
        "Portuguese"
      ]
    },
    {
      "country": "Paraguay",
      "languages": [
        "German",
        "Guaran√≠",
        "Portuguese",
        "Spanish"
      ]
    },
    {
      "country": "Palestine",
      "languages": [
        "Arabic",
        "Hebrew"
      ]
    },
    {
      "country": "French Polynesia",
      "languages": [
        "Chinese",
        "French",
        "Tahitian"
      ]
    },
    {
      "country": "Qatar",
      "languages": [
        "Arabic",
        "Urdu"
      ]
    },
    {
      "country": "Reunion",
      "languages": [
        "Chinese",
        "Comorian",
        "Creole French",
        "Malagasy",
        "Tamil"
      ]
    },
    {
      "country": "Romania",
      "languages": [
        "German",
        "Hungarian",
        "Romani",
        "Romanian",
        "Serbo-Croatian",
        "Ukrainian"
      ]
    },
    {
      "country": "Russian Federation",
      "languages": [
        "Avarian",
        "Bashkir",
        "Belorussian",
        "Chechen",
        "Chuvash",
        "Kazakh",
        "Mari",
        "Mordva",
        "Russian",
        "Tatar",
        "Udmur",
        "Ukrainian"
      ]
    },
    {
      "country": "Rwanda",
      "languages": [
        "French",
        "Rwanda"
      ]
    },
    {
      "country": "Saudi Arabia",
      "languages": [
        "Arabic"
      ]
    },
    {
      "country": "Sudan",
      "languages": [
        "Arabic",
        "Bari",
        "Beja",
        "Chilluk",
        "Dinka",
        "Fur",
        "Lotuko",
        "Nubian Languages",
        "Nuer",
        "Zande"
      ]
    },
    {
      "country": "Senegal",
      "languages": [
        "Diola",
        "Ful",
        "Malinke",
        "Serer",
        "Soninke",
        "Wolof"
      ]
    },
    {
      "country": "Serbia",
      "languages": [
        "Serbian",
        "Hungarian",
        "Slovak",
        "Romanian",
        "Croatian",
        "Rusyn",
        "Albanian",
        "Bulgarian",
        "English"
      ]
    },
    {
      "country": "Singapore",
      "languages": [
        "Chinese",
        "Malay",
        "Tamil"
      ]
    },
    {
      "country": "Saint Helena",
      "languages": [
        "English"
      ]
    },
    {
      "country": "Svalbard and Jan Mayen",
      "languages": [
        "Norwegian",
        "Russian"
      ]
    },
    {
      "country": "Solomon Islands",
      "languages": [
        "Malenasian Languages",
        "Papuan Languages",
        "Polynesian Languages"
      ]
    },
    {
      "country": "Sierra Leone",
      "languages": [
        "Bullom-sherbro",
        "Ful",
        "Kono-vai",
        "Kuranko",
        "Limba",
        "Mende",
        "Temne",
        "Yalunka"
      ]
    },
    {
      "country": "El Salvador",
      "languages": [
        "Nahua",
        "Spanish"
      ]
    },
    {
      "country": "San Marino",
      "languages": [
        "Italian"
      ]
    },
    {
      "country": "Somalia",
      "languages": [
        "Arabic",
        "Somali"
      ]
    },
    {
      "country": "Saint Pierre and Miquelon",
      "languages": [
        "French"
      ]
    },
    {
      "country": "Sao Tome and Principe",
      "languages": [
        "Crioulo",
        "French"
      ]
    },
    {
      "country": "Suriname",
      "languages": [
        "Hindi",
        "Sranantonga"
      ]
    },
    {
      "country": "Slovakia",
      "languages": [
        "Czech and Moravian",
        "Hungarian",
        "Romani",
        "Slovak",
        "Ukrainian and Russian"
      ]
    },
    {
      "country": "Slovenia",
      "languages": [
        "Hungarian",
        "Serbo-Croatian",
        "Slovene"
      ]
    },
    {
      "country": "Sweden",
      "languages": [
        "Arabic",
        "Finnish",
        "Norwegian",
        "Southern Slavic Languages",
        "Spanish",
        "Swedish"
      ]
    },
    {
      "country": "Swaziland",
      "languages": [
        "Swazi",
        "Zulu"
      ]
    },
    {
      "country": "Seychelles",
      "languages": [
        "English",
        "French",
        "Seselwa"
      ]
    },
    {
      "country": "Syria",
      "languages": [
        "Arabic",
        "Kurdish"
      ]
    },
    {
      "country": "Turks and Caicos Islands",
      "languages": [
        "English"
      ]
    },
    {
      "country": "Chad",
      "languages": [
        "Arabic",
        "Gorane",
        "Hadjarai",
        "Kanem-bornu",
        "Mayo-kebbi",
        "Ouaddai",
        "Sara",
        "Tandjile"
      ]
    },
    {
      "country": "Togo",
      "languages": [
        "Ane",
        "Ewe",
        "Gurma",
        "Kaby√©",
        "Kotokoli",
        "Moba",
        "Naudemba",
        "Watyi"
      ]
    },
    {
      "country": "Thailand",
      "languages": [
        "Chinese",
        "Khmer",
        "Kuy",
        "Lao",
        "Malay",
        "Thai"
      ]
    },
    {
      "country": "Tajikistan",
      "languages": [
        "Russian",
        "Tadzhik",
        "Uzbek"
      ]
    },
    {
      "country": "Tokelau",
      "languages": [
        "English",
        "Tokelau"
      ]
    },
    {
      "country": "Turkmenistan",
      "languages": [
        "Kazakh",
        "Russian",
        "Turkmenian",
        "Uzbek"
      ]
    },
    {
      "country": "East Timor",
      "languages": [
        "Portuguese",
        "Sunda"
      ]
    },
    {
      "country": "Tonga",
      "languages": [
        "English",
        "Tongan"
      ]
    },
    {
      "country": "Trinidad and Tobago",
      "languages": [
        "Creole English",
        "English",
        "Hindi"
      ]
    },
    {
      "country": "Tunisia",
      "languages": [
        "Arabic",
        "Arabic-French",
        "Arabic-French-English"
      ]
    },
    {
      "country": "Turkey",
      "languages": [
        "Arabic",
        "Kurdish",
        "Turkish"
      ]
    },
    {
      "country": "Tuvalu",
      "languages": [
        "English",
        "Kiribati",
        "Tuvalu"
      ]
    },
    {
      "country": "Taiwan",
      "languages": [
        "Ami",
        "Atayal",
        "Hakka",
        "Mandarin Chinese",
        "Min",
        "Paiwan"
      ]
    },
    {
      "country": "Tanzania",
      "languages": [
        "Chaga and Pare",
        "Sambaa",
        "Bondei",
        "Digo",
        "Gogo",
        "Ha",
        "Haya",
        "Hehet",
        "Luguru",
        "Makonde",
        "Nyakusa",
        "Nyamwezi",
        "Shambala",
        "Swahili"
      ]
    },
    {
      "country": "Uganda",
      "languages": [
        "Acholi",
        "Ganda",
        "Gisu",
        "Kiga",
        "Lango",
        "Lugbara",
        "Nkole",
        "Rwanda",
        "Soga",
        "Teso"
      ]
    },
    {
      "country": "Ukraine",
      "languages": [
        "Belorussian",
        "Bulgariana",
        "Hungarian",
        "Polish",
        "Romanian",
        "Russian",
        "Ukrainian"
      ]
    },
    {
      "country": "United States Minor Outlying Islands",
      "languages": [
        "English"
      ]
    },
    {
      "country": "Uruguay",
      "languages": [
        "Spanish"
      ]
    },
    {
      "country": "United States",
      "languages": [
        "Chinese",
        "English",
        "French",
        "German",
        "Italian",
        "Japanese",
        "Korean",
        "Polish",
        "Portuguese",
        "Spanish",
        "Tagalog",
        "Vietnamese"
      ]
    },
    {
      "country": "Uzbekistan",
      "languages": [
        "Karakalpak",
        "Kazakh",
        "Russian",
        "Tadzhik",
        "Tatar",
        "Uzbek"
      ]
    },
    {
      "country": "Holy See (Vatican City State)",
      "languages": [
        "Italian"
      ]
    },
    {
      "country": "Saint Vincent and the Grenadines",
      "languages": [
        "Creole English",
        "English"
      ]
    },
    {
      "country": "Venezuela",
      "languages": [
        "Goajiro",
        "Spanish",
        "Warrau"
      ]
    },
    {
      "country": "Virgin Islands, British",
      "languages": [
        "English"
      ]
    },
    {
      "country": "Virgin Islands, U.S.",
      "languages": [
        "English",
        "French",
        "Spanish"
      ]
    },
    {
      "country": "Vietnam",
      "languages": [
        "Chinese",
        "Khmer",
        "Man",
        "Miao",
        "Muong",
        "Nung",
        "Thai",
        "Tho",
        "Vietnamese"
      ]
    },
    {
      "country": "Vanuatu",
      "languages": [
        "Bislama",
        "English",
        "French"
      ]
    },
    {
      "country": "Wallis and Futuna",
      "languages": [
        "Futuna",
        "Wallis"
      ]
    },
    {
      "country": "Samoa",
      "languages": [
        "English",
        "Samoan",
        "Samoan-English"
      ]
    },
    {
      "country": "Yemen",
      "languages": [
        "Arabic",
        "Soqutri"
      ]
    },
    {
      "country": "South Africa",
      "languages": [
        "Afrikaans",
        "English",
        "Ndebele",
        "Northsotho",
        "Southsotho",
        "Swazi",
        "Tsonga",
        "Tswana",
        "Venda",
        "Xhosa",
        "Zulu"
      ]
    },
    {
      "country": "Zambia",
      "languages": [
        "Bemba",
        "Chewa",
        "Lozi",
        "Nsenga",
        "Nyanja",
        "Tongan"
      ]
    },
    {
      "country": "Zimbabwe",
      "languages": [
        "English",
        "Ndebele",
        "Nyanja",
        "Shona"
      ]
    }
  ];
}
*/
// -----------------------------------------------------------------------------
/// NOT USED COUNTRIES
/*

[log] COUNTRY NOT FOUND : aia
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Anguilla,
[log]          01. ISO2 : AI,
[log]          02. ISO3 : AIA,
[log]          03. Top Level Domain : ai,
[log]          04. FIPS : AV,
[log]          05. ISO Numeric : 660,
[log]          06. GeoNameID : 3573511,
[log]          07. E164 : 1,
[log]          08. Phone Code : 1-264,
[log]          09. Continent : North America,
[log]          10. Capital : The Valley,
[log]          11. Time Zone in Capital : America/Port_of_Spain,
[log]          12. Currency : Dollar,
[log]          13. Language Codes : en-AI,
[log]          14. Languages : English (official),
[log]          15. Area KM2 : 102,
[log]          16. Internet Hosts : 269,
[log]          17. Internet Users : 3700,
[log]          18. Phones (Mobile) : 26000,
[log]          19. Phones (Landline) : 6000,
[log]          20. GDP : 175400000,
[log]       }.........Length : 21 keys <~~~

[log] COUNTRY NOT FOUND : ata
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Antarctica,
[log]          01. ISO2 : AQ,
[log]          02. ISO3 : ATA,
[log]          03. Top Level Domain : aq,
[log]          04. FIPS : AY,
[log]          05. ISO Numeric : 010,
[log]          06. GeoNameID : 6697173,
[log]          07. E164 : 672,
[log]          08. Phone Code : 672,
[log]          09. Continent : Antarctica,
[log]          10. Capital : ,
[log]          11. Time Zone in Capital : Antarctica/Troll,
[log]          12. Currency : ,
[log]          13. Language Codes : ,
[log]          14. Languages : ,
[log]          15. Area KM2 : 14000000,
[log]          16. Internet Hosts : 7764,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : ,
[log]       }.........Length : 21 keys <~~~

og] COUNTRY NOT FOUND : iot
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : British Indian Ocean Territory,
[log]          01. ISO2 : IO,
[log]          02. ISO3 : IOT,
[log]          03. Top Level Domain : io,
[log]          04. FIPS : IO,
[log]          05. ISO Numeric : 086,
[log]          06. GeoNameID : 1282588,
[log]          07. E164 : 246,
[log]          08. Phone Code : 246,
[log]          09. Continent : Asia,
[log]          10. Capital : Diego Garcia,
[log]          11. Time Zone in Capital : Indian/Chagos,
[log]          12. Currency : Dollar,
[log]          13. Language Codes : en-IO,
[log]          14. Languages : English,
[log]          15. Area KM2 : 60,
[log]          16. Internet Hosts : 75006,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : ,
[log]       }.........Length : 21 keys <~~~

[log] COUNTRY NOT FOUND : vgb
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : British Virgin Islands,
[log]          01. ISO2 : VG,
[log]          02. ISO3 : VGB,
[log]          03. Top Level Domain : vg,
[log]          04. FIPS : VI,
[log]          05. ISO Numeric : 092,
[log]          06. GeoNameID : 3577718,
[log]          07. E164 : 1,
[log]          08. Phone Code : 1-284,
[log]          09. Continent : North America,
[log]          10. Capital : Road Town,
[log]          11. Time Zone in Capital : America/Port_of_Spain,
[log]          12. Currency : Dollar,
[log]          13. Language Codes : en-VG,
[log]          14. Languages : English (official),
[log]          15. Area KM2 : 153,
[log]          16. Internet Hosts : 505,
[log]          17. Internet Users : 4000,
[log]          18. Phones (Mobile) : 48700,
[log]          19. Phones (Landline) : 12268,
[log]          20. GDP : 1095000000,
[log]       }.........Length : 21 keys <~~~

log] COUNTRY NOT FOUND : cxr
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Christmas Island,
[log]          01. ISO2 : CX,
[log]          02. ISO3 : CXR,
[log]          03. Top Level Domain : cx,
[log]          04. FIPS : KT,
[log]          05. ISO Numeric : 162,
[log]          06. GeoNameID : 2078138,
[log]          07. E164 : 61,
[log]          08. Phone Code : 61,
[log]          09. Continent : Asia,
[log]          10. Capital : Flying Fish Cove,
[log]          11. Time Zone in Capital : Indian/Christmas,
[log]          12. Currency : Dollar,
[log]          13. Language Codes : en,zh,ms-CC,
[log]          14. Languages : English (official), Chinese, Malay,
[log]          15. Area KM2 : 135,
[log]          16. Internet Hosts : 3028,
[log]          17. Internet Users : 464,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : ,
[log]       }.........Length : 21 keys <~~~

[log] COUNTRY NOT FOUND : cck
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Cocos Islands,
[log]          01. ISO2 : CC,
[log]          02. ISO3 : CCK,
[log]          03. Top Level Domain : cc,
[log]          04. FIPS : CK,
[log]          05. ISO Numeric : 166,
[log]          06. GeoNameID : 1547376,
[log]          07. E164 : 61,
[log]          08. Phone Code : 61,
[log]          09. Continent : Asia,
[log]          10. Capital : West Island,
[log]          11. Time Zone in Capital : Indian/Cocos,
[log]          12. Currency : Dollar,
[log]          13. Language Codes : ms-CC,en,
[log]          14. Languages : Malay (Cocos dialect), English,
[log]          15. Area KM2 : 14,
[log]          16. Internet Hosts : ,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : ,
[log]       }.........Length : 21 keys <~~~

[log] COUNTRY NOT FOUND : ggy
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Guernsey,
[log]          01. ISO2 : GG,
[log]          02. ISO3 : GGY,
[log]          03. Top Level Domain : gg,
[log]          04. FIPS : GK,
[log]          05. ISO Numeric : 831,
[log]          06. GeoNameID : 3042362,
[log]          07. E164 : 44,
[log]          08. Phone Code : 44-1481,
[log]          09. Continent : Europe,
[log]          10. Capital : St Peter Port,
[log]          11. Time Zone in Capital : Europe/London,
[log]          12. Currency : Pound,
[log]          13. Language Codes : en,fr,
[log]          14. Languages : English, French, Norman-French dialect spoken in country districts,
[log]          15. Area KM2 : 78,
[log]          16. Internet Hosts : 239,
[log]          17. Internet Users : 48300,
[log]          18. Phones (Mobile) : 43800,
[log]          19. Phones (Landline) : 45100,
[log]          20. GDP : 2742000000,
[log]       }.........Length : 21 keys <~~~

[log] COUNTRY NOT FOUND : xkx
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Kosovo,
[log]          01. ISO2 : XK,
[log]          02. ISO3 : XKX,
[log]          03. Top Level Domain : ,
[log]          04. FIPS : KV,
[log]          05. ISO Numeric : 0,
[log]          06. GeoNameID : 831053,
[log]          07. E164 : 383,
[log]          08. Phone Code : 383,
[log]          09. Continent : Europe,
[log]          10. Capital : Pristina,
[log]          11. Time Zone in Capital : Europe/Belgrade,
[log]          12. Currency : Euro,
[log]          13. Language Codes : sq,sr,
[log]          14. Languages : Albanian (official), Serbian (official), Bosnian, Turkish, Roma,
[log]          15. Area KM2 : 10887,
[log]          16. Internet Hosts : ,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : 562000,
[log]          19. Phones (Landline) : 106300,
[log]          20. GDP : 7150000000,
[log]       }.........Length : 21 keys <~~~

[log] COUNTRY NOT FOUND : msr
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Montserrat,
[log]          01. ISO2 : MS,
[log]          02. ISO3 : MSR,
[log]          03. Top Level Domain : ms,
[log]          04. FIPS : MH,
[log]          05. ISO Numeric : 500,
[log]          06. GeoNameID : 3578097,
[log]          07. E164 : 1,
[log]          08. Phone Code : 1-664,
[log]          09. Continent : North America,
[log]          10. Capital : Plymouth,
[log]          11. Time Zone in Capital : America/Port_of_Spain,
[log]          12. Currency : Dollar,
[log]          13. Language Codes : en-MS,
[log]          14. Languages : English,
[log]          15. Area KM2 : 102,
[log]          16. Internet Hosts : 2431,
[log]          17. Internet Users : 1200,
[log]          18. Phones (Mobile) : 4000,
[log]          19. Phones (Landline) : 3000,
[log]          20. GDP : ,
[log]       }.........Length : 21 keys <~~~

[log] COUNTRY NOT FOUND : nru
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Nauru,
[log]          01. ISO2 : NR,
[log]          02. ISO3 : NRU,
[log]          03. Top Level Domain : nr,
[log]          04. FIPS : NR,
[log]          05. ISO Numeric : 520,
[log]          06. GeoNameID : 2110425,
[log]          07. E164 : 674,
[log]          08. Phone Code : 674,
[log]          09. Continent : Oceania,
[log]          10. Capital : Yaren,
[log]          11. Time Zone in Capital : Pacific/Nauru,
[log]          12. Currency : Dollar,
[log]          13. Language Codes : na,en-NR,
[log]          14. Languages : Nauruan 93% (official, a distinct Pacific Island language), English 2% (widely understood, spoken, and used for most government and commercial purposes), other 5% (includes I-Kiribati 2% and Chinese 2%),
[log]          15. Area KM2 : 21,
[log]          16. Internet Hosts : 8162,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : 6800,
[log]          19. Phones (Landline) : 1900,
[log]          20. GDP : ,
[log]       }.........Length : 21 keys <~~~

[log] COUNTRY NOT FOUND : ant
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Netherlands Antilles,
[log]          01. ISO2 : AN,
[log]          02. ISO3 : ANT,
[log]          03. Top Level Domain : an,
[log]          04. FIPS : NT,
[log]          05. ISO Numeric : 530,
[log]          06. GeoNameID : ,
[log]          07. E164 : 599,
[log]          08. Phone Code : 599,
[log]          09. Continent : North America,
[log]          10. Capital : Willemstad,
[log]          11. Time Zone in Capital : America/Curacao,
[log]          12. Currency : Guilder,
[log]          13. Language Codes : nl-AN,en,es,
[log]          14. Languages : Dutch, English, Spanish,
[log]          15. Area KM2 : 960,
[log]          16. Internet Hosts : ,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : ,
[log]       }.........Length : 21 keys <~~~

[log] COUNTRY NOT FOUND : niu
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Niue,
[log]          01. ISO2 : NU,
[log]          02. ISO3 : NIU,
[log]          03. Top Level Domain : nu,
[log]          04. FIPS : NE,
[log]          05. ISO Numeric : 570,
[log]          06. GeoNameID : 4036232,
[log]          07. E164 : 683,
[log]          08. Phone Code : 683,
[log]          09. Continent : Oceania,
[log]          10. Capital : Alofi,
[log]          11. Time Zone in Capital : Pacific/Niue,
[log]          12. Currency : Dollar,
[log]          13. Language Codes : niu,en-NU,
[log]          14. Languages : Niuean (official) 46% (a Polynesian language closely related to Tongan and Samoan), Niuean and English 32%, English (official) 11%, Niuean and others 5%, other 6% (2011 est.),
[log]          15. Area KM2 : 260,
[log]          16. Internet Hosts : 79508,
[log]          17. Internet Users : 1100,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : 10010000,
[log]       }.........Length : 21 keys <~~~

[log] COUNTRY NOT FOUND : pcn
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Pitcairn,
[log]          01. ISO2 : PN,
[log]          02. ISO3 : PCN,
[log]          03. Top Level Domain : pn,
[log]          04. FIPS : PC,
[log]          05. ISO Numeric : 612,
[log]          06. GeoNameID : 4030699,
[log]          07. E164 : 64,
[log]          08. Phone Code : 64,
[log]          09. Continent : Oceania,
[log]          10. Capital : Adamstown,
[log]          11. Time Zone in Capital : Pacific/Pitcairn,
[log]          12. Currency : Dollar,
[log]          13. Language Codes : en-PN,
[log]          14. Languages : English,
[log]          15. Area KM2 : 47,
[log]          16. Internet Hosts : ,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : ,
[log]       }.........Length : 21 keys <~~~

[log] COUNTRY NOT FOUND : blm
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Saint Barthelemy,
[log]          01. ISO2 : BL,
[log]          02. ISO3 : BLM,
[log]          03. Top Level Domain : gp,
[log]          04. FIPS : TB,
[log]          05. ISO Numeric : 652,
[log]          06. GeoNameID : 3578476,
[log]          07. E164 : 590,
[log]          08. Phone Code : 590,
[log]          09. Continent : North America,
[log]          10. Capital : Gustavia,
[log]          11. Time Zone in Capital : America/Port_of_Spain,
[log]          12. Currency : Euro,
[log]          13. Language Codes : fr,
[log]          14. Languages : French (primary), English,
[log]          15. Area KM2 : 21,
[log]          16. Internet Hosts : ,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : 0,
[log]       }.........Length : 21 keys <~~~

log] COUNTRY NOT FOUND : maf
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Saint Martin,
[log]          01. ISO2 : MF,
[log]          02. ISO3 : MAF,
[log]          03. Top Level Domain : gp,
[log]          04. FIPS : RN,
[log]          05. ISO Numeric : 663,
[log]          06. GeoNameID : 3578421,
[log]          07. E164 : 1,
[log]          08. Phone Code : 590,
[log]          09. Continent : North America,
[log]          10. Capital : Marigot,
[log]          11. Time Zone in Capital : America/Port_of_Spain,
[log]          12. Currency : Euro,
[log]          13. Language Codes : fr,
[log]          14. Languages : French (official), English, Dutch, French Patois, Spanish, Papiamento (dialect of Netherlands Antilles),
[log]          15. Area KM2 : 53,
[log]          16. Internet Hosts : ,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : 561500000,
[log]       }.........Length : 21 keys <~~~

[log] COUNTRY NOT FOUND : spm
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Saint Pierre and Miquelon,
[log]          01. ISO2 : PM,
[log]          02. ISO3 : SPM,
[log]          03. Top Level Domain : pm,
[log]          04. FIPS : SB,
[log]          05. ISO Numeric : 666,
[log]          06. GeoNameID : 3424932,
[log]          07. E164 : 508,
[log]          08. Phone Code : 508,
[log]          09. Continent : North America,
[log]          10. Capital : Saint-Pierre,
[log]          11. Time Zone in Capital : America/Miquelon,
[log]          12. Currency : Euro,
[log]          13. Language Codes : fr-PM,
[log]          14. Languages : French (official),
[log]          15. Area KM2 : 242,
[log]          16. Internet Hosts : 15,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : 4800,
[log]          20. GDP : 215300000,
[log]       }.........Length : 21 keys <~~~

 COUNTRY NOT FOUND : sxm
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Sint Maarten,
[log]          01. ISO2 : SX,
[log]          02. ISO3 : SXM,
[log]          03. Top Level Domain : sx,
[log]          04. FIPS : NN,
[log]          05. ISO Numeric : 534,
[log]          06. GeoNameID : 7609695,
[log]          07. E164 : 1,
[log]          08. Phone Code : 1-721,
[log]          09. Continent : North America,
[log]          10. Capital : Philipsburg,
[log]          11. Time Zone in Capital : America/Curacao,
[log]          12. Currency : Guilder,
[log]          13. Language Codes : nl,en,
[log]          14. Languages : English (official) 67.5%, Spanish 12.9%, Creole 8.2%, Dutch (official) 4.2%, Papiamento (a Spanish-Portuguese-Dutch-English dialect) 2.2%, French 1.5%, other 3.5% (2001 census),
[log]          15. Area KM2 : 34,
[log]          16. Internet Hosts : ,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : 794700000,
[log]       }.........Length : 21 keys <~~~

og] COUNTRY NOT FOUND : sjm
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Svalbard and Jan Mayen,
[log]          01. ISO2 : SJ,
[log]          02. ISO3 : SJM,
[log]          03. Top Level Domain : sj,
[log]          04. FIPS : SV,
[log]          05. ISO Numeric : 744,
[log]          06. GeoNameID : 607072,
[log]          07. E164 : 47,
[log]          08. Phone Code : 47,
[log]          09. Continent : Europe,
[log]          10. Capital : Longyearbyen,
[log]          11. Time Zone in Capital : Europe/Oslo,
[log]          12. Currency : Krone,
[log]          13. Language Codes : no,ru,
[log]          14. Languages : Norwegian, Russian,
[log]          15. Area KM2 : 62049,
[log]          16. Internet Hosts : ,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : 0,
[log]       }.........Length : 21 keys <~~~

g] COUNTRY NOT FOUND : tkl
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Tokelau,
[log]          01. ISO2 : TK,
[log]          02. ISO3 : TKL,
[log]          03. Top Level Domain : tk,
[log]          04. FIPS : TL,
[log]          05. ISO Numeric : 772,
[log]          06. GeoNameID : 4031074,
[log]          07. E164 : 690,
[log]          08. Phone Code : 690,
[log]          09. Continent : Oceania,
[log]          10. Capital : ,
[log]          11. Time Zone in Capital : Pacific/Fakaofo,
[log]          12. Currency : Dollar,
[log]          13. Language Codes : tkl,en-TK,
[log]          14. Languages : Tokelauan 93.5% (a Polynesian language), English 58.9%, Samoan 45.5%, Tuvaluan 11.6%, Kiribati 2.7%, other 2.5%, none 4.1%, unspecified 0.6%,
[log]          15. Area KM2 : 10,
[log]          16. Internet Hosts : 2069,
[log]          17. Internet Users : 800,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : 0,
[log]       }.........Length : 21 keys <~~~

 COUNTRY NOT FOUND : vir
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : U.S. Virgin Islands,
[log]          01. ISO2 : VI,
[log]          02. ISO3 : VIR,
[log]          03. Top Level Domain : vi,
[log]          04. FIPS : VQ,
[log]          05. ISO Numeric : 850,
[log]          06. GeoNameID : 4796775,
[log]          07. E164 : 1,
[log]          08. Phone Code : 1-340,
[log]          09. Continent : North America,
[log]          10. Capital : Charlotte Amalie,
[log]          11. Time Zone in Capital : America/Port_of_Spain,
[log]          12. Currency : Dollar,
[log]          13. Language Codes : en-VI,
[log]          14. Languages : English 74.7%, Spanish or Spanish Creole 16.8%, French or French Creole 6.6%, other 1.9% (2000 census),
[log]          15. Area KM2 : 352,
[log]          16. Internet Hosts : 4790,
[log]          17. Internet Users : 30000,
[log]          18. Phones (Mobile) : 80300,
[log]          19. Phones (Landline) : 75800,
[log]          20. GDP : 0,
[log]       }.........Length : 21 keys <~~~

og] COUNTRY NOT FOUND : esh
[log]  ~~~> <String, dynamic>{
[log]          00. Country Name : Western Sahara,
[log]          01. ISO2 : EH,
[log]          02. ISO3 : ESH,
[log]          03. Top Level Domain : eh,
[log]          04. FIPS : WI,
[log]          05. ISO Numeric : 732,
[log]          06. GeoNameID : 2461445,
[log]          07. E164 : 212,
[log]          08. Phone Code : 212,
[log]          09. Continent : Africa,
[log]          10. Capital : El-Aaiun,
[log]          11. Time Zone in Capital : Africa/El_Aaiun,
[log]          12. Currency : Dirham,
[log]          13. Language Codes : ar,mey,
[log]          14. Languages : Standard Arabic (national), Hassaniya Arabic, Moroccan Arabic,
[log]          15. Area KM2 : 266000,
[log]          16. Internet Hosts : ,
[log]          17. Internet Users : ,
[log]          18. Phones (Mobile) : ,
[log]          19. Phones (Landline) : ,
[log]          20. GDP : 0,
[log]       }.........Length : 21 keys <~~~

 */
// -----------------------------------------------------------------------------
/// DEPRECATED
/*
Future<void> fixOldFireCountriesToNewRealMaps(BuildContext context) async {

  final List<Map<String, dynamic>> _conMaps = getInternetCountries();

  for (int i = 0; i < _conMaps.length; i++){

    final String _index = Numeric.uniformizeIndexDigits(index: i+1, listLength: _conMaps.length);

    final Map<String, dynamic> map = _conMaps[i];

    final String countryID = (map['ISO3'] as String).toLowerCase();

    final CountryModel _fireCountry = await ZoneProtocols.fetchCountry(
      context: context,
      countryID: countryID,
    );

    if (_fireCountry == null){
      blog('$_index : $countryID : SKIPPED ');
      // Mapper.blogMap(map);
      // final bool _continue = await CenterDialog.showCenterDialog(context: context, title: 'countryID : $countryID',
      //   body: 'NOT FOUND',
      //   boolDialog: true,
      //   confirmButtonText: 'Continue',
      // );
      //
      // if (_continue == false){
      //   break;
      // }

    }
    else {

      final CountryModel _updated = _fireCountry.copyWith(
        langCodes: xGetLangs(countryID),
        areaSqKm: xGetAreaKM(countryID),
        capital: xGetCapital(countryID),
        iso2: xGetIso2(countryID),
        phoneCode: xGetPhoneCode(countryID),
        internetUsers: xGetInternetUsers(countryID),
        gdp: xGetGDP(countryID),
      );

      // _updated.blogCountry(methodName: '${i+1} : $countryID');

      await Real.createNamedDoc(
        context: context,
        collName: RealColl.zoneCountries,
        docName: countryID,
        map: _updated.toMap(includePhrasesTrigrams: false),
      );

      blog('$_index : $countryID : TAMAM ');

    }


  }

  blog('but got ${_conMaps.length} countries');

}
 */
// -----------------------------------------------------------------------------
