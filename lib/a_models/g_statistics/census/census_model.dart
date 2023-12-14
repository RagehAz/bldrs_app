import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
/// => TAMAM
@immutable
class CensusModel {
  /// --------------------------------------------------------------------------
  const CensusModel({
    required this.id,
    required this.totalUsers,
    required this.totalBzz,
    required this.totalAuthors,
    required this.totalFlyers,
    required this.totalSlides,
    required this.bzSectionRealEstate,
    required this.bzSectionConstruction,
    required this.bzSectionSupplies,
    required this.bzTypeDeveloper,
    required this.bzTypeBroker,
    required this.bzTypeDesigner,
    required this.bzTypeContractor,
    required this.bzTypeArtisan,
    required this.bzTypeManufacturer,
    required this.bzTypeSupplier,
    required this.bzFormIndividual,
    required this.bzFormCompany,
    required this.bzAccountTypeStandard,
    required this.bzAccountTypePro,
    required this.bzAccountTypeMaster,
    required this.flyerTypeGeneral,
    required this.flyerTypeProperty,
    required this.flyerTypeDesign,
    required this.flyerTypeUndertaking,
    required this.flyerTypeTrade,
    required this.flyerTypeProduct,
    required this.flyerTypeEquipment,
    required this.needTypeSeekProperty,
    required this.needTypePlanConstruction,
    required this.needTypeFinishConstruction,
    required this.needTypeFurnish,
    required this.needTypeOfferProperty,
    required this.savesGeneral,
    required this.savesProperties,
    required this.savesDesigns,
    required this.savesUndertakings,
    required this.savesTrades,
    required this.savesProducts,
    required this.savesEquipments,
    required this.followsDevelopers,
    required this.followsBrokers,
    required this.followsDesigners,
    required this.followsContractors,
    required this.followsArtisans,
    required this.followsManufacturers,
    required this.followsSuppliers,
    required this.callsDevelopers,
    required this.callsBrokers,
    required this.callsDesigners,
    required this.callsContractors,
    required this.callsArtisans,
    required this.callsManufacturers,
    required this.callsSuppliers,
  });
  // --------------------------------------------------------------------------
  final String? id;
  /// TOTALS
  final int totalUsers;
  final int totalBzz;
  final int totalAuthors;
  final int totalFlyers;
  final int totalSlides;
  /// BZ SECTIONS
  final int bzSectionRealEstate;
  final int bzSectionConstruction;
  final int bzSectionSupplies;
  /// BZ TYPES
  final int bzTypeDeveloper;
  final int bzTypeBroker;
  final int bzTypeDesigner;
  final int bzTypeContractor;
  final int bzTypeArtisan;
  final int bzTypeManufacturer;
  final int bzTypeSupplier;
  /// BZ FORMS
  final int bzFormIndividual;
  final int bzFormCompany;
  /// BZ ACCOUNT TYPES
  final int bzAccountTypeStandard;
  final int bzAccountTypePro;
  final int bzAccountTypeMaster;
  /// FLYER TYPES
  final int flyerTypeGeneral;
  final int flyerTypeProperty;
  final int flyerTypeDesign;
  final int flyerTypeUndertaking;
  final int flyerTypeTrade;
  final int flyerTypeProduct;
  final int flyerTypeEquipment;
  /// NEED TYPES
  final int needTypeSeekProperty;
  final int needTypePlanConstruction;
  final int needTypeFinishConstruction;
  final int needTypeFurnish;
  final int needTypeOfferProperty;
  /// SAVES
  final int savesGeneral;
  final int savesProperties;
  final int savesDesigns;
  final int savesUndertakings;
  final int savesTrades;
  final int savesProducts;
  final int savesEquipments;
  /// FOLLOWS
  final int followsDevelopers;
  final int followsBrokers;
  final int followsDesigners;
  final int followsContractors;
  final int followsArtisans;
  final int followsManufacturers;
  final int followsSuppliers;
  /// CALLS
  final int callsDevelopers;
  final int callsBrokers;
  final int callsDesigners;
  final int callsContractors;
  final int callsArtisans;
  final int callsManufacturers;
  final int callsSuppliers;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  CensusModel copyWith({
    String? id,
    int? totalUsers,
    int? totalBzz,
    int? totalAuthors,
    int? totalFlyers,
    int? totalSlides,
    int? bzSectionRealEstate,
    int? bzSectionConstruction,
    int? bzSectionSupplies,
    int? bzTypeDeveloper,
    int? bzTypeBroker,
    int? bzTypeDesigner,
    int? bzTypeContractor,
    int? bzTypeArtisan,
    int? bzTypeManufacturer,
    int? bzTypeSupplier,
    int? bzFormIndividual,
    int? bzFormCompany,
    int? bzAccountTypeStandard,
    int? bzAccountTypePro,
    int? bzAccountTypeMaster,
    int? flyerTypeGeneral,
    int? flyerTypeProperty,
    int? flyerTypeDesign,
    int? flyerTypeUndertaking,
    int? flyerTypeProduct,
    int? flyerTypeTrade,
    int? flyerTypeEquipment,
    int? needTypeSeekProperty,
    int? needTypePlanConstruction,
    int? needTypeFinishConstruction,
    int? needTypeFurnish,
    int? needTypeOfferProperty,
    int? savesGeneral,
    int? savesProperties,
    int? savesDesigns,
    int? savesUndertakings,
    int? savesTrades,
    int? savesProducts,
    int? savesEquipments,
    int? followsDevelopers,
    int? followsBrokers,
    int? followsDesigners,
    int? followsContractors,
    int? followsArtisans,
    int? followsManufacturers,
    int? followsSuppliers,
    int? callsDevelopers,
    int? callsBrokers,
    int? callsDesigners,
    int? callsContractors,
    int? callsArtisans,
    int? callsManufacturers,
    int? callsSuppliers,
  }){

    return CensusModel(
      id: id ?? this.id,
      totalUsers: totalUsers ?? this.totalUsers,
      totalBzz: totalBzz ?? this.totalBzz,
      totalAuthors: totalAuthors ?? this.totalAuthors,
      totalFlyers: totalFlyers ?? this.totalFlyers,
      totalSlides: totalSlides ?? this.totalSlides,
      bzSectionRealEstate: bzSectionRealEstate ?? this.bzSectionRealEstate,
      bzSectionConstruction: bzSectionConstruction ?? this.bzSectionConstruction,
      bzSectionSupplies: bzSectionSupplies ?? this.bzSectionSupplies,
      bzTypeDeveloper: bzTypeDeveloper ?? this.bzTypeDeveloper,
      bzTypeBroker: bzTypeBroker ?? this.bzTypeBroker,
      bzTypeDesigner: bzTypeDesigner ?? this.bzTypeDesigner,
      bzTypeContractor: bzTypeContractor ?? this.bzTypeContractor,
      bzTypeArtisan: bzTypeArtisan ?? this.bzTypeArtisan,
      bzTypeManufacturer: bzTypeManufacturer ?? this.bzTypeManufacturer,
      bzTypeSupplier: bzTypeSupplier ?? this.bzTypeSupplier,
      bzFormIndividual: bzFormIndividual ?? this.bzFormIndividual,
      bzFormCompany: bzFormCompany ?? this.bzFormCompany,
      bzAccountTypeStandard: bzAccountTypeStandard ?? this.bzAccountTypeStandard,
      bzAccountTypePro: bzAccountTypePro ?? this.bzAccountTypePro,
      bzAccountTypeMaster: bzAccountTypeMaster ?? this.bzAccountTypeMaster,
      flyerTypeGeneral: flyerTypeGeneral ?? this.flyerTypeGeneral,
      flyerTypeProperty: flyerTypeProperty ?? this.flyerTypeProperty,
      flyerTypeDesign: flyerTypeDesign ?? this.flyerTypeDesign,
      flyerTypeUndertaking: flyerTypeUndertaking ?? this.flyerTypeUndertaking,
      flyerTypeProduct: flyerTypeProduct ?? this.flyerTypeProduct,
      flyerTypeTrade: flyerTypeTrade ?? this.flyerTypeTrade,
      flyerTypeEquipment: flyerTypeEquipment ?? this.flyerTypeEquipment,
      needTypeSeekProperty: needTypeSeekProperty ?? this.needTypeSeekProperty,
      needTypePlanConstruction: needTypePlanConstruction ?? this.needTypePlanConstruction,
      needTypeFinishConstruction: needTypeFinishConstruction ?? this.needTypeFinishConstruction,
      needTypeFurnish: needTypeFurnish ?? this.needTypeFurnish,
      needTypeOfferProperty: needTypeOfferProperty ?? this.needTypeOfferProperty,
      savesGeneral: savesGeneral ?? this.savesGeneral,
      savesProperties: savesProperties ?? this.savesProperties,
      savesDesigns: savesDesigns ?? this.savesDesigns,
      savesUndertakings: savesUndertakings ?? this.savesUndertakings,
      savesTrades: savesTrades ?? this.savesTrades,
      savesProducts: savesProducts ?? this.savesProducts,
      savesEquipments: savesEquipments ?? this.savesEquipments,
      followsDevelopers: followsDevelopers ?? this.followsDevelopers,
      followsBrokers: followsBrokers ?? this.followsBrokers,
      followsDesigners: followsDesigners ?? this.followsDesigners,
      followsContractors: followsContractors ?? this.followsContractors,
      followsArtisans: followsArtisans ?? this.followsArtisans,
      followsManufacturers: followsManufacturers ?? this.followsManufacturers,
      followsSuppliers: followsSuppliers ?? this.followsSuppliers,
      callsDevelopers: callsDevelopers ?? this.callsDevelopers,
      callsBrokers: callsBrokers ?? this.callsBrokers,
      callsDesigners: callsDesigners ?? this.callsDesigners,
      callsContractors: callsContractors ?? this.callsContractors,
      callsArtisans: callsArtisans ?? this.callsArtisans,
      callsManufacturers: callsManufacturers ?? this.callsManufacturers,
      callsSuppliers: callsSuppliers ?? this.callsSuppliers,
    );

  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    required bool toLDB,
  }){

    Map<String, dynamic> _map = {
      'totalUsers': totalUsers,
      'totalBzz': totalBzz,
      'totalAuthors': totalAuthors,
      'totalFlyers': totalFlyers,
      'totalSlides': totalSlides,
      'bzSectionRealEstate': bzSectionRealEstate,
      'bzSectionConstruction': bzSectionConstruction,
      'bzSectionSupplies': bzSectionSupplies,
      'bzTypeDeveloper': bzTypeDeveloper,
      'bzTypeBroker': bzTypeBroker,
      'bzTypeDesigner': bzTypeDesigner,
      'bzTypeContractor': bzTypeContractor,
      'bzTypeArtisan': bzTypeArtisan,
      'bzTypeManufacturer': bzTypeManufacturer,
      'bzTypeSupplier': bzTypeSupplier,
      'bzFormIndividual': bzFormIndividual,
      'bzFormCompany': bzFormCompany,
      'bzAccountTypeStandard': bzAccountTypeStandard,
      'bzAccountTypePro': bzAccountTypePro,
      'bzAccountTypeMaster': bzAccountTypeMaster,
      'flyerTypeGeneral': flyerTypeGeneral,
      'flyerTypeProperty': flyerTypeProperty,
      'flyerTypeDesign': flyerTypeDesign,
      'flyerTypeUndertaking': flyerTypeUndertaking,
      'flyerTypeProduct': flyerTypeProduct,
      'flyerTypeTrade': flyerTypeTrade,
      'flyerTypeEquipment': flyerTypeEquipment,
      'needTypeSeekProperty': needTypeSeekProperty,
      'needTypePlanConstruction': needTypePlanConstruction,
      'needTypeFinishConstruction': needTypeFinishConstruction,
      'needTypeFurnish': needTypeFurnish,
      'needTypeOfferProperty': needTypeOfferProperty,
      'savesGeneral': savesGeneral,
      'savesProperties': savesProperties,
      'savesDesigns': savesDesigns,
      'savesUndertakings': savesUndertakings,
      'savesTrades': savesTrades,
      'savesProducts': savesProducts,
      'savesEquipments': savesEquipments,
      'followsDevelopers': followsDevelopers,
      'followsBrokers': followsBrokers,
      'followsDesigners': followsDesigners,
      'followsContractors': followsContractors,
      'followsArtisans': followsArtisans,
      'followsManufacturers': followsManufacturers,
      'followsSuppliers': followsSuppliers,
      'callsDevelopers': callsDevelopers,
      'callsBrokers': callsBrokers,
      'callsDesigners': callsDesigners,
      'callsContractors': callsContractors,
      'callsArtisans': callsArtisans,
      'callsManufacturers': callsManufacturers,
      'callsSuppliers': callsSuppliers,
    };

    if (toLDB == true){

      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'id',
        value: id,
        overrideExisting: true,
      );

    }

    return _map;
  }
  // --------------------
  /// not tested
  static List<Map<String, dynamic>> cipherCensuses({
    required List<CensusModel> censuses,
    required bool toLDB,
  }){
    final List<Map<String, dynamic>> _output = [];

    if (Lister.checkCanLoop(censuses) == true){

      for (final CensusModel _census in censuses){

        _output.add(_census.toMap(toLDB: toLDB));

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CensusModel? decipher({
    required Map<String, dynamic>? map,
    required String id,
  }){

    CensusModel? _output;

    if (map != null){

      // Mapper.blogMap(map);

      _output = CensusModel(
        id: map['id'] ?? id,
        totalUsers: map['totalUsers'],
        totalBzz: map['totalBzz'],
        totalAuthors: map['totalAuthors'],
        totalFlyers: map['totalFlyers'],
        totalSlides: map['totalSlides'],
        bzSectionRealEstate: map['bzSectionRealEstate'],
        bzSectionConstruction: map['bzSectionConstruction'],
        bzSectionSupplies: map['bzSectionSupplies'],
        bzTypeDeveloper: map['bzTypeDeveloper'],
        bzTypeBroker: map['bzTypeBroker'],
        bzTypeDesigner: map['bzTypeDesigner'],
        bzTypeContractor: map['bzTypeContractor'],
        bzTypeArtisan: map['bzTypeArtisan'],
        bzTypeManufacturer: map['bzTypeManufacturer'],
        bzTypeSupplier: map['bzTypeSupplier'],
        bzFormIndividual: map['bzFormIndividual'],
        bzFormCompany: map['bzFormCompany'],
        bzAccountTypeStandard: map['bzAccountTypeStandard'],
        bzAccountTypePro: map['bzAccountTypePro'],
        bzAccountTypeMaster: map['bzAccountTypeMaster'],
        flyerTypeGeneral: map['flyerTypeGeneral'],
        flyerTypeProperty: map['flyerTypeProperty'],
        flyerTypeDesign: map['flyerTypeDesign'],
        flyerTypeUndertaking: map['flyerTypeUndertaking'],
        flyerTypeProduct: map['flyerTypeProduct'],
        flyerTypeTrade: map['flyerTypeTrade'],
        flyerTypeEquipment: map['flyerTypeEquipment'],
        needTypeSeekProperty: map['needTypeSeekProperty'],
        needTypePlanConstruction: map['needTypePlanConstruction'],
        needTypeFinishConstruction: map['needTypeFinishConstruction'],
        needTypeFurnish: map['needTypeFurnish'],
        needTypeOfferProperty: map['needTypeOfferProperty'],
        savesGeneral: map['savesGeneral'],
        savesProperties: map['savesProperties'],
        savesDesigns: map['savesDesigns'],
        savesUndertakings: map['savesUndertakings'],
        savesTrades: map['savesTrades'],
        savesProducts: map['savesProducts'],
        savesEquipments: map['savesEquipments'],
        followsDevelopers: map['followsDevelopers'],
        followsBrokers: map['followsBrokers'],
        followsDesigners: map['followsDesigners'],
        followsContractors: map['followsContractors'],
        followsArtisans: map['followsArtisans'],
        followsManufacturers: map['followsManufacturers'],
        followsSuppliers: map['followsSuppliers'],
        callsDevelopers: map['callsDevelopers'],
        callsBrokers: map['callsBrokers'],
        callsDesigners: map['callsDesigners'],
        callsContractors: map['callsContractors'],
        callsArtisans: map['callsArtisans'],
        callsManufacturers: map['callsManufacturers'],
        callsSuppliers: map['callsSuppliers'],
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CensusModel> decipherCensuses(List<Map<String, dynamic>>? maps){
    final List<CensusModel> _output = <CensusModel>[];

    if (Lister.checkCanLoop(maps) == true){

      for (final Map<String, dynamic> _map in maps!){

        final CensusModel? _model = decipher(
          map: _map,
          id: _map['id'],
        );

        if (_model != null){
          _output.add(_model);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// AGENDA MODEL CYPHER

  // --------------------
  /*
  /// TASK : TEST ME
  static Map<String, dynamic> cypherAgendaToCensusX({
    required bool isIncrementing,
    required AgendaModel agenda,
  }){

    /// AGENDA IS NULL
    if (agenda == null){
      return null;
    }

    /// AGENDA IS NOT NULL
    else {

      final int _increment = isIncrementing ? 1 : -1;

      return {
        'followsDevelopers'   : fireDB.ServerValue.increment(agenda?.developers?.length    ?? 0  * _increment),
        'followsBrokers'      : fireDB.ServerValue.increment(agenda?.brokers?.length       ?? 0  * _increment),
        'followsDesigners'    : fireDB.ServerValue.increment(agenda?.designers?.length     ?? 0  * _increment),
        'followsContractors'  : fireDB.ServerValue.increment(agenda?.contractors?.length   ?? 0  * _increment),
        'followsArtisans'     : fireDB.ServerValue.increment(agenda?.artisans?.length      ?? 0  * _increment),
        'followsManufacturers': fireDB.ServerValue.increment(agenda?.manufacturers?.length ?? 0  * _increment),
        'followsSuppliers'    : fireDB.ServerValue.increment(agenda?.suppliers?.length     ?? 0  * _increment),
      };

    }

  }
   */
  // -----------------------------------------------------------------------------

  /// DECK MODEL CYPHER

  // --------------------
  /*
  /// TASK : TEST ME
  static Map<String, dynamic> cypherDeckToCensusX({
    required bool isIncrementing,
    required DeckModel deck,
  }){

    /// DECK IS NULL
    if (deck == null){
      return null;
    }

    /// DECK HAS VALUE
    else {
      final int _increment = isIncrementing ? 1 : -1;

      return {
        'savesGeneral':      fireDB.ServerValue.increment(deck?.general?.length       ?? 0 * _increment),
        'savesProperties':   fireDB.ServerValue.increment(deck?.properties?.length    ?? 0 * _increment),
        'savesDesigns':      fireDB.ServerValue.increment(deck?.designs?.length       ?? 0 * _increment),
        'savesUndertakings': fireDB.ServerValue.increment(deck?.undertakings?.length  ?? 0 * _increment),
        'savesTrades':       fireDB.ServerValue.increment(deck?.trades?.length        ?? 0 * _increment),
        'savesProducts':     fireDB.ServerValue.increment(deck?.products?.length      ?? 0 * _increment),
        'savesEquipments':   fireDB.ServerValue.increment(deck?.equipment?.length     ?? 0 * _increment),
      };
    }

  }
   */
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static CensusModel createEmptyModel({
    required String? id,
  }){
    return CensusModel(
      id: id,
      totalUsers: 0,
      totalBzz: 0,
      totalAuthors: 0,
      totalFlyers: 0,
      totalSlides: 0,
      bzSectionRealEstate: 0,
      bzSectionConstruction: 0,
      bzSectionSupplies: 0,
      bzTypeDeveloper: 0,
      bzTypeBroker: 0,
      bzTypeDesigner: 0,
      bzTypeContractor: 0,
      bzTypeArtisan: 0,
      bzTypeManufacturer: 0,
      bzTypeSupplier: 0,
      bzFormIndividual: 0,
      bzFormCompany: 0,
      bzAccountTypeStandard: 0,
      bzAccountTypePro: 0,
      bzAccountTypeMaster: 0,
      flyerTypeGeneral: 0,
      flyerTypeProperty: 0,
      flyerTypeDesign: 0,
      flyerTypeUndertaking: 0,
      flyerTypeProduct: 0,
      flyerTypeTrade: 0,
      flyerTypeEquipment: 0,
      needTypeSeekProperty: 0,
      needTypePlanConstruction: 0,
      needTypeFinishConstruction: 0,
      needTypeFurnish: 0,
      needTypeOfferProperty: 0,
      savesGeneral: 0,
      savesProperties: 0,
      savesDesigns: 0,
      savesUndertakings: 0,
      savesTrades: 0,
      savesProducts: 0,
      savesEquipments: 0,
      followsDevelopers: 0,
      followsBrokers: 0,
      followsDesigners: 0,
      followsContractors: 0,
      followsArtisans: 0,
      followsManufacturers: 0,
      followsSuppliers: 0,
      callsDevelopers: 0,
      callsBrokers: 0,
      callsDesigners: 0,
      callsContractors: 0,
      callsArtisans: 0,
      callsManufacturers: 0,
      callsSuppliers: 0,
    );
  }
  // -----------------------------------------------------------------------------

  /// CREATE USER CENSUS MAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> createUserCensusMap({
    required UserModel? userModel,
    required bool isIncrementing,
  }){

    final int _increment = isIncrementing ? 1 : -1;

    Map<String, dynamic> _map = {
      /// TOTAL USERS
      'totalUsers' : _increment,
    };

    /// NEED
    if (userModel?.need?.needType != null){
      /// NEED TYPES
      _map = Mapper.insertPairInMap(
        map: _map,
        key: CensusModel.getNeedTypeFieldName(userModel?.need?.needType),
        value: _increment,
        overrideExisting: true,
      );
    }

    return _map;
  }
  // -----------------------------------------------------------------------------

  /// CREATE FOLLOW CENSUS MAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? createFollowCensusMap({
    required BzModel? bzModel,
    required bool isIncrementing,
    int count = 1,
  }){
    Map<String, dynamic> _map = {};

    if (bzModel != null){

      if (Lister.checkCanLoop(bzModel.bzTypes) == true){

        final int _increment = isIncrementing ? count : -count;

        for (final BzType bzType in bzModel.bzTypes!){
          _map = Mapper.insertPairInMap(
            map: _map,
            key: CensusModel.getFollowBzTypeFieldName(bzType),
            value: _increment,
            overrideExisting: true,
          );
        }

      }

    }

    return _map;
  }
  // --------------------
  /// NOTE : WE WILL NOT WIPE FOLLOW CENSUS ON USER WIPE
  // --------------------------------------------------

  /// CREATE SAVE CENSUS MAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> createFlyerSaveCensusMap({
    required FlyerModel flyerModel,
    required bool isIncrementing,
    int count = 1,
  }){

    // assert(flyerModel != null, 'flyerModel is null');

    final int _increment = isIncrementing ? count : -count;

    final Map<String, dynamic> _map = {};

    return Mapper.insertPairInMap(
      map: _map,
      key: CensusModel.getFlyerSaveFieldName(flyerModel.flyerType),
      value: _increment,
      overrideExisting: true,
    );
  }
  // --------------------
  /// NOTE : WE WILL NOTE WIPE FLYER SAVES CENSUS ON USER WIPE
  // --------------------------------------------------

  /// CREATE BZ CENSUS MAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> createBzCensusMap({
    required BzModel? bzModel,
    required bool isIncrementing,
  }){

    final int _increment = isIncrementing ? 1 : -1;

    Map<String, dynamic> _map = {
      /// TOTAL BZZ
      'totalBzz' : _increment,
      /// TOTAL AUTHORS
      'totalAuthors' : (bzModel?.authors?.length ?? 0) * _increment,
    };

    /// SECTION
    _map = Mapper.insertPairInMap(
      map: _map,
      key: CensusModel.getBzSectionFieldName(BzTyper.concludeBzSectionByBzTypes(bzModel?.bzTypes)),
      value: _increment,
      overrideExisting: true,
    );

    /// TYPE
    if (Lister.checkCanLoop(bzModel?.bzTypes) == true){
      for (final BzType bzType in bzModel!.bzTypes!){
        _map = Mapper.insertPairInMap(
          map: _map,
          key: CensusModel.getBzTypeFieldName(bzType),
          value: _increment,
          overrideExisting: true,
        );
      }
    }

    /// FORM
    _map = Mapper.insertPairInMap(
      map: _map,
      key: CensusModel.getBzFormFieldName(bzModel?.bzForm),
      value: _increment,
      overrideExisting: true,
    );

    /// ACCOUNT TYPE
    _map = Mapper.insertPairInMap(
      map: _map,
      key: CensusModel.getBzAccountTypeFieldName(bzModel?.accountType),
      value: _increment,
      overrideExisting: true,
    );

    return _map;
  }
  // --------------------------------------------------

  /// CREATE CALL CENSUS MAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> createCallCensusMap({
    required BzModel? bzModel,
    required bool isIncrementing, // WILL ALWAYS BE TRUE
    int count = 1,
  }){
    Map<String, dynamic> _map = {};

    if (bzModel != null){

      if (Lister.checkCanLoop(bzModel.bzTypes) == true){

        final int _increment = isIncrementing ? count : -count;

        for (final BzType bzType in bzModel.bzTypes!){

          _map = Mapper.insertPairInMap(
            map: _map,
            key: CensusModel.getCallBzTypeFieldName(bzType),
            value: _increment,
            overrideExisting: true,
          );
        }

      }

    }

    return _map;
  }
  // --------------------
  /// REMINDER : WE DO NOT WIPE CALLS CENSUS ON BZ WIPE
  static Future<Map<String, dynamic>> createCallsWipeMap(BzModel bzModel) async {

    /// NOTE : ON BZ WIPE : WE WILL NOT WIPE CALLS COUNT WHILE WIPING A BZ ACCOUNT
    /// WHY
    /// we can not track bz account type changes,
    /// and as call census map respects bz type,, and increment each type for each call
    /// that means that when a user calls a bz account, while the bz account has two types
    /// this increments calls census in both bz types for that single call
    /// and if bz account changed its bz types
    /// then we can not trace his calls and change their census,,
    /// "we can but it's just too complex and not worth it"
    /// so
    /// we will skip the feature where we delete calls count in census when we delete a bz account

    /// DEPRECATED
    // assert(bzModel != null, 'bzModel is null');
    //
    // Map<String, dynamic> _map = <String, dynamic>{};
    //
    // /// NOTE : MAKE SURE TO DELETE COUNTING BZ LOCATION AFTER READING THIS INFO IN WIPE BZ PROTOCOLS
    // final int _callsCount = await Real.readPath(
    //   path: '${RealColl.countingBzz}/${bzModel.id}/calls',
    // );
    //
    // if (_callsCount != null && _callsCount > 0){
    //
    //   if (Lister.checkCanLoop(bzModel.bzTypes) == true){
    //
    //     for (final BzType bzType in bzModel.bzTypes){
    //       _map = Mapper.insertPairInMap(
    //         map: _map,
    //         key: CensusModel.getCallBzTypeFieldName(bzType),
    //         value: fireDB.ServerValue.increment(_callsCount * -1),
    //       );
    //     }
    //
    //   }
    //
    // }

    return <String, dynamic>{};
  }
  // --------------------------------------------------

  /// CREATE FLYER CENSUS MAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> createFlyerCensusMap({
    required FlyerModel flyerModel,
    required bool isIncrementing,
  }){

    final int _increment = isIncrementing ? 1 : -1;

    final Map<String, dynamic> _map = {
      /// TOTAL FLYERS
      'totalFlyers' : _increment,
      /// TOTAL SLIDES
      'totalSlides' : (flyerModel.slides?.length ?? 0) * _increment,
    };

    /// FLYER TYPE
    return Mapper.insertPairInMap(
      map: _map,
      key: CensusModel.getFlyerTypeFieldName(flyerModel.flyerType),
      value: _increment,
      overrideExisting: true,
    );

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, int> completeMapForIncrementation(Map<String, dynamic>? input){
    Map<String, dynamic>? _output;

    /// NOTE : THIS METHOD MAKES SURE THAT NO FIELD IN CENSUS MODEL IS NULL ON CENSUS PROTOCOLS

    if (input != null){

      _output = {};
      final Map<String, dynamic> _fullMap = createEmptyModel(id: input['id']).toMap(
        toLDB: false, // this is not used for LDB but only for REAL DB
      );
      final List<String> _allKeys = _fullMap.keys.toList();

      for (final String _key in _allKeys){

        /// WHEN KEY IS ABSENT
        if (input[_key] == null){
          _output = Mapper.insertPairInMap(
            map: _output,
            key: _key,
            value: 0, /// ADD NO INCREMENTATION IN THIS FIELD
            overrideExisting: true,
          );
        }

        /// KEY IS DEFINED
        else {
          _output = Mapper.insertPairInMap(
            map: _output,
            key: _key,
            value: input[_key], /// ADD THE FIELD THAT'S ALREADY DEFINED BY PREVIOUS METHODS
            overrideExisting: true,
          );
        }


      }

    }

    return _getStringIntFromStringDynamic(_output);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, int> _getStringIntFromStringDynamic(Map<String, dynamic>? maw){
    final Map<String, int> _output = {};

    if (maw != null){

      final List<String> _keys = maw.keys.toList();
      if (Lister.checkCanLoop(_keys) == true){

        for (final String key in _keys){

          if (maw[key] is int){
            _output[key] = maw[key];
          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CensusModel? combineUSACensuses({
    required List<CensusModel>? models,
  }){
    CensusModel? _output;

    if (Lister.checkCanLoop(models) == true){

      _output = createEmptyModel(id: 'usa');

      for (final CensusModel model in models!){

        final bool _isState = America.checkCountryIDIsStateID(model.id);

        if (_isState == true){

          _output = _output!.copyWith(
            id: 'usa',
            totalUsers: _output.totalUsers + model.totalUsers,
            totalBzz: _output.totalBzz + model.totalBzz,
            totalAuthors: _output.totalAuthors + model.totalAuthors,
            totalFlyers: _output.totalFlyers + model.totalFlyers,
            totalSlides: _output.totalSlides + model.totalSlides,
            bzSectionRealEstate: _output.bzSectionRealEstate + model.bzSectionRealEstate,
            bzSectionConstruction: _output.bzSectionConstruction + model.bzSectionConstruction,
            bzSectionSupplies: _output.bzSectionSupplies + model.bzSectionSupplies,
            bzTypeDeveloper: _output.bzTypeDeveloper + model.bzTypeDeveloper,
            bzTypeBroker: _output.bzTypeBroker + model.bzTypeBroker,
            bzTypeDesigner: _output.bzTypeDesigner + model.bzTypeDesigner,
            bzTypeContractor: _output.bzTypeContractor + model.bzTypeContractor,
            bzTypeArtisan: _output.bzTypeArtisan + model.bzTypeArtisan,
            bzTypeManufacturer: _output.bzTypeManufacturer + model.bzTypeManufacturer,
            bzTypeSupplier: _output.bzTypeSupplier + model.bzTypeSupplier,
            bzFormIndividual: _output.bzFormIndividual + model.bzFormIndividual,
            bzFormCompany: _output.bzFormCompany + model.bzFormCompany,
            bzAccountTypeStandard: _output.bzAccountTypeStandard + model.bzAccountTypeStandard,
            bzAccountTypePro: _output.bzAccountTypePro + model.bzAccountTypePro,
            bzAccountTypeMaster: _output.bzAccountTypeMaster + model.bzAccountTypeMaster,
            flyerTypeGeneral: _output.flyerTypeGeneral + model.flyerTypeGeneral,
            flyerTypeProperty: _output.flyerTypeProperty + model.flyerTypeProperty,
            flyerTypeDesign: _output.flyerTypeDesign + model.flyerTypeDesign,
            flyerTypeUndertaking: _output.flyerTypeUndertaking + model.flyerTypeUndertaking,
            flyerTypeProduct: _output.flyerTypeProduct + model.flyerTypeProduct,
            flyerTypeTrade: _output.flyerTypeTrade + model.flyerTypeTrade,
            flyerTypeEquipment: _output.flyerTypeEquipment + model.flyerTypeEquipment,
            needTypeSeekProperty: _output.needTypeSeekProperty + model.needTypeSeekProperty,
            needTypePlanConstruction: _output.needTypePlanConstruction + model.needTypePlanConstruction,
            needTypeFinishConstruction: _output.needTypeFinishConstruction + model.needTypeFinishConstruction,
            needTypeFurnish: _output.needTypeFurnish + model.needTypeFurnish,
            needTypeOfferProperty: _output.needTypeOfferProperty + model.needTypeOfferProperty,
            savesGeneral: _output.savesGeneral + model.savesGeneral,
            savesProperties: _output.savesProperties + model.savesProperties,
            savesDesigns: _output.savesDesigns + model.savesDesigns,
            savesUndertakings: _output.savesUndertakings + model.savesUndertakings,
            savesTrades: _output.savesTrades + model.savesTrades,
            savesProducts: _output.savesProducts + model.savesProducts,
            savesEquipments: _output.savesEquipments + model.savesEquipments,
            followsDevelopers: _output.followsDevelopers + model.followsDevelopers,
            followsBrokers: _output.followsBrokers + model.followsBrokers,
            followsDesigners: _output.followsDesigners + model.followsDesigners,
            followsContractors: _output.followsContractors + model.followsContractors,
            followsArtisans: _output.followsArtisans + model.followsArtisans,
            followsManufacturers: _output.followsManufacturers + model.followsManufacturers,
            followsSuppliers: _output.followsSuppliers + model.followsSuppliers,
            callsDevelopers: _output.callsDevelopers + model.callsDevelopers,
            callsBrokers: _output.callsBrokers + model.callsBrokers,
            callsDesigners: _output.callsDesigners + model.callsDesigners,
            callsContractors: _output.callsContractors + model.callsContractors,
            callsArtisans: _output.callsArtisans + model.callsArtisans,
            callsManufacturers: _output.callsManufacturers + model.callsManufacturers,
            callsSuppliers: _output.callsSuppliers + model.callsSuppliers,
          );

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GET FIELD NAME (NEEDS)

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getNeedTypeFieldName(NeedType? needType){
    switch (needType) {
      case NeedType.seekProperty :       return 'needTypeSeekProperty';
      case NeedType.planConstruction :   return 'needTypePlanConstruction';
      case NeedType.finishConstruction : return 'needTypeFinishConstruction';
      case NeedType.furnish :            return 'needTypeFurnish';
      case NeedType.offerProperty :      return 'needTypeOfferProperty';
      default:return null;
      }
  }
  // -----------------------------------------------------------------------------

  /// GET FIELD NAME (SAVES)

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFlyerSaveFieldName(FlyerType? flyerType){
    switch (flyerType) {
      case FlyerType.general      : return 'savesGeneral';
      case FlyerType.property     : return 'savesProperties';
      case FlyerType.design       : return 'savesDesigns';
      case FlyerType.undertaking  : return 'savesUndertakings';
      case FlyerType.trade        : return 'savesTrades';
      case FlyerType.product      : return 'savesProducts';
      case FlyerType.equipment    : return 'savesEquipments';
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// GET FIELD NAME (FOLLOWS)

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFollowBzTypeFieldName(BzType? bzType){
    switch (bzType) {
      case BzType.developer :     return 'followsDevelopers';
      case BzType.broker :        return 'followsBrokers';
      case BzType.designer :      return 'followsDesigners';
      case BzType.contractor :    return 'followsContractors';
      case BzType.artisan :       return 'followsArtisans';
      case BzType.manufacturer :  return 'followsManufacturers';
      case BzType.supplier :      return 'followsSuppliers';
      default:                    return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// GET FIELD NAME (BZ)

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBzSectionFieldName(BzSection? bzSection){
    switch (bzSection) {
      case BzSection.realestate :   return 'bzSectionRealEstate';
      case BzSection.construction : return 'bzSectionConstruction';
      case BzSection.supplies :     return 'bzSectionSupplies';
      default:                      return null;
      }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBzTypeFieldName(BzType? bzType){
    switch (bzType) {
      case BzType.developer :     return 'bzTypeDeveloper';
      case BzType.broker :        return 'bzTypeBroker';
      case BzType.designer :      return 'bzTypeDesigner';
      case BzType.contractor :    return 'bzTypeContractor';
      case BzType.artisan :       return 'bzTypeArtisan';
      case BzType.manufacturer :  return 'bzTypeManufacturer';
      case BzType.supplier :      return 'bzTypeSupplier';
      default:                    return null;
      }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBzFormFieldName(BzForm? bzForm){
    switch (bzForm) {
      case BzForm.individual :  return 'bzFormIndividual';
      case BzForm.company :     return 'bzFormCompany';
      default:                  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBzAccountTypeFieldName(BzAccountType? bzAccountType){
    switch (bzAccountType) {
      case BzAccountType.basic :      return 'bzAccountTypeStandard';
      case BzAccountType.advanced :   return 'bzAccountTypePro';
      case BzAccountType.premium :    return 'bzAccountTypeMaster';
      default:                        return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// GET FIELD NAME (CALLS)

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getCallBzTypeFieldName(BzType? bzType){
    switch (bzType) {
      case BzType.developer :     return 'callsDevelopers';
      case BzType.broker :        return 'callsBrokers';
      case BzType.designer :      return 'callsDesigners';
      case BzType.contractor :    return 'callsContractors';
      case BzType.artisan :       return 'callsArtisans';
      case BzType.manufacturer :  return 'callsManufacturers';
      case BzType.supplier :      return 'callsSuppliers';
      default:                    return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// GET FIELD NAME (FLYER)

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFlyerTypeFieldName(FlyerType? flyerType){
    switch (flyerType) {
      case FlyerType.general      : return 'flyerTypeGeneral';
      case FlyerType.property     : return 'flyerTypeProperty';
      case FlyerType.design       : return 'flyerTypeDesign';
      case FlyerType.product      : return 'flyerTypeProduct';
      case FlyerType.undertaking  : return 'flyerTypeProject';
      case FlyerType.trade        : return 'flyerTypeTrade';
      case FlyerType.equipment    : return 'flyerTypeEquipment';
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkShouldUpdateUserCensus({
    required UserModel? oldUser,
    required UserModel? newUser,
  }){
    bool _shouldUpdate = false;

    if (newUser != null && oldUser != null){

      if (
        ZoneModel.checkZonesIDsAreIdentical(zone1: oldUser.zone, zone2: newUser.zone) == false ||
        NeedModel.checkNeedsAreIdentical(oldUser.need, newUser.need) == false
      ){
        _shouldUpdate = true;
      }

    }

    return _shouldUpdate;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkShouldUpdateBzCensus({
    required BzModel? oldBz,
    required BzModel? newBz,
  }){
    bool _shouldUpdate = false;

    if (newBz != null){

      if (
      ZoneModel.checkZonesIDsAreIdentical(zone1: oldBz?.zone, zone2: newBz.zone) == false ||
      oldBz?.authors?.length != newBz.authors?.length ||
      BzTyper.checkBzTypesAreIdentical(oldBz?.bzTypes, newBz.bzTypes) == false ||
      oldBz?.bzForm != newBz.bzForm ||
      oldBz?.accountType != newBz.accountType
      ){
        _shouldUpdate = true;
      }

    }

    return _shouldUpdate;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkShouldUpdateFlyerCensus({
    required FlyerModel? oldFlyer,
    required FlyerModel? newFlyer,
  }){
    bool _shouldUpdate = false;

    if (newFlyer != null){

      if (
      ZoneModel.checkZonesIDsAreIdentical(zone1: oldFlyer?.zone, zone2: newFlyer.zone) == false ||
      oldFlyer?.slides?.length != newFlyer.slides?.length ||
      oldFlyer?.flyerType != newFlyer.flyerType
      ){
        _shouldUpdate = true;
      }

    }

    return _shouldUpdate;
  }
  // -----------------------------------------------------------------------------

  /// LIST GETTERS

  // --------------------
  static CensusModel? getCensusFromCensusesByID({
    required List<CensusModel>? censuses,
    required String? censusID,
  }){
    CensusModel? _output;

    if (Lister.checkCanLoop(censuses) == true && censusID != null){
      _output = censuses!.firstWhereOrNull((census) => census.id == censusID);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TESTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static CensusModel? incrementCensus({
    required CensusModel? model,
    required Map<String, int>? map,
  }){
    CensusModel? _output = model;

    if (model != null && map != null && model.id != null){


      final List<String> _keys = map.keys.toList();
      if (Lister.checkCanLoop(_keys) == true){

        _keys.remove('id');

        Map<String, dynamic> ciphered = model.toMap(toLDB: true);

        for (final String key in _keys){

          final int _existing = ciphered[key] ?? 0;
          final int _increment = map[key] ?? 0;

          ciphered = Mapper.insertPairInMap(
              map: ciphered,
              key: key,
              value: _existing + _increment,
              overrideExisting: true,
          );

        }

        final Map<String, int> _final = completeMapForIncrementation(ciphered);

        _output = decipher(map: _final, id: model.id!);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogCensus(){

    blog(' ====> CENSUS MODEL : BLOG CENSUS : ID : $id');

    blog(
      'totalUsers: $totalUsers | '
      'totalBzz: $totalBzz | '
      'totalAuthors: $totalAuthors | '
      'totalFlyers: $totalFlyers | '
      'totalSlides: $totalSlides'
    );

    blog(
      'bzSectionRealEstate: $bzSectionRealEstate | '
      'bzSectionConstruction: $bzSectionConstruction | '
      'bzSectionSupplies: $bzSectionSupplies |'
    );

    blog(
      'bzTypeDeveloper: $bzTypeDeveloper | '
      'bzTypeBroker: $bzTypeBroker | '
      'bzTypeDesigner: $bzTypeDesigner | '
      'bzTypeContractor: $bzTypeContractor | '
      'bzTypeArtisan: $bzTypeArtisan | '
      'bzTypeManufacturer: $bzTypeManufacturer | '
      'bzTypeSupplier: $bzTypeSupplier |'
    );

    blog(
      'bzFormIndividual: $bzFormIndividual | '
      'bzFormCompany: $bzFormCompany | '
    );

    blog(
      'bzAccountTypeStandard: $bzAccountTypeStandard | '
      'bzAccountTypePro: $bzAccountTypePro | '
      'bzAccountTypeMaster: $bzAccountTypeMaster | '
    );

    blog(
      'flyerTypeGeneral: $flyerTypeGeneral | '
      'flyerTypeProperty: $flyerTypeProperty | '
      'flyerTypeDesign: $flyerTypeDesign | '
      'flyerTypeProduct: $flyerTypeProduct | '
      'flyerTypeUndertaking: $flyerTypeUndertaking | '
      'flyerTypeTrade: $flyerTypeTrade | '
      'flyerTypeEquipment: $flyerTypeEquipment |'
    );

    blog(
      'needTypeSeekProperty: $needTypeSeekProperty | '
      'needTypePlanConstruction: $needTypePlanConstruction | '
      'needTypeFinishConstruction: $needTypeFinishConstruction | '
      'needTypeFurnish: $needTypeFurnish | '
      'needTypeOfferProperty : $needTypeOfferProperty |'
    );

    blog(
      'savesGeneral: $savesGeneral | '
      'savesProperties: $savesProperties | '
      'savesDesigns: $savesDesigns | '
      'savesUndertakings: $savesUndertakings | '
      'savesTrades: $savesTrades | '
      'savesProducts: $savesProducts | '
      'savesEquipments: $savesEquipments'
    );

    blog(
      'followsDevelopers: $followsDevelopers | '
      'followsBrokers: $followsBrokers | '
      'followsDesigners: $followsDesigners | '
      'followsContractors: $followsContractors | '
      'followsArtisans: $followsArtisans | '
      'followsManufacturers: $followsManufacturers | '
      'followsSuppliers: $followsSuppliers'
    );


    blog(
      'callsDevelopers: $callsDevelopers | '
      'callsBrokers: $callsBrokers | '
      'callsDesigners: $callsDesigners | '
      'callsContractors: $callsContractors | '
      'callsArtisans: $callsArtisans | '
      'callsManufacturers: $callsManufacturers | '
      'callsSuppliers: $callsSuppliers'
    );

    blog(' =====================================> CETUS MODEL : BLOG CENSUS : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogCensuses({
    required List<CensusModel> censuses,
  }){
    if (Lister.checkCanLoop(censuses) == true){
      for (final CensusModel census in censuses) {
        census.blogCensus();
      }
    }

    else {
      blog('CENSUS LIST IS EMPTY');
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogDifference(CensusModel? census1, CensusModel? census2){

    Mapper.blogMapsDifferences(
      map1: census1?.toMap(toLDB: true),
      map2: census2?.toMap(toLDB: true),
      invoker: 'blogCensusesDifferences',
    );

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  ///
  static bool checkCensusAreIdentical({
    required CensusModel? census1,
    required CensusModel? census2,
  }){
    bool _areIdentical = false;

    if (census1 == null && census2 == null){
      _areIdentical = true;
    }

    else if (census1 != null && census2 != null){

      if (
        census1.id == census2.id &&
        census1.totalUsers == census2.totalUsers &&
        census1.totalBzz == census2.totalBzz &&
        census1.totalAuthors == census2.totalAuthors &&
        census1.totalFlyers == census2.totalFlyers &&
        census1.totalSlides == census2.totalSlides &&
        census1.bzSectionRealEstate == census2.bzSectionRealEstate &&
        census1.bzSectionConstruction == census2.bzSectionConstruction &&
        census1.bzSectionSupplies == census2.bzSectionSupplies &&
        census1.bzTypeDeveloper == census2.bzTypeDeveloper &&
        census1.bzTypeBroker == census2.bzTypeBroker &&
        census1.bzTypeDesigner == census2.bzTypeDesigner &&
        census1.bzTypeContractor == census2.bzTypeContractor &&
        census1.bzTypeArtisan == census2.bzTypeArtisan &&
        census1.bzTypeManufacturer == census2.bzTypeManufacturer &&
        census1.bzTypeSupplier == census2.bzTypeSupplier &&
        census1.bzFormIndividual == census2.bzFormIndividual &&
        census1.bzFormCompany == census2.bzFormCompany &&
        census1.bzAccountTypeStandard == census2.bzAccountTypeStandard &&
        census1.bzAccountTypePro == census2.bzAccountTypePro &&
        census1.bzAccountTypeMaster == census2.bzAccountTypeMaster &&
        census1.flyerTypeGeneral == census2.flyerTypeGeneral &&
        census1.flyerTypeProperty == census2.flyerTypeProperty &&
        census1.flyerTypeDesign == census2.flyerTypeDesign &&
        census1.flyerTypeUndertaking == census2.flyerTypeUndertaking &&
        census1.flyerTypeTrade == census2.flyerTypeTrade &&
        census1.flyerTypeProduct == census2.flyerTypeProduct &&
        census1.flyerTypeEquipment == census2.flyerTypeEquipment &&
        census1.needTypeSeekProperty == census2.needTypeSeekProperty &&
        census1.needTypePlanConstruction == census2.needTypePlanConstruction &&
        census1.needTypeFinishConstruction == census2.needTypeFinishConstruction &&
        census1.needTypeFurnish == census2.needTypeFurnish &&
        census1.needTypeOfferProperty == census2.needTypeOfferProperty &&
        census1.savesGeneral == census2.savesGeneral &&
        census1.savesProperties == census2.savesProperties &&
        census1.savesDesigns == census2.savesDesigns &&
        census1.savesUndertakings == census2.savesUndertakings &&
        census1.savesTrades == census2.savesTrades &&
        census1.savesProducts == census2.savesProducts &&
        census1.savesEquipments == census2.savesEquipments &&
        census1.followsDevelopers == census2.followsDevelopers &&
        census1.followsBrokers == census2.followsBrokers &&
        census1.followsDesigners == census2.followsDesigners &&
        census1.followsContractors == census2.followsContractors &&
        census1.followsArtisans == census2.followsArtisans &&
        census1.followsManufacturers == census2.followsManufacturers &&
        census1.followsSuppliers == census2.followsSuppliers &&
        census1.callsDevelopers == census2.callsDevelopers &&
        census1.callsBrokers == census2.callsBrokers &&
        census1.callsDesigners == census2.callsDesigners &&
        census1.callsContractors == census2.callsContractors &&
        census1.callsArtisans == census2.callsArtisans &&
        census1.callsManufacturers == census2.callsManufacturers &&
        census1.callsSuppliers == census2.callsSuppliers
      ){
        _areIdentical = true;
      }

    }

    if (_areIdentical == false){
      blogDifference(census1, census2);
    }

    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString(){

    final String _text =
    '''
CensusModel(
  id: $id, 
  totalUsers: $totalUsers, totalBzz: $totalBzz, totalAuthors: $totalAuthors, totalFlyers: $totalFlyers, totalSlides: $totalSlides,
  bzSectionRealEstate: $bzSectionRealEstate, bzSectionConstruction: $bzSectionConstruction, bzSectionSupplies: $bzSectionSupplies,
  bzTypeDeveloper: $bzTypeDeveloper, bzTypeBroker: $bzTypeBroker, bzTypeDesigner: $bzTypeDesigner, bzTypeContractor: $bzTypeContractor,bzTypeArtisan: $bzTypeArtisan, bzTypeManufacturer: $bzTypeManufacturer,bzTypeSupplier: $bzTypeSupplier, bzFormIndividual: $bzFormIndividual,bzFormCompany: $bzFormCompany,
  bzAccountTypeStandard: $bzAccountTypeStandard, bzAccountTypePro: $bzAccountTypePro, bzAccountTypeMaster: $bzAccountTypeMaster,
  flyerTypeGeneral: $flyerTypeGeneral,flyerTypeProperty: $flyerTypeProperty,flyerTypeDesign: $flyerTypeDesign,flyerTypeUndertaking: $flyerTypeUndertaking,flyerTypeTrade: $flyerTypeTrade,flyerTypeProduct: $flyerTypeProduct,flyerTypeEquipment: $flyerTypeEquipment,
  needTypeSeekProperty: $needTypeSeekProperty,needTypePlanConstruction: $needTypePlanConstruction,needTypeFinishConstruction: $needTypeFinishConstruction,needTypeFurnish: $needTypeFurnish,needTypeOfferProperty: $needTypeOfferProperty,
  savesGeneral: $savesGeneral,savesProperties: $savesProperties,savesDesigns: $savesDesigns,savesUndertakings: $savesUndertakings,savesTrades: $savesTrades,savesProducts: $savesProducts,savesEquipments: $savesEquipments,
  followsDevelopers: $followsDevelopers,followsBrokers: $followsBrokers,followsDesigners: $followsDesigners,followsContractors: $followsContractors,followsArtisans: $followsArtisans,followsManufacturers: $followsManufacturers,followsSuppliers: $followsSuppliers,
  callsDevelopers: $callsDevelopers,callsBrokers: $callsBrokers,callsDesigners: $callsDesigners,callsContractors: $callsContractors,callsArtisans: $callsArtisans,callsManufacturers: $callsManufacturers,callsSuppliers: $callsSuppliers,
    );
    ''';

    return _text;
   }
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is CensusModel){
      _areIdentical = checkCensusAreIdentical(
        census1: this,
        census2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      totalUsers.hashCode^
      totalBzz.hashCode^
      totalAuthors.hashCode^
      totalFlyers.hashCode^
      totalSlides.hashCode^
      bzSectionRealEstate.hashCode^
      bzSectionConstruction.hashCode^
      bzSectionSupplies.hashCode^
      bzTypeDeveloper.hashCode^
      bzTypeBroker.hashCode^
      bzTypeDesigner.hashCode^
      bzTypeContractor.hashCode^
      bzTypeArtisan.hashCode^
      bzTypeManufacturer.hashCode^
      bzTypeSupplier.hashCode^
      bzFormIndividual.hashCode^
      bzFormCompany.hashCode^
      bzAccountTypeStandard.hashCode^
      bzAccountTypePro.hashCode^
      bzAccountTypeMaster.hashCode^
      flyerTypeGeneral.hashCode^
      flyerTypeProperty.hashCode^
      flyerTypeDesign.hashCode^
      flyerTypeUndertaking.hashCode^
      flyerTypeTrade.hashCode^
      flyerTypeProduct.hashCode^
      flyerTypeEquipment.hashCode^
      needTypeSeekProperty.hashCode^
      needTypePlanConstruction.hashCode^
      needTypeFinishConstruction.hashCode^
      needTypeFurnish.hashCode^
      needTypeOfferProperty.hashCode^
      savesGeneral.hashCode^
      savesProperties.hashCode^
      savesDesigns.hashCode^
      savesUndertakings.hashCode^
      savesTrades.hashCode^
      savesProducts.hashCode^
      savesEquipments.hashCode^
      followsDevelopers.hashCode^
      followsBrokers.hashCode^
      followsDesigners.hashCode^
      followsContractors.hashCode^
      followsArtisans.hashCode^
      followsManufacturers.hashCode^
      followsSuppliers.hashCode^
      callsDevelopers.hashCode^
      callsBrokers.hashCode^
      callsDesigners.hashCode^
      callsContractors.hashCode^
      callsArtisans.hashCode^
      callsManufacturers.hashCode^
      callsSuppliers.hashCode;
  // -----------------------------------------------------------------------------
}
