import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:flutter/foundation.dart';

class Flag {
  final String countryID;
  final String icon;

  const Flag({
    @required this.countryID,
    @required this.icon,
});
// -----------------------------------------------------------------------------
  static String getFlagIconByCountryID(String countryID) {

    String _flagIcon = Iconz.DvBlankSVG;

    if (countryID != null){
      final Flag _flag = allFlags.singleWhere((Flag flag) => flag.countryID == countryID, orElse: () => null);
      _flagIcon = _flag?.icon;
    }

    return _flagIcon;
  }
// -----------------------------------------------------------------------------
    static List<Flag> allFlags = const <Flag>[

    const Flag(countryID: 'ala', icon: _ala,),
    const Flag(countryID: 'alb', icon: _alb,),
    const Flag(countryID: 'dza', icon: _dza,),
    const Flag(countryID: 'asm', icon: _asm,),
    const Flag(countryID: 'and', icon: _and,),
    const Flag(countryID: 'ago', icon: _ago,),
    const Flag(countryID: 'aia', icon: _aia,),
    const Flag(countryID: 'atg', icon: _atg,),
    const Flag(countryID: 'arg', icon: _arg,),
    const Flag(countryID: 'arm', icon: _arm,),
    const Flag(countryID: 'abw', icon: _abw,),
    const Flag(countryID: 'aus', icon: _aus,),
    const Flag(countryID: 'aut', icon: _aut,),
    const Flag(countryID: 'aze', icon: _aze,),
    const Flag(countryID: 'bhs', icon: _bhs,),
    const Flag(countryID: 'bhr', icon: _bhr,),
    const Flag(countryID: 'bgd', icon: _bgd,),
    const Flag(countryID: 'brb', icon: _brb,),
    const Flag(countryID: 'blr', icon: _blr,),
    const Flag(countryID: 'bel', icon: _bel,),
    const Flag(countryID: 'blz', icon: _blz,),
    const Flag(countryID: 'ben', icon: _ben,),
    const Flag(countryID: 'bmu', icon: _bmu,),
    const Flag(countryID: 'btn', icon: _btn,),
    const Flag(countryID: 'bol', icon: _bol,),
    const Flag(countryID: 'bes', icon: _bes,),
    const Flag(countryID: 'bih', icon: _bih,),
    const Flag(countryID: 'bwa', icon: _bwa,),
    const Flag(countryID: 'bvt', icon: _bvt,),
    const Flag(countryID: 'bra', icon: _bra,),
    const Flag(countryID: 'iot', icon: _iot,),
    const Flag(countryID: 'brn', icon: _brn,),
    const Flag(countryID: 'bgr', icon: _bgr,),
    const Flag(countryID: 'bfa', icon: _bfa,),
    const Flag(countryID: 'bdi', icon: _bdi,),
    const Flag(countryID: 'cpv', icon: _cpv,),
    const Flag(countryID: 'khm', icon: _khm,),
    const Flag(countryID: 'cmr', icon: _cmr,),
    const Flag(countryID: 'can', icon: _can,),
    const Flag(countryID: 'cym', icon: _cym,),
    const Flag(countryID: 'caf', icon: _caf,),
    const Flag(countryID: 'tcd', icon: _tcd,),
    const Flag(countryID: 'chl', icon: _chl,),
    const Flag(countryID: 'chn', icon: _chn,),
    const Flag(countryID: 'cxr', icon: _cxr,),
    const Flag(countryID: 'cck', icon: _cck,),
    const Flag(countryID: 'col', icon: _col,),
    const Flag(countryID: 'com', icon: _com,),
    const Flag(countryID: 'cog', icon: _cog,),
    const Flag(countryID: 'cod', icon: _cod,),
    const Flag(countryID: 'cok', icon: _cok,),
    const Flag(countryID: 'cri', icon: _cri,),
    const Flag(countryID: 'civ', icon: _civ,),
    const Flag(countryID: 'hrv', icon: _hrv,),
    const Flag(countryID: 'cub', icon: _cub,),
    const Flag(countryID: 'cuw', icon: _cuw,),
    const Flag(countryID: 'cyp', icon: _cyp,),
    const Flag(countryID: 'cze', icon: _cze,),
    const Flag(countryID: 'dnk', icon: _dnk,),
    const Flag(countryID: 'dji', icon: _dji,),
    const Flag(countryID: 'dma', icon: _dma,),
    const Flag(countryID: 'dom', icon: _dom,),
    const Flag(countryID: 'ecu', icon: _ecu,),
    const Flag(countryID: 'egy', icon: _egy,),
    const Flag(countryID: 'slv', icon: _slv,),
    const Flag(countryID: 'gnq', icon: _gnq,),
    const Flag(countryID: 'eri', icon: _eri,),
    const Flag(countryID: 'est', icon: _est,),
    const Flag(countryID: 'swz', icon: _swz,),
    const Flag(countryID: 'eth', icon: _eth,),
    const Flag(countryID: 'flk', icon: _flk,),
    const Flag(countryID: 'fro', icon: _fro,),
    const Flag(countryID: 'fji', icon: _fji,),
    const Flag(countryID: 'fin', icon: _fin,),
    const Flag(countryID: 'fra', icon: _fra,),
    const Flag(countryID: 'guf', icon: _guf,),
    const Flag(countryID: 'pyf', icon: _pyf,),
    const Flag(countryID: 'atf', icon: _atf,),
    const Flag(countryID: 'gab', icon: _gab,),
    const Flag(countryID: 'gmb', icon: _gmb,),
    const Flag(countryID: 'geo', icon: _geo,),
    const Flag(countryID: 'deu', icon: _deu,),
    const Flag(countryID: 'gha', icon: _gha,),
    const Flag(countryID: 'gib', icon: _gib,),
    const Flag(countryID: 'grc', icon: _grc,),
    const Flag(countryID: 'grl', icon: _grl,),
    const Flag(countryID: 'grd', icon: _grd,),
    const Flag(countryID: 'glp', icon: _glp,),
    const Flag(countryID: 'gum', icon: _gum,),
    const Flag(countryID: 'gtm', icon: _gtm,),
    const Flag(countryID: 'ggy', icon: _ggy,),
    const Flag(countryID: 'gin', icon: _gin,),
    const Flag(countryID: 'gnb', icon: _gnb,),
    const Flag(countryID: 'guy', icon: _guy,),
    const Flag(countryID: 'hti', icon: _hti,),
    const Flag(countryID: 'hmd', icon: _hmd,),
    const Flag(countryID: 'vat', icon: _vat,),
    const Flag(countryID: 'hnd', icon: _hnd,),
    const Flag(countryID: 'hkg', icon: _hkg,),
    const Flag(countryID: 'hun', icon: _hun,),
    const Flag(countryID: 'isl', icon: _isl,),
    const Flag(countryID: 'ind', icon: _ind,),
    const Flag(countryID: 'idn', icon: _idn,),
    const Flag(countryID: 'irn', icon: _irn,),
    const Flag(countryID: 'irq', icon: _irq,),
    const Flag(countryID: 'irl', icon: _irl,),
    const Flag(countryID: 'imn', icon: _imn,),
    const Flag(countryID: 'isr', icon: _isr,),
    const Flag(countryID: 'ita', icon: _ita,),
    const Flag(countryID: 'jam', icon: _jam,),
    const Flag(countryID: 'jpn', icon: _jpn,),
    const Flag(countryID: 'jey', icon: _jey,),
    const Flag(countryID: 'jor', icon: _jor,),
    const Flag(countryID: 'kaz', icon: _kaz,),
    const Flag(countryID: 'ken', icon: _ken,),
    const Flag(countryID: 'kir', icon: _kir,),
    const Flag(countryID: 'prk', icon: _prk,),
    const Flag(countryID: 'kor', icon: _kor,),
    const Flag(countryID: 'kwt', icon: _kwt,),
    const Flag(countryID: 'kgz', icon: _kgz,),
    const Flag(countryID: 'lao', icon: _lao,),
    const Flag(countryID: 'lva', icon: _lva,),
    const Flag(countryID: 'lbn', icon: _lbn,),
    const Flag(countryID: 'lso', icon: _lso,),
    const Flag(countryID: 'lbr', icon: _lbr,),
    const Flag(countryID: 'lby', icon: _lby,),
    const Flag(countryID: 'lie', icon: _lie,),
    const Flag(countryID: 'ltu', icon: _ltu,),
    const Flag(countryID: 'lux', icon: _lux,),
    const Flag(countryID: 'mac', icon: _mac,),
    const Flag(countryID: 'mdg', icon: _mdg,),
    const Flag(countryID: 'mwi', icon: _mwi,),
    const Flag(countryID: 'mys', icon: _mys,),
    const Flag(countryID: 'mdv', icon: _mdv,),
    const Flag(countryID: 'mli', icon: _mli,),
    const Flag(countryID: 'mlt', icon: _mlt,),
    const Flag(countryID: 'mhl', icon: _mhl,),
    const Flag(countryID: 'mtq', icon: _mtq,),
    const Flag(countryID: 'mrt', icon: _mrt,),
    const Flag(countryID: 'mus', icon: _mus,),
    const Flag(countryID: 'myt', icon: _myt,),
    const Flag(countryID: 'mex', icon: _mex,),
    const Flag(countryID: 'fsm', icon: _fsm,),
    const Flag(countryID: 'mda', icon: _mda,),
    const Flag(countryID: 'mco', icon: _mco,),
    const Flag(countryID: 'mng', icon: _mng,),
    const Flag(countryID: 'mne', icon: _mne,),
    const Flag(countryID: 'msr', icon: _msr,),
    const Flag(countryID: 'mar', icon: _mar,),
    const Flag(countryID: 'moz', icon: _moz,),
    const Flag(countryID: 'mmr', icon: _mmr,),
    const Flag(countryID: 'nam', icon: _nam,),
    const Flag(countryID: 'nru', icon: _nru,),
    const Flag(countryID: 'npl', icon: _npl,),
    const Flag(countryID: 'nld', icon: _nld,),
    const Flag(countryID: 'ncl', icon: _ncl,),
    const Flag(countryID: 'nzl', icon: _nzl,),
    const Flag(countryID: 'nic', icon: _nic,),
    const Flag(countryID: 'ner', icon: _ner,),
    const Flag(countryID: 'nga', icon: _nga,),
    const Flag(countryID: 'niu', icon: _niu,),
    const Flag(countryID: 'nfk', icon: _nfk,),
    const Flag(countryID: 'mkd', icon: _mkd,),
    const Flag(countryID: 'mnp', icon: _mnp,),
    const Flag(countryID: 'nor', icon: _nor,),
    const Flag(countryID: 'omn', icon: _omn,),
    const Flag(countryID: 'pak', icon: _pak,),
    const Flag(countryID: 'plw', icon: _plw,),
    const Flag(countryID: 'pse', icon: _pse,),
    const Flag(countryID: 'pan', icon: _pan,),
    const Flag(countryID: 'png', icon: _png,),
    const Flag(countryID: 'pry', icon: _pry,),
    const Flag(countryID: 'per', icon: _per,),
    const Flag(countryID: 'phl', icon: _phl,),
    const Flag(countryID: 'pcn', icon: _pcn,),
    const Flag(countryID: 'pol', icon: _pol,),
    const Flag(countryID: 'prt', icon: _prt,),
    const Flag(countryID: 'pri', icon: _pri,),
    const Flag(countryID: 'qat', icon: _qat,),
    const Flag(countryID: 'reu', icon: _reu,),
    const Flag(countryID: 'rou', icon: _rou,),
    const Flag(countryID: 'rus', icon: _rus,),
    const Flag(countryID: 'rwa', icon: _rwa,),
    const Flag(countryID: 'blm', icon: _blm,),
    const Flag(countryID: 'shn', icon: _shn,),
    const Flag(countryID: 'kna', icon: _kna,),
    const Flag(countryID: 'lca', icon: _lca,),
    const Flag(countryID: 'maf', icon: _maf,),
    const Flag(countryID: 'spm', icon: _spm,),
    const Flag(countryID: 'vct', icon: _vct,),
    const Flag(countryID: 'wsm', icon: _wsm,),
    const Flag(countryID: 'smr', icon: _smr,),
    const Flag(countryID: 'stp', icon: _stp,),
    const Flag(countryID: 'sau', icon: _sau,),
    const Flag(countryID: 'sen', icon: _sen,),
    const Flag(countryID: 'srb', icon: _srb,),
    const Flag(countryID: 'syc', icon: _syc,),
    const Flag(countryID: 'sle', icon: _sle,),
    const Flag(countryID: 'sgp', icon: _sgp,),
    const Flag(countryID: 'sxm', icon: _sxm,),
    const Flag(countryID: 'svk', icon: _svk,),
    const Flag(countryID: 'svn', icon: _svn,),
    const Flag(countryID: 'slb', icon: _slb,),
    const Flag(countryID: 'som', icon: _som,),
    const Flag(countryID: 'zaf', icon: _zaf,),
    const Flag(countryID: 'sgs', icon: _sgs,),
    const Flag(countryID: 'ssd', icon: _ssd,),
    const Flag(countryID: 'esp', icon: _esp,),
    const Flag(countryID: 'lka', icon: _lka,),
    const Flag(countryID: 'sdn', icon: _sdn,),
    const Flag(countryID: 'sur', icon: _sur,),
    const Flag(countryID: 'sjm', icon: _sjm,),
    const Flag(countryID: 'swe', icon: _swe,),
    const Flag(countryID: 'che', icon: _che,),
    const Flag(countryID: 'syr', icon: _syr,),
    const Flag(countryID: 'twn', icon: _twn,),
    const Flag(countryID: 'tjk', icon: _tjk,),
    const Flag(countryID: 'tza', icon: _tza,),
    const Flag(countryID: 'tha', icon: _tha,),
    const Flag(countryID: 'tls', icon: _tls,),
    const Flag(countryID: 'tgo', icon: _tgo,),
    const Flag(countryID: 'tkl', icon: _tkl,),
    const Flag(countryID: 'ton', icon: _ton,),
    const Flag(countryID: 'tto', icon: _tto,),
    const Flag(countryID: 'tun', icon: _tun,),
    const Flag(countryID: 'tur', icon: _tur,),
    const Flag(countryID: 'tkm', icon: _tkm,),
    const Flag(countryID: 'tca', icon: _tca,),
    const Flag(countryID: 'tuv', icon: _tuv,),
    const Flag(countryID: 'uga', icon: _uga,),
    const Flag(countryID: 'ukr', icon: _ukr,),
    const Flag(countryID: 'are', icon: _are,),
    const Flag(countryID: 'gbr', icon: _gbr,),
    const Flag(countryID: 'usa', icon: _usa,),
    const Flag(countryID: 'umi', icon: _umi,),
    const Flag(countryID: 'ury', icon: _ury,),
    const Flag(countryID: 'uzb', icon: _uzb,),
    const Flag(countryID: 'vut', icon: _vut,),
    const Flag(countryID: 'ven', icon: _ven,),
    const Flag(countryID: 'vnm', icon: _vnm,),
    const Flag(countryID: 'vgb', icon: _vgb,),
    const Flag(countryID: 'vir', icon: _vir,),
    const Flag(countryID: 'wlf', icon: _wlf,),
    const Flag(countryID: 'esh', icon: _esh,),
    const Flag(countryID: 'yem', icon: _yem,),
    const Flag(countryID: 'zmb', icon: _zmb,),
    const Flag(countryID: 'zwe', icon: _zwe,),
    const Flag(countryID: 'euz', icon: _euz,),
    const Flag(countryID: 'xks', icon: _xks,),
    const Flag(countryID: 'afg', icon: _afg,),

  ];
// -----------------------------------------------------------------------------
  static const String _flagsPath = "assets/icons/flags/";
  static const String _afg = _flagsPath + "flag_as_s_afghanistan.svg" ;
  static const String _ala = _flagsPath + "flag_eu_n_aland_islands.svg" ;
  static const String _alb = _flagsPath + "flag_eu_s_albania.svg" ;
  static const String _dza = _flagsPath + "flag_af_n_algeria.svg" ;
  static const String _asm = _flagsPath + "flag_oc_poly_american_samoa.svg" ;
  static const String _and = _flagsPath + "flag_eu_s_andorra.svg" ;
  static const String _ago = _flagsPath + "flag_af_m_angola.svg" ;
  static const String _aia = _flagsPath + "flag_na_cr_anguilla.svg" ;
  static const String _atg = _flagsPath + "flag_na_cr_antigua_and_barbuda.svg" ;
  static const String _arg = _flagsPath + "flag_sa_argentina.svg" ;
  static const String _arm = _flagsPath + "flag_as_w_armenia.svg" ;
  static const String _abw = _flagsPath + "flag_na_cr_aruba.svg" ;
  static const String _aus = _flagsPath + "flag_az_flag_australia.svg" ;
  static const String _aut = _flagsPath + "flag_eu_w_austria.svg" ;
  static const String _aze = _flagsPath + "flag_as_w_azerbaijan.svg" ;
  static const String _bhs = _flagsPath + "flag_na_cr_bahamas.svg" ;
  static const String _bhr = _flagsPath + "flag_as_w_bahrain.svg" ;
  static const String _bgd = _flagsPath + "flag_as_s_bangladesh.svg" ;
  static const String _brb = _flagsPath + "flag_na_cr_barbados.svg" ;
  static const String _blr = _flagsPath + "flag_eu_e_belarus.svg" ;
  static const String _bel = _flagsPath + "flag_eu_w_belgium.svg" ;
  static const String _blz = _flagsPath + "flag_na_c_belize.svg" ;
  static const String _ben = _flagsPath + "flag_af_w_benin.svg" ;
  static const String _bmu = _flagsPath + "flag_na_n_bermuda.svg" ;
  static const String _btn = _flagsPath + "flag_as_s_bhutan.svg" ;
  static const String _bol = _flagsPath + "flag_sa_bolivia.svg" ;
  static const String _bes = _flagsPath + "flag_na_cr_bonaire.svg" ;
  static const String _bih = _flagsPath + "flag_eu_s_bosnia_and_herzegovina.svg" ;
  static const String _bwa = _flagsPath + "flag_af_s_botswana.svg" ;
  static const String _bvt = _flagsPath + "flag_eu_n_norway.svg" ;
  static const String _bra = _flagsPath + "flag_sa_brazil.svg" ;
  static const String _iot = _flagsPath + "flag_na_cr_british_indian_ocean_territory.svg" ;
  static const String _brn = _flagsPath + "flag_as_se_brunei.svg" ;
  static const String _bgr = _flagsPath + "flag_eu_e_bulgaria.svg" ;
  static const String _bfa = _flagsPath + "flag_af_w_burkina_faso.svg" ;
  static const String _bdi = _flagsPath + "flag_af_w_burundi.svg" ;
  static const String _cpv = _flagsPath + "flag_af_w_cape_verde.svg" ;
  static const String _khm = _flagsPath + "flag_as_se_cambodia.svg" ;
  static const String _cmr = _flagsPath + "flag_af_m_cameroon.svg" ;
  static const String _can = _flagsPath + "flag_na_n_canada.svg" ;
  static const String _cym = _flagsPath + "flag_na_cr_cayman_islands.svg" ;
  static const String _caf = _flagsPath + "flag_af_m_central_african_republic.svg" ;
  static const String _tcd = _flagsPath + "flag_af_m_chad.svg" ;
  static const String _chl = _flagsPath + "flag_sa_chile.svg" ;
  static const String _chn = _flagsPath + "flag_as_e_china.svg" ;
  static const String _cxr = _flagsPath + "flag_az_christmas_island.svg" ;
  static const String _cck = _flagsPath + "flag_az_cocos_island.svg" ;
  static const String _col = _flagsPath + "flag_sa_colombia.svg" ;
  static const String _com = _flagsPath + "flag_af_e_comoros.svg" ;
  static const String _cog = _flagsPath + "flag_af_m_congo.svg" ;
  static const String _cod = _flagsPath + "flag_af_m_congo2.svg" ;
  static const String _cok = _flagsPath + "flag_oc_poly_cook_islands.svg" ;
  static const String _cri = _flagsPath + "flag_sa_costa_rica.svg" ;
  static const String _civ = _flagsPath + "flag_af_w_cote_divoire.svg" ;
  static const String _hrv = _flagsPath + "flag_eu_s_croatia.svg" ;
  static const String _cub = _flagsPath + "flag_na_cr_cuba.svg" ;
  static const String _cuw = _flagsPath + "flag_na_cr_curacao.svg" ;
  static const String _cyp = _flagsPath + "flag_as_w_cyprus.svg" ;
  static const String _cze = _flagsPath + "flag_eu_e_czech_republic.svg" ;
  static const String _dnk = _flagsPath + "flag_eu_n_denmark.svg" ;
  static const String _dji = _flagsPath + "flag_af_e_djibouti.svg" ;
  static const String _dma = _flagsPath + "flag_na_cr_dominica.svg" ;
  static const String _dom = _flagsPath + "flag_na_cr_dominican_republic.svg" ;
  static const String _ecu = _flagsPath + "flag_sa_ecuador.svg" ;
  static const String _egy = _flagsPath + "flag_af_n_egypt.svg" ;
  static const String _slv = _flagsPath + "flag_na_c_el_salvador.svg" ;
  static const String _gnq = _flagsPath + "flag_af_m_equatorial_guinea.svg" ;
  static const String _eri = _flagsPath + "flag_af_e_eritrea.svg" ;
  static const String _est = _flagsPath + "flag_eu_n_estonia.svg" ;
  static const String _swz = _flagsPath + "flag_af_s_swaziland.svg" ;
  static const String _eth = _flagsPath + "flag_af_e_ethiopia.svg" ;
  static const String _flk = _flagsPath + "flag_sa_falkland_islands.svg" ;
  static const String _fro = _flagsPath + "flag_eu_n_faroe_islands.svg" ;
  static const String _fji = _flagsPath + "flag_oc_melan_fiji.svg" ;
  static const String _fin = _flagsPath + "flag_eu_n_finland.svg" ;
  static const String _fra = _flagsPath + "flag_eu_w_france.svg" ;
  static const String _guf = _flagsPath + "flag_sa_french_guiana.svg" ;
  static const String _pyf = _flagsPath + "flag_oc_poly_french_polynesia.svg" ;
  static const String _atf = _flagsPath + "flag_eu_w_france.svg" ;
  static const String _gab = _flagsPath + "flag_af_m_gabon.svg" ;
  static const String _gmb = _flagsPath + "flag_af_w_gambia.svg" ;
  static const String _geo = _flagsPath + "flag_as_w_georgia.svg" ;
  static const String _deu = _flagsPath + "flag_eu_w_germany.svg" ;
  static const String _gha = _flagsPath + "flag_af_w_ghana.svg" ;
  static const String _gib = _flagsPath + "flag_eu_s_gibraltar.svg" ;
  static const String _grc = _flagsPath + "flag_eu_s_greece.svg" ;
  static const String _grl = _flagsPath + "flag_na_n_greenland.svg" ;
  static const String _grd = _flagsPath + "flag_na_cr_grenada.svg" ;
  static const String _glp = _flagsPath + "flag_na_cr_guadeloupe.svg" ;
  static const String _gum = _flagsPath + "flag_oc_micro_guam.svg" ;
  static const String _gtm = _flagsPath + "flag_na_c_guatemala.svg" ;
  static const String _ggy = _flagsPath + "flag_eu_n_guernsey.svg" ;
  static const String _gin = _flagsPath + "flag_af_w_guinea.svg" ;
  static const String _gnb = _flagsPath + "flag_af_w_guinea_bissau.svg" ;
  static const String _guy = _flagsPath + "flag_sa_guyana.svg" ;
  static const String _hti = _flagsPath + "flag_na_cr_haiti.svg" ;
  static const String _hmd = _flagsPath + "flag_az_flag_australia.svg" ;
  static const String _vat = _flagsPath + "flag_eu_w_vatican_city.svg" ;
  static const String _hnd = _flagsPath + "flag_na_c_honduras.svg" ;
  static const String _hkg = _flagsPath + "flag_as_e_hong_kong.svg" ;
  static const String _hun = _flagsPath + "flag_eu_e_hungary.svg" ;
  static const String _isl = _flagsPath + "flag_eu_n_iceland.svg" ;
  static const String _ind = _flagsPath + "flag_as_s_india.svg" ;
  static const String _idn = _flagsPath + "flag_as_se_indonesia.svg" ;
  static const String _irn = _flagsPath + "flag_as_s_iran.svg" ;
  static const String _irq = _flagsPath + "flag_as_w_iraq.svg" ;
  static const String _irl = _flagsPath + "flag_eu_n_ireland.svg" ;
  static const String _imn = _flagsPath + "flag_eu_n_isle_of_man.svg" ;
  static const String _isr = _flagsPath + "flag_as_w_israel.svg" ;
  static const String _ita = _flagsPath + "flag_eu_s_italy.svg" ;
  static const String _jam = _flagsPath + "flag_na_cr_jamaica.svg" ;
  static const String _jpn = _flagsPath + "flag_as_e_japan.svg" ;
  static const String _jey = _flagsPath + "flag_eu_n_jersey.svg" ;
  static const String _jor = _flagsPath + "flag_as_w_jordan.svg" ;
  static const String _kaz = _flagsPath + "flag_as_c_kazakhstan.svg" ;
  static const String _ken = _flagsPath + "flag_af_e_kenya.svg" ;
  static const String _kir = _flagsPath + "flag_oc_micro_kiribati.svg" ;
  static const String _prk = _flagsPath + "flag_as_e_north_korea.svg" ;
  static const String _kor = _flagsPath + "flag_as_e_south_korea.svg" ;
  static const String _kwt = _flagsPath + "flag_as_w_kuwait.svg" ;
  static const String _kgz = _flagsPath + "flag_as_c_kyrgyzstan.svg" ;
  static const String _lao = _flagsPath + "flag_as_se_laos.svg" ;
  static const String _lva = _flagsPath + "flag_eu_n_latvia.svg" ;
  static const String _lbn = _flagsPath + "flag_as_w_lebanon.svg" ;
  static const String _lso = _flagsPath + "flag_af_s_lesotho.svg" ;
  static const String _lbr = _flagsPath + "flag_af_w_liberia.svg" ;
  static const String _lby = _flagsPath + "flag_af_n_libya.svg" ;
  static const String _lie = _flagsPath + "flag_eu_w_liechtenstein.svg" ;
  static const String _ltu = _flagsPath + "flag_eu_n_lithuania.svg" ;
  static const String _lux = _flagsPath + "flag_eu_w_luxembourg.svg" ;
  static const String _mac = _flagsPath + "flag_as_e_macao.svg" ;
  static const String _mdg = _flagsPath + "flag_af_e_madagascar.svg" ;
  static const String _mwi = _flagsPath + "flag_af_e_malawi.svg" ;
  static const String _mys = _flagsPath + "flag_as_se_malaysia.svg" ;
  static const String _mdv = _flagsPath + "flag_as_s_maldives.svg" ;
  static const String _mli = _flagsPath + "flag_af_w_mali.svg" ;
  static const String _mlt = _flagsPath + "flag_eu_s_malta.svg" ;
  static const String _mhl = _flagsPath + "flag_oc_micro_marshall_island.svg" ;
  static const String _mtq = _flagsPath + "flag_na_cr_martinique.svg" ;
  static const String _mrt = _flagsPath + "flag_af_w_mauritania.svg" ;
  static const String _mus = _flagsPath + "flag_af_e_mauritius.svg" ;
  static const String _myt = _flagsPath + "flag_af_e_mayotte.svg" ;
  static const String _mex = _flagsPath + "flag_na_c_mexico.svg" ;
  static const String _fsm = _flagsPath + "flag_oc_micro_micronesia.svg" ;
  static const String _mda = _flagsPath + "flag_eu_e_moldova.svg" ;
  static const String _mco = _flagsPath + "flag_eu_w_monaco.svg" ;
  static const String _mng = _flagsPath + "flag_as_e_mongolia.svg" ;
  static const String _mne = _flagsPath + "flag_eu_s_montenegro.svg" ;
  static const String _msr = _flagsPath + "flag_na_cr_montserrat.svg" ;
  static const String _mar = _flagsPath + "flag_af_n_morocco.svg" ;
  static const String _moz = _flagsPath + "flag_af_e_mozambique.svg" ;
  static const String _mmr = _flagsPath + "flag_as_se_myanmar.svg" ;
  static const String _nam = _flagsPath + "flag_af_s_namibia.svg" ;
  static const String _nru = _flagsPath + "flag_oc_micro_nauru.svg" ;
  static const String _npl = _flagsPath + "flag_as_s_nepal.svg" ;
  static const String _nld = _flagsPath + "flag_eu_w_netherlands.svg" ;
  static const String _ncl = _flagsPath + "flag_eu_w_france.svg" ;
  static const String _nzl = _flagsPath + "flag_az_new_zealand.svg" ;
  static const String _nic = _flagsPath + "flag_na_c_nicaragua.svg" ;
  static const String _ner = _flagsPath + "flag_af_w_niger.svg" ;
  static const String _nga = _flagsPath + "flag_af_w_nigeria.svg" ;
  static const String _niu = _flagsPath + "flag_oc_poly_niue.svg" ;
  static const String _nfk = _flagsPath + "flag_az_norfolk_island.svg" ;
  static const String _mkd = _flagsPath + "flag_eu_s_macedonia.svg" ;
  static const String _mnp = _flagsPath + "flag_oc_micro_northern_marianas_islands.svg" ;
  static const String _nor = _flagsPath + "flag_eu_n_norway.svg" ;
  static const String _omn = _flagsPath + "flag_as_w_oman.svg" ;
  static const String _pak = _flagsPath + "flag_as_s_pakistan.svg" ;
  static const String _plw = _flagsPath + "flag_oc_micro_palau.svg" ;
  static const String _pse = _flagsPath + "flag_as_w_palestine.svg" ;
  static const String _pan = _flagsPath + "flag_na_c_panama.svg" ;
  static const String _png = _flagsPath + "flag_oc_melan_papua_new_guinea.svg" ;
  static const String _pry = _flagsPath + "flag_sa_paraguay.svg" ;
  static const String _per = _flagsPath + "flag_sa_peru.svg" ;
  static const String _phl = _flagsPath + "flag_as_se_philippines.svg" ;
  static const String _pcn = _flagsPath + "flag_oc_poly_pitcairn_islands.svg" ;
  static const String _pol = _flagsPath + "flag_eu_e_poland.svg" ;
  static const String _prt = _flagsPath + "flag_eu_s_portugal.svg" ;
  static const String _pri = _flagsPath + "flag_na_cr_puerto_rico.svg" ;
  static const String _qat = _flagsPath + "flag_as_w_qatar.svg" ;
  static const String _reu = _flagsPath + "flag_af_e_reunion.svg" ;
  static const String _rou = _flagsPath + "flag_eu_e_romania.svg" ;
  static const String _rus = _flagsPath + "flag_eu_e_russia.svg" ;
  static const String _rwa = _flagsPath + "flag_af_e_rwanda.svg" ;
  static const String _blm = _flagsPath + "flag_na_cr_saint_barthelemy.svg" ;
  static const String _shn = _flagsPath + "flag_af_w_saint_helena.svg" ;
  static const String _kna = _flagsPath + "flag_na_cr_saint_kitts_and_nevis.svg" ;
  static const String _lca = _flagsPath + "flag_na_cr_saint_lucia.svg" ;
  static const String _maf = _flagsPath + "flag_eu_w_france.svg" ;
  static const String _spm = _flagsPath + "flag_na_n_saint_pierre_and_miquelon.svg" ;
  static const String _vct = _flagsPath + "flag_na_cr_saint_vincent_and_the_grenadines.svg" ;
  static const String _wsm = _flagsPath + "flag_oc_poly_samoa.svg" ;
  static const String _smr = _flagsPath + "flag_eu_s_san_marino.svg" ;
  static const String _stp = _flagsPath + "flag_af_m_sao_tome_and_principe.svg" ;
  static const String _sau = _flagsPath + "flag_as_w_saudi_arabia.svg" ;
  static const String _sen = _flagsPath + "flag_af_w_senegal.svg" ;
  static const String _srb = _flagsPath + "flag_eu_s_serbia.svg" ;
  static const String _syc = _flagsPath + "flag_af_e_seychelles.svg" ;
  static const String _sle = _flagsPath + "flag_af_w_sierra_leone.svg" ;
  static const String _sgp = _flagsPath + "flag_as_se_singapore.svg" ;
  static const String _sxm = _flagsPath + "flag_na_cr_sint maarten.svg" ;
  static const String _svk = _flagsPath + "flag_eu_e_slovakia.svg" ;
  static const String _svn = _flagsPath + "flag_eu_s_slovenia.svg" ;
  static const String _slb = _flagsPath + "flag_oc_melan_solomon_islands.svg" ;
  static const String _som = _flagsPath + "flag_af_e_somalia.svg" ;
  static const String _zaf = _flagsPath + "flag_af_s_south_africa.svg" ;
  static const String _sgs = _flagsPath + "flag_sa_south_georgia.svg" ;
  static const String _ssd = _flagsPath + "flag_af_e_south_sudan.svg" ;
  static const String _esp = _flagsPath + "flag_eu_s_spain.svg" ;
  static const String _lka = _flagsPath + "flag_as_s_sri_lanka.svg" ;
  static const String _sdn = _flagsPath + "flag_af_e_sudan.svg" ;
  static const String _sur = _flagsPath + "flag_sa_suriname.svg" ;
  static const String _sjm = _flagsPath + "flag_eu_n_svalbard_and_jan_mayen_islands.svg" ;
  static const String _swe = _flagsPath + "flag_eu_n_sweden.svg" ;
  static const String _che = _flagsPath + "flag_eu_w_switzerland.svg" ;
  static const String _syr = _flagsPath + "flag_as_w_syria.svg" ;
  static const String _twn = _flagsPath + "flag_as_e_taiwan.svg" ;
  static const String _tjk = _flagsPath + "flag_as_c_tajikistan.svg" ;
  static const String _tza = _flagsPath + "flag_af_e_tanzania.svg" ;
  static const String _tha = _flagsPath + "flag_as_se_thailand.svg" ;
  static const String _tls = _flagsPath + "flag_as_se_timor_leste.svg" ;
  static const String _tgo = _flagsPath + "flag_af_w_togo.svg" ;
  static const String _tkl = _flagsPath + "flag_oc_poly_tokelau.svg" ;
  static const String _ton = _flagsPath + "flag_oc_poly_tonga.svg" ;
  static const String _tto = _flagsPath + "flag_na_cr_trinidad_and_tobago.svg" ;
  static const String _tun = _flagsPath + "flag_af_n_tunisia.svg" ;
  static const String _tur = _flagsPath + "flag_as_w_turkey.svg" ;
  static const String _tkm = _flagsPath + "flag_as_c_turkmenistan.svg" ;
  static const String _tca = _flagsPath + "flag_na_cr_turks_and_caicos.svg" ;
  static const String _tuv = _flagsPath + "flag_oc_poly_tuvalu.svg" ;
  static const String _uga = _flagsPath + "flag_af_e_uganda.svg" ;
  static const String _ukr = _flagsPath + "flag_eu_e_ukraine.svg" ;
  static const String _are = _flagsPath + "flag_as_w_uae.svg" ;
  static const String _gbr = _flagsPath + "flag_eu_n_united_kingdom.svg" ;
  static const String _usa = _flagsPath + "flag_na_usa.svg" ;
  static const String _umi = _flagsPath + "flag_na_usa.svg" ;
  static const String _ury = _flagsPath + "flag_sa_uruguay.svg" ;
  static const String _uzb = _flagsPath + "flag_as_c_uzbekistn.svg" ;
  static const String _vut = _flagsPath + "flag_oc_melan_vanuatu.svg" ;
  static const String _ven = _flagsPath + "flag_sa_venezuela.svg" ;
  static const String _vnm = _flagsPath + "flag_as_se_vietnam.svg" ;
  static const String _vgb = _flagsPath + "flag_na_cr_british_virgin_islands.svg" ;
  static const String _vir = _flagsPath + "flag_na_cr_virgin_islands.svg" ;
  static const String _wlf = _flagsPath + "flag_eu_w_france.svg" ;
  static const String _esh = _flagsPath + "flag_af_n_western_sahara.svg" ;
  static const String _yem = _flagsPath + "flag_as_w_yemen.svg" ;
  static const String _zmb = _flagsPath + "flag_af_e_zambia.svg" ;
  static const String _zwe = _flagsPath + "flag_af_e_zimbabwe.svg" ;
  static const String _euz = _flagsPath + "flag_eu_euro.svg" ;
  static const String _xks = _flagsPath + "flag_eu_s_kosovo.svg";
// -----------------------------------------------------------------------------

}

