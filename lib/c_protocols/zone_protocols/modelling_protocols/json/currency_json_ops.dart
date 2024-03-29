import 'package:basics/models/america.dart';
import 'package:basics/models/flag_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
/// => TAMAM
class CurrencyJsonOps {
  // -----------------------------------------------------------------------------

  const CurrencyJsonOps();

  // -----------------------------------------------------------------------------

  /// READ CURRENCIES

  // --------------------
  static const Map<String, dynamic> allCurrencies = {
    'currency_IQD':{'id':'currency_IQD','countriesIDs':['irq'],'symbol':'د.ع','digits':0},
    'currency_SDG':{'id':'currency_SDG','countriesIDs':['sdn'],'symbol':'SDG','digits':2},
    'currency_MYR':{'id':'currency_MYR','countriesIDs':['mys'],'symbol':'RM','digits':2},
    'currency_DOP':{'id':'currency_DOP','countriesIDs':['dom'],'symbol':r'RD$','digits':2},
    'currency_KMF':{'id':'currency_KMF','countriesIDs':['com'],'symbol':'FC','digits':0},
    'currency_RSD':{'id':'currency_RSD','countriesIDs':['srb'],'symbol':'дин.','digits':0},
    'currency_TWD':{'id':'currency_TWD','countriesIDs':['twn'],'symbol':r'NT$','digits':2},
    'currency_BRL':{'id':'currency_BRL','countriesIDs':['bra'],'symbol':r'R$','digits':2},
    'currency_PEN':{'id':'currency_PEN','countriesIDs':['per'],'symbol':'S/.','digits':2},
    'currency_NZD':{'id':'currency_NZD','countriesIDs':['nzl','cok'],'symbol':r'$','digits':2},
    'currency_NIO':{'id':'currency_NIO','countriesIDs':['nic'],'symbol':r'C$','digits':2},
    'currency_NAD':{'id':'currency_NAD','countriesIDs':['nam'],'symbol':r'N$','digits':2},
    'currency_ZAR':{'id':'currency_ZAR','countriesIDs':['zaf'],'symbol':'R','digits':2},
    'currency_BAM':{'id':'currency_BAM','countriesIDs':['bih'],'symbol':'KM','digits':2},
    'currency_EGP':{'id':'currency_EGP','countriesIDs':['egy'],'symbol':'ج.م','digits':2},
    'currency_MOP':{'id':'currency_MOP','countriesIDs':['mac'],'symbol':r'MOP$','digits':2},
    'currency_TND':{'id':'currency_TND','countriesIDs':['tun'],'symbol':'د.ت','digits':3},
    'currency_CLP':{'id':'currency_CLP','countriesIDs':['chl'],'symbol':r'$','digits':0},
    'currency_UGX':{'id':'currency_UGX','countriesIDs':['uga'],'symbol':'USh','digits':0},
    'currency_HNL':{'id':'currency_HNL','countriesIDs':['hnd'],'symbol':'L','digits':2},
    'currency_CDF':{'id':'currency_CDF','countriesIDs':['cod'],'symbol':'FrCD','digits':2},
    'currency_GTQ':{'id':'currency_GTQ','countriesIDs':['gtm'],'symbol':'Q','digits':2},
    'currency_MXN':{'id':'currency_MXN','countriesIDs':['mex'],'symbol':r'$','digits':2},
    'currency_HUF':{'id':'currency_HUF','countriesIDs':['hun'],'symbol':'Ft','digits':0},
    'currency_BYN':{'id':'currency_BYN','countriesIDs':['blr'],'symbol':'руб.','digits':2},
    'currency_GBP':{'id':'currency_GBP','countriesIDs':['gbr','imn','jey'],'symbol':'£','digits':2},
    'currency_JPY':{'id':'currency_JPY','countriesIDs':['jpn'],'symbol':'￥','digits':0},
    'currency_PLN':{'id':'currency_PLN','countriesIDs':['pol'],'symbol':'zł','digits':2},
    'currency_KRW':{'id':'currency_KRW','countriesIDs':['kor'],'symbol':'₩','digits':0},
    'currency_NPR':{'id':'currency_NPR','countriesIDs':['npl'],'symbol':'नेरू','digits':2},
    'currency_BZD':{'id':'currency_BZD','countriesIDs':['blz'],'symbol':r'$','digits':2},
    'currency_MGA':{'id':'currency_MGA','countriesIDs':['mdg'],'symbol':'MGA','digits':0},
    'currency_BIF':{'id':'currency_BIF','countriesIDs':['bdi'],'symbol':'FBu','digits':0},
    'currency_PKR':{'id':'currency_PKR','countriesIDs':['pak'],'symbol':'₨','digits':0},
    'currency_NGN':{'id':'currency_NGN','countriesIDs':['nga'],'symbol':'₦','digits':2},
    'currency_YER':{'id':'currency_YER','countriesIDs':['yem'],'symbol':'ر.ي','digits':0},
    'currency_CRC':{'id':'currency_CRC','countriesIDs':['cri'],'symbol':'₡','digits':0},
    'currency_CZK':{'id':'currency_CZK','countriesIDs':['cze'],'symbol':'Kč','digits':2},
    'currency_LKR':{'id':'currency_LKR','countriesIDs':['lka'],'symbol':'SL Re','digits':2},
    'currency_RON':{'id':'currency_RON','countriesIDs':['rou'],'symbol':'RON','digits':2},
    'currency_INR':{'id':'currency_INR','countriesIDs':['ind'],'symbol':'টকা','digits':2},
    'currency_ZWL':{'id':'currency_ZWL','countriesIDs':['zwe'],'symbol':r'ZWL$','digits':0},
    'currency_AFN':{'id':'currency_AFN','countriesIDs':['afg'],'symbol':'؋','digits':0},
    'currency_KZT':{'id':'currency_KZT','countriesIDs':['kaz'],'symbol':'тңг.','digits':2},
    'currency_TTD':{'id':'currency_TTD','countriesIDs':['tto'],'symbol':r'$','digits':2},
    'currency_SAR':{'id':'currency_SAR','countriesIDs':['sau'],'symbol':'ر.س','digits':2},
    'currency_BHD':{'id':'currency_BHD','countriesIDs':['bhr'],'symbol':'د.ب','digits':3},
    'currency_TRY':{'id':'currency_TRY','countriesIDs':['tur'],'symbol':'TL','digits':2},
    'currency_BWP':{'id':'currency_BWP','countriesIDs':['bwa'],'symbol':'P','digits':2},
    'currency_LBP':{'id':'currency_LBP','countriesIDs':['lbn'],'symbol':'ل.ل','digits':0},
    'currency_AMD':{'id':'currency_AMD','countriesIDs':['arm'],'symbol':'դր.','digits':0},
    'currency_IDR':{'id':'currency_IDR','countriesIDs':['idn'],'symbol':'Rp','digits':0},
    'currency_KHR':{'id':'currency_KHR','countriesIDs':['khm'],'symbol':'៛','digits':2},
    'currency_MDL':{'id':'currency_MDL','countriesIDs':['mda'],'symbol':'MDL','digits':2},
    'currency_BOB':{'id':'currency_BOB','countriesIDs':['bol'],'symbol':'Bs','digits':2},
    'currency_GHS':{'id':'currency_GHS','countriesIDs':['gha'],'symbol':'GH₵','digits':2},
    'currency_ILS':{'id':'currency_ILS','countriesIDs':['isr'],'symbol':'₪','digits':2},
    'currency_AUD':{'id':'currency_AUD','countriesIDs':['aus','kir','tuv'],'symbol':r'$','digits':2},
    'currency_MMK':{'id':'currency_MMK','countriesIDs':['mmr'],'symbol':'K','digits':0},
    'currency_MUR':{'id':'currency_MUR','countriesIDs':['mus'],'symbol':'MURs','digits':0},
    'currency_SYP':{'id':'currency_SYP','countriesIDs':['syr'],'symbol':'ل.س','digits':0},
    'currency_NOK':{'id':'currency_NOK','countriesIDs':['nor'],'symbol':'kr','digits':2},
    'currency_BGN':{'id':'currency_BGN','countriesIDs':['bgr'],'symbol':'лв.','digits':2},
    'currency_CAD':{'id':'currency_CAD','countriesIDs':['can'],'symbol':r'$','digits':2},
    'currency_DKK':{'id':'currency_DKK','countriesIDs':['dnk','fro','grl'],'symbol':'kr','digits':2},
    'currency_EUR':{'id':'currency_EUR','countriesIDs':['euz','and','aut','bel','cyp','est','fin','fra','guf','deu','grc','glp','vat','irl','ita','lva','ltu','lux','mlt','mtq','myt','mco','mne','nld','prt','reu','smr','svk','svn','esp','xks'],'symbol':'€','digits':2},
    'currency_HKD':{'id':'currency_HKD','countriesIDs':['hkg'],'symbol':r'$','digits':2},
    'currency_RWF':{'id':'currency_RWF','countriesIDs':['rwa'],'symbol':'FR','digits':0},
    'currency_AED':{'id':'currency_AED','countriesIDs':['are'],'symbol':'د.إ','digits':2},
    'currency_JOD':{'id':'currency_JOD','countriesIDs':['jor'],'symbol':'د.أ','digits':3},
    'currency_BND':{'id':'currency_BND','countriesIDs':['brn'],'symbol':r'$','digits':2},
    'currency_VEF':{'id':'currency_VEF','countriesIDs':['ven'],'symbol':'Bs.F.','digits':2},
    'currency_SOS':{'id':'currency_SOS','countriesIDs':['som'],'symbol':'Ssh','digits':0},
    'currency_ETB':{'id':'currency_ETB','countriesIDs':['eth'],'symbol':'Br','digits':2},
    'currency_PAB':{'id':'currency_PAB','countriesIDs':['pan'],'symbol':'B/.','digits':2},
    'currency_SGD':{'id':'currency_SGD','countriesIDs':['sgp'],'symbol':r'$','digits':2},
    'currency_DZD':{'id':'currency_DZD','countriesIDs':['dza'],'symbol':'د.ج','digits':2},
    'currency_TZS':{'id':'currency_TZS','countriesIDs':['tza'],'symbol':'TSh','digits':0},
    'currency_VND':{'id':'currency_VND','countriesIDs':['vnm'],'symbol':'₫','digits':0},
    'currency_HRK':{'id':'currency_HRK','countriesIDs':['hrv'],'symbol':'kn','digits':2},
    'currency_ALL':{'id':'currency_ALL','countriesIDs':['alb'],'symbol':'Lek','digits':0},
    'currency_CHF':{'id':'currency_CHF','countriesIDs':['che', 'lie'],'symbol':'CHF','digits':2},
    'currency_DJF':{'id':'currency_DJF','countriesIDs':['dji'],'symbol':'Fdj','digits':0},
    'currency_XAF':{'id':'currency_XAF','countriesIDs':['cmr','caf','tcd','cog','gnq','gab'],'symbol':'FCFA','digits':0},
    'currency_PHP':{'id':'currency_PHP','countriesIDs':['phl'],'symbol':'₱','digits':2},
    'currency_KWD':{'id':'currency_KWD','countriesIDs':['kwt'],'symbol':'د.ك','digits':3},
    'currency_LYD':{'id':'currency_LYD','countriesIDs':['lby'],'symbol':'د.ل','digits':3},
    'currency_BDT':{'id':'currency_BDT','countriesIDs':['bgd'],'symbol':'৳','digits':2},
    'currency_UZS':{'id':'currency_UZS','countriesIDs':['uzb'],'symbol':'UZS','digits':0},
    'currency_CNY':{'id':'currency_CNY','countriesIDs':['chn'],'symbol':'CN¥','digits':2},
    'currency_THB':{'id':'currency_THB','countriesIDs':['tha'],'symbol':'฿','digits':2},
    'currency_USD':{'id':'currency_USD','countriesIDs':['usa','asm','ecu','slv','gum','mhl','fsm','mnp','plw','pse','pri','tls','tca'],'symbol':r'$','digits':2},
    'currency_MKD':{'id':'currency_MKD','countriesIDs':['mkd'],'symbol':'MKD','digits':2},
    'currency_COP':{'id':'currency_COP','countriesIDs':['col'],'symbol':r'$','digits':0},
    'currency_JMD':{'id':'currency_JMD','countriesIDs':['jam'],'symbol':r'$','digits':2},
    'currency_ISK':{'id':'currency_ISK','countriesIDs':['isl'],'symbol':'kr','digits':0},
    'currency_RUB':{'id':'currency_RUB','countriesIDs':['rus'],'symbol':'₽.','digits':2},
    'currency_PYG':{'id':'currency_PYG','countriesIDs':['pry'],'symbol':'₲','digits':0},
    'currency_UAH':{'id':'currency_UAH','countriesIDs':['ukr'],'symbol':'₴','digits':2},
    'currency_KES':{'id':'currency_KES','countriesIDs':['ken'],'symbol':'Ksh','digits':2},
    'currency_SEK':{'id':'currency_SEK','countriesIDs':['swe'],'symbol':'kr','digits':2},
    'currency_AZN':{'id':'currency_AZN','countriesIDs':['aze'],'symbol':'ман.','digits':2},
    'currency_TOP':{'id':'currency_TOP','countriesIDs':['ton'],'symbol':r'T$','digits':2},
    'currency_OMR':{'id':'currency_OMR','countriesIDs':['omn'],'symbol':'ر.ع','digits':3},
    'currency_CVE':{'id':'currency_CVE','countriesIDs':['cpv'],'symbol':r'CV$','digits':2},
    'currency_UYU':{'id':'currency_UYU','countriesIDs':['ury'],'symbol':r'$','digits':2},
    'currency_MAD':{'id':'currency_MAD','countriesIDs':['mar'],'symbol':'د.م','digits':2},
    'currency_GEL':{'id':'currency_GEL','countriesIDs':['geo'],'symbol':'GEL','digits':2},
    'currency_XOF':{'id':'currency_XOF','countriesIDs':['sen','ben','bfa','civ','gnb','mli','ner','tgo'],'symbol':'CFA','digits':0},
    'currency_IRR':{'id':'currency_IRR','countriesIDs':['irn'],'symbol':'﷼','digits':0},
    'currency_ARS':{'id':'currency_ARS','countriesIDs':['arg'],'symbol':r'$','digits':2},
    'currency_QAR':{'id':'currency_QAR','countriesIDs':['qat'],'symbol':'ر.ق','digits':2},
    'currency_ERN':{'id':'currency_ERN','countriesIDs':['eri'],'symbol':'Nfk','digits':2},
    'currency_MZN':{'id':'currency_MZN','countriesIDs':['moz'],'symbol':'MTn','digits':2},
    'currency_GNF':{'id':'currency_GNF','countriesIDs':['gin'],'symbol':'FG','digits':0}
  };
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CurrencyModel> readAllCurrencies() {

    // final Map<String, dynamic>? _mappedJson = await Filers.readLocalJSON(
    //     path: WorldZoningPaths.currenciesFilePath,
    // );

    return CurrencyModel.decipherCurrencies(allCurrencies);
  }
  // -----------------------------------------------------------------------------

  /// GET CURRENCY

  // --------------------
  /// TESTED : WORKS PERFECT
  static CurrencyModel? proGetCurrencyByCountryID({
    required String? countryID,
  }) {

      final String _countryID = countryID == Flag.planetID ? 'usa'
          :
      America.checkCountryIDIsStateID(countryID) == true ? 'usa'
          :
      countryID ?? 'usa';

      return CurrencyModel.getCurrencyFromCurrenciesByCountryID(
        currencies: CurrencyModel.decipherCurrencies(allCurrencies),
        countryID: _countryID,
      );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CurrencyModel? proGetCurrencyByCurrencyID({
    required String? currencyID,
  }) {
    CurrencyModel? _currency;

    if (currencyID != null) {

      _currency = CurrencyModel.getCurrencyByID(
        allCurrencies: CurrencyModel.decipherCurrencies(allCurrencies),
        currencyID: currencyID,
      );

    }

    return _currency;
  }
  // --------------------
}
