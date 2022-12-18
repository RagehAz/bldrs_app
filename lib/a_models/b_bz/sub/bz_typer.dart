import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
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
  standard,
  pro,
  master,
}

enum BzState {
  online,
  offline,
  deactivated,
  deleted,
  banned,
}

class BzTyper {
  // -----------------------------------------------------------------------------

  const BzTyper();

  // -----------------------------------------------------------------------------

  /// BZ SECTION CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherBzSection(BzSection section){
    switch (section) {
      case BzSection.realestate      :  return 'realestate'    ; break;
      case BzSection.construction    :  return 'construction'  ; break;
      case BzSection.supplies        :  return 'supplies'      ; break;
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzSection decipherBzSection(String section){
    switch (section) {
      case 'realestate'   : return BzSection.realestate   ; break;
      case 'construction' : return BzSection.construction ; break;
      case 'supplies'     : return BzSection.supplies     ; break;
      default:  return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// BZ TYPE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherBzType(BzType x) {
    switch (x) {
      case BzType.developer       :  return 'developer'     ; break;
      case BzType.broker          :  return 'broker'        ; break;
      case BzType.designer        :  return 'designer'      ; break;
      case BzType.contractor      :  return 'contractor'    ; break;
      case BzType.artisan         :  return 'artisan'       ; break;
      case BzType.manufacturer    :  return 'manufacturer'  ; break;
      case BzType.supplier        :  return 'supplier'      ; break;
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> cipherBzTypes(List<BzType> bzTypes){
    final List<String> _bzTypes = <String>[];

    if (Mapper.checkCanLoopList(bzTypes) == true){

      for (final BzType bzType in bzTypes){
        final String _ciphered = cipherBzType(bzType);
        _bzTypes.add(_ciphered);
      }

    }

    return _bzTypes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzType decipherBzType(String x) {
    switch (x) {
      case 'developer'      : return BzType.developer;      break;
      case 'broker'         : return BzType.broker;         break;
      case 'designer'       : return BzType.designer;       break;
      case 'contractor'     : return BzType.contractor;     break;
      case 'artisan'        : return BzType.artisan;        break;
      case 'manufacturer'   : return BzType.manufacturer;   break;
      case 'supplier'       : return BzType.supplier;       break;
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzType> decipherBzTypes(List<dynamic> bzTypes){
    final List<BzType> _bzTypes = <BzType>[];

    if (Mapper.checkCanLoopList(bzTypes) == true){

      final List<String> _strings = Stringer.getStringsFromDynamics(dynamics: bzTypes);

      for (final String _string in _strings){
        final BzType _bzType = decipherBzType(_string);
        _bzTypes.add(_bzType);
      }

    }

    return _bzTypes;
  }
  // -----------------------------------------------------------------------------

  /// BZ TYPE GETTERS

  // --------------------
  static const List<BzType> bzTypesList = <BzType>[
    BzType.developer,
    BzType.broker,
    BzType.designer,
    BzType.contractor,
    BzType.artisan,
    BzType.manufacturer,
    BzType.supplier,
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
  static String getBzTypeIconOff(BzType bzType) {

    final String icon = bzType == BzType.developer ? Iconz.bxPropertiesOff
        :
    bzType == BzType.broker ? Iconz.bxPropertiesOff
        :
    bzType == BzType.manufacturer ? Iconz.bxProductsOff
        :
    bzType == BzType.supplier ? Iconz.bxProductsOff
        :
    bzType == BzType.designer ? Iconz.bxDesignsOff
        :
    bzType == BzType.contractor ? Iconz.bxUndertakingOff
        :
    bzType == BzType.artisan ? Iconz.bxTradesOff
        :
    null;

    return icon;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzTypeIconOn(BzType bzType) {

    final String icon =
    bzType == BzType.developer ? Iconz.bxPropertiesOn
        :
    bzType == BzType.broker ? Iconz.bxPropertiesOn
        :
    bzType == BzType.manufacturer ? Iconz.bxProductsOn
        :
    bzType == BzType.supplier ? Iconz.bxProductsOn
        :
    bzType == BzType.designer ? Iconz.bxDesignsOn
        :
    bzType == BzType.contractor ? Iconz.bzUndertakingOn
        :
    bzType == BzType.artisan ? Iconz.bxTradesOn
        :
    null;

    return icon;
  }
  // -----------------------------------------------------------------------------

  /// BZ TYPE CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBzTypesContainThisType({
    @required BzType bzType,
    @required List<BzType> bzTypes,
  }){
    bool _contains = false;

    if (Mapper.checkCanLoopList(bzTypes) == true){

      if (bzTypes.contains(bzType) == true){
        _contains = true;
      }

    }

    return _contains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkBzTypesAreIdentical(List<BzType> types1, List<BzType> types2){

    final List<String> _a = cipherBzTypes(types1);
    final List<String> _b = cipherBzTypes(types2);

    return Mapper.checkListsAreIdentical(
        list1: _a,
        list2: _b
    );

  }
  // -----------------------------------------------------------------------------

  /// BZ TYPE TRANSLATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzTypePhid({
    @required BzType bzType,
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
    @required BuildContext context,
    @required List<BzType> bzTypes,
    bool pluralTranslation = true,
  }){
    final List<String> _strings = <String>[];

    if (Mapper.checkCanLoopList(bzTypes) == true){

      for (final BzType type in bzTypes){

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
    @required BuildContext context,
    @required List<BzType> bzTypes,
    @required BzForm bzForm,
    bool oneLine = false,
  }){

    final List<String> _bzTypesPhids = getBzTypesPhids(
      context: context,
      bzTypes: bzTypes,
      pluralTranslation: false,
    );
    final List<String> _typesTranslated = xPhrases(context, _bzTypesPhids);
    final String _bzTypesOneString = Stringer.generateStringFromStrings(
      strings: _typesTranslated,
    );

    final String _bzFormPhid = getBzFormPhid(
      context: context,
      bzForm: bzForm,
    );
    final String _formTranslated = xPhrase(context, _bzFormPhid);


    String _output = '$_bzTypesOneString\n$_formTranslated';

    /// ENGLISH
    if (TextDir.checkAppIsLeftToRight(context) == false){

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
  static String translateBzTypeAskHint(BuildContext context, BzType bzType){

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
    @required BzSection bzSection,
    List<BzType> initialBzTypes,
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
      if (Mapper.checkCanLoopList(initialBzTypes) == true){
        if (bzSection == BzSection.construction){
          if (
          initialBzTypes.contains(BzType.designer)
              ||
              initialBzTypes.contains(BzType.contractor)
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
  static List<BzType> concludeMixableBzTypes({
    @required BzType bzType,
  }){

    List<BzType> _mixableTypes;

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
    @required BzType selectedBzType,
  }){

    final List<BzType> _mixableTypes = concludeMixableBzTypes(
        bzType: selectedBzType
    );

    final List<BzType> _inactiveTypes = <BzType>[...bzTypesList];
    _inactiveTypes.remove(selectedBzType);

    /// REMOVE MIXABLE TYPES FROM ALL TYPE TO GET INACTIVE TYPES
    for (final BzType type in _mixableTypes){
      _inactiveTypes.remove(type);
    }

    return _inactiveTypes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzType> concludeDeactivatedBzTypesBasedOnSelectedBzTypes({
    @required BzType newSelectedType,
    @required List<BzType> selectedBzTypes,
    @required BzSection selectedBzSection,
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
    @required BzType newSelectedBzType,
    @required List<BzType> selectedBzTypes,
  }){

    final List<BzType> _outputTypes = <BzType>[...selectedBzTypes];

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
  static String cipherBzAccountType(BzAccountType bzAccountType) {
    switch (bzAccountType) {
      case BzAccountType.standard:  return 'standard';  break;
      case BzAccountType.pro:       return 'pro';       break;
      case BzAccountType.master:    return 'master';    break;
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzAccountType decipherBzAccountType(String bzAccountType) {
    switch (bzAccountType) {
      case 'standard'   : return BzAccountType.standard   ; break;
      case 'pro'        : return BzAccountType.pro        ; break;
      case 'master'     : return BzAccountType.master     ; break;
      default:return null;
    }
  }
  // --------------------
  static const List<BzAccountType> bzAccountTypesList = <BzAccountType>[
    BzAccountType.standard,
    BzAccountType.pro,
    BzAccountType.master,
  ];
  // -----------------------------------------------------------------------------

  /// BZ FORM

  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherBzForm(BzForm x) {
    switch (x) {
      case BzForm.individual  : return 'individual' ; break;
      case BzForm.company     : return 'company'    ; break;
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzForm decipherBzForm(String x) {
    switch (x) {
      case 'individual' :  return BzForm.individual ; break; // 1
      case 'company'    :  return BzForm.company    ; break; // 2
      default:  return null;
    }
  }
  // --------------------
  ///
  static List<String> cipherBzForms(List<BzForm> x){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(x) == true){

      for (final BzForm form in x){
        _output.add(cipherBzForm(form));
      }

    }

    return _output;
  }
  // --------------------
  ///
  static List<BzForm> decipherBzForms(List<String> y){
    final List<BzForm> _output = <BzForm>[];

    if (Mapper.checkCanLoopList(y) == true){

      for (final String form in y){
        _output.add(decipherBzForm(form));
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BZ FORM TRANSLATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzFormPhid({
    @required BuildContext context,
    @required BzForm bzForm,
  }){

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
    @required BuildContext context,
    @required List<BzForm> bzForms,
  }){
    final List<String> _strings = <String>[];

    if (Mapper.checkCanLoopList(bzForms) == true){

      for (final BzForm bzForm in bzForms){
        final String _translation = getBzFormPhid(
          context: context,
          bzForm: bzForm,
        );
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
    @required List<BzForm> bzForms,
    @required BzForm bzForm,
  }){
    bool _contains = false;

    if (Mapper.checkCanLoopList(bzForms) == true){

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
  static List<BzForm> concludeInactiveBzFormsByBzTypes(List<BzType> selectedBzTypes){

    /// INITIAL LIST OF ALL BZ FORMS
    List<BzForm> _bzForms = <BzForm>[...bzFormsList];

    if (Mapper.checkCanLoopList(selectedBzTypes) == true){

      /// MORE THAN ONE BZ TYPE
      if (selectedBzTypes.length > 1){
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

    return _bzForms;
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
  static String cipherBzState(BzState state) {
    switch (state) {
      case BzState.online       : return 'online'     ; break;
      case BzState.offline      : return 'offline'    ; break;
      case BzState.deactivated  : return 'deactivated'; break;
      case BzState.deleted      : return 'deleted'    ; break;
      case BzState.banned       : return 'banned'     ;  break;
      default:  return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzState decipherBzState(String state) {
    switch (state) {
      case 'online'       : return BzState.online       ; break;
      case 'offline'      : return BzState.offline      ; break;
      case 'deactivated'  : return BzState.deactivated  ; break;
      case 'deleted'      : return BzState.deleted      ; break;
      case 'banned'       : return BzState.banned       ; break;
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
    @required BuildContext context,
    @required BzSection bzSection,
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
    @required BuildContext context,
    @required List<BzSection> bzSections,
  }){
    final List<String> _strings = <String>[];

    if (Mapper.checkCanLoopList(bzSections) == true){

      for (final BzSection section in bzSections){
        final String _translation = getBzSectionPhid(
          context: context,
          bzSection: section,
        );
        _strings.add(_translation);
      }

    }

    return _strings;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzSection concludeBzSectionByBzTypes(List<BzType> selectedBzTypes){

    BzType _bzType;
    if (Mapper.checkCanLoopList(selectedBzTypes) == true){
      _bzType = selectedBzTypes[0];
    }

    switch (_bzType){

      case BzType.developer: return BzSection.realestate; break;
      case BzType.broker: return BzSection.realestate; break;

      case BzType.designer: return BzSection.construction; break;
      case BzType.contractor: return BzSection.construction; break;
      case BzType.artisan: return BzSection.construction; break;

      case BzType.supplier: return BzSection.construction; break;
      case BzType.manufacturer: return BzSection.construction; break;

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