class CountryIso{
  final String countryID;
  final String iso;

  const CountryIso({
    @required this.countryID,
    @required this.iso,
});
// -----------------------------------------------------------------------------
  static String getCountryIDByIso(String iso){
    final CountryIso _countryIso = _allCountriesIsoCodes.firstWhere((CountryIso countryIso) => countryIso.iso == iso?.toLowerCase());

    if (_countryIso == null){
      return null;
    }
    else {
      return _countryIso.countryID;
    }
  }

// -----------------------------------------------------------------------------
  static const List<CountryIso> _allCountriesIsoCodes = const <CountryIso>[
    const CountryIso(countryID: 'afg', iso: 'af',),
    const CountryIso(countryID: 'alb', iso: 'al',),
    const CountryIso(countryID: 'dza', iso: 'dz',),
    const CountryIso(countryID: 'asm', iso: 'as',),
    const CountryIso(countryID: 'and', iso: 'ad',),
    const CountryIso(countryID: 'ago', iso: 'ao',),
    const CountryIso(countryID: 'atg', iso: 'ag',),
    const CountryIso(countryID: 'arg', iso: 'ar',),
    const CountryIso(countryID: 'arm', iso: 'am',),
    const CountryIso(countryID: 'abw', iso: 'aw',),
    const CountryIso(countryID: 'aus', iso: 'au',),
    const CountryIso(countryID: 'aut', iso: 'at',),
    const CountryIso(countryID: 'aze', iso: 'az',),
    const CountryIso(countryID: 'bhs', iso: 'bs',),
    const CountryIso(countryID: 'bhr', iso: 'bh',),
    const CountryIso(countryID: 'bgd', iso: 'bd',),
    const CountryIso(countryID: 'brb', iso: 'bb',),
    const CountryIso(countryID: 'blr', iso: 'by',),
    const CountryIso(countryID: 'bel', iso: 'be',),
    const CountryIso(countryID: 'blz', iso: 'bz',),
    const CountryIso(countryID: 'ben', iso: 'bj',),
    const CountryIso(countryID: 'bmu', iso: 'bm',),
    const CountryIso(countryID: 'btn', iso: 'bt',),
    const CountryIso(countryID: 'bol', iso: 'bo',),
    const CountryIso(countryID: 'bih', iso: 'ba',),
    const CountryIso(countryID: 'bwa', iso: 'bw',),
    const CountryIso(countryID: 'bra', iso: 'br',),
    const CountryIso(countryID: 'brn', iso: 'bn',),
    const CountryIso(countryID: 'bgr', iso: 'bg',),
    const CountryIso(countryID: 'bfa', iso: 'bf',),
    const CountryIso(countryID: 'mmr', iso: 'mm',),
    const CountryIso(countryID: 'bdi', iso: 'bi',),
    const CountryIso(countryID: 'cpv', iso: 'cv',),
    const CountryIso(countryID: 'khm', iso: 'kh',),
    const CountryIso(countryID: 'cmr', iso: 'cm',),
    const CountryIso(countryID: 'can', iso: 'ca',),
    const CountryIso(countryID: 'cym', iso: 'ky',),
    const CountryIso(countryID: 'caf', iso: 'cf',),
    const CountryIso(countryID: 'tcd', iso: 'td',),
    const CountryIso(countryID: 'chl', iso: 'cl',),
    const CountryIso(countryID: 'chn', iso: 'cn',),
    const CountryIso(countryID: 'col', iso: 'co',),
    const CountryIso(countryID: 'com', iso: 'km',),
    const CountryIso(countryID: 'cog', iso: 'cg',),
    const CountryIso(countryID: 'cod', iso: 'cd',),
    const CountryIso(countryID: 'cok', iso: 'ck',),
    const CountryIso(countryID: 'cri', iso: 'cr',),
    const CountryIso(countryID: 'civ', iso: 'ci',),
    const CountryIso(countryID: 'hrv', iso: 'hr',),
    const CountryIso(countryID: 'cub', iso: 'cu',),
    const CountryIso(countryID: 'cuw', iso: 'cw',),
    const CountryIso(countryID: 'cyp', iso: 'cy',),
    const CountryIso(countryID: 'cze', iso: 'cz',),
    const CountryIso(countryID: 'dnk', iso: 'dk',),
    const CountryIso(countryID: 'dji', iso: 'dj',),
    const CountryIso(countryID: 'dma', iso: 'dm',),
    const CountryIso(countryID: 'dom', iso: 'do',),
    const CountryIso(countryID: 'ecu', iso: 'ec',),
    const CountryIso(countryID: 'egy', iso: 'eg',),
    const CountryIso(countryID: 'slv', iso: 'sv',),
    const CountryIso(countryID: 'gnq', iso: 'gq',),
    const CountryIso(countryID: 'eri', iso: 'er',),
    const CountryIso(countryID: 'est', iso: 'ee',),
    const CountryIso(countryID: 'eth', iso: 'et',),
    const CountryIso(countryID: 'flk', iso: 'fk',),
    const CountryIso(countryID: 'fro', iso: 'fo',),
    const CountryIso(countryID: 'fji', iso: 'fj',),
    const CountryIso(countryID: 'fin', iso: 'fi',),
    const CountryIso(countryID: 'fra', iso: 'fr',),
    const CountryIso(countryID: 'guf', iso: 'gf',),
    const CountryIso(countryID: 'pyf', iso: 'pf',),
    const CountryIso(countryID: 'gab', iso: 'ga',),
    const CountryIso(countryID: 'gmb', iso: 'gm',),
    const CountryIso(countryID: 'geo', iso: 'ge',),
    const CountryIso(countryID: 'deu', iso: 'de',),
    const CountryIso(countryID: 'gha', iso: 'gh',),
    const CountryIso(countryID: 'gib', iso: 'gi',),
    const CountryIso(countryID: 'grc', iso: 'gr',),
    const CountryIso(countryID: 'grl', iso: 'gl',),
    const CountryIso(countryID: 'grd', iso: 'gd',),
    const CountryIso(countryID: 'glp', iso: 'gp',),
    const CountryIso(countryID: 'gum', iso: 'gu',),
    const CountryIso(countryID: 'gtm', iso: 'gt',),
    const CountryIso(countryID: 'gin', iso: 'gn',),
    const CountryIso(countryID: 'gnb', iso: 'gw',),
    const CountryIso(countryID: 'guy', iso: 'gy',),
    const CountryIso(countryID: 'hti', iso: 'ht',),
    const CountryIso(countryID: 'hnd', iso: 'hn',),
    const CountryIso(countryID: 'hkg', iso: 'hk',),
    const CountryIso(countryID: 'hun', iso: 'hu',),
    const CountryIso(countryID: 'isl', iso: 'is',),
    const CountryIso(countryID: 'ind', iso: 'in',),
    const CountryIso(countryID: 'idn', iso: 'id',),
    const CountryIso(countryID: 'irn', iso: 'ir',),
    const CountryIso(countryID: 'irq', iso: 'iq',),
    const CountryIso(countryID: 'irl', iso: 'ie',),
    const CountryIso(countryID: 'imn', iso: 'im',),
    const CountryIso(countryID: 'isr', iso: 'il',),
    const CountryIso(countryID: 'ita', iso: 'it',),
    const CountryIso(countryID: 'jam', iso: 'jm',),
    const CountryIso(countryID: 'jpn', iso: 'jp',),
    const CountryIso(countryID: 'jey', iso: 'je',),
    const CountryIso(countryID: 'jor', iso: 'jo',),
    const CountryIso(countryID: 'kaz', iso: 'kz',),
    const CountryIso(countryID: 'ken', iso: 'ke',),
    const CountryIso(countryID: 'kir', iso: 'ki',),
    const CountryIso(countryID: 'prk', iso: 'kp',),
    const CountryIso(countryID: 'kor', iso: 'kr',),
    const CountryIso(countryID: 'xks', iso: 'xk',),
    const CountryIso(countryID: 'kwt', iso: 'kw',),
    const CountryIso(countryID: 'kgz', iso: 'kg',),
    const CountryIso(countryID: 'lao', iso: 'la',),
    const CountryIso(countryID: 'lva', iso: 'lv',),
    const CountryIso(countryID: 'lbn', iso: 'lb',),
    const CountryIso(countryID: 'lso', iso: 'ls',),
    const CountryIso(countryID: 'lbr', iso: 'lr',),
    const CountryIso(countryID: 'lby', iso: 'ly',),
    const CountryIso(countryID: 'lie', iso: 'li',),
    const CountryIso(countryID: 'ltu', iso: 'lt',),
    const CountryIso(countryID: 'lux', iso: 'lu',),
    const CountryIso(countryID: 'mac', iso: 'mo',),
    const CountryIso(countryID: 'mkd', iso: 'mk',),
    const CountryIso(countryID: 'mdg', iso: 'mg',),
    const CountryIso(countryID: 'mwi', iso: 'mw',),
    const CountryIso(countryID: 'mys', iso: 'my',),
    const CountryIso(countryID: 'mdv', iso: 'mv',),
    const CountryIso(countryID: 'mli', iso: 'ml',),
    const CountryIso(countryID: 'mlt', iso: 'mt',),
    const CountryIso(countryID: 'mhl', iso: 'mh',),
    const CountryIso(countryID: 'mtq', iso: 'mq',),
    const CountryIso(countryID: 'mrt', iso: 'mr',),
    const CountryIso(countryID: 'mus', iso: 'mu',),
    const CountryIso(countryID: 'myt', iso: 'yt',),
    const CountryIso(countryID: 'mex', iso: 'mx',),
    const CountryIso(countryID: 'fsm', iso: 'fm',),
    const CountryIso(countryID: 'mda', iso: 'md',),
    const CountryIso(countryID: 'mco', iso: 'mc',),
    const CountryIso(countryID: 'mng', iso: 'mn',),
    const CountryIso(countryID: 'mne', iso: 'me',),
    const CountryIso(countryID: 'mar', iso: 'ma',),
    const CountryIso(countryID: 'moz', iso: 'mz',),
    const CountryIso(countryID: 'nam', iso: 'na',),
    const CountryIso(countryID: 'npl', iso: 'np',),
    const CountryIso(countryID: 'nld', iso: 'nl',),
    const CountryIso(countryID: 'ncl', iso: 'nc',),
    const CountryIso(countryID: 'nzl', iso: 'nz',),
    const CountryIso(countryID: 'nic', iso: 'ni',),
    const CountryIso(countryID: 'ner', iso: 'ne',),
    const CountryIso(countryID: 'nga', iso: 'ng',),
    const CountryIso(countryID: 'mnp', iso: 'mp',),
    const CountryIso(countryID: 'nor', iso: 'no',),
    const CountryIso(countryID: 'omn', iso: 'om',),
    const CountryIso(countryID: 'pak', iso: 'pk',),
    const CountryIso(countryID: 'plw', iso: 'pw',),
    const CountryIso(countryID: 'pan', iso: 'pa',),
    const CountryIso(countryID: 'png', iso: 'pg',),
    const CountryIso(countryID: 'pry', iso: 'py',),
    const CountryIso(countryID: 'per', iso: 'pe',),
    const CountryIso(countryID: 'phl', iso: 'ph',),
    const CountryIso(countryID: 'pol', iso: 'pl',),
    const CountryIso(countryID: 'prt', iso: 'pt',),
    const CountryIso(countryID: 'pri', iso: 'pr',),
    const CountryIso(countryID: 'qat', iso: 'qa',),
    const CountryIso(countryID: 'reu', iso: 're',),
    const CountryIso(countryID: 'rou', iso: 'ro',),
    const CountryIso(countryID: 'rus', iso: 'ru',),
    const CountryIso(countryID: 'rwa', iso: 'rw',),
    const CountryIso(countryID: 'shn', iso: 'sh',),
    const CountryIso(countryID: 'kna', iso: 'kn',),
    const CountryIso(countryID: 'lca', iso: 'lc',),
    const CountryIso(countryID: 'vct', iso: 'vc',),
    const CountryIso(countryID: 'wsm', iso: 'ws',),
    const CountryIso(countryID: 'smr', iso: 'sm',),
    const CountryIso(countryID: 'stp', iso: 'st',),
    const CountryIso(countryID: 'sau', iso: 'sa',),
    const CountryIso(countryID: 'sen', iso: 'sn',),
    const CountryIso(countryID: 'srb', iso: 'rs',),
    const CountryIso(countryID: 'syc', iso: 'sc',),
    const CountryIso(countryID: 'sle', iso: 'sl',),
    const CountryIso(countryID: 'sgp', iso: 'sg',),
    const CountryIso(countryID: 'svk', iso: 'sk',),
    const CountryIso(countryID: 'svn', iso: 'si',),
    const CountryIso(countryID: 'slb', iso: 'sb',),
    const CountryIso(countryID: 'som', iso: 'so',),
    const CountryIso(countryID: 'zaf', iso: 'za',),
    const CountryIso(countryID: 'sgs', iso: 'gs',),
    const CountryIso(countryID: 'ssd', iso: 'ss',),
    const CountryIso(countryID: 'esp', iso: 'es',),
    const CountryIso(countryID: 'lka', iso: 'lk',),
    const CountryIso(countryID: 'sdn', iso: 'sd',),
    const CountryIso(countryID: 'sur', iso: 'sr',),
    const CountryIso(countryID: 'swz', iso: 'sz',),
    const CountryIso(countryID: 'swe', iso: 'se',),
    const CountryIso(countryID: 'che', iso: 'ch',),
    const CountryIso(countryID: 'syr', iso: 'sy',),
    const CountryIso(countryID: 'twn', iso: 'tw',),
    const CountryIso(countryID: 'tjk', iso: 'tj',),
    const CountryIso(countryID: 'tza', iso: 'tz',),
    const CountryIso(countryID: 'tha', iso: 'th',),
    const CountryIso(countryID: 'tls', iso: 'tl',),
    const CountryIso(countryID: 'tgo', iso: 'tg',),
    const CountryIso(countryID: 'ton', iso: 'to',),
    const CountryIso(countryID: 'tto', iso: 'tt',),
    const CountryIso(countryID: 'tun', iso: 'tn',),
    const CountryIso(countryID: 'tur', iso: 'tr',),
    const CountryIso(countryID: 'tkm', iso: 'tm',),
    const CountryIso(countryID: 'tca', iso: 'tc',),
    const CountryIso(countryID: 'tuv', iso: 'tv',),
    const CountryIso(countryID: 'uga', iso: 'ug',),
    const CountryIso(countryID: 'ukr', iso: 'ua',),
    const CountryIso(countryID: 'are', iso: 'ae',),
    const CountryIso(countryID: 'gbr', iso: 'gb',),
    const CountryIso(countryID: 'usa', iso: 'us',),
    const CountryIso(countryID: 'ury', iso: 'uy',),
    const CountryIso(countryID: 'uzb', iso: 'uz',),
    const CountryIso(countryID: 'vut', iso: 'vu',),
    const CountryIso(countryID: 'vat', iso: 'va',),
    const CountryIso(countryID: 'ven', iso: 've',),
    const CountryIso(countryID: 'vnm', iso: 'vn',),
    const CountryIso(countryID: 'wlf', iso: 'wf',),
    const CountryIso(countryID: 'pse', iso: 'xw',),
    const CountryIso(countryID: 'yem', iso: 'ye',),
    const CountryIso(countryID: 'zmb', iso: 'zm',),
    const CountryIso(countryID: 'zwe', iso: 'zw',),
  ];
// -----------------------------------------------------------------------------
}