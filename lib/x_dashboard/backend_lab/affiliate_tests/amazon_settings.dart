// ignore_for_file: constant_identifier_names

import 'dart:io';

/// Country key
enum CountryKey {
  USA,
  UK,
  Germany,
  France,
  Japan,
  Canada,
  China,
  Italy,
  Spain,
  India,
  Brazil,
  Mexico,
  Australia,
}

/// Map for this plugin's country key to dart's country code
/// https://pub.dev/documentation/locales/latest/locales/Locale-class.html
const Map<String, CountryKey> countryLocale = {
  'US': CountryKey.USA,
  'GB': CountryKey.UK,
  'DE': CountryKey.Germany,
  'FR': CountryKey.France,
  'JP': CountryKey.Japan,
  'CA': CountryKey.Canada,
  'CN': CountryKey.China,
  'IT': CountryKey.Italy,
  'ES': CountryKey.Spain,
  'IN': CountryKey.India,
  'BR': CountryKey.Brazil,
  'MX': CountryKey.Mexico,
  'AU': CountryKey.Australia,
};

/// Map for amazon's domain.
/// https://en.wikipedia.org/wiki/Amazon_(company)
const Map<CountryKey, String> amazonDomains = {
  CountryKey.USA: 'amazon.com',
  CountryKey.UK: 'amazon.co.uk',
  CountryKey.Germany: 'amazon.de',
  CountryKey.France: 'amazon.fr',
  CountryKey.Japan: 'amazon.co.jp',
  CountryKey.Canada: 'amazon.ca',
  CountryKey.China: 'amazon.cn',
  CountryKey.Italy: 'amazon.it',
  CountryKey.Spain: 'amazon.es',
  CountryKey.India: 'amazon.in',
  CountryKey.Brazil: 'amazon.com.br',
  CountryKey.Mexico: 'amazon.com.mx',
  CountryKey.Australia: 'amazon.com.au',
};

/// Map for amazon's contry code.
const Map<CountryKey, String> codes = {
  CountryKey.USA: '01',
  CountryKey.UK: '02',
  CountryKey.Germany: '03',
  CountryKey.France: '08',
  CountryKey.Japan: '09',
  CountryKey.Canada: '15',
  CountryKey.China: '28',
  CountryKey.Italy: '29',
  CountryKey.Spain: '30',
  CountryKey.India: '31',
  CountryKey.Brazil: '32',
  CountryKey.Mexico: '33',
  CountryKey.Australia: '35',
};

class AmazonPicSetting {

  /// Set for amazon_image's globals setting.
  factory AmazonPicSetting() {
    return _instance;
  }

  AmazonPicSetting._internal() {
    try {
      if (!Platform.isAndroid && !Platform.isIOS) {
        return;
      }
    }  on Exception catch (_) {

      return;
    }
    final localName = Platform.localeName;
    if (3 < localName.length) {
      _defaultCountry = localName.substring(3);
    }
  }

  String _trackingId = 'flutter_amazon_image-22';
  String _defaultCountry = 'US';

  String get trackingId => _trackingId;

  String get defaultCountry => _defaultCountry;

  static final AmazonPicSetting _instance = AmazonPicSetting._internal();



  /// set amazon associates' Tracking ID
  void setTrackingId(String trackingId) {
    _trackingId = trackingId;
  }
}