import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:flutter/material.dart';

@immutable
class AgendaModel {
  // -----------------------------------------------------------------------------
  const AgendaModel({
    required this.all,
    required this.developers,
    required this.brokers,
    required this.designers,
    required this.contractors,
    required this.artisans,
    required this.manufacturers,
    required this.suppliers,
  });
  // -----------------------------------------------------------------------------
  final List<String>? all;
  final List<String>? developers;
  final List<String>? brokers;
  final List<String>? designers;
  final List<String>? contractors;
  final List<String>? artisans;
  final List<String>? manufacturers;
  final List<String>? suppliers;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  AgendaModel copyWith({
    List<String>? all,
    List<String>? developers,
    List<String>? brokers,
    List<String>? designers,
    List<String>? contractors,
    List<String>? artisans,
    List<String>? manufacturers,
    List<String>? suppliers,
  }){

    return AgendaModel(
      all: all ?? this.all,
      developers: developers ?? this.developers,
      brokers: brokers ?? this.brokers,
      designers: designers ?? this.designers,
      contractors: contractors ?? this.contractors,
      artisans: artisans ?? this.artisans,
      manufacturers: manufacturers ?? this.manufacturers,
      suppliers: suppliers ?? this.suppliers,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AgendaModel newAgenda(){
    return const AgendaModel(
      all: <String>[],
      developers: <String>[],
      brokers: <String>[],
      designers: <String>[],
      contractors: <String>[],
      artisans: <String>[],
      manufacturers: <String>[],
      suppliers: <String>[],
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'all': all,
      'developers': developers,
      'brokers': brokers,
      'designers': designers,
      'contractors': contractors,
      'artisans': artisans,
      'manufacturers': manufacturers,
      'suppliers': suppliers,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AgendaModel decipher(Map<String, dynamic>? map){
    AgendaModel _agenda = newAgenda();

    if (map != null){

      _agenda = AgendaModel(
        all: Stringer.getStringsFromDynamics(map['all']),
        developers: Stringer.getStringsFromDynamics(map['developers']),
        brokers: Stringer.getStringsFromDynamics(map['brokers']),
        designers: Stringer.getStringsFromDynamics(map['designers']),
        contractors: Stringer.getStringsFromDynamics(map['contractors']),
        artisans: Stringer.getStringsFromDynamics(map['artisans']),
        manufacturers: Stringer.getStringsFromDynamics(map['manufacturers']),
        suppliers: Stringer.getStringsFromDynamics(map['suppliers']),
      );

    }

    return _agenda;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static AgendaModel addBz({
    required BzModel? bzModel,
    required AgendaModel? oldAgenda,
  }){
    AgendaModel _newAgenda = oldAgenda ?? newAgenda();

    if (bzModel != null){

      _newAgenda = _newAgenda.copyWith(
          all: Stringer.addStringToListIfDoesNotContainIt(
            strings: _newAgenda.all,
            stringToAdd: bzModel.id,
          )
      );

      if (Lister.checkCanLoopList(bzModel.bzTypes) == true){
        for (final BzType bzType in bzModel.bzTypes!){

          switch(bzType){

            /// DEVELOPER
            case BzType.developer:
              _newAgenda = _newAgenda.copyWith(
                developers: Stringer.addStringToListIfDoesNotContainIt(
                  strings: _newAgenda.developers,
                  stringToAdd: bzModel.id,
                ),
              ); break;

              /// BROKER
            case BzType.broker:
              _newAgenda = _newAgenda.copyWith(
                brokers: Stringer.addStringToListIfDoesNotContainIt(
                  strings: _newAgenda.brokers,
                  stringToAdd: bzModel.id,
                ),
              ); break;

              /// DESIGNER
            case BzType.designer:
              _newAgenda = _newAgenda.copyWith(
                designers: Stringer.addStringToListIfDoesNotContainIt(
                  strings: _newAgenda.designers,
                  stringToAdd: bzModel.id,
                ),
              ); break;

              /// CONTRACTOR
            case BzType.contractor:
              _newAgenda = _newAgenda.copyWith(
                contractors: Stringer.addStringToListIfDoesNotContainIt(
                  strings: _newAgenda.contractors,
                  stringToAdd: bzModel.id,
                ),
              ); break;

              /// ARTISAN
            case BzType.artisan:
              _newAgenda = _newAgenda.copyWith(
                artisans: Stringer.addStringToListIfDoesNotContainIt(
                  strings: _newAgenda.artisans,
                  stringToAdd: bzModel.id,
                ),
              ); break;

              /// MANUFACTURER
            case BzType.manufacturer:
              _newAgenda = _newAgenda.copyWith(
                manufacturers: Stringer.addStringToListIfDoesNotContainIt(
                  strings: _newAgenda.manufacturers,
                  stringToAdd: bzModel.id,
                ),
              ); break;

              /// SUPPLIER
            case BzType.supplier:
              _newAgenda = _newAgenda.copyWith(
                suppliers: Stringer.addStringToListIfDoesNotContainIt(
                  strings: _newAgenda.suppliers,
                  stringToAdd: bzModel.id,
                ),
              ); break;

          }

        }
      }

    }

    return _newAgenda;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AgendaModel addBzz({
    required List<BzModel>? bzzModels,
    required AgendaModel? oldAgenda,
  }){
    AgendaModel _newAgenda = oldAgenda ?? newAgenda();

    if (Lister.checkCanLoopList(bzzModels) == true){

      for (final BzModel bzModel in bzzModels!){
        _newAgenda = addBz(
          bzModel: bzModel,
          oldAgenda: _newAgenda,
        );
      }

    }

    return _newAgenda;
  }
  // --------------------
  /// TASK : TEST ME
  static AgendaModel addOrRemoveBz({
    required BzModel? bzModel,
    required AgendaModel? oldAgenda,
  }){
    AgendaModel _newAgenda = oldAgenda ?? newAgenda();

    if (bzModel != null){

      _newAgenda = _newAgenda.copyWith(
          all: Stringer.addOrRemoveStringToStrings(
            strings: _newAgenda.all,
            string: bzModel.id,
          )
      );

      if (Lister.checkCanLoopList(bzModel.bzTypes) == true){

        for (final BzType bzType in bzModel.bzTypes!){

          switch(bzType){

            /// DEVELOPER
            case BzType.developer:
              _newAgenda = _newAgenda.copyWith(developers: Stringer.addOrRemoveStringToStrings(
                strings: _newAgenda.developers,
                string: bzModel.id,
              ),); break;

              /// BROKER
            case BzType.broker:
              _newAgenda = _newAgenda.copyWith(brokers: Stringer.addOrRemoveStringToStrings(
                strings: _newAgenda.brokers,
                string: bzModel.id,
              ),); break;

              /// DESIGNER
            case BzType.designer:
              _newAgenda = _newAgenda.copyWith(designers: Stringer.addOrRemoveStringToStrings(
                strings: _newAgenda.designers,
                string: bzModel.id,
              ),); break;

              /// CONTRACTOR
            case BzType.contractor:
              _newAgenda = _newAgenda.copyWith(contractors: Stringer.addOrRemoveStringToStrings(
                strings: _newAgenda.contractors,
                string: bzModel.id,
              ),); break;

              /// ARTISAN
            case BzType.artisan:
              _newAgenda = _newAgenda.copyWith(artisans: Stringer.addOrRemoveStringToStrings(
                strings: _newAgenda.artisans,
                string: bzModel.id,
              ),); break;

              /// MANUFACTURER
            case BzType.manufacturer:
              _newAgenda = _newAgenda.copyWith(manufacturers: Stringer.addOrRemoveStringToStrings(
                strings: _newAgenda.manufacturers,
                string: bzModel.id,
              ),); break;

              /// SUPPLIER
            case BzType.supplier:
              _newAgenda = _newAgenda.copyWith(suppliers: Stringer.addOrRemoveStringToStrings(
                strings: _newAgenda.suppliers,
                string: bzModel.id,
              ),); break;

            default: _newAgenda = _newAgenda.copyWith();
          }

        }

      }

    }

    return _newAgenda;
  }
  // --------------------
  /// TASK : TEST ME
  static AgendaModel addOrRemoveFlyers({
    required List<BzModel>? bzModels,
    required AgendaModel? oldAgenda,
  }){
    AgendaModel _newAgenda = oldAgenda ?? newAgenda();

    if (Lister.checkCanLoopList(bzModels) == true){

      for (final BzModel bzModel in bzModels!){

        _newAgenda = addOrRemoveBz(
          bzModel: bzModel,
          oldAgenda: _newAgenda,
        );

      }

    }

    return _newAgenda;
  }
  // --------------------
  /// TASK : TEST ME
  static AgendaModel removeBz({
    required BzModel? bz,
    required AgendaModel? oldAgenda,
  }){
    AgendaModel _newAgenda = oldAgenda ?? newAgenda();
    final String? _bzID = bz?.id;

    if (bz != null && _bzID != null){

      _newAgenda = _newAgenda.copyWith(
          all: Stringer.removeStringsFromStrings(
            removeFrom: _newAgenda.all,
            removeThis: [_bzID],
          )
      );

      if (Lister.checkCanLoopList(bz.bzTypes) == true){

        for (final BzType bzType in bz.bzTypes!){

          switch(bzType){

            /// DEVELOPER
            case BzType.developer:
              _newAgenda = _newAgenda.copyWith(
                developers: Stringer.removeStringsFromStrings(
                  removeFrom: _newAgenda.developers,
                  removeThis: [_bzID],
                ),
              ); break;

              /// BROKER
            case BzType.broker:
              _newAgenda = _newAgenda.copyWith(
                brokers: Stringer.removeStringsFromStrings(
                  removeFrom: _newAgenda.brokers,
                  removeThis: [_bzID],
                ),
              ); break;

              /// DESIGNER
          case BzType.designer:
            _newAgenda = _newAgenda.copyWith(
              designers: Stringer.removeStringsFromStrings(
                removeFrom: _newAgenda.designers,
                removeThis: [_bzID],
              ),
            ); break;

            /// CONTRACTOR
          case BzType.contractor:
            _newAgenda = _newAgenda.copyWith(
              contractors: Stringer.removeStringsFromStrings(
                removeFrom: _newAgenda.contractors,
                removeThis: [_bzID],
              ),
            ); break;

            /// ARTISAN
          case BzType.artisan:
            _newAgenda = _newAgenda.copyWith(
              artisans: Stringer.removeStringsFromStrings(
                removeFrom: _newAgenda.artisans,
                removeThis: [_bzID],
              ),
            ); break;

            /// MANUFACTURER
          case BzType.manufacturer:
            _newAgenda = _newAgenda.copyWith(
              manufacturers: Stringer.removeStringsFromStrings(
                removeFrom: _newAgenda.manufacturers,
                removeThis: [_bzID],
              ),
            ); break;

            /// SUPPLIER
          case BzType.supplier:
            _newAgenda = _newAgenda.copyWith(
              suppliers: Stringer.removeStringsFromStrings(
                removeFrom: _newAgenda.suppliers,
                removeThis: [_bzID],
              ),
            ); break;

            default: _newAgenda = _newAgenda.copyWith();

          }

        }

      }

    }

    return _newAgenda;
  }
  // --------------------
  /// TASK : TEST ME
  static AgendaModel removeBzz({
    required List<BzModel>? bzz,
    required AgendaModel? oldAgenda,
  }){
    AgendaModel _newAgenda = oldAgenda ?? newAgenda();

    if (Lister.checkCanLoopList(bzz) == true){

      for (final BzModel bz in bzz!){

        _newAgenda = removeBz(
          bz: bz,
          oldAgenda: _newAgenda,
        );

      }

    }

    return _newAgenda;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AgendaModel removeBzByID({
    required AgendaModel? oldAgenda,
    required String? bzID,
  }){
    AgendaModel _newAgenda = oldAgenda ?? newAgenda();

    if (bzID != null){

      final bool _contains = Stringer.checkStringsContainString(
        strings: _newAgenda.all,
        string: bzID,
      );

      if (_contains == true){

        /// REMOVE FROM ALL
        _newAgenda = _newAgenda.copyWith(all: Stringer.removeStringsFromStrings(
          removeFrom: _newAgenda.all,
          removeThis: [bzID],
        ),);

        /// DEVELOPER
        if (Stringer.checkStringsContainString(strings: _newAgenda.developers, string: bzID,) == true){
          _newAgenda = _newAgenda.copyWith(developers: Stringer.removeStringsFromStrings(
            removeFrom: _newAgenda.developers,
            removeThis: [bzID],
          ),);
        }
        /// BROKER
        else if (Stringer.checkStringsContainString(strings: _newAgenda.brokers, string: bzID) == true){
          _newAgenda = _newAgenda.copyWith(brokers: Stringer.removeStringsFromStrings(
            removeFrom: _newAgenda.brokers,
            removeThis: [bzID],
          ),);
        }
        /// DESIGNER
        else if (Stringer.checkStringsContainString(strings: _newAgenda.designers, string: bzID) == true){
          _newAgenda = _newAgenda.copyWith(designers: Stringer.removeStringsFromStrings(
            removeFrom: _newAgenda.designers,
            removeThis: [bzID],
          ),);
        }
        /// CONTRACTOR
        else if (Stringer.checkStringsContainString(strings: _newAgenda.contractors, string: bzID) == true){
          _newAgenda = _newAgenda.copyWith(contractors: Stringer.removeStringsFromStrings(
            removeFrom: _newAgenda.contractors,
            removeThis: [bzID],
          ),);
        }
        /// ARTISAN
        else if (Stringer.checkStringsContainString(strings: _newAgenda.artisans, string: bzID) == true){
          _newAgenda = _newAgenda.copyWith(artisans: Stringer.removeStringsFromStrings(
            removeFrom: _newAgenda.artisans,
            removeThis: [bzID],
          ),);
        }
        /// MANUFACTURER
        else if (Stringer.checkStringsContainString(strings: _newAgenda.manufacturers, string: bzID) == true){
          _newAgenda = _newAgenda.copyWith(manufacturers: Stringer.removeStringsFromStrings(
            removeFrom: _newAgenda.manufacturers,
            removeThis: [bzID],
          ),);
        }
        /// SUPPLIERS
        else if (Stringer.checkStringsContainString(strings: _newAgenda.suppliers, string: bzID) == true){
          _newAgenda = _newAgenda.copyWith(suppliers: Stringer.removeStringsFromStrings(
            removeFrom: _newAgenda.suppliers,
            removeThis: [bzID],
          ),);
        }

      }

    }

    return _newAgenda;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AgendaModel removeFlyersByIDs({
    required AgendaModel? oldAgenda,
    required List<String>? bzzIDs,
  }){
    AgendaModel _newAgenda = oldAgenda ?? newAgenda();

    if (Lister.checkCanLoopList(bzzIDs) == true){

      for (final String bzID in bzzIDs!){

        _newAgenda = removeBzByID(
          bzID: bzID,
          oldAgenda: oldAgenda,
        );

      }

    }

    return _newAgenda;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static int? getCountByBzType({
    required BzType? bzType,
    required AgendaModel? agenda,
  }){
    int? _output;

    if (bzType != null && agenda != null){

      switch (bzType) {
        case BzType.developer     : return _output = agenda.developers   ?.length;
        case BzType.broker        : return _output = agenda.brokers      ?.length;
        case BzType.designer      : return _output = agenda.designers    ?.length;
        case BzType.contractor    : return _output = agenda.contractors  ?.length;
        case BzType.artisan       : return _output = agenda.artisans     ?.length;
        case BzType.manufacturer  : return _output = agenda.manufacturers?.length;
        case BzType.supplier      : return _output = agenda.suppliers    ?.length;
        default: _output = 0;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  void blogAgenda({required String invoker}){
    blog('XXX === >>> AgendaModel : $invoker');
    blog('   all          : $all');
    blog('   developers   : $developers');
    blog('   brokers      : $brokers');
    blog('   designers    : $designers');
    blog('   contractors  : $contractors');
    blog('   artisans     : $artisans');
    blog('   manufacturers: $manufacturers');
    blog('   suppliers    : $suppliers');
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED: WORKS PERFECT
  static bool checkAgendasAreIdentical({
    required AgendaModel? agenda1,
    required AgendaModel? agenda2,
  }){
    bool _areIdentical = false;

    if (agenda1 == null && agenda2 == null){
      _areIdentical = true;
    }

    else if (agenda1 != null && agenda2 != null){

      if (
          Lister.checkListsAreIdentical(list1: agenda1.all           ,list2: agenda2.all           ) == true &&
          Lister.checkListsAreIdentical(list1: agenda1.developers    ,list2: agenda2.developers    ) == true &&
          Lister.checkListsAreIdentical(list1: agenda1.brokers       ,list2: agenda2.brokers       ) == true &&
          Lister.checkListsAreIdentical(list1: agenda1.designers     ,list2: agenda2.designers     ) == true &&
          Lister.checkListsAreIdentical(list1: agenda1.contractors   ,list2: agenda2.contractors   ) == true &&
          Lister.checkListsAreIdentical(list1: agenda1.artisans      ,list2: agenda2.artisans      ) == true &&
          Lister.checkListsAreIdentical(list1: agenda1.manufacturers ,list2: agenda2.manufacturers ) == true &&
          Lister.checkListsAreIdentical(list1: agenda1.suppliers     ,list2: agenda2.suppliers     ) == true
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() =>
      'AgendaModel(\n'
          '   all          : \n       $all          \n'
          '   developers   : \n       $developers   \n'
          '   brokers      : \n       $brokers      \n'
          '   designers    : \n       $designers    \n'
          '   contractors  : \n       $contractors  \n'
          '   artisans     : \n       $artisans     \n'
          '   manufacturers: \n       $manufacturers\n'
          '   suppliers    : \n       $suppliers    \n'
          ')';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is AgendaModel){
      _areIdentical = checkAgendasAreIdentical(
        agenda1: this,
        agenda2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      all          .hashCode^
      developers   .hashCode^
      brokers      .hashCode^
      designers    .hashCode^
      contractors  .hashCode^
      artisans     .hashCode^
      manufacturers.hashCode^
      suppliers    .hashCode;
  // -----------------------------------------------------------------------------
}
