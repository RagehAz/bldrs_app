import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

enum BzSection {
  realestate,
  construction,
  supplies,
}

enum BzType {
  developer, // (property flyer - property source flyer)
  broker, // (property flyer)

  designer, // (design flyer)
  contractor, // (undertaking flyer)
  artisan, // (trade flyer)

  manufacturer, // (product flyer - product source flyer)
  supplier, // (product flyer)
}

enum BzForm {
  individual,
  company,
}

enum BzAccountType {
  basic,
  advanced,
  premium,
}

enum BzState {
  online,
  offline,
  deactivated,
  deleted,
  banned,
}

/// => TAMAM
class BzTyper {
  // -----------------------------------------------------------------------------

  const BzTyper();

  // -----------------------------------------------------------------------------

  /// BZ SECTION CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherBzSection(BzSection? section){
    switch (section) {
      case BzSection.realestate      :  return 'realestate'    ;
      case BzSection.construction    :  return 'construction'  ;
      case BzSection.supplies        :  return 'supplies'      ;
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzSection? decipherBzSection(String? section){
    switch (section) {
      case 'realestate'   : return BzSection.realestate   ;
      case 'construction' : return BzSection.construction ;
      case 'supplies'     : return BzSection.supplies     ;
      default:  return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// BZ TYPE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherBzType(BzType? x) {
    switch (x) {
      case BzType.developer       :  return 'developer'     ;
      case BzType.broker          :  return 'broker'        ;
      case BzType.designer        :  return 'designer'      ;
      case BzType.contractor      :  return 'contractor'    ;
      case BzType.artisan         :  return 'artisan'       ;
      case BzType.manufacturer    :  return 'manufacturer'  ;
      case BzType.supplier        :  return 'supplier'      ;
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? cipherBzTypes(List<BzType>? bzTypes){
    Map<String, dynamic>? _output;

    if (Lister.checkCanLoop(bzTypes) == true){

      _output = {};

      for (final BzType bzType in bzTypes!){

        final String? _ciphered = cipherBzType(bzType);

        _output = Mapper.insertPairInMap(
          map: _output,
          key: _ciphered,
          value: true,
          overrideExisting: true,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzType? decipherBzType(String? x) {
    switch (x) {
      case 'developer'      : return BzType.developer;
      case 'broker'         : return BzType.broker;
      case 'designer'       : return BzType.designer;
      case 'contractor'     : return BzType.contractor;
      case 'artisan'        : return BzType.artisan;
      case 'manufacturer'   : return BzType.manufacturer;
      case 'supplier'       : return BzType.supplier;
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzType> decipherBzTypes(Map<String, dynamic>? map){
    final List<BzType> _bzTypes = <BzType>[];

    if (map != null) {

      final List<String> _ciphered = map.keys.toList();

      if (Lister.checkCanLoop(_ciphered) == true) {
        for (final String _string in _ciphered) {
          final BzType? _bzType = decipherBzType(_string);
          if (_bzType != null){
            _bzTypes.add(_bzType);
          }
        }
      }

    }

    return _bzTypes;
  }
  // -----------------------------------------------------------------------------

  /// BZ TYPE GETTERS

  // --------------------
  static const List<BzType> bzTypesList = <BzType>[
    BzType.designer,
    BzType.contractor,
    BzType.artisan,
    BzType.manufacturer,
    BzType.supplier,
    BzType.developer,
    BzType.broker,
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzType> getBzTypesListWithoutOneType(BzType removeThisType){
    const List<BzType> _allTypes = bzTypesList;
    final List<BzType> _output = <BzType>[];

    for (final BzType bzType in _allTypes){
      if (bzType != removeThisType){
        _output.add(bzType);
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBzTypeIcon(BzType? bzType) {

    switch (bzType){
      case BzType.developer:    return Iconz.bzTypeDeveloper;
      case BzType.broker:       return Iconz.bzTypeBroker;
      case BzType.designer:     return Iconz.bzTypeDesigner;
      case BzType.contractor:   return Iconz.bzTypeContractor;
      case BzType.artisan:      return Iconz.bzTypeArtisan;
      case BzType.manufacturer: return Iconz.bzTypeManufacturer;
      case BzType.supplier:     return Iconz.bzTypeSupplier;
      default: return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getTheSevenArtwork(BzType? bzType){
    switch (bzType){
      case BzType.developer:    return Iconz.theSevenDevelopers;
      case BzType.broker:       return Iconz.theSevenBrokers;
      case BzType.designer:     return Iconz.theSevenDesigners;
      case BzType.contractor:   return Iconz.theSevenContractors;
      case BzType.artisan:      return Iconz.theSevenArtisans;
      case BzType.manufacturer: return Iconz.theSevenManufacturers;
      case BzType.supplier:     return Iconz.theSevenSuppliers;
      default:                  return Iconz.theSevenOwners;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzTypePublishesPhid(BzType bzType){
    switch (bzType){
      case BzType.designer:       return 'phid_designers_publish';
      case BzType.contractor:     return 'phid_contractors_publish';
      case BzType.artisan:        return 'phid_artisans_publish';
      case BzType.manufacturer:   return 'phid_manufacturers_publish';
      case BzType.supplier:       return 'phid_suppliers_publish';
      case BzType.developer:      return 'phid_developers_publish';
      case BzType.broker:         return 'phid_brokers_publish';
    }
  }
  // -----------------------------------------------------------------------------

  /// BZ TYPE CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBzTypesContainThisType({
    required BzType? bzType,
    required List<BzType>? bzTypes,
  }){
    bool _contains = false;

    if (Lister.checkCanLoop(bzTypes) == true){

      if (bzTypes!.contains(bzType) == true){
        _contains = true;
      }

    }

    return _contains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBzTypesAreIdentical(List<BzType>? types1, List<BzType>? types2){

    final Map<String, dynamic>? _a = cipherBzTypes(types1);
    final Map<String, dynamic>? _b = cipherBzTypes(types2);

    return Mapper.checkMapsAreIdentical(
        map1: _a,
        map2: _b,
    );

  }
  // -----------------------------------------------------------------------------

  /// BZ TYPE TRANSLATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzTypePhid({
    required BzType? bzType,
    bool nounTranslation = true,
    bool pluralTranslation = true,
  }){

    /// NOUN
    if (nounTranslation == true){
      return
        bzType == BzType.developer ?    'phid_realEstateDevelopment' :
        bzType == BzType.broker ?       'phid_realEstateBrokerage' :
        bzType == BzType.designer ?     'phid_design' :
        bzType == BzType.contractor ?   'phid_contracting' :
        bzType == BzType.artisan ?      'phid_tradesmanship' :
        bzType == BzType.manufacturer ? 'phid_manufacturing' :
        bzType == BzType.supplier ?     'phid_supplying' :
        'phid_bldrs';
    }

    /// NOT NOUN
    else {

      /// PLURAL
      if (pluralTranslation == true){
        return
          bzType == BzType.developer ?    'phid_realEstateDevelopers' :
          bzType == BzType.broker ?       'phid_realEstateBrokers' :
          bzType == BzType.designer ?     'phid_designers' :
          bzType == BzType.contractor ?   'phid_contractors' :
          bzType == BzType.artisan ?      'phid_artisans' :
          bzType == BzType.manufacturer ? 'phid_manufacturers' :
          bzType == BzType.supplier ?     'phid_suppliers' :
          'phid_bldrs';
      }

      /// SINGLE
      else {
        return
          bzType == BzType.developer ?    'phid_realEstateDeveloper' :
          bzType == BzType.broker ?       'phid_realEstateBroker' :
          bzType == BzType.designer ?     'phid_designer' :
          bzType == BzType.contractor ?   'phid_contractor' :
          bzType == BzType.artisan ?      'phid_artisan' :
          bzType == BzType.manufacturer ? 'phid_manufacturer' :
          bzType == BzType.supplier ?     'phid_supplier' :
          'phid_bldr';
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getBzTypesPhids({
    required BuildContext context,
    required List<BzType>? bzTypes,
    bool pluralTranslation = true,
  }){
    final List<String> _strings = <String>[];

    if (Lister.checkCanLoop(bzTypes) == true){

      for (final BzType type in bzTypes!){

        final String _bzTypePhid = getBzTypePhid(
          bzType: type,
          pluralTranslation: pluralTranslation,
        );

        _strings.add(_bzTypePhid);

      }

    }

    return _strings;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String translateBzTypesIntoString({
    required BuildContext context,
    required List<BzType>? bzTypes,
    required BzForm? bzForm,
    bool oneLine = false,
  }){

    /// only gets translation according to current language
    // blog('translateBzTypesIntoString : bzForm : $bzForm : bzTypes : $bzTypes');

    final List<String> _bzTypesPhids = getBzTypesPhids(
      context: context,
      bzTypes: bzTypes,
      pluralTranslation: false,
    );

    // Stringer.blogStrings(strings: _bzTypesPhids, invoker: 'translateBzTypesIntoString');

    final List<String> _typesTranslated = getWords(_bzTypesPhids);

    final String _bzTypesOneString = Stringer.generateStringFromStrings(
      strings: _typesTranslated,
    ) ?? '';

    final String? _bzFormPhid = getBzFormPhid(bzForm)!;
    final String _formTranslated = getWord(_bzFormPhid);

    String _output = '$_bzTypesOneString\n$_formTranslated';

    /// ENGLISH
    if (UiProvider.checkAppIsLeftToRight() == false){

      if (oneLine == true){
        _output = '$_formTranslated, $_bzTypesOneString';
      }
      else {
        _output = '$_formTranslated\n$_bzTypesOneString';
      }

    }

    /// ARABIC
    else {

      if (oneLine == true){
        _output = '$_bzTypesOneString, $_formTranslated';
      }
      else {
        _output = '$_bzTypesOneString\n$_formTranslated';
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzTypeAskHintPhid(BzType bzType){

    final String _askHint =
    bzType == BzType.developer ?    'phid_askHint_developer' :
    bzType == BzType.broker ?       'phid_askHint_broker' :
    bzType == BzType.manufacturer ? 'phid_askHint_manufacturer' :
    bzType == BzType.supplier ?     'phid_askHint_supplier' :
    bzType == BzType.designer ?     'phid_askHint_designer' :
    bzType == BzType.contractor ?   'phid_askHint_contractor' :
    bzType == BzType.artisan ?      'phid_askHint_artisan' :
    'phid_askHint';

    return _askHint;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzTypeWhoArePhid(BzType? bzType){
    final String _output =
    bzType == BzType.developer ?    'phid_who_are_developers' :
    bzType == BzType.broker ?       'phid_who_are_brokers' :
    bzType == BzType.manufacturer ? 'phid_who_are_manufacturers' :
    bzType == BzType.supplier ?     'phid_who_are_suppliers' :
    bzType == BzType.designer ?     'phid_who_are_designers' :
    bzType == BzType.contractor ?   'phid_who_are_contractors' :
    bzType == BzType.artisan ?      'phid_who_are_artisans' :
    bzType == null ?                'phid_who_are_owners':
    ''
    ;

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BZ TYPE CONCLUDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzType> concludeBzTypeByBzSection(BzSection bzSection){

    List<BzType> _bzTypes = <BzType>[];

    /// REAL ESTATE BZ TYPES
    if (bzSection == BzSection.realestate){
      _bzTypes = <BzType>[BzType.developer, BzType.broker];
    }

    /// CONSTRUCTION BZ TYPES
    else if (bzSection == BzSection.construction){
      _bzTypes = <BzType>[BzType.designer, BzType.contractor, BzType.artisan];
    }

    /// SUPPLIES BZ TYPES
    else {
      _bzTypes = <BzType>[BzType.supplier, BzType.manufacturer];
    }

    return _bzTypes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzType> concludeDeactivatedBzTypesBySection({
    required BzSection? bzSection,
    List<BzType>? initialBzTypes,
  }){

    /// INITIAL LIST OF ALL BZ TYPES
    final List<BzType> _bzTypes = <BzType>[...bzTypesList];

    if (bzSection != null){

      /// BZ TYPES BY SECTION
      final List<BzType> _bzTypesBySection = concludeBzTypeByBzSection(bzSection);

      /// REMOVE SELECTED BZ TYPES FROM THE LIST
      for (final BzType bzType in _bzTypesBySection){
        _bzTypes.remove(bzType);
      }

      /// ADD ARTISAN IF STARTING WITH DESIGNERS OR CONTRACTORS
      if (Lister.checkCanLoop(initialBzTypes) == true){
        if (bzSection == BzSection.construction){
          if (
              initialBzTypes!.contains(BzType.designer) == true
              ||
              initialBzTypes.contains(BzType.contractor) == true
          ){
            _bzTypes.add(BzType.artisan);
          }
        }
      }

    }


    return _bzTypes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzType>? concludeMixableBzTypes({
    required BzType? bzType,
  }){

    List<BzType>? _mixableTypes;

    /// DEVELOPER
    if (bzType == BzType.developer){
      _mixableTypes = <BzType>[
        BzType.broker
      ];
    }

    /// BROKER
    if (bzType == BzType.broker){
      _mixableTypes = <BzType>[
        BzType.developer
      ];
    }

    /// DESIGNER
    if (bzType == BzType.designer){
      _mixableTypes = <BzType>[
        BzType.contractor
      ];
    }

    /// CONTRACTOR
    if (bzType == BzType.contractor){
      _mixableTypes = <BzType>[
        BzType.designer
      ];
    }

    /// ARTISAN
    if (bzType == BzType.artisan){
      _mixableTypes = <BzType>[];
    }

    /// SUPPLIER
    if (bzType == BzType.supplier){
      _mixableTypes = <BzType>[
        BzType.manufacturer,
      ];
    }

    /// MANUFACTURER
    if (bzType == BzType.manufacturer){
      _mixableTypes = <BzType>[
        BzType.supplier,
      ];
    }

    return _mixableTypes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzType> concludeDeactivatedBzTypesBySelectedType({
    required BzType selectedBzType,
  }){

    final List<BzType>? _mixableTypes = concludeMixableBzTypes(
        bzType: selectedBzType
    );

    final List<BzType> _inactiveTypes = <BzType>[...bzTypesList];
    _inactiveTypes.remove(selectedBzType);

    /// REMOVE MIXABLE TYPES FROM ALL TYPE TO GET INACTIVE TYPES
    if (Lister.checkCanLoop(_mixableTypes) == true){
      for (final BzType bzType in _mixableTypes!){
        _inactiveTypes.remove(bzType);
      }
    }

    return _inactiveTypes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzType> concludeDeactivatedBzTypesBasedOnSelectedBzTypes({
    required BzType newSelectedType,
    required List<BzType> selectedBzTypes,
    required BzSection? selectedBzSection,
  }){

    List<BzType> _inactiveBzTypes;

    /// INACTIVATE BZ TYPES ACCORDING TO SECTION WHEN NOTHING IS SELECTED
    if (selectedBzTypes.isEmpty){
      _inactiveBzTypes = concludeDeactivatedBzTypesBySection(
        bzSection: selectedBzSection,
      );

    }

    /// INACTIVATE BZ TYPES ACCORDING TO SELECTION
    else {
      _inactiveBzTypes = concludeDeactivatedBzTypesBySelectedType(
        selectedBzType: newSelectedType,
      );
    }

    return _inactiveBzTypes;
  }
  // -----------------------------------------------------------------------------

  /// BZ TYPE MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzType> addOrRemoveBzTypeToBzzTypes({
    required BzType newSelectedBzType,
    required List<BzType>? selectedBzTypes,
  }){

    final List<BzType> _outputTypes = <BzType>[...?selectedBzTypes];

    final bool _alreadySelected = checkBzTypesContainThisType(
      bzTypes: selectedBzTypes,
      bzType: newSelectedBzType,
    );

    if (_alreadySelected == true){
      _outputTypes.remove(newSelectedBzType);
    }

    else {
      _outputTypes.add(newSelectedBzType);
    }

    return _outputTypes;
  }
  // -----------------------------------------------------------------------------

  /// BZ ACCOUNT TYPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherBzAccountType(BzAccountType? bzAccountType) {
    switch (bzAccountType) {
      case BzAccountType.basic:     return 'basic';
      case BzAccountType.advanced:  return 'advanced';
      case BzAccountType.premium:   return 'premium';
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzAccountType? decipherBzAccountType(String? bzAccountType) {
    switch (bzAccountType) {
      case 'basic'       : return BzAccountType.basic;
      case 'advanced'    : return BzAccountType.advanced;
      case 'premium'     : return BzAccountType.premium;
      default:return null;
    }
  }
  // --------------------
  static const List<BzAccountType> bzAccountTypesList = <BzAccountType>[
    BzAccountType.basic,
    BzAccountType.advanced,
    BzAccountType.premium,
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBzAccountTypePhid({
    required BzAccountType? type,
  }){
    switch (type) {
      case BzAccountType.basic:     return 'phid_basic_account';
      case BzAccountType.advanced:  return 'phid_advanced_account';
      case BzAccountType.premium:   return 'phid_premium_account';
      default:  return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// BZ FORM

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherBzForm(BzForm? x) {
    switch (x) {
      case BzForm.individual  : return 'individual' ;
      case BzForm.company     : return 'company'    ;
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzForm? decipherBzForm(String? x) {
    switch (x) {
      case 'individual' :  return BzForm.individual ;
      case 'company'    :  return BzForm.company    ;
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> cipherBzForms(List<BzForm>? x){
    final List<String> _output = <String>[];

    if (Lister.checkCanLoop(x) == true){

      for (final BzForm form in x!){
        _output.add(cipherBzForm(form)!);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzForm> decipherBzForms(List<String> y){
    final List<BzForm> _output = <BzForm>[];

    if (Lister.checkCanLoop(y) == true){

      for (final String form in y){
        _output.add(decipherBzForm(form)!);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BZ FORM TRANSLATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getBzFormPhid(BzForm? bzForm){

    if (bzForm == BzForm.company){
      return 'phid_company';
    }

    else if (bzForm == BzForm.individual){
      return 'phid_professional';
    }

    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getBzFormsPhids({
    required List<BzForm>? bzForms,
  }){
    final List<String> _strings = <String>[];

    if (Lister.checkCanLoop(bzForms) == true){

      for (final BzForm bzForm in bzForms!){
        final String _translation = getBzFormPhid(bzForm)!;
        _strings.add(_translation);
      }

    }

    return _strings;
  }
  // -----------------------------------------------------------------------------

  /// BZ FORM CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool bzFormsContainThisForm({
    required List<BzForm> bzForms,
    required BzForm bzForm,
  }){
    bool _contains = false;

    if (Lister.checkCanLoop(bzForms) == true){

      if (bzForms.contains(bzForm) == true){
        _contains = true;
      }

    }

    return _contains;
  }
  // -----------------------------------------------------------------------------

  /// BZ FORM CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzForm> concludeInactiveBzFormsByBzTypes(List<BzType>? selectedBzTypes){

    /// INITIAL LIST OF ALL BZ FORMS
    List<BzForm>? _bzForms = <BzForm>[...bzFormsList];

    if (Lister.checkCanLoop(selectedBzTypes) == true){

      /// MORE THAN ONE BZ TYPE
      if (selectedBzTypes!.length > 1){
        _bzForms.remove(BzForm.company);
      }

      /// IF ONLY ONE BZ TYPE
      else {

        /// BZ FORMS BY SECTION
        final List<BzForm> _bzFormsBySection = concludeBzFormsByBzType(selectedBzTypes[0]);

        /// REMOVE SELECTED BZ FORMS FROM THE LIST
        for (final BzForm bzForm in _bzFormsBySection){
          _bzForms.remove(bzForm);
        }

      }

    }

    /// IF NO BZ TYPES SELECTED
    else {
      _bzForms = null;
    }

    return _bzForms ?? [];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzForm> concludeBzFormsByBzType(BzType selectedBzType){

    List<BzForm> _bzForm = <BzForm>[];

    /// DEVELOPER
    if (selectedBzType == BzType.developer){
      _bzForm = <BzForm>[BzForm.company];
    }

    /// BROKER
    else if (selectedBzType == BzType.broker){
      _bzForm = <BzForm>[BzForm.company, BzForm.individual];
    }

    /// DESIGNER
    else if (selectedBzType == BzType.designer){
      _bzForm = <BzForm>[BzForm.company, BzForm.individual];
    }

    /// CONTRACTOR
    else if (selectedBzType == BzType.contractor){
      _bzForm = <BzForm>[BzForm.company, BzForm.individual];
    }

    /// ARTISAN
    else if (selectedBzType == BzType.artisan){
      _bzForm = <BzForm>[BzForm.individual];
    }

    /// SUPPLIER
    else if (selectedBzType == BzType.supplier){
      _bzForm = <BzForm>[BzForm.company];
    }

    /// MANUFACTURER
    else if (selectedBzType == BzType.manufacturer){
      _bzForm = <BzForm>[BzForm.company];
    }

    else {
      _bzForm = <BzForm>[BzForm.company, BzForm.individual];
    }

    return _bzForm;
  }
  // --------------------
  static const List<BzForm> bzFormsList = <BzForm>[
    BzForm.individual,
    BzForm.company,
  ];
  // -----------------------------------------------------------------------------

  /// BZ STATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherBzState(BzState? state) {
    switch (state) {
      case BzState.online       : return 'online'     ;
      case BzState.offline      : return 'offline'    ;
      case BzState.deactivated  : return 'deactivated';
      case BzState.deleted      : return 'deleted'    ;
      case BzState.banned       : return 'banned'     ;
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzState? decipherBzState(String? state) {
    switch (state) {
      case 'online'       : return BzState.online       ;
      case 'offline'      : return BzState.offline      ;
      case 'deactivated'  : return BzState.deactivated  ;
      case 'deleted'      : return BzState.deleted      ;
      case 'banned'       : return BzState.banned       ;
      default:  return null;
    }
  }
  // --------------------
  static const List<BzState> bzStatesList = <BzState>[
    BzState.online,
    BzState.offline,
    BzState.deactivated,
    BzState.deleted,
    BzState.banned,
  ];
  // -----------------------------------------------------------------------------

  /// BZ SECTION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzSectionPhid({
    required BzSection? bzSection,
  }){
    final String _translation =
    bzSection == BzSection.realestate ? 'phid_realEstate'
        :
    bzSection == BzSection.construction ? 'phid_construction'
        :
    bzSection == BzSection.supplies ? 'phid_supplies'
        :
    'phid_bldrsFullName';

    return _translation;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getBzSectionsPhids({
    required BuildContext context,
    required List<BzSection> bzSections,
  }){
    final List<String> _strings = <String>[];

    if (Lister.checkCanLoop(bzSections) == true){

      for (final BzSection section in bzSections){
        final String _translation = getBzSectionPhid(
          bzSection: section,
        );
        _strings.add(_translation);
      }

    }

    return _strings;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzSection? concludeBzSectionByBzTypes(List<BzType>? selectedBzTypes){

    BzType? _bzType;
    if (Lister.checkCanLoop(selectedBzTypes) == true){
      _bzType = selectedBzTypes?[0];
    }

    switch (_bzType){

      case BzType.developer: return BzSection.realestate;
      case BzType.broker: return BzSection.realestate;

      case BzType.designer: return BzSection.construction;
      case BzType.contractor: return BzSection.construction;
      case BzType.artisan: return BzSection.construction;

      case BzType.supplier: return BzSection.supplies;
      case BzType.manufacturer: return BzSection.supplies;

      default : return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static  const List<BzSection> bzSectionsList = <BzSection>[
    BzSection.realestate,
    BzSection.construction,
    BzSection.supplies,
  ];
  // -----------------------------------------------------------------------------
}
