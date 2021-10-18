import 'package:bldrs/controllers/theme/iconz.dart';
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
      final Flag _flag = allFlags.singleWhere((flag) => flag.countryID == countryID, orElse: () => null);
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

