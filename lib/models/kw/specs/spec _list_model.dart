import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/specs/specs_lists.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:flutter/foundation.dart';

class SpecList{
  final String id;
  final List<Name> names;
  /// can pick many allows selecting either only 1 value from the chain or multiple values
  final bool canPickMany;
  /// THE SELECTABLE RANGE allows selecting only parts of the original spec list
  /// if <KW>['id1', 'id2'] only these IDs will be included,
  /// if <int>[1, 5] then only this range is selectable
  final List<dynamic> range;
  final Chain specChain;

  const SpecList({
    @required this.id,
    @required this.names,
    @required this.canPickMany,
    @required this.range,
    @required this.specChain,
  });

  static List<SpecList> propertiesSpecLists = <SpecList>[

    /// PROPERTY FORM
    SpecList(
        id: 'propertyForm',
        names: SpecChain.propertyForm.names,
        canPickMany: false,
        range: null,
        specChain: SpecChain.propertyForm
    ),
    /// PROPERTY LICENSE
    SpecList(
        id: 'propertyLicense',
        names: SpecChain.propertyLicense.names,
        canPickMany: true,
        range: null,
        specChain: SpecChain.propertyLicense
    ),
    /// PROPERTY CONTRACT TYPE
    const SpecList(
        id: 'propertyContractType',
        names: <Name>[Name(code: 'en', value: 'Property contract Type'), Name(code: 'ar', value: 'نوع التعاقد')],
        canPickMany: false,
        range: null,
        specChain: SpecChain.contractType
    ),

  ];
}
