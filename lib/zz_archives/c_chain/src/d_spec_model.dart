part of chains;

@immutable
class SpecModel {
  // -----------------------------------------------------------------------------

  /// CONSTRUCTOR

  // --------------------
  const SpecModel({
    required this.pickerChainID,
    required this.value,
  });
  // --------------------
  /// specID is the specPicker's chain id , and the key of firebase map
  final String? pickerChainID;
  /// string, int, double, List<String>, List<double>, list<dynamic>
  final dynamic value;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic>? toMap() {
    /// shall be saved like this inside flyerModel
    /// specs : {
    /// 'specName' : 'value',
    /// 'weight' : 15,
    /// 'weightUnit' : 'Kg',
    /// 'price' : 160,
    /// 'priceUnit' : 'EGP',
    /// ...
    ///
    /// and should be saved like this in specs docs
    /// 'propertiesSpecs' : {
    ///   'xxx' : {},
    ///   'yyy' : {},
    /// }
    ///
    /// 'numberOfInstallments' : 12,
    /// 'installmentsDuration' : 12,
    /// 'installmentsDurationUnit' : 'months'
    /// },
    if (pickerChainID == null){
      return null;
    }
    else {
      return <String, dynamic>{
        pickerChainID!: value,
      };
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? cipherSpecs(List<SpecModel>? specs) {
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Lister.checkCanLoop(specs) == true) {

      final List<SpecModel> sorted = sortByKeysAlphabetically(specs: specs);

      for (final SpecModel spec in sorted) {

        final String? _key = spec.pickerChainID;

        /// KEY IS NOT DEFINED
        if (_key == null || _map[_key] == null){
          _map = Mapper.insertPairInMap(
            map: _map,
            key: spec.pickerChainID,
            value: spec.value,
            overrideExisting: true,
          );
        }

        /// KEY ALREADY DEFINED
        else {

          final dynamic _existingValue = _map[_key];

          if (_existingValue is String){

            final List<String> _list = <String>[_existingValue, spec.value];
            _map[_key] = _list;

          }

          else if (_existingValue is List<String>){
            final List<String> _list = <String>[..._existingValue, spec.value];
            _map[_key] = _list;
          }


        }

      }
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<SpecModel> decipherSpecs(Map<String, dynamic>? map) {
    final List<SpecModel> _specs = <SpecModel>[];

    if (map != null){

      final List<String> _keys = map.keys.toList();

      if (Lister.checkCanLoop(_keys)) {
        for (final String key in _keys) {

          final dynamic _value = map[key];

          if (_value is List<dynamic>){

            for (final dynamic val in _value){
              final SpecModel _spec = SpecModel(
                pickerChainID: key,
                value: val,
              );
              _specs.add(_spec);
            }

          }

          else {
            final SpecModel _spec = SpecModel(
              pickerChainID: key,
              value: _value,
            );
            _specs.add(_spec);
          }

        }
      }

    }

    return sortByKeysAlphabetically(specs: _specs);
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

// --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSpecsContainThisSpec({
    required List<SpecModel>? specs,
    required SpecModel? spec,
  }) {
    bool _contains = false;

    if (Lister.checkCanLoop(specs) && spec != null) {
      final SpecModel? _result = specs!.firstWhereOrNull(
              (SpecModel sp) => SpecModel.checkSpecsAreIdentical(sp, spec) == true,
          );

      if (_result == null) {
        _contains = false;
      } else {
        _contains = true;
      }
    }

    return _contains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSpecsContainThisSpecValue({
    required List<SpecModel>? specs,
    required dynamic value,
  }) {
    bool _contains = false;

    if (Lister.checkCanLoop(specs) && value != null) {
      final List<SpecModel> _specs = specs!.where((SpecModel spec) => spec.value == value).toList();

      if (_specs.isNotEmpty) {
        _contains = true;
      }
    }

    return _contains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSpecsContainOfSamePickerChainID({
    required List<SpecModel>? specs,
    required String? pickerChainID,
  }) {
    bool _contains = false;

    if (Lister.checkCanLoop(specs) && pickerChainID != null) {
      final SpecModel? _result = specs?.firstWhereOrNull(
              (SpecModel sp) => sp.pickerChainID == pickerChainID,
          );

      if (_result == null) {
        _contains = false;
      } else {
        _contains = true;
      }
    }

    return _contains;
  }
  // --------------------
  /// TASK : TEST ME
  static bool specsContainsNewSale(List<SpecModel> specs) {
    const SpecModel _newSaleSpec = SpecModel(
      pickerChainID: 'propertyContractType',
      value: null,//RawSpecs.newSaleID
    );

    final bool _containsNewSale = SpecModel.checkSpecsContainThisSpec(
      specs: specs,
      spec: _newSaleSpec,
    );

    return _containsNewSale;
  }
  // --------------------
  /// TASK : TEST ME
  static bool checkSpecIsFromChainK({
    required SpecModel? spec,
  }){
    bool _isFromKeywords = false;

    if (spec != null){
      // _isFromKeywords =  Chain.chainKSonsIDs.contains(spec.pickerChainID);

      _isFromKeywords = Keyworder.checkIsPhidK(spec.pickerChainID);

    }

    return _isFromKeywords;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool specsIncludeOtherSpecUsingThisUnit({
    required List<PickerModel>? pickers,
    required List<SpecModel>? specs,
    required SpecModel? unitSpec,
  }){
    bool _include = false;

    if (Lister.checkCanLoop(specs) == true && Lister.checkCanLoop(pickers) == true){

      for (final SpecModel spec in specs!){

        final PickerModel? _specPicker = PickerModel.getPickerByChainIDOrUnitChainID(
          pickers: pickers,
          chainIDOrUnitChainID: spec.pickerChainID,
        );

        if (_specPicker?.unitChainID == unitSpec?.pickerChainID){
          _include = true;
          break;
        }

      }

    }

    return _include;
  }
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<SpecModel> dummySpecs() {
    return <SpecModel>[
      const SpecModel(pickerChainID: '0008_phid_k_flyer_type_design', value: '0000_phid_k_designType_landscape'),
      const SpecModel(pickerChainID: '0008_phid_k_flyer_type_design', value: '0001_phid_k_designType_interior'),
      const SpecModel(pickerChainID: '0008_phid_k_flyer_type_design', value: '0003_phid_k_designType_urban'),
      const SpecModel(pickerChainID: '0008_phid_k_flyer_type_design', value: '0005_phid_k_designType_kiosk'),
      const SpecModel(pickerChainID: '0041_phid_s_contractType', value: '0001_phid_s_contractType_Resale'),
      const SpecModel(pickerChainID: '0008_phid_k_flyer_type_design', value: '0008_phid_k_designType_facade'),
      const SpecModel(pickerChainID: '0039_phid_s_propertyLicense', value: '0004_phid_s_ppt_lic_industrial'),

    ];
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogSpec() {
    blog('BLOGGING SPEC : specsListID : ( $pickerChainID ) : value : ( $value )');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogSpecs(List<SpecModel>? specs) {
    blog('SPECS-PRINT -------------------------------------------------- START');

    if (Lister.checkCanLoop(specs) == true){
      for (final SpecModel spec in specs!) {
        blog('${spec.pickerChainID} : ${spec.value}');
      }
    }
    else{
      blog('No specs to blog');
    }

    blog('SPECS-PRINT -------------------------------------------------- END');
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TASK : TEST ME
  static List<SpecModel> getSpecsBelongingToThisPicker({
    required List<SpecModel>? specs,
    required PickerModel? picker,
  }){
    final List<SpecModel> _result = <SpecModel>[];

    if (Lister.checkCanLoop(specs) == true && picker != null) {

      final List<SpecModel> _belongingSpecs = <SpecModel>[];

      /// GET ALL SPECS BELONGING TO THIS PICKER : EITHER (CHAIN ID) OR (UNIT CHAIN ID)
      for (final SpecModel spec in specs!){
        final bool _isOfChainID = spec.pickerChainID == picker.chainID;
        final bool _isOfUnitChainID = spec.pickerChainID == picker.unitChainID;
        if (_isOfChainID == true || _isOfUnitChainID == true){
          _belongingSpecs.add(spec);
        }
      }

      /// CHECK IF ONLY A UNIT CHAIN ID
      if (_belongingSpecs.length == 1 && _belongingSpecs[0].pickerChainID == picker.unitChainID){
        /// will not add it
      }
      else {
        _result.addAll(_belongingSpecs);
      }

    }

    return _result;
  }
  // --------------------
  /// TASK : TEST ME
  static List<SpecModel> getSpecsByPickerChainID({
    required List<SpecModel>? specs,
    required String? pickerChainID,
  }) {
    List<SpecModel> _result = <SpecModel>[];

    if (Lister.checkCanLoop(specs) == true && pickerChainID != null) {
      _result = specs!.where(
            (SpecModel spec) => Phider.removeIndexFromPhid(phid: spec.pickerChainID) == Phider.removeIndexFromPhid(phid: pickerChainID),
      )
          .toList();
    }

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SpecModel? getFirstSpecFromSpecsByPickerChainID({
    required List<SpecModel>? specs,
    required String? pickerChainID,
  }){
    SpecModel? _result;

    if (Lister.checkCanLoop(specs) == true && pickerChainID != null) {

      for (final SpecModel spec in specs!){
        if (spec.pickerChainID == pickerChainID){
          _result = spec;
          break;
        }
      }

    }

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getSpecsIDs(List<SpecModel>? specs){
    final List<String> _output = <String>[];

    if (Lister.checkCanLoop(specs) == true){
      for (final SpecModel spec in specs!){

        if (spec.value is String){
          _output.add(spec.value);
        }

      }
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static List<SpecModel> getChainKSpecs(List<SpecModel> specs){
    final List<SpecModel> _output = <SpecModel>[];

    if (Lister.checkCanLoop(specs) == true){
      for (final SpecModel spec in specs){

        final bool _specIsKeywordID = SpecModel.checkSpecIsFromChainK(
          spec: spec,
        );

        if (_specIsKeywordID == true){
          _output.add(spec);
        }

      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<SpecModel> putSpecsInSpecs({
    required List<SpecModel> parentSpecs,
    required List<SpecModel> inputSpecs,
    required bool? canPickMany,
  }) {
    /// This considers if the specPicker can or can't pick many spec of same list,
    /// then adds if absent and updates or ignores if exists accordingly
    ///
    final List<SpecModel> _specs = <SpecModel>[];

    if (Lister.checkCanLoop(parentSpecs) == true){
      _specs.addAll(parentSpecs);
    }

    if (Lister.checkCanLoop(inputSpecs)) {
      for (final SpecModel inputSpec in inputSpecs) {

        /// A - CAN PICK MANY "of this list ID"
        if (Mapper.boolIsTrue(canPickMany) == true) {
          final bool _alreadyThere = checkSpecsContainThisSpec(specs: _specs, spec: inputSpec);

          /// A1 - SPEC ALREADY SELECTED => do nothing
          if (_alreadyThere == true) {
          }

          /// A2 - SPEC IS NOT SELECTED => add spec
          else {
            _specs.add(inputSpec);
          }
        }

        /// B - CAN NOT PICK MANY " of this list ID"
        else {
          final bool _specsContainOfSamePickerChainID = checkSpecsContainOfSamePickerChainID(
            specs: _specs,
            pickerChainID: inputSpec.pickerChainID,
          );

          /// B1 - LIST ID IS ALREADY THERE in [_specs] => REPLACE
          if (_specsContainOfSamePickerChainID == true) {
            final int _specOfSameListIDIndex = _specs.indexWhere(
                    (SpecModel sp) => sp.pickerChainID == inputSpec.pickerChainID);
            _specs[_specOfSameListIDIndex] = inputSpec;
          }

          /// B2 - LIST ID IS NOT THERE in [_specs] => ADD
          else {
            _specs.add(inputSpec);
          }

          // if (_alreadyThere == true){
          //   final int _specIndex = _specs.indexWhere((sp) => Spec.specsAreTheSame(sp, inputSpec));
          //   _specs[_specIndex] = inputSpec;
          // }
          //
          // else {
          //   _specs.add(inputSpec);
          // }

        }

      }
    }

    return SpecModel.cleanSpecs(_specs);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<SpecModel> cleanSpecs(List<SpecModel>? specs) {
    final List<SpecModel> _output = <SpecModel>[];

    if (Lister.checkCanLoop(specs) == true) {
      for (final SpecModel spec in specs!) {
        if (
            // spec != null &&
            spec.value != null &&
            spec.value != 0 &&
            spec.value != '' &&
            spec.pickerChainID != null &&
            spec.pickerChainID != '') {
          _output.add(spec);
        }
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<SpecModel> removeSpecFromSpecs({
    required List<SpecModel>? specs,
    required SpecModel? spec,
  }){

    List<SpecModel> _output = <SpecModel>[];

    if (Lister.checkCanLoop(specs) == true){
      _output = <SpecModel>[...specs!];

      _output.remove(spec);

    }

    return _output;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<SpecModel> removeSpecsFromSpecs({
    required List<SpecModel> sourceSpecs,
    required List<SpecModel> specsToRemove,
  }){

    // blog('removeSpecsFromSpecs : removing : ${specsToRemove.length}');

    List<SpecModel> _output = <SpecModel>[...sourceSpecs];

    if (
    Lister.checkCanLoop(_output) == true
        &&
        Lister.checkCanLoop(specsToRemove) == true
    ){

      // blog('removeSpecsFromSpecs : can remove them');

      for (final SpecModel specToRemove in specsToRemove){

        // blog('removeSpecsFromSpecs : removing : ${specToRemove.value} ');

        _output = removeSpecFromSpecs(
            specs: _output,
            spec: specToRemove
        );

      }

    }

    // blog('and the output had become :-');
    // SpecModel.blogSpecs(_output);

    return _output;
  }
  // --------------------
  /// TASK : NOT WORKING
  static List<SpecModel> generateSpecsByPhids({
    required List<String> phids,
  }){
    final List<SpecModel> _specs = <SpecModel>[];

    blog('generateSpecsByPhids : phids : $phids');

    if (Lister.checkCanLoop(phids) == true){

      // final List<String> _chainsIDs = FlyerTyper.getChainsIDsPerViewingEvent(
      //   flyerType: flyerType,
      //   event: ViewingEvent.admin,
      // );

      for (final String phid in phids){

        final String? _pickerChainID = PickerModel.getPickerChainIDOfPhid(
          phid: phid,
          bldrsChains: [],
        );

        if (_pickerChainID != null){


          final SpecModel _spec = SpecModel(
              pickerChainID: _pickerChainID,
              value: phid
          );

          _specs.add(_spec);

        }
      }

    }

    SpecModel.blogSpecs(_specs);

    return _specs;
  }
  // --------------------
  /// TASK : NOT WORKING
  /*
  static List<String> getPhidsFromSpecsFilteredByFlyerType({
    required FlyerType flyerType,
    required List<SpecModel> specs,
  }){
    final List<String> _output = <String>[];

    if (flyerType != null && Lister.checkCanLoop(specs) == true) {

      final List<String> _chainsIDs = FlyerTyper.getChainsIDsPerViewingEvent(
        flyerType: flyerType,
        event: ViewingEvent.admin,
      );

      for (final SpecModel spec in specs) {

        if (spec.value is String){ // && Keyworder.checkIsPhidK(spec.value) == true) {

          final bool _isInChainID = Stringer.checkStringsContainString(
              strings: _chainsIDs,
              string: spec.pickerChainID
          );

          if (_isInChainID == true){
            _output.add(spec.value);
          }

          // x
          //
          // final String _chainIDByFlyerType = FlyerTyper.concludeChainIDByFlyerType(
          //     flyerType: flyerType,
          // );
          // blog('come on : ${spec.value} : ${spec.pickerChainID} _chainIDByFlyerType : $_chainIDByFlyerType');
          //
          // if (_chainIDBySpec == _chainIDByFlyerType) {
          //   _output.add(spec.value);
          // }

        }

      }

    }

    return _output;
  }
   */
  // -----------------------------------------------------------------------------
  /*
    /// STANDARDS

    // --------------------
    static int getMaxDigitsOfSelectedUnit({
      required String unitID,
    }){

      int _digits;

      switch (Phider.removeIndexFromPhid(phid: unitID)){

        /// phid_s_linearMeasureUnit
        case 'phid_s_micron': _digits = 0; break;
        case 'phid_s_micrometer': _digits = 2; break;

        // default: _digits = null;
      }

      return _digits;
    }
   */
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// NOT TESTED
  static List<SpecModel> sortByKeysAlphabetically({
    required List<SpecModel>? specs,
  }){
    List<SpecModel> _output = [];

    if (Lister.checkCanLoop(specs) == true){

      _output = <SpecModel>[...specs!];

      _output.sort(
              (SpecModel a, SpecModel b) => a.pickerChainID!.compareTo(b.pickerChainID!)
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsListOfSpecs(dynamic object) {
    bool _objectsListIsSpecs = false;

    if (object != null) {
      if (object.length > 0) {
        if (object[0].runtimeType == SpecModel) {
          _objectsListIsSpecs = true;
        }
      }
    }

    return _objectsListIsSpecs;
  }
    // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSpecsAreIdentical(SpecModel? spec1, SpecModel? spec2) {
    bool _areIdentical = false;

    if (spec1 == null && spec2 == null){
      _areIdentical = true;
    }
    else if (spec1 != null && spec2 != null) {
      if (spec1.pickerChainID == spec2.pickerChainID) {
        if (spec1.value == spec2.value) {
          _areIdentical = true;
        }
      }
    }

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSpecsListsAreIdentical(List<SpecModel>? specs1, List<SpecModel>? specs2) {

    bool _listsAreIdentical = false;

    if (specs1 == null && specs2 == null){
      _listsAreIdentical = true;
    }
    else if (Lister.checkCanLoop(specs1) == false && Lister.checkCanLoop(specs2) == false){
      _listsAreIdentical = true;
    }
    else if (Lister.checkCanLoop(specs1) == true && Lister.checkCanLoop(specs2) == true){

      if (specs1!.length != specs2!.length){
        _listsAreIdentical = false;
      }
      else {

        final List<SpecModel> _list1 = sortByKeysAlphabetically(specs: specs1);
        final List<SpecModel> _list2 = sortByKeysAlphabetically(specs: specs2);

        for (int i = 0; i < _list1.length; i++){

          final SpecModel _spec1 = _list1[i];
          final SpecModel _spec2 = _list2[i];

          final bool _areIdentical = checkSpecsAreIdentical(_spec1, _spec2);

          if (_areIdentical == false){
            _listsAreIdentical = false;
            break;
          }

          _listsAreIdentical = true;

        }

      }

    }

    // blog('specsListsAreIdentical : _listsAreIdentical : $_listsAreIdentical');

    return _listsAreIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
     @override
     String toString() => 'MapModel(key: $key, value: ${value.toString()})';
     */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is SpecModel){
      _areIdentical = checkSpecsAreIdentical(this, other,);
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      pickerChainID.hashCode^
      value.hashCode;
// -----------------------------------------------------------------------------
}

class Speccer {
  // -----------------------------------------------------------------------------
  const Speccer();
  // --------------------
  static double? getSalePrice(List<SpecModel>? specs) {
    return SpecModel.getFirstSpecFromSpecsByPickerChainID(
      specs: specs,
      pickerChainID: 'phid_s_salePrice',
    )?.value;
  }
  // --------------------
  static double? getRentPrice(List<SpecModel>? specs) {
    return SpecModel.getFirstSpecFromSpecsByPickerChainID(
      specs: specs,
      pickerChainID: 'phid_s_rentPrice',
    )?.value;
  }
  // --------------------
  static double? getPropertySalePrice(List<SpecModel>? specs) {
    return SpecModel.getFirstSpecFromSpecsByPickerChainID(
      specs: specs,
      pickerChainID: 'phid_s_PropertySalePrice',
    )?.value;
  }
  // --------------------
  static double? getPropertyRentPrice(List<SpecModel>? specs) {
    return SpecModel.getFirstSpecFromSpecsByPickerChainID(
      specs: specs,
      pickerChainID: 'phid_s_PropertyRentPrice',
    )?.value;
  }
  // --------------------
  static String? getCurrencyID(List<SpecModel>? specs) {
    return SpecModel.getFirstSpecFromSpecsByPickerChainID(specs: specs, pickerChainID: 'phid_s_currency',)?.value;
  }
  // --------------------
  static bool checkSpecsHavePrice(List<SpecModel>? specs){

    if (Lister.checkCanLoop(specs) == false){
      return false;
    }
    else {

      final double? _price =
              getSalePrice(specs) ??
              getRentPrice(specs) ??
              getPropertySalePrice(specs) ??
              getPropertyRentPrice(specs);

      if (_price == null){
        return false;
      }
      else {
        return true;
      }

    }

  }
  // -----------------------------------------------------------------------------
}
