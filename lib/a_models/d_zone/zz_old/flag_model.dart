import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/foundation.dart';

@immutable
class Flag {
  /// --------------------------------------------------------------------------
  const Flag({
    @required this.countryID,
    @required this.icon,
  });
  /// --------------------------------------------------------------------------
  final String countryID;
  final String icon;
  /// --------------------------------------------------------------------------
  static String getFlagIcon(String countryID) {
    String _flagIcon = Iconz.dvBlankSVG;

    if (countryID != null) {
      final Flag _flag = allFlags.singleWhere(
              (Flag flag) => flag.countryID == countryID,
          orElse: () => null);
      _flagIcon = _flag?.icon;
    }

    return _flagIcon;
  }

// -----------------------------------------------------------------------------
  static const List<Flag> allFlags = <Flag>[
    Flag(
      countryID: 'ala',
      icon: _ala,
    ),
    Flag(
      countryID: 'alb',
      icon: _alb,
    ),
    Flag(
      countryID: 'dza',
      icon: _dza,
    ),
    Flag(
      countryID: 'asm',
      icon: _asm,
    ),
    Flag(
      countryID: 'and',
      icon: _and,
    ),
    Flag(
      countryID: 'ago',
      icon: _ago,
    ),
    Flag(
      countryID: 'aia',
      icon: _aia,
    ),
    Flag(
      countryID: 'atg',
      icon: _atg,
    ),
    Flag(
      countryID: 'arg',
      icon: _arg,
    ),
    Flag(
      countryID: 'arm',
      icon: _arm,
    ),
    Flag(
      countryID: 'abw',
      icon: _abw,
    ),
    Flag(
      countryID: 'aus',
      icon: _aus,
    ),
    Flag(
      countryID: 'aut',
      icon: _aut,
    ),
    Flag(
      countryID: 'aze',
      icon: _aze,
    ),
    Flag(
      countryID: 'bhs',
      icon: _bhs,
    ),
    Flag(
      countryID: 'bhr',
      icon: _bhr,
    ),
    Flag(
      countryID: 'bgd',
      icon: _bgd,
    ),
    Flag(
      countryID: 'brb',
      icon: _brb,
    ),
    Flag(
      countryID: 'blr',
      icon: _blr,
    ),
    Flag(
      countryID: 'bel',
      icon: _bel,
    ),
    Flag(
      countryID: 'blz',
      icon: _blz,
    ),
    Flag(
      countryID: 'ben',
      icon: _ben,
    ),
    Flag(
      countryID: 'bmu',
      icon: _bmu,
    ),
    Flag(
      countryID: 'btn',
      icon: _btn,
    ),
    Flag(
      countryID: 'bol',
      icon: _bol,
    ),
    Flag(
      countryID: 'bes',
      icon: _bes,
    ),
    Flag(
      countryID: 'bih',
      icon: _bih,
    ),
    Flag(
      countryID: 'bwa',
      icon: _bwa,
    ),
    Flag(
      countryID: 'bvt',
      icon: _bvt,
    ),
    Flag(
      countryID: 'bra',
      icon: _bra,
    ),
    Flag(
      countryID: 'iot',
      icon: _iot,
    ),
    Flag(
      countryID: 'brn',
      icon: _brn,
    ),
    Flag(
      countryID: 'bgr',
      icon: _bgr,
    ),
    Flag(
      countryID: 'bfa',
      icon: _bfa,
    ),
    Flag(
      countryID: 'bdi',
      icon: _bdi,
    ),
    Flag(
      countryID: 'cpv',
      icon: _cpv,
    ),
    Flag(
      countryID: 'khm',
      icon: _khm,
    ),
    Flag(
      countryID: 'cmr',
      icon: _cmr,
    ),
    Flag(
      countryID: 'can',
      icon: _can,
    ),
    Flag(
      countryID: 'cym',
      icon: _cym,
    ),
    Flag(
      countryID: 'caf',
      icon: _caf,
    ),
    Flag(
      countryID: 'tcd',
      icon: _tcd,
    ),
    Flag(
      countryID: 'chl',
      icon: _chl,
    ),
    Flag(
      countryID: 'chn',
      icon: _chn,
    ),
    Flag(
      countryID: 'cxr',
      icon: _cxr,
    ),
    Flag(
      countryID: 'cck',
      icon: _cck,
    ),
    Flag(
      countryID: 'col',
      icon: _col,
    ),
    Flag(
      countryID: 'com',
      icon: _com,
    ),
    Flag(
      countryID: 'cog',
      icon: _cog,
    ),
    Flag(
      countryID: 'cod',
      icon: _cod,
    ),
    Flag(
      countryID: 'cok',
      icon: _cok,
    ),
    Flag(
      countryID: 'cri',
      icon: _cri,
    ),
    Flag(
      countryID: 'civ',
      icon: _civ,
    ),
    Flag(
      countryID: 'hrv',
      icon: _hrv,
    ),
    Flag(
      countryID: 'cub',
      icon: _cub,
    ),
    Flag(
      countryID: 'cuw',
      icon: _cuw,
    ),
    Flag(
      countryID: 'cyp',
      icon: _cyp,
    ),
    Flag(
      countryID: 'cze',
      icon: _cze,
    ),
    Flag(
      countryID: 'dnk',
      icon: _dnk,
    ),
    Flag(
      countryID: 'dji',
      icon: _dji,
    ),
    Flag(
      countryID: 'dma',
      icon: _dma,
    ),
    Flag(
      countryID: 'dom',
      icon: _dom,
    ),
    Flag(
      countryID: 'ecu',
      icon: _ecu,
    ),
    Flag(
      countryID: 'egy',
      icon: _egy,
    ),
    Flag(
      countryID: 'slv',
      icon: _slv,
    ),
    Flag(
      countryID: 'gnq',
      icon: _gnq,
    ),
    Flag(
      countryID: 'eri',
      icon: _eri,
    ),
    Flag(
      countryID: 'est',
      icon: _est,
    ),
    Flag(
      countryID: 'swz',
      icon: _swz,
    ),
    Flag(
      countryID: 'eth',
      icon: _eth,
    ),
    Flag(
      countryID: 'flk',
      icon: _flk,
    ),
    Flag(
      countryID: 'fro',
      icon: _fro,
    ),
    Flag(
      countryID: 'fji',
      icon: _fji,
    ),
    Flag(
      countryID: 'fin',
      icon: _fin,
    ),
    Flag(
      countryID: 'fra',
      icon: _fra,
    ),
    Flag(
      countryID: 'guf',
      icon: _guf,
    ),
    Flag(
      countryID: 'pyf',
      icon: _pyf,
    ),
    Flag(
      countryID: 'atf',
      icon: _atf,
    ),
    Flag(
      countryID: 'gab',
      icon: _gab,
    ),
    Flag(
      countryID: 'gmb',
      icon: _gmb,
    ),
    Flag(
      countryID: 'geo',
      icon: _geo,
    ),
    Flag(
      countryID: 'deu',
      icon: _deu,
    ),
    Flag(
      countryID: 'gha',
      icon: _gha,
    ),
    Flag(
      countryID: 'gib',
      icon: _gib,
    ),
    Flag(
      countryID: 'grc',
      icon: _grc,
    ),
    Flag(
      countryID: 'grl',
      icon: _grl,
    ),
    Flag(
      countryID: 'grd',
      icon: _grd,
    ),
    Flag(
      countryID: 'glp',
      icon: _glp,
    ),
    Flag(
      countryID: 'gum',
      icon: _gum,
    ),
    Flag(
      countryID: 'gtm',
      icon: _gtm,
    ),
    Flag(
      countryID: 'ggy',
      icon: _ggy,
    ),
    Flag(
      countryID: 'gin',
      icon: _gin,
    ),
    Flag(
      countryID: 'gnb',
      icon: _gnb,
    ),
    Flag(
      countryID: 'guy',
      icon: _guy,
    ),
    Flag(
      countryID: 'hti',
      icon: _hti,
    ),
    Flag(
      countryID: 'hmd',
      icon: _hmd,
    ),
    Flag(
      countryID: 'vat',
      icon: _vat,
    ),
    Flag(
      countryID: 'hnd',
      icon: _hnd,
    ),
    Flag(
      countryID: 'hkg',
      icon: _hkg,
    ),
    Flag(
      countryID: 'hun',
      icon: _hun,
    ),
    Flag(
      countryID: 'isl',
      icon: _isl,
    ),
    Flag(
      countryID: 'ind',
      icon: _ind,
    ),
    Flag(
      countryID: 'idn',
      icon: _idn,
    ),
    Flag(
      countryID: 'irn',
      icon: _irn,
    ),
    Flag(
      countryID: 'irq',
      icon: _irq,
    ),
    Flag(
      countryID: 'irl',
      icon: _irl,
    ),
    Flag(
      countryID: 'imn',
      icon: _imn,
    ),
    Flag(
      countryID: 'isr',
      icon: _isr,
    ),
    Flag(
      countryID: 'ita',
      icon: _ita,
    ),
    Flag(
      countryID: 'jam',
      icon: _jam,
    ),
    Flag(
      countryID: 'jpn',
      icon: _jpn,
    ),
    Flag(
      countryID: 'jey',
      icon: _jey,
    ),
    Flag(
      countryID: 'jor',
      icon: _jor,
    ),
    Flag(
      countryID: 'kaz',
      icon: _kaz,
    ),
    Flag(
      countryID: 'ken',
      icon: _ken,
    ),
    Flag(
      countryID: 'kir',
      icon: _kir,
    ),
    Flag(
      countryID: 'prk',
      icon: _prk,
    ),
    Flag(
      countryID: 'kor',
      icon: _kor,
    ),
    Flag(
      countryID: 'kwt',
      icon: _kwt,
    ),
    Flag(
      countryID: 'kgz',
      icon: _kgz,
    ),
    Flag(
      countryID: 'lao',
      icon: _lao,
    ),
    Flag(
      countryID: 'lva',
      icon: _lva,
    ),
    Flag(
      countryID: 'lbn',
      icon: _lbn,
    ),
    Flag(
      countryID: 'lso',
      icon: _lso,
    ),
    Flag(
      countryID: 'lbr',
      icon: _lbr,
    ),
    Flag(
      countryID: 'lby',
      icon: _lby,
    ),
    Flag(
      countryID: 'lie',
      icon: _lie,
    ),
    Flag(
      countryID: 'ltu',
      icon: _ltu,
    ),
    Flag(
      countryID: 'lux',
      icon: _lux,
    ),
    Flag(
      countryID: 'mac',
      icon: _mac,
    ),
    Flag(
      countryID: 'mdg',
      icon: _mdg,
    ),
    Flag(
      countryID: 'mwi',
      icon: _mwi,
    ),
    Flag(
      countryID: 'mys',
      icon: _mys,
    ),
    Flag(
      countryID: 'mdv',
      icon: _mdv,
    ),
    Flag(
      countryID: 'mli',
      icon: _mli,
    ),
    Flag(
      countryID: 'mlt',
      icon: _mlt,
    ),
    Flag(
      countryID: 'mhl',
      icon: _mhl,
    ),
    Flag(
      countryID: 'mtq',
      icon: _mtq,
    ),
    Flag(
      countryID: 'mrt',
      icon: _mrt,
    ),
    Flag(
      countryID: 'mus',
      icon: _mus,
    ),
    Flag(
      countryID: 'myt',
      icon: _myt,
    ),
    Flag(
      countryID: 'mex',
      icon: _mex,
    ),
    Flag(
      countryID: 'fsm',
      icon: _fsm,
    ),
    Flag(
      countryID: 'mda',
      icon: _mda,
    ),
    Flag(
      countryID: 'mco',
      icon: _mco,
    ),
    Flag(
      countryID: 'mng',
      icon: _mng,
    ),
    Flag(
      countryID: 'mne',
      icon: _mne,
    ),
    Flag(
      countryID: 'msr',
      icon: _msr,
    ),
    Flag(
      countryID: 'mar',
      icon: _mar,
    ),
    Flag(
      countryID: 'moz',
      icon: _moz,
    ),
    Flag(
      countryID: 'mmr',
      icon: _mmr,
    ),
    Flag(
      countryID: 'nam',
      icon: _nam,
    ),
    Flag(
      countryID: 'nru',
      icon: _nru,
    ),
    Flag(
      countryID: 'npl',
      icon: _npl,
    ),
    Flag(
      countryID: 'nld',
      icon: _nld,
    ),
    Flag(
      countryID: 'ncl',
      icon: _ncl,
    ),
    Flag(
      countryID: 'nzl',
      icon: _nzl,
    ),
    Flag(
      countryID: 'nic',
      icon: _nic,
    ),
    Flag(
      countryID: 'ner',
      icon: _ner,
    ),
    Flag(
      countryID: 'nga',
      icon: _nga,
    ),
    Flag(
      countryID: 'niu',
      icon: _niu,
    ),
    Flag(
      countryID: 'nfk',
      icon: _nfk,
    ),
    Flag(
      countryID: 'mkd',
      icon: _mkd,
    ),
    Flag(
      countryID: 'mnp',
      icon: _mnp,
    ),
    Flag(
      countryID: 'nor',
      icon: _nor,
    ),
    Flag(
      countryID: 'omn',
      icon: _omn,
    ),
    Flag(
      countryID: 'pak',
      icon: _pak,
    ),
    Flag(
      countryID: 'plw',
      icon: _plw,
    ),
    Flag(
      countryID: 'pse',
      icon: _pse,
    ),
    Flag(
      countryID: 'pan',
      icon: _pan,
    ),
    Flag(
      countryID: 'png',
      icon: _png,
    ),
    Flag(
      countryID: 'pry',
      icon: _pry,
    ),
    Flag(
      countryID: 'per',
      icon: _per,
    ),
    Flag(
      countryID: 'phl',
      icon: _phl,
    ),
    Flag(
      countryID: 'pcn',
      icon: _pcn,
    ),
    Flag(
      countryID: 'pol',
      icon: _pol,
    ),
    Flag(
      countryID: 'prt',
      icon: _prt,
    ),
    Flag(
      countryID: 'pri',
      icon: _pri,
    ),
    Flag(
      countryID: 'qat',
      icon: _qat,
    ),
    Flag(
      countryID: 'reu',
      icon: _reu,
    ),
    Flag(
      countryID: 'rou',
      icon: _rou,
    ),
    Flag(
      countryID: 'rus',
      icon: _rus,
    ),
    Flag(
      countryID: 'rwa',
      icon: _rwa,
    ),
    Flag(
      countryID: 'blm',
      icon: _blm,
    ),
    Flag(
      countryID: 'shn',
      icon: _shn,
    ),
    Flag(
      countryID: 'kna',
      icon: _kna,
    ),
    Flag(
      countryID: 'lca',
      icon: _lca,
    ),
    Flag(
      countryID: 'maf',
      icon: _maf,
    ),
    Flag(
      countryID: 'spm',
      icon: _spm,
    ),
    Flag(
      countryID: 'vct',
      icon: _vct,
    ),
    Flag(
      countryID: 'wsm',
      icon: _wsm,
    ),
    Flag(
      countryID: 'smr',
      icon: _smr,
    ),
    Flag(
      countryID: 'stp',
      icon: _stp,
    ),
    Flag(
      countryID: 'sau',
      icon: _sau,
    ),
    Flag(
      countryID: 'sen',
      icon: _sen,
    ),
    Flag(
      countryID: 'srb',
      icon: _srb,
    ),
    Flag(
      countryID: 'syc',
      icon: _syc,
    ),
    Flag(
      countryID: 'sle',
      icon: _sle,
    ),
    Flag(
      countryID: 'sgp',
      icon: _sgp,
    ),
    Flag(
      countryID: 'sxm',
      icon: _sxm,
    ),
    Flag(
      countryID: 'svk',
      icon: _svk,
    ),
    Flag(
      countryID: 'svn',
      icon: _svn,
    ),
    Flag(
      countryID: 'slb',
      icon: _slb,
    ),
    Flag(
      countryID: 'som',
      icon: _som,
    ),
    Flag(
      countryID: 'zaf',
      icon: _zaf,
    ),
    Flag(
      countryID: 'sgs',
      icon: _sgs,
    ),
    Flag(
      countryID: 'ssd',
      icon: _ssd,
    ),
    Flag(
      countryID: 'esp',
      icon: _esp,
    ),
    Flag(
      countryID: 'lka',
      icon: _lka,
    ),
    Flag(
      countryID: 'sdn',
      icon: _sdn,
    ),
    Flag(
      countryID: 'sur',
      icon: _sur,
    ),
    Flag(
      countryID: 'sjm',
      icon: _sjm,
    ),
    Flag(
      countryID: 'swe',
      icon: _swe,
    ),
    Flag(
      countryID: 'che',
      icon: _che,
    ),
    Flag(
      countryID: 'syr',
      icon: _syr,
    ),
    Flag(
      countryID: 'twn',
      icon: _twn,
    ),
    Flag(
      countryID: 'tjk',
      icon: _tjk,
    ),
    Flag(
      countryID: 'tza',
      icon: _tza,
    ),
    Flag(
      countryID: 'tha',
      icon: _tha,
    ),
    Flag(
      countryID: 'tls',
      icon: _tls,
    ),
    Flag(
      countryID: 'tgo',
      icon: _tgo,
    ),
    Flag(
      countryID: 'tkl',
      icon: _tkl,
    ),
    Flag(
      countryID: 'ton',
      icon: _ton,
    ),
    Flag(
      countryID: 'tto',
      icon: _tto,
    ),
    Flag(
      countryID: 'tun',
      icon: _tun,
    ),
    Flag(
      countryID: 'tur',
      icon: _tur,
    ),
    Flag(
      countryID: 'tkm',
      icon: _tkm,
    ),
    Flag(
      countryID: 'tca',
      icon: _tca,
    ),
    Flag(
      countryID: 'tuv',
      icon: _tuv,
    ),
    Flag(
      countryID: 'uga',
      icon: _uga,
    ),
    Flag(
      countryID: 'ukr',
      icon: _ukr,
    ),
    Flag(
      countryID: 'are',
      icon: _are,
    ),
    Flag(
      countryID: 'gbr',
      icon: _gbr,
    ),
    Flag(
      countryID: 'usa',
      icon: _usa,
    ),
    Flag(
      countryID: 'umi',
      icon: _umi,
    ),
    Flag(
      countryID: 'ury',
      icon: _ury,
    ),
    Flag(
      countryID: 'uzb',
      icon: _uzb,
    ),
    Flag(
      countryID: 'vut',
      icon: _vut,
    ),
    Flag(
      countryID: 'ven',
      icon: _ven,
    ),
    Flag(
      countryID: 'vnm',
      icon: _vnm,
    ),
    Flag(
      countryID: 'vgb',
      icon: _vgb,
    ),
    Flag(
      countryID: 'vir',
      icon: _vir,
    ),
    Flag(
      countryID: 'wlf',
      icon: _wlf,
    ),
    Flag(
      countryID: 'esh',
      icon: _esh,
    ),
    Flag(
      countryID: 'yem',
      icon: _yem,
    ),
    Flag(
      countryID: 'zmb',
      icon: _zmb,
    ),
    Flag(
      countryID: 'zwe',
      icon: _zwe,
    ),
    Flag(
      countryID: 'euz',
      icon: _euz,
    ),
    Flag(
      countryID: 'xks',
      icon: _xks,
    ),
    Flag(
      countryID: 'afg',
      icon: _afg,
    ),
  ];
// -----------------------------------------------------------------------------
  static const String _flagsPath = 'assets/icons/flags/';
  static const String _afg = '$_flagsPath' 'flag_as_s_afghanistan.svg';
  static const String _ala = '$_flagsPath' 'flag_eu_n_aland_islands.svg';
  static const String _alb = '$_flagsPath' 'flag_eu_s_albania.svg';
  static const String _dza = '$_flagsPath' 'flag_af_n_algeria.svg';
  static const String _asm = '$_flagsPath' 'flag_oc_poly_american_samoa.svg';
  static const String _and = '$_flagsPath' 'flag_eu_s_andorra.svg';
  static const String _ago = '$_flagsPath' 'flag_af_m_angola.svg';
  static const String _aia = '$_flagsPath' 'flag_na_cr_anguilla.svg';
  static const String _atg = '$_flagsPath' 'flag_na_cr_antigua_and_barbuda.svg';
  static const String _arg = '$_flagsPath' 'flag_sa_argentina.svg';
  static const String _arm = '$_flagsPath' 'flag_as_w_armenia.svg';
  static const String _abw = '$_flagsPath' 'flag_na_cr_aruba.svg';
  static const String _aus = '$_flagsPath' 'flag_az_flag_australia.svg';
  static const String _aut = '$_flagsPath' 'flag_eu_w_austria.svg';
  static const String _aze = '$_flagsPath' 'flag_as_w_azerbaijan.svg';
  static const String _bhs = '$_flagsPath' 'flag_na_cr_bahamas.svg';
  static const String _bhr = '$_flagsPath' 'flag_as_w_bahrain.svg';
  static const String _bgd = '$_flagsPath' 'flag_as_s_bangladesh.svg';
  static const String _brb = '$_flagsPath' 'flag_na_cr_barbados.svg';
  static const String _blr = '$_flagsPath' 'flag_eu_e_belarus.svg';
  static const String _bel = '$_flagsPath' 'flag_eu_w_belgium.svg';
  static const String _blz = '$_flagsPath' 'flag_na_c_belize.svg';
  static const String _ben = '$_flagsPath' 'flag_af_w_benin.svg';
  static const String _bmu = '$_flagsPath' 'flag_na_n_bermuda.svg';
  static const String _btn = '$_flagsPath' 'flag_as_s_bhutan.svg';
  static const String _bol = '$_flagsPath' 'flag_sa_bolivia.svg';
  static const String _bes = '$_flagsPath' 'flag_na_cr_bonaire.svg';
  static const String _bih = '$_flagsPath' 'flag_eu_s_bosnia_and_herzegovina.svg';
  static const String _bwa = '$_flagsPath' 'flag_af_s_botswana.svg';
  static const String _bvt = '$_flagsPath' 'flag_eu_n_norway.svg';
  static const String _bra = '$_flagsPath' 'flag_sa_brazil.svg';
  static const String _iot = '$_flagsPath' 'flag_na_cr_british_indian_ocean_territory.svg';
  static const String _brn = '$_flagsPath' 'flag_as_se_brunei.svg';
  static const String _bgr = '$_flagsPath' 'flag_eu_e_bulgaria.svg';
  static const String _bfa = '$_flagsPath' 'flag_af_w_burkina_faso.svg';
  static const String _bdi = '$_flagsPath' 'flag_af_w_burundi.svg';
  static const String _cpv = '$_flagsPath' 'flag_af_w_cape_verde.svg';
  static const String _khm = '$_flagsPath' 'flag_as_se_cambodia.svg';
  static const String _cmr = '$_flagsPath' 'flag_af_m_cameroon.svg';
  static const String _can = '$_flagsPath' 'flag_na_n_canada.svg';
  static const String _cym = '$_flagsPath' 'flag_na_cr_cayman_islands.svg';
  static const String _caf = '$_flagsPath' 'flag_af_m_central_african_republic.svg';
  static const String _tcd = '$_flagsPath' 'flag_af_m_chad.svg';
  static const String _chl = '$_flagsPath' 'flag_sa_chile.svg';
  static const String _chn = '$_flagsPath' 'flag_as_e_china.svg';
  static const String _cxr = '$_flagsPath' 'flag_az_christmas_island.svg';
  static const String _cck = '$_flagsPath' 'flag_az_cocos_island.svg';
  static const String _col = '$_flagsPath' 'flag_sa_colombia.svg';
  static const String _com = '$_flagsPath' 'flag_af_e_comoros.svg';
  static const String _cog = '$_flagsPath' 'flag_af_m_congo.svg';
  static const String _cod = '$_flagsPath' 'flag_af_m_congo2.svg';
  static const String _cok = '$_flagsPath' 'flag_oc_poly_cook_islands.svg';
  static const String _cri = '$_flagsPath' 'flag_sa_costa_rica.svg';
  static const String _civ = '$_flagsPath' 'flag_af_w_cote_divoire.svg';
  static const String _hrv = '$_flagsPath' 'flag_eu_s_croatia.svg';
  static const String _cub = '$_flagsPath' 'flag_na_cr_cuba.svg';
  static const String _cuw = '$_flagsPath' 'flag_na_cr_curacao.svg';
  static const String _cyp = '$_flagsPath' 'flag_as_w_cyprus.svg';
  static const String _cze = '$_flagsPath' 'flag_eu_e_czech_republic.svg';
  static const String _dnk = '$_flagsPath' 'flag_eu_n_denmark.svg';
  static const String _dji = '$_flagsPath' 'flag_af_e_djibouti.svg';
  static const String _dma = '$_flagsPath' 'flag_na_cr_dominica.svg';
  static const String _dom = '$_flagsPath' 'flag_na_cr_dominican_republic.svg';
  static const String _ecu = '$_flagsPath' 'flag_sa_ecuador.svg';
  static const String _egy = '$_flagsPath' 'flag_af_n_egypt.svg';
  static const String _slv = '$_flagsPath' 'flag_na_c_el_salvador.svg';
  static const String _gnq = '$_flagsPath' 'flag_af_m_equatorial_guinea.svg';
  static const String _eri = '$_flagsPath' 'flag_af_e_eritrea.svg';
  static const String _est = '$_flagsPath' 'flag_eu_n_estonia.svg';
  static const String _swz = '$_flagsPath' 'flag_af_s_swaziland.svg';
  static const String _eth = '$_flagsPath' 'flag_af_e_ethiopia.svg';
  static const String _flk = '$_flagsPath' 'flag_sa_falkland_islands.svg';
  static const String _fro = '$_flagsPath' 'flag_eu_n_faroe_islands.svg';
  static const String _fji = '$_flagsPath' 'flag_oc_melan_fiji.svg';
  static const String _fin = '$_flagsPath' 'flag_eu_n_finland.svg';
  static const String _fra = '$_flagsPath' 'flag_eu_w_france.svg';
  static const String _guf = '$_flagsPath' 'flag_sa_french_guiana.svg';
  static const String _pyf = '$_flagsPath' 'flag_oc_poly_french_polynesia.svg';
  static const String _atf = '$_flagsPath' 'flag_eu_w_france.svg';
  static const String _gab = '$_flagsPath' 'flag_af_m_gabon.svg';
  static const String _gmb = '$_flagsPath' 'flag_af_w_gambia.svg';
  static const String _geo = '$_flagsPath' 'flag_as_w_georgia.svg';
  static const String _deu = '$_flagsPath' 'flag_eu_w_germany.svg';
  static const String _gha = '$_flagsPath' 'flag_af_w_ghana.svg';
  static const String _gib = '$_flagsPath' 'flag_eu_s_gibraltar.svg';
  static const String _grc = '$_flagsPath' 'flag_eu_s_greece.svg';
  static const String _grl = '$_flagsPath' 'flag_na_n_greenland.svg';
  static const String _grd = '$_flagsPath' 'flag_na_cr_grenada.svg';
  static const String _glp = '$_flagsPath' 'flag_na_cr_guadeloupe.svg';
  static const String _gum = '$_flagsPath' 'flag_oc_micro_guam.svg';
  static const String _gtm = '$_flagsPath' 'flag_na_c_guatemala.svg';
  static const String _ggy = '$_flagsPath' 'flag_eu_n_guernsey.svg';
  static const String _gin = '$_flagsPath' 'flag_af_w_guinea.svg';
  static const String _gnb = '$_flagsPath' 'flag_af_w_guinea_bissau.svg';
  static const String _guy = '$_flagsPath' 'flag_sa_guyana.svg';
  static const String _hti = '$_flagsPath' 'flag_na_cr_haiti.svg';
  static const String _hmd = '$_flagsPath' 'flag_az_flag_australia.svg';
  static const String _vat = '$_flagsPath' 'flag_eu_w_vatican_city.svg';
  static const String _hnd = '$_flagsPath' 'flag_na_c_honduras.svg';
  static const String _hkg = '$_flagsPath' 'flag_as_e_hong_kong.svg';
  static const String _hun = '$_flagsPath' 'flag_eu_e_hungary.svg';
  static const String _isl = '$_flagsPath' 'flag_eu_n_iceland.svg';
  static const String _ind = '$_flagsPath' 'flag_as_s_india.svg';
  static const String _idn = '$_flagsPath' 'flag_as_se_indonesia.svg';
  static const String _irn = '$_flagsPath' 'flag_as_s_iran.svg';
  static const String _irq = '$_flagsPath' 'flag_as_w_iraq.svg';
  static const String _irl = '$_flagsPath' 'flag_eu_n_ireland.svg';
  static const String _imn = '$_flagsPath' 'flag_eu_n_isle_of_man.svg';
  static const String _isr = '$_flagsPath' 'flag_as_w_israel.svg';
  static const String _ita = '$_flagsPath' 'flag_eu_s_italy.svg';
  static const String _jam = '$_flagsPath' 'flag_na_cr_jamaica.svg';
  static const String _jpn = '$_flagsPath' 'flag_as_e_japan.svg';
  static const String _jey = '$_flagsPath' 'flag_eu_n_jersey.svg';
  static const String _jor = '$_flagsPath' 'flag_as_w_jordan.svg';
  static const String _kaz = '$_flagsPath' 'flag_as_c_kazakhstan.svg';
  static const String _ken = '$_flagsPath' 'flag_af_e_kenya.svg';
  static const String _kir = '$_flagsPath' 'flag_oc_micro_kiribati.svg';
  static const String _prk = '$_flagsPath' 'flag_as_e_north_korea.svg';
  static const String _kor = '$_flagsPath' 'flag_as_e_south_korea.svg';
  static const String _kwt = '$_flagsPath' 'flag_as_w_kuwait.svg';
  static const String _kgz = '$_flagsPath' 'flag_as_c_kyrgyzstan.svg';
  static const String _lao = '$_flagsPath' 'flag_as_se_laos.svg';
  static const String _lva = '$_flagsPath' 'flag_eu_n_latvia.svg';
  static const String _lbn = '$_flagsPath' 'flag_as_w_lebanon.svg';
  static const String _lso = '$_flagsPath' 'flag_af_s_lesotho.svg';
  static const String _lbr = '$_flagsPath' 'flag_af_w_liberia.svg';
  static const String _lby = '$_flagsPath' 'flag_af_n_libya.svg';
  static const String _lie = '$_flagsPath' 'flag_eu_w_liechtenstein.svg';
  static const String _ltu = '$_flagsPath' 'flag_eu_n_lithuania.svg';
  static const String _lux = '$_flagsPath' 'flag_eu_w_luxembourg.svg';
  static const String _mac = '$_flagsPath' 'flag_as_e_macao.svg';
  static const String _mdg = '$_flagsPath' 'flag_af_e_madagascar.svg';
  static const String _mwi = '$_flagsPath' 'flag_af_e_malawi.svg';
  static const String _mys = '$_flagsPath' 'flag_as_se_malaysia.svg';
  static const String _mdv = '$_flagsPath' 'flag_as_s_maldives.svg';
  static const String _mli = '$_flagsPath' 'flag_af_w_mali.svg';
  static const String _mlt = '$_flagsPath' 'flag_eu_s_malta.svg';
  static const String _mhl = '$_flagsPath' 'flag_oc_micro_marshall_island.svg';
  static const String _mtq = '$_flagsPath' 'flag_na_cr_martinique.svg';
  static const String _mrt = '$_flagsPath' 'flag_af_w_mauritania.svg';
  static const String _mus = '$_flagsPath' 'flag_af_e_mauritius.svg';
  static const String _myt = '$_flagsPath' 'flag_af_e_mayotte.svg';
  static const String _mex = '$_flagsPath' 'flag_na_c_mexico.svg';
  static const String _fsm = '$_flagsPath' 'flag_oc_micro_micronesia.svg';
  static const String _mda = '$_flagsPath' 'flag_eu_e_moldova.svg';
  static const String _mco = '$_flagsPath' 'flag_eu_w_monaco.svg';
  static const String _mng = '$_flagsPath' 'flag_as_e_mongolia.svg';
  static const String _mne = '$_flagsPath' 'flag_eu_s_montenegro.svg';
  static const String _msr = '$_flagsPath' 'flag_na_cr_montserrat.svg';
  static const String _mar = '$_flagsPath' 'flag_af_n_morocco.svg';
  static const String _moz = '$_flagsPath' 'flag_af_e_mozambique.svg';
  static const String _mmr = '$_flagsPath' 'flag_as_se_myanmar.svg';
  static const String _nam = '$_flagsPath' 'flag_af_s_namibia.svg';
  static const String _nru = '$_flagsPath' 'flag_oc_micro_nauru.svg';
  static const String _npl = '$_flagsPath' 'flag_as_s_nepal.svg';
  static const String _nld = '$_flagsPath' 'flag_eu_w_netherlands.svg';
  static const String _ncl = '$_flagsPath' 'flag_eu_w_france.svg';
  static const String _nzl = '$_flagsPath' 'flag_az_new_zealand.svg';
  static const String _nic = '$_flagsPath' 'flag_na_c_nicaragua.svg';
  static const String _ner = '$_flagsPath' 'flag_af_w_niger.svg';
  static const String _nga = '$_flagsPath' 'flag_af_w_nigeria.svg';
  static const String _niu = '$_flagsPath' 'flag_oc_poly_niue.svg';
  static const String _nfk = '$_flagsPath' 'flag_az_norfolk_island.svg';
  static const String _mkd = '$_flagsPath' 'flag_eu_s_macedonia.svg';
  static const String _mnp = '$_flagsPath' 'flag_oc_micro_northern_marianas_islands.svg';
  static const String _nor = '$_flagsPath' 'flag_eu_n_norway.svg';
  static const String _omn = '$_flagsPath' 'flag_as_w_oman.svg';
  static const String _pak = '$_flagsPath' 'flag_as_s_pakistan.svg';
  static const String _plw = '$_flagsPath' 'flag_oc_micro_palau.svg';
  static const String _pse = '$_flagsPath' 'flag_as_w_palestine.svg';
  static const String _pan = '$_flagsPath' 'flag_na_c_panama.svg';
  static const String _png = '$_flagsPath' 'flag_oc_melan_papua_new_guinea.svg';
  static const String _pry = '$_flagsPath' 'flag_sa_paraguay.svg';
  static const String _per = '$_flagsPath' 'flag_sa_peru.svg';
  static const String _phl = '$_flagsPath' 'flag_as_se_philippines.svg';
  static const String _pcn = '$_flagsPath' 'flag_oc_poly_pitcairn_islands.svg';
  static const String _pol = '$_flagsPath' 'flag_eu_e_poland.svg';
  static const String _prt = '$_flagsPath' 'flag_eu_s_portugal.svg';
  static const String _pri = '$_flagsPath' 'flag_na_cr_puerto_rico.svg';
  static const String _qat = '$_flagsPath' 'flag_as_w_qatar.svg';
  static const String _reu = '$_flagsPath' 'flag_af_e_reunion.svg';
  static const String _rou = '$_flagsPath' 'flag_eu_e_romania.svg';
  static const String _rus = '$_flagsPath' 'flag_eu_e_russia.svg';
  static const String _rwa = '$_flagsPath' 'flag_af_e_rwanda.svg';
  static const String _blm = '$_flagsPath' 'flag_na_cr_saint_barthelemy.svg';
  static const String _shn = '$_flagsPath' 'flag_af_w_saint_helena.svg';
  static const String _kna = '$_flagsPath' 'flag_na_cr_saint_kitts_and_nevis.svg';
  static const String _lca = '$_flagsPath' 'flag_na_cr_saint_lucia.svg';
  static const String _maf = '$_flagsPath' 'flag_eu_w_france.svg';
  static const String _spm = '$_flagsPath' 'flag_na_n_saint_pierre_and_miquelon.svg';
  static const String _vct = '$_flagsPath' 'flag_na_cr_saint_vincent_and_the_grenadines.svg';
  static const String _wsm = '$_flagsPath' 'flag_oc_poly_samoa.svg';
  static const String _smr = '$_flagsPath' 'flag_eu_s_san_marino.svg';
  static const String _stp = '$_flagsPath' 'flag_af_m_sao_tome_and_principe.svg';
  static const String _sau = '$_flagsPath' 'flag_as_w_saudi_arabia.svg';
  static const String _sen = '$_flagsPath' 'flag_af_w_senegal.svg';
  static const String _srb = '$_flagsPath' 'flag_eu_s_serbia.svg';
  static const String _syc = '$_flagsPath' 'flag_af_e_seychelles.svg';
  static const String _sle = '$_flagsPath' 'flag_af_w_sierra_leone.svg';
  static const String _sgp = '$_flagsPath' 'flag_as_se_singapore.svg';
  static const String _sxm = '$_flagsPath' 'flag_na_cr_sint maarten.svg';
  static const String _svk = '$_flagsPath' 'flag_eu_e_slovakia.svg';
  static const String _svn = '$_flagsPath' 'flag_eu_s_slovenia.svg';
  static const String _slb = '$_flagsPath' 'flag_oc_melan_solomon_islands.svg';
  static const String _som = '$_flagsPath' 'flag_af_e_somalia.svg';
  static const String _zaf = '$_flagsPath' 'flag_af_s_south_africa.svg';
  static const String _sgs = '$_flagsPath' 'flag_sa_south_georgia.svg';
  static const String _ssd = '$_flagsPath' 'flag_af_e_south_sudan.svg';
  static const String _esp = '$_flagsPath' 'flag_eu_s_spain.svg';
  static const String _lka = '$_flagsPath' 'flag_as_s_sri_lanka.svg';
  static const String _sdn = '$_flagsPath' 'flag_af_e_sudan.svg';
  static const String _sur = '$_flagsPath' 'flag_sa_suriname.svg';
  static const String _sjm = '$_flagsPath' 'flag_eu_n_svalbard_and_jan_mayen_islands.svg';
  static const String _swe = '$_flagsPath' 'flag_eu_n_sweden.svg';
  static const String _che = '$_flagsPath' 'flag_eu_w_switzerland.svg';
  static const String _syr = '$_flagsPath' 'flag_as_w_syria.svg';
  static const String _twn = '$_flagsPath' 'flag_as_e_taiwan.svg';
  static const String _tjk = '$_flagsPath' 'flag_as_c_tajikistan.svg';
  static const String _tza = '$_flagsPath' 'flag_af_e_tanzania.svg';
  static const String _tha = '$_flagsPath' 'flag_as_se_thailand.svg';
  static const String _tls = '$_flagsPath' 'flag_as_se_timor_leste.svg';
  static const String _tgo = '$_flagsPath' 'flag_af_w_togo.svg';
  static const String _tkl = '$_flagsPath' 'flag_oc_poly_tokelau.svg';
  static const String _ton = '$_flagsPath' 'flag_oc_poly_tonga.svg';
  static const String _tto = '$_flagsPath' 'flag_na_cr_trinidad_and_tobago.svg';
  static const String _tun = '$_flagsPath' 'flag_af_n_tunisia.svg';
  static const String _tur = '$_flagsPath' 'flag_as_w_turkey.svg';
  static const String _tkm = '$_flagsPath' 'flag_as_c_turkmenistan.svg';
  static const String _tca = '$_flagsPath' 'flag_na_cr_turks_and_caicos.svg';
  static const String _tuv = '$_flagsPath' 'flag_oc_poly_tuvalu.svg';
  static const String _uga = '$_flagsPath' 'flag_af_e_uganda.svg';
  static const String _ukr = '$_flagsPath' 'flag_eu_e_ukraine.svg';
  static const String _are = '$_flagsPath' 'flag_as_w_uae.svg';
  static const String _gbr = '$_flagsPath' 'flag_eu_n_united_kingdom.svg';
  static const String _usa = '$_flagsPath' 'flag_na_usa.svg';
  static const String _umi = '$_flagsPath' 'flag_na_usa.svg';
  static const String _ury = '$_flagsPath' 'flag_sa_uruguay.svg';
  static const String _uzb = '$_flagsPath' 'flag_as_c_uzbekistn.svg';
  static const String _vut = '$_flagsPath' 'flag_oc_melan_vanuatu.svg';
  static const String _ven = '$_flagsPath' 'flag_sa_venezuela.svg';
  static const String _vnm = '$_flagsPath' 'flag_as_se_vietnam.svg';
  static const String _vgb = '$_flagsPath' 'flag_na_cr_british_virgin_islands.svg';
  static const String _vir = '$_flagsPath' 'flag_na_cr_virgin_islands.svg';
  static const String _wlf = '$_flagsPath' 'flag_eu_w_france.svg';
  static const String _esh = '$_flagsPath' 'flag_af_n_western_sahara.svg';
  static const String _yem = '$_flagsPath' 'flag_as_w_yemen.svg';
  static const String _zmb = '$_flagsPath' 'flag_af_e_zambia.svg';
  static const String _zwe = '$_flagsPath' 'flag_af_e_zimbabwe.svg';
  static const String _euz = '$_flagsPath' 'flag_eu_euro.svg';
  static const String _xks = '$_flagsPath' 'flag_eu_s_kosovo.svg';
// -----------------------------------------------------------------------------

}

