import 'package:bldrs/ambassadors/database/db_planet/db_areas.dart';
import 'package:bldrs/ambassadors/database/db_planet/db_countries.dart';
import 'package:bldrs/ambassadors/database/db_planet/db_provinces.dart';
import 'package:bldrs/models/planet/city_model.dart';
import 'package:bldrs/models/planet/country_model.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier{
  /// get user country
  String _currentCountry = 'egy';
  String _currentArea = 'Cairo';
  List<Country> _countries = dbCountries;
  List<Province> _provinces = dbProvinces;
  List<Area> _areas = dbAreas;


  String get currentCountry {
    return _currentCountry;
  }

  String get currentCity {
    return _currentArea;
  }

  void changeCountry(String country){
    _currentCountry = country;
    notifyListeners();
  }

  void changeArea(String city){
    _currentArea = city;
    notifyListeners();
  }

  String superFlag(String iso3){
    String flag;
    flagsMaps.forEach((map) {
      if(map['iso3'] == iso3){flag = map['flag'];}
    });
    return flag;
  }

  String superCountryName(BuildContext context, String iso3){
    return translate(context, iso3);
  }

  /// get available countries
  List<Map<String,String>> getAvailableCountries(){
    List<Map<String,String>> _countriesMaps = new List();
    _countries.forEach((co) {
      if (co.isActivated){_countriesMaps.add(
        { "iso3" : co.iso3, "flag" : co.flag}
      );}
    });
    return _countriesMaps;
  }

  /// get Provinces list by country iso3
  List<Map<String,String>> getProvincesNames(BuildContext context, String iso3){
    List<Map<String,String>> _provincesNames = new List();
    String _currentLanguageCode = Wordz.languageCode(context);

    _provinces.forEach((pr) {
      if (pr.iso3 == iso3){
        if (_currentLanguageCode == 'en'){_provincesNames.add({'id': pr.name, 'name': pr.name});}
        else
          {
            String _areaNameInCurrentLanguage = pr.names.firstWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;
            if (_areaNameInCurrentLanguage == null){_provincesNames.add({'id': pr.name, 'name': pr.name});}
            else {_provincesNames.add({'id': pr.name, 'name': _areaNameInCurrentLanguage});}
          }
      }
    });

    return _provincesNames;
  }

  /// get Areas list by Province name
  /// uses provinceName in English as ID
  List<Map<String, String>> getAreasNames(BuildContext context, String provinceID){
    List<Map<String, String>> _areasNames = new List();
    String _currentLanguageCode = Wordz.languageCode(context);
    _areas.forEach((ar) {
      if(ar.province == provinceID){
          String _areaNameInCurrentLanguage = ar.names.firstWhere((name) => name.code == _currentLanguageCode, orElse: ()=> null)?.value;
          if (_areaNameInCurrentLanguage == null){_areasNames.add({'id': ar.name, 'name': ar.name});}
          else {_areasNames.add({'id': ar.name, 'name': _areaNameInCurrentLanguage});}
      }
    });
    return _areasNames;
  }

  var flagsMaps = <Map<String, String>>[
    {"iso3" : "afg", "flag" : Flagz.afg},
    {"iso3" : "ala", "flag" : Flagz.ala},
    {"iso3" : "alb", "flag" : Flagz.alb},
    {"iso3" : "dza", "flag" : Flagz.dza},
    {"iso3" : "asm", "flag" : Flagz.asm},
    {"iso3" : "and", "flag" : Flagz.and},
    {"iso3" : "ago", "flag" : Flagz.ago},
    {"iso3" : "aia", "flag" : Flagz.aia},
    {"iso3" : "ata", "flag" : Flagz.ata},
    {"iso3" : "atg", "flag" : Flagz.atg},
    {"iso3" : "arg", "flag" : Flagz.arg},
    {"iso3" : "arm", "flag" : Flagz.arm},
    {"iso3" : "abw", "flag" : Flagz.abw},
    {"iso3" : "aus", "flag" : Flagz.aus},
    {"iso3" : "aut", "flag" : Flagz.aut},
    {"iso3" : "aze", "flag" : Flagz.aze},
    {"iso3" : "bhs", "flag" : Flagz.bhs},
    {"iso3" : "bhr", "flag" : Flagz.bhr},
    {"iso3" : "bgd", "flag" : Flagz.bgd},
    {"iso3" : "brb", "flag" : Flagz.brb},
    {"iso3" : "blr", "flag" : Flagz.blr},
    {"iso3" : "bel", "flag" : Flagz.bel},
    {"iso3" : "blz", "flag" : Flagz.blz},
    {"iso3" : "ben", "flag" : Flagz.ben},
    {"iso3" : "bmu", "flag" : Flagz.bmu},
    {"iso3" : "btn", "flag" : Flagz.btn},
    {"iso3" : "bol", "flag" : Flagz.bol},
    {"iso3" : "bes", "flag" : Flagz.bes},
    {"iso3" : "bih", "flag" : Flagz.bih},
    {"iso3" : "bwa", "flag" : Flagz.bwa},
    {"iso3" : "bvt", "flag" : Flagz.bvt},
    {"iso3" : "bra", "flag" : Flagz.bra},
    {"iso3" : "iot", "flag" : Flagz.iot},
    {"iso3" : "brn", "flag" : Flagz.brn},
    {"iso3" : "bgr", "flag" : Flagz.bgr},
    {"iso3" : "bfa", "flag" : Flagz.bfa},
    {"iso3" : "bdi", "flag" : Flagz.bdi},
    {"iso3" : "cpv", "flag" : Flagz.cpv},
    {"iso3" : "khm", "flag" : Flagz.khm},
    {"iso3" : "cmr", "flag" : Flagz.cmr},
    {"iso3" : "can", "flag" : Flagz.can},
    {"iso3" : "cym", "flag" : Flagz.cym},
    {"iso3" : "caf", "flag" : Flagz.caf},
    {"iso3" : "tcd", "flag" : Flagz.tcd},
    {"iso3" : "chl", "flag" : Flagz.chl},
    {"iso3" : "chn", "flag" : Flagz.chn},
    {"iso3" : "cxr", "flag" : Flagz.cxr},
    {"iso3" : "cck", "flag" : Flagz.cck},
    {"iso3" : "col", "flag" : Flagz.col},
    {"iso3" : "com", "flag" : Flagz.com},
    {"iso3" : "cog", "flag" : Flagz.cog},
    {"iso3" : "cod", "flag" : Flagz.cod},
    {"iso3" : "cok", "flag" : Flagz.cok},
    {"iso3" : "cri", "flag" : Flagz.cri},
    {"iso3" : "civ", "flag" : Flagz.civ},
    {"iso3" : "hrv", "flag" : Flagz.hrv},
    {"iso3" : "cub", "flag" : Flagz.cub},
    {"iso3" : "cuw", "flag" : Flagz.cuw},
    {"iso3" : "cyp", "flag" : Flagz.cyp},
    {"iso3" : "cze", "flag" : Flagz.cze},
    {"iso3" : "dnk", "flag" : Flagz.dnk},
    {"iso3" : "dji", "flag" : Flagz.dji},
    {"iso3" : "dma", "flag" : Flagz.dma},
    {"iso3" : "dom", "flag" : Flagz.dom},
    {"iso3" : "ecu", "flag" : Flagz.ecu},
    {"iso3" : "egy", "flag" : Flagz.egy},
    {"iso3" : "slv", "flag" : Flagz.slv},
    {"iso3" : "gnq", "flag" : Flagz.gnq},
    {"iso3" : "eri", "flag" : Flagz.eri},
    {"iso3" : "est", "flag" : Flagz.est},
    {"iso3" : "swz", "flag" : Flagz.swz},
    {"iso3" : "eth", "flag" : Flagz.eth},
    {"iso3" : "flk", "flag" : Flagz.flk},
    {"iso3" : "fro", "flag" : Flagz.fro},
    {"iso3" : "fji", "flag" : Flagz.fji},
    {"iso3" : "fin", "flag" : Flagz.fin},
    {"iso3" : "fra", "flag" : Flagz.fra},
    {"iso3" : "guf", "flag" : Flagz.guf},
    {"iso3" : "pyf", "flag" : Flagz.pyf},
    {"iso3" : "atf", "flag" : Flagz.atf},
    {"iso3" : "gab", "flag" : Flagz.gab},
    {"iso3" : "gmb", "flag" : Flagz.gmb},
    {"iso3" : "geo", "flag" : Flagz.geo},
    {"iso3" : "deu", "flag" : Flagz.deu},
    {"iso3" : "gha", "flag" : Flagz.gha},
    {"iso3" : "gib", "flag" : Flagz.gib},
    {"iso3" : "grc", "flag" : Flagz.grc},
    {"iso3" : "grl", "flag" : Flagz.grl},
    {"iso3" : "grd", "flag" : Flagz.grd},
    {"iso3" : "glp", "flag" : Flagz.glp},
    {"iso3" : "gum", "flag" : Flagz.gum},
    {"iso3" : "gtm", "flag" : Flagz.gtm},
    {"iso3" : "ggy", "flag" : Flagz.ggy},
    {"iso3" : "gin", "flag" : Flagz.gin},
    {"iso3" : "gnb", "flag" : Flagz.gnb},
    {"iso3" : "guy", "flag" : Flagz.guy},
    {"iso3" : "hti", "flag" : Flagz.hti},
    {"iso3" : "hmd", "flag" : Flagz.hmd},
    {"iso3" : "vat", "flag" : Flagz.vat},
    {"iso3" : "hnd", "flag" : Flagz.hnd},
    {"iso3" : "hkg", "flag" : Flagz.hkg},
    {"iso3" : "hun", "flag" : Flagz.hun},
    {"iso3" : "isl", "flag" : Flagz.isl},
    {"iso3" : "ind", "flag" : Flagz.ind},
    {"iso3" : "idn", "flag" : Flagz.idn},
    {"iso3" : "irn", "flag" : Flagz.irn},
    {"iso3" : "irq", "flag" : Flagz.irq},
    {"iso3" : "irl", "flag" : Flagz.irl},
    {"iso3" : "imn", "flag" : Flagz.imn},
    {"iso3" : "isr", "flag" : Flagz.isr},
    {"iso3" : "ita", "flag" : Flagz.ita},
    {"iso3" : "jam", "flag" : Flagz.jam},
    {"iso3" : "jpn", "flag" : Flagz.jpn},
    {"iso3" : "jey", "flag" : Flagz.jey},
    {"iso3" : "jor", "flag" : Flagz.jor},
    {"iso3" : "kaz", "flag" : Flagz.kaz},
    {"iso3" : "ken", "flag" : Flagz.ken},
    {"iso3" : "kir", "flag" : Flagz.kir},
    {"iso3" : "prk", "flag" : Flagz.prk},
    {"iso3" : "kor", "flag" : Flagz.kor},
    {"iso3" : "kwt", "flag" : Flagz.kwt},
    {"iso3" : "kgz", "flag" : Flagz.kgz},
    {"iso3" : "lao", "flag" : Flagz.lao},
    {"iso3" : "lva", "flag" : Flagz.lva},
    {"iso3" : "lbn", "flag" : Flagz.lbn},
    {"iso3" : "lso", "flag" : Flagz.lso},
    {"iso3" : "lbr", "flag" : Flagz.lbr},
    {"iso3" : "lby", "flag" : Flagz.lby},
    {"iso3" : "lie", "flag" : Flagz.lie},
    {"iso3" : "ltu", "flag" : Flagz.ltu},
    {"iso3" : "lux", "flag" : Flagz.lux},
    {"iso3" : "mac", "flag" : Flagz.mac},
    {"iso3" : "mdg", "flag" : Flagz.mdg},
    {"iso3" : "mwi", "flag" : Flagz.mwi},
    {"iso3" : "mys", "flag" : Flagz.mys},
    {"iso3" : "mdv", "flag" : Flagz.mdv},
    {"iso3" : "mli", "flag" : Flagz.mli},
    {"iso3" : "mlt", "flag" : Flagz.mlt},
    {"iso3" : "mhl", "flag" : Flagz.mhl},
    {"iso3" : "mtq", "flag" : Flagz.mtq},
    {"iso3" : "mrt", "flag" : Flagz.mrt},
    {"iso3" : "mus", "flag" : Flagz.mus},
    {"iso3" : "myt", "flag" : Flagz.myt},
    {"iso3" : "mex", "flag" : Flagz.mex},
    {"iso3" : "fsm", "flag" : Flagz.fsm},
    {"iso3" : "mda", "flag" : Flagz.mda},
    {"iso3" : "mco", "flag" : Flagz.mco},
    {"iso3" : "mng", "flag" : Flagz.mng},
    {"iso3" : "mne", "flag" : Flagz.mne},
    {"iso3" : "msr", "flag" : Flagz.msr},
    {"iso3" : "mar", "flag" : Flagz.mar},
    {"iso3" : "moz", "flag" : Flagz.moz},
    {"iso3" : "mmr", "flag" : Flagz.mmr},
    {"iso3" : "nam", "flag" : Flagz.nam},
    {"iso3" : "nru", "flag" : Flagz.nru},
    {"iso3" : "npl", "flag" : Flagz.npl},
    {"iso3" : "nld", "flag" : Flagz.nld},
    {"iso3" : "ncl", "flag" : Flagz.ncl},
    {"iso3" : "nzl", "flag" : Flagz.nzl},
    {"iso3" : "nic", "flag" : Flagz.nic},
    {"iso3" : "ner", "flag" : Flagz.ner},
    {"iso3" : "nga", "flag" : Flagz.nga},
    {"iso3" : "niu", "flag" : Flagz.niu},
    {"iso3" : "nfk", "flag" : Flagz.nfk},
    {"iso3" : "mkd", "flag" : Flagz.mkd},
    {"iso3" : "mnp", "flag" : Flagz.mnp},
    {"iso3" : "nor", "flag" : Flagz.nor},
    {"iso3" : "omn", "flag" : Flagz.omn},
    {"iso3" : "pak", "flag" : Flagz.pak},
    {"iso3" : "plw", "flag" : Flagz.plw},
    {"iso3" : "pse", "flag" : Flagz.pse},
    {"iso3" : "pan", "flag" : Flagz.pan},
    {"iso3" : "png", "flag" : Flagz.png},
    {"iso3" : "pry", "flag" : Flagz.pry},
    {"iso3" : "per", "flag" : Flagz.per},
    {"iso3" : "phl", "flag" : Flagz.phl},
    {"iso3" : "pcn", "flag" : Flagz.pcn},
    {"iso3" : "pol", "flag" : Flagz.pol},
    {"iso3" : "prt", "flag" : Flagz.prt},
    {"iso3" : "pri", "flag" : Flagz.pri},
    {"iso3" : "qat", "flag" : Flagz.qat},
    {"iso3" : "reu", "flag" : Flagz.reu},
    {"iso3" : "rou", "flag" : Flagz.rou},
    {"iso3" : "rus", "flag" : Flagz.rus},
    {"iso3" : "rwa", "flag" : Flagz.rwa},
    {"iso3" : "blm", "flag" : Flagz.blm},
    {"iso3" : "shn", "flag" : Flagz.shn},
    {"iso3" : "kna", "flag" : Flagz.kna},
    {"iso3" : "lca", "flag" : Flagz.lca},
    {"iso3" : "maf", "flag" : Flagz.maf},
    {"iso3" : "spm", "flag" : Flagz.spm},
    {"iso3" : "vct", "flag" : Flagz.vct},
    {"iso3" : "wsm", "flag" : Flagz.wsm},
    {"iso3" : "smr", "flag" : Flagz.smr},
    {"iso3" : "stp", "flag" : Flagz.stp},
    {"iso3" : "sau", "flag" : Flagz.sau},
    {"iso3" : "sen", "flag" : Flagz.sen},
    {"iso3" : "srb", "flag" : Flagz.srb},
    {"iso3" : "syc", "flag" : Flagz.syc},
    {"iso3" : "sle", "flag" : Flagz.sle},
    {"iso3" : "sgp", "flag" : Flagz.sgp},
    {"iso3" : "sxm", "flag" : Flagz.sxm},
    {"iso3" : "svk", "flag" : Flagz.svk},
    {"iso3" : "svn", "flag" : Flagz.svn},
    {"iso3" : "slb", "flag" : Flagz.slb},
    {"iso3" : "som", "flag" : Flagz.som},
    {"iso3" : "zaf", "flag" : Flagz.zaf},
    {"iso3" : "sgs", "flag" : Flagz.sgs},
    {"iso3" : "ssd", "flag" : Flagz.ssd},
    {"iso3" : "esp", "flag" : Flagz.esp},
    {"iso3" : "lka", "flag" : Flagz.lka},
    {"iso3" : "sdn", "flag" : Flagz.sdn},
    {"iso3" : "sur", "flag" : Flagz.sur},
    {"iso3" : "sjm", "flag" : Flagz.sjm},
    {"iso3" : "swe", "flag" : Flagz.swe},
    {"iso3" : "che", "flag" : Flagz.che},
    {"iso3" : "syr", "flag" : Flagz.syr},
    {"iso3" : "twn", "flag" : Flagz.twn},
    {"iso3" : "tjk", "flag" : Flagz.tjk},
    {"iso3" : "tza", "flag" : Flagz.tza},
    {"iso3" : "tha", "flag" : Flagz.tha},
    {"iso3" : "tls", "flag" : Flagz.tls},
    {"iso3" : "tgo", "flag" : Flagz.tgo},
    {"iso3" : "tkl", "flag" : Flagz.tkl},
    {"iso3" : "ton", "flag" : Flagz.ton},
    {"iso3" : "tto", "flag" : Flagz.tto},
    {"iso3" : "tun", "flag" : Flagz.tun},
    {"iso3" : "tur", "flag" : Flagz.tur},
    {"iso3" : "tkm", "flag" : Flagz.tkm},
    {"iso3" : "tca", "flag" : Flagz.tca},
    {"iso3" : "tuv", "flag" : Flagz.tuv},
    {"iso3" : "uga", "flag" : Flagz.uga},
    {"iso3" : "ukr", "flag" : Flagz.ukr},
    {"iso3" : "are", "flag" : Flagz.are},
    {"iso3" : "gbr", "flag" : Flagz.gbr},
    {"iso3" : "usa", "flag" : Flagz.usa},
    {"iso3" : "umi", "flag" : Flagz.umi},
    {"iso3" : "ury", "flag" : Flagz.ury},
    {"iso3" : "uzb", "flag" : Flagz.uzb},
    {"iso3" : "vut", "flag" : Flagz.vut},
    {"iso3" : "ven", "flag" : Flagz.ven},
    {"iso3" : "vnm", "flag" : Flagz.vnm},
    {"iso3" : "vgb", "flag" : Flagz.vgb},
    {"iso3" : "vir", "flag" : Flagz.vir},
    {"iso3" : "wlf", "flag" : Flagz.wlf},
    {"iso3" : "esh", "flag" : Flagz.esh},
    {"iso3" : "yem", "flag" : Flagz.yem},
    {"iso3" : "zmb", "flag" : Flagz.zmb},
    {"iso3" : "zwe", "flag" : Flagz.zwe},
  ];

}