class CountryIso {
  /// --------------------------------------------------------------------------
  const CountryIso({
    @required this.countryID,
    @required this.iso,
  });
  /// --------------------------------------------------------------------------
  final String countryID;
  final String iso;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static String getCountryIDByIso(String iso) {

    final CountryIso _countryIso = _allCountriesIsoCodes.firstWhere(
          (CountryIso countryIso) => countryIso.iso == iso?.toLowerCase(),
      orElse: () => null,
    );

    if (_countryIso == null) {
      return null;
    }

    else {
      return _countryIso.countryID;
    }

  }
  // --------------------------------------------------------------------------
  static const List<CountryIso> _allCountriesIsoCodes = <CountryIso>[
    CountryIso(
      countryID: 'afg',
      iso: 'af',
    ),
    CountryIso(
      countryID: 'alb',
      iso: 'al',
    ),
    CountryIso(
      countryID: 'dza',
      iso: 'dz',
    ),
    CountryIso(
      countryID: 'asm',
      iso: 'as',
    ),
    CountryIso(
      countryID: 'and',
      iso: 'ad',
    ),
    CountryIso(
      countryID: 'ago',
      iso: 'ao',
    ),
    CountryIso(
      countryID: 'atg',
      iso: 'ag',
    ),
    CountryIso(
      countryID: 'arg',
      iso: 'ar',
    ),
    CountryIso(
      countryID: 'arm',
      iso: 'am',
    ),
    CountryIso(
      countryID: 'abw',
      iso: 'aw',
    ),
    CountryIso(
      countryID: 'aus',
      iso: 'au',
    ),
    CountryIso(
      countryID: 'aut',
      iso: 'at',
    ),
    CountryIso(
      countryID: 'aze',
      iso: 'az',
    ),
    CountryIso(
      countryID: 'bhs',
      iso: 'bs',
    ),
    CountryIso(
      countryID: 'bhr',
      iso: 'bh',
    ),
    CountryIso(
      countryID: 'bgd',
      iso: 'bd',
    ),
    CountryIso(
      countryID: 'brb',
      iso: 'bb',
    ),
    CountryIso(
      countryID: 'blr',
      iso: 'by',
    ),
    CountryIso(
      countryID: 'bel',
      iso: 'be',
    ),
    CountryIso(
      countryID: 'blz',
      iso: 'bz',
    ),
    CountryIso(
      countryID: 'ben',
      iso: 'bj',
    ),
    CountryIso(
      countryID: 'bmu',
      iso: 'bm',
    ),
    CountryIso(
      countryID: 'btn',
      iso: 'bt',
    ),
    CountryIso(
      countryID: 'bol',
      iso: 'bo',
    ),
    CountryIso(
      countryID: 'bih',
      iso: 'ba',
    ),
    CountryIso(
      countryID: 'bwa',
      iso: 'bw',
    ),
    CountryIso(
      countryID: 'bra',
      iso: 'br',
    ),
    CountryIso(
      countryID: 'brn',
      iso: 'bn',
    ),
    CountryIso(
      countryID: 'bgr',
      iso: 'bg',
    ),
    CountryIso(
      countryID: 'bfa',
      iso: 'bf',
    ),
    CountryIso(
      countryID: 'mmr',
      iso: 'mm',
    ),
    CountryIso(
      countryID: 'bdi',
      iso: 'bi',
    ),
    CountryIso(
      countryID: 'cpv',
      iso: 'cv',
    ),
    CountryIso(
      countryID: 'khm',
      iso: 'kh',
    ),
    CountryIso(
      countryID: 'cmr',
      iso: 'cm',
    ),
    CountryIso(
      countryID: 'can',
      iso: 'ca',
    ),
    CountryIso(
      countryID: 'cym',
      iso: 'ky',
    ),
    CountryIso(
      countryID: 'caf',
      iso: 'cf',
    ),
    CountryIso(
      countryID: 'tcd',
      iso: 'td',
    ),
    CountryIso(
      countryID: 'chl',
      iso: 'cl',
    ),
    CountryIso(
      countryID: 'chn',
      iso: 'cn',
    ),
    CountryIso(
      countryID: 'col',
      iso: 'co',
    ),
    CountryIso(
      countryID: 'com',
      iso: 'km',
    ),
    CountryIso(
      countryID: 'cog',
      iso: 'cg',
    ),
    CountryIso(
      countryID: 'cod',
      iso: 'cd',
    ),
    CountryIso(
      countryID: 'cok',
      iso: 'ck',
    ),
    CountryIso(
      countryID: 'cri',
      iso: 'cr',
    ),
    CountryIso(
      countryID: 'civ',
      iso: 'ci',
    ),
    CountryIso(
      countryID: 'hrv',
      iso: 'hr',
    ),
    CountryIso(
      countryID: 'cub',
      iso: 'cu',
    ),
    CountryIso(
      countryID: 'cuw',
      iso: 'cw',
    ),
    CountryIso(
      countryID: 'cyp',
      iso: 'cy',
    ),
    CountryIso(
      countryID: 'cze',
      iso: 'cz',
    ),
    CountryIso(
      countryID: 'dnk',
      iso: 'dk',
    ),
    CountryIso(
      countryID: 'dji',
      iso: 'dj',
    ),
    CountryIso(
      countryID: 'dma',
      iso: 'dm',
    ),
    CountryIso(
      countryID: 'dom',
      iso: 'do',
    ),
    CountryIso(
      countryID: 'ecu',
      iso: 'ec',
    ),
    CountryIso(
      countryID: 'egy',
      iso: 'eg',
    ),
    CountryIso(
      countryID: 'slv',
      iso: 'sv',
    ),
    CountryIso(
      countryID: 'gnq',
      iso: 'gq',
    ),
    CountryIso(
      countryID: 'eri',
      iso: 'er',
    ),
    CountryIso(
      countryID: 'est',
      iso: 'ee',
    ),
    CountryIso(
      countryID: 'eth',
      iso: 'et',
    ),
    CountryIso(
      countryID: 'flk',
      iso: 'fk',
    ),
    CountryIso(
      countryID: 'fro',
      iso: 'fo',
    ),
    CountryIso(
      countryID: 'fji',
      iso: 'fj',
    ),
    CountryIso(
      countryID: 'fin',
      iso: 'fi',
    ),
    CountryIso(
      countryID: 'fra',
      iso: 'fr',
    ),
    CountryIso(
      countryID: 'guf',
      iso: 'gf',
    ),
    CountryIso(
      countryID: 'pyf',
      iso: 'pf',
    ),
    CountryIso(
      countryID: 'gab',
      iso: 'ga',
    ),
    CountryIso(
      countryID: 'gmb',
      iso: 'gm',
    ),
    CountryIso(
      countryID: 'geo',
      iso: 'ge',
    ),
    CountryIso(
      countryID: 'deu',
      iso: 'de',
    ),
    CountryIso(
      countryID: 'gha',
      iso: 'gh',
    ),
    CountryIso(
      countryID: 'gib',
      iso: 'gi',
    ),
    CountryIso(
      countryID: 'grc',
      iso: 'gr',
    ),
    CountryIso(
      countryID: 'grl',
      iso: 'gl',
    ),
    CountryIso(
      countryID: 'grd',
      iso: 'gd',
    ),
    CountryIso(
      countryID: 'glp',
      iso: 'gp',
    ),
    CountryIso(
      countryID: 'gum',
      iso: 'gu',
    ),
    CountryIso(
      countryID: 'gtm',
      iso: 'gt',
    ),
    CountryIso(
      countryID: 'gin',
      iso: 'gn',
    ),
    CountryIso(
      countryID: 'gnb',
      iso: 'gw',
    ),
    CountryIso(
      countryID: 'guy',
      iso: 'gy',
    ),
    CountryIso(
      countryID: 'hti',
      iso: 'ht',
    ),
    CountryIso(
      countryID: 'hnd',
      iso: 'hn',
    ),
    CountryIso(
      countryID: 'hkg',
      iso: 'hk',
    ),
    CountryIso(
      countryID: 'hun',
      iso: 'hu',
    ),
    CountryIso(
      countryID: 'isl',
      iso: 'is',
    ),
    CountryIso(
      countryID: 'ind',
      iso: 'in',
    ),
    CountryIso(
      countryID: 'idn',
      iso: 'id',
    ),
    CountryIso(
      countryID: 'irn',
      iso: 'ir',
    ),
    CountryIso(
      countryID: 'irq',
      iso: 'iq',
    ),
    CountryIso(
      countryID: 'irl',
      iso: 'ie',
    ),
    CountryIso(
      countryID: 'imn',
      iso: 'im',
    ),
    CountryIso(
      countryID: 'isr',
      iso: 'il',
    ),
    CountryIso(
      countryID: 'ita',
      iso: 'it',
    ),
    CountryIso(
      countryID: 'jam',
      iso: 'jm',
    ),
    CountryIso(
      countryID: 'jpn',
      iso: 'jp',
    ),
    CountryIso(
      countryID: 'jey',
      iso: 'je',
    ),
    CountryIso(
      countryID: 'jor',
      iso: 'jo',
    ),
    CountryIso(
      countryID: 'kaz',
      iso: 'kz',
    ),
    CountryIso(
      countryID: 'ken',
      iso: 'ke',
    ),
    CountryIso(
      countryID: 'kir',
      iso: 'ki',
    ),
    CountryIso(
      countryID: 'prk',
      iso: 'kp',
    ),
    CountryIso(
      countryID: 'kor',
      iso: 'kr',
    ),
    CountryIso(
      countryID: 'xks',
      iso: 'xk',
    ),
    CountryIso(
      countryID: 'kwt',
      iso: 'kw',
    ),
    CountryIso(
      countryID: 'kgz',
      iso: 'kg',
    ),
    CountryIso(
      countryID: 'lao',
      iso: 'la',
    ),
    CountryIso(
      countryID: 'lva',
      iso: 'lv',
    ),
    CountryIso(
      countryID: 'lbn',
      iso: 'lb',
    ),
    CountryIso(
      countryID: 'lso',
      iso: 'ls',
    ),
    CountryIso(
      countryID: 'lbr',
      iso: 'lr',
    ),
    CountryIso(
      countryID: 'lby',
      iso: 'ly',
    ),
    CountryIso(
      countryID: 'lie',
      iso: 'li',
    ),
    CountryIso(
      countryID: 'ltu',
      iso: 'lt',
    ),
    CountryIso(
      countryID: 'lux',
      iso: 'lu',
    ),
    CountryIso(
      countryID: 'mac',
      iso: 'mo',
    ),
    CountryIso(
      countryID: 'mkd',
      iso: 'mk',
    ),
    CountryIso(
      countryID: 'mdg',
      iso: 'mg',
    ),
    CountryIso(
      countryID: 'mwi',
      iso: 'mw',
    ),
    CountryIso(
      countryID: 'mys',
      iso: 'my',
    ),
    CountryIso(
      countryID: 'mdv',
      iso: 'mv',
    ),
    CountryIso(
      countryID: 'mli',
      iso: 'ml',
    ),
    CountryIso(
      countryID: 'mlt',
      iso: 'mt',
    ),
    CountryIso(
      countryID: 'mhl',
      iso: 'mh',
    ),
    CountryIso(
      countryID: 'mtq',
      iso: 'mq',
    ),
    CountryIso(
      countryID: 'mrt',
      iso: 'mr',
    ),
    CountryIso(
      countryID: 'mus',
      iso: 'mu',
    ),
    CountryIso(
      countryID: 'myt',
      iso: 'yt',
    ),
    CountryIso(
      countryID: 'mex',
      iso: 'mx',
    ),
    CountryIso(
      countryID: 'fsm',
      iso: 'fm',
    ),
    CountryIso(
      countryID: 'mda',
      iso: 'md',
    ),
    CountryIso(
      countryID: 'mco',
      iso: 'mc',
    ),
    CountryIso(
      countryID: 'mng',
      iso: 'mn',
    ),
    CountryIso(
      countryID: 'mne',
      iso: 'me',
    ),
    CountryIso(
      countryID: 'mar',
      iso: 'ma',
    ),
    CountryIso(
      countryID: 'moz',
      iso: 'mz',
    ),
    CountryIso(
      countryID: 'nam',
      iso: 'na',
    ),
    CountryIso(
      countryID: 'npl',
      iso: 'np',
    ),
    CountryIso(
      countryID: 'nld',
      iso: 'nl',
    ),
    CountryIso(
      countryID: 'ncl',
      iso: 'nc',
    ),
    CountryIso(
      countryID: 'nzl',
      iso: 'nz',
    ),
    CountryIso(
      countryID: 'nic',
      iso: 'ni',
    ),
    CountryIso(
      countryID: 'ner',
      iso: 'ne',
    ),
    CountryIso(
      countryID: 'nga',
      iso: 'ng',
    ),
    CountryIso(
      countryID: 'mnp',
      iso: 'mp',
    ),
    CountryIso(
      countryID: 'nor',
      iso: 'no',
    ),
    CountryIso(
      countryID: 'omn',
      iso: 'om',
    ),
    CountryIso(
      countryID: 'pak',
      iso: 'pk',
    ),
    CountryIso(
      countryID: 'plw',
      iso: 'pw',
    ),
    CountryIso(
      countryID: 'pan',
      iso: 'pa',
    ),
    CountryIso(
      countryID: 'png',
      iso: 'pg',
    ),
    CountryIso(
      countryID: 'pry',
      iso: 'py',
    ),
    CountryIso(
      countryID: 'per',
      iso: 'pe',
    ),
    CountryIso(
      countryID: 'phl',
      iso: 'ph',
    ),
    CountryIso(
      countryID: 'pol',
      iso: 'pl',
    ),
    CountryIso(
      countryID: 'prt',
      iso: 'pt',
    ),
    CountryIso(
      countryID: 'pri',
      iso: 'pr',
    ),
    CountryIso(
      countryID: 'qat',
      iso: 'qa',
    ),
    CountryIso(
      countryID: 'reu',
      iso: 're',
    ),
    CountryIso(
      countryID: 'rou',
      iso: 'ro',
    ),
    CountryIso(
      countryID: 'rus',
      iso: 'ru',
    ),
    CountryIso(
      countryID: 'rwa',
      iso: 'rw',
    ),
    CountryIso(
      countryID: 'shn',
      iso: 'sh',
    ),
    CountryIso(
      countryID: 'kna',
      iso: 'kn',
    ),
    CountryIso(
      countryID: 'lca',
      iso: 'lc',
    ),
    CountryIso(
      countryID: 'vct',
      iso: 'vc',
    ),
    CountryIso(
      countryID: 'wsm',
      iso: 'ws',
    ),
    CountryIso(
      countryID: 'smr',
      iso: 'sm',
    ),
    CountryIso(
      countryID: 'stp',
      iso: 'st',
    ),
    CountryIso(
      countryID: 'sau',
      iso: 'sa',
    ),
    CountryIso(
      countryID: 'sen',
      iso: 'sn',
    ),
    CountryIso(
      countryID: 'srb',
      iso: 'rs',
    ),
    CountryIso(
      countryID: 'syc',
      iso: 'sc',
    ),
    CountryIso(
      countryID: 'sle',
      iso: 'sl',
    ),
    CountryIso(
      countryID: 'sgp',
      iso: 'sg',
    ),
    CountryIso(
      countryID: 'svk',
      iso: 'sk',
    ),
    CountryIso(
      countryID: 'svn',
      iso: 'si',
    ),
    CountryIso(
      countryID: 'slb',
      iso: 'sb',
    ),
    CountryIso(
      countryID: 'som',
      iso: 'so',
    ),
    CountryIso(
      countryID: 'zaf',
      iso: 'za',
    ),
    CountryIso(
      countryID: 'sgs',
      iso: 'gs',
    ),
    CountryIso(
      countryID: 'ssd',
      iso: 'ss',
    ),
    CountryIso(
      countryID: 'esp',
      iso: 'es',
    ),
    CountryIso(
      countryID: 'lka',
      iso: 'lk',
    ),
    CountryIso(
      countryID: 'sdn',
      iso: 'sd',
    ),
    CountryIso(
      countryID: 'sur',
      iso: 'sr',
    ),
    CountryIso(
      countryID: 'swz',
      iso: 'sz',
    ),
    CountryIso(
      countryID: 'swe',
      iso: 'se',
    ),
    CountryIso(
      countryID: 'che',
      iso: 'ch',
    ),
    CountryIso(
      countryID: 'syr',
      iso: 'sy',
    ),
    CountryIso(
      countryID: 'twn',
      iso: 'tw',
    ),
    CountryIso(
      countryID: 'tjk',
      iso: 'tj',
    ),
    CountryIso(
      countryID: 'tza',
      iso: 'tz',
    ),
    CountryIso(
      countryID: 'tha',
      iso: 'th',
    ),
    CountryIso(
      countryID: 'tls',
      iso: 'tl',
    ),
    CountryIso(
      countryID: 'tgo',
      iso: 'tg',
    ),
    CountryIso(
      countryID: 'ton',
      iso: 'to',
    ),
    CountryIso(
      countryID: 'tto',
      iso: 'tt',
    ),
    CountryIso(
      countryID: 'tun',
      iso: 'tn',
    ),
    CountryIso(
      countryID: 'tur',
      iso: 'tr',
    ),
    CountryIso(
      countryID: 'tkm',
      iso: 'tm',
    ),
    CountryIso(
      countryID: 'tca',
      iso: 'tc',
    ),
    CountryIso(
      countryID: 'tuv',
      iso: 'tv',
    ),
    CountryIso(
      countryID: 'uga',
      iso: 'ug',
    ),
    CountryIso(
      countryID: 'ukr',
      iso: 'ua',
    ),
    CountryIso(
      countryID: 'are',
      iso: 'ae',
    ),
    CountryIso(
      countryID: 'gbr',
      iso: 'gb',
    ),
    CountryIso(
      countryID: 'usa',
      iso: 'us',
    ),
    CountryIso(
      countryID: 'ury',
      iso: 'uy',
    ),
    CountryIso(
      countryID: 'uzb',
      iso: 'uz',
    ),
    CountryIso(
      countryID: 'vut',
      iso: 'vu',
    ),
    CountryIso(
      countryID: 'vat',
      iso: 'va',
    ),
    CountryIso(
      countryID: 'ven',
      iso: 've',
    ),
    CountryIso(
      countryID: 'vnm',
      iso: 'vn',
    ),
    CountryIso(
      countryID: 'wlf',
      iso: 'wf',
    ),
    CountryIso(
      countryID: 'pse',
      iso: 'xw',
    ),
    CountryIso(
      countryID: 'yem',
      iso: 'ye',
    ),
    CountryIso(
      countryID: 'zmb',
      iso: 'zm',
    ),
    CountryIso(
      countryID: 'zwe',
      iso: 'zw',
    ),
  ];
// -----------------------------------------------------------------------------
}
