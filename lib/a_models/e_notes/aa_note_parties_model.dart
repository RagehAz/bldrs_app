import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:flutter/material.dart';

enum PartyType {
  bldrs,
  user,
  bz,
  country,
}
/// => TAMAM
@immutable
class NoteParties {
  /// --------------------------------------------------------------------------
  const NoteParties({
    required this.senderID,
    required this.senderImageURL,
    required this.senderType,
    required this.receiverID,
    required this.receiverType,
  });
  /// --------------------------------------------------------------------------
  final String? senderID;
  final String? senderImageURL;
  final PartyType? senderType;
  final String? receiverID;
  final PartyType? receiverType;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  NoteParties copyWith({
    String? senderID,
    String? senderImageURL,
    PartyType? senderType,
    String? receiverID,
    PartyType? receiverType,
  }){
    return NoteParties(
      senderID: senderID ?? this.senderID,
      senderImageURL: senderImageURL ?? this.senderImageURL,
      senderType: senderType ?? this.senderType,
      receiverID: receiverID ?? this.receiverID,
      receiverType: receiverType ?? this.receiverType,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  NoteParties nullifyField({
    bool senderID = false,
    bool senderImageURL = false,
    bool senderType = false,
    bool receiverID = false,
    bool receiverType = false,
  }){
    return NoteParties(
      senderID: senderID == true ? null : this.senderID,
      senderImageURL: senderImageURL == true ? null : this.senderImageURL,
      senderType: senderType == true ? null : this.senderType,
      receiverID: receiverID == true ? null : this.receiverID,
      receiverType: receiverType == true ? null : this.receiverType,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'senderID': senderID,
      'senderImageURL': senderImageURL,
      'senderType': cipherPartyType(senderType),
      'receiverID': receiverID,
      'receiverType' : cipherPartyType(receiverType),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteParties? decipherParties(Map<String, dynamic>? map){
    NoteParties? _parties;

    if (map != null){
      _parties = NoteParties(
        senderID: map['senderID'],
        senderImageURL: map['senderImageURL'],
        senderType: decipherPartyType(map['senderType']),
        receiverID: map['receiverID'],
        receiverType: decipherPartyType(map['receiverType']),
      );
    }

    return _parties;
  }
  // -----------------------------------------------------------------------------

  /// NOTE SENDER - RECEIVER TYPE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherPartyType(PartyType? type){
    switch (type) {
      case PartyType.bz:           return 'bz';      /// data type : String bzID
    // case NoteSenderOrRecieverType.author:       return 'author';  break; /// data type : String authorID
      case PartyType.user:         return 'user';    /// data type : String userID
      case PartyType.country:      return 'country'; /// data type : String countryID
      case PartyType.bldrs:        return 'bldrs';   /// data type : String graphicID
      default:return 'non';
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PartyType? decipherPartyType(String? type){
    switch (type) {
      case 'bldrs':   return PartyType.bldrs;
      case 'user':    return PartyType.user;
    // case 'author':  return NoteSenderOrRecieverType.author;   break;
      case 'bz':      return PartyType.bz;
      case 'country': return PartyType.country;
      default:        return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static const List<PartyType> noteSenderTypesList = <PartyType>[
    PartyType.bz,
    // NoteSenderOrRecieverType.author,
    PartyType.user,
    PartyType.country,
    PartyType.bldrs,
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static const List<PartyType> noteReceiverTypesList = <PartyType>[
    PartyType.bz,
    PartyType.user,
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getPartyIcon(PartyType? type){
    switch(type){
      case PartyType.user:        return Iconz.normalUser;
      case PartyType.bz:          return Iconz.bz;
      case PartyType.country:     return Iconz.flag;
      case PartyType.bldrs:       return Iconz.bldrsNameSquare;
      default:                        return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getReceiversIDs({
    required List<dynamic>? receiversModels,
    required PartyType? partyType,
  }){
    List<String> _ids = [];

    if (Lister.checkCanLoopList(receiversModels) == true){

      if (partyType == PartyType.bz){
        final List<BzModel> _bzz = [...?receiversModels];
        _ids = BzModel.getBzzIDs(_bzz);
      }

      else if (partyType == PartyType.user){
        final List<UserModel> users = [...?receiversModels];
        _ids = UserModel.getUsersIDs(users);
      }

    }

    return _ids;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getReceiversPics({
    required List<dynamic>? receiversModels,
    required PartyType? partyType,
  }){
    List<String> _pics = [];

    if (Lister.checkCanLoopList(receiversModels) == true){

      if (partyType == PartyType.bz){
        _pics = BzModel.getBzzLogos(receiversModels as List<BzModel>);
      }

      else if (partyType == PartyType.user){
        _pics = UserModel.getUsersPics(receiversModels as List<UserModel>);
      }

    }

    return _pics;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getReceiversTypePhid({
    required List<dynamic>? receiversModels,
    required PartyType? partyType,
    bool plural = true,
  }){
    String _phid = '';

    if (Lister.checkCanLoopList(receiversModels) == true){

      if (partyType == PartyType.bz){
        _phid = plural == true ? 'phid_bzz' : 'phid_bz';
      }

      else if (partyType == PartyType.user){
        _phid = plural == true ? 'phid_users' : 'phid_user';
      }

    }

    return _phid;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<dynamic>> fetchReceiversModels({
    required List<String> ids,
    required PartyType? partyType,
  }) async {
    List<dynamic> _output = [];

    if (Lister.checkCanLoopList(ids) == true){

      if (partyType == PartyType.bz){
        _output = await BzProtocols.fetchBzz(bzzIDs: ids,);
      }

      else if (partyType == PartyType.user){
        _output = await UserProtocols.fetchUsers(usersIDs: ids,);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPartiesAreIdentical({
    required NoteParties? parties1,
    required NoteParties? parties2,
  }){
    bool _areIdentical = false;

    if (parties1 == null && parties2 == null){
      _areIdentical = true;
    }

    else if (parties1 != null && parties2 != null){

      if (
          parties1.senderID == parties2.senderID &&
          parties1.senderImageURL == parties2.senderImageURL &&
          parties1.senderType == parties2.senderType &&
          parties1.receiverID == parties2.receiverID &&
          parties1.receiverType == parties2.receiverType
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // --------------------
  /*
  static bool checkReceiversAreIdentical({
    required List<dynamic>? receivers1,
    required List<dynamic>? receivers2,
  }){
    bool _areIdentical = false;

    if (Lister.checkCanLoopList(receivers1) == true && Lister.checkCanLoopList(receivers2) == true){

      if (receivers1!.length == receivers2!.length){

        final List<dynamic> _receivers1 = _sortReceiversByIDs(receivers: receivers1);
        final List<dynamic> _receivers2 = _sortReceiversByIDs(receivers: receivers2);

        for (int i = 0; i < _receivers1.length; i++){

          if (_receivers1[i] == _receivers2[i]){
            _areIdentical = true;
          }

          else {
            _areIdentical = false;
            break;
          }

        }

      }

    }

    return _areIdentical;
  }
  // --------------------
  static List<dynamic> _sortReceiversByIDs({
    required List<dynamic>? receivers,
  }){
    List<dynamic> _output = [];

    blog('receivers : $receivers');

    if (Lister.checkCanLoopList(receivers) == true){

      List<Map<String, dynamic>> _maps = [];
      final bool _isUserModel = receivers![0] is UserModel;
      final bool _isBzModel = receivers[0] is BzModel;

      blog('_isUserModel : $_isUserModel : _isBzModel : $_isBzModel');

      if (_isUserModel == true){
        _maps = UserModel.cipherUsers(
            users: receivers as List<UserModel>,
            toJSON: true,
        );
      }
      else if (_isBzModel == true){
        _maps = BzModel.cipherBzz(
            bzz: receivers as List<BzModel>,
            toJSON: true
        );
      }

      _maps.sort((Map<String, dynamic> a, Map<String, dynamic> b){
        final String _idA = a['id'] ?? '';
        final String _isB = b['id'] ?? '';
        return _idA.compareTo(_isB);
      });

      if (_isUserModel == true){
        _output = UserModel.decipherUsers(maps: _maps, fromJSON: true);
      }
      else if (_isBzModel == true){
        _output = BzModel.decipherBzz(maps: _maps, fromJSON: true);
      }

    }

    return _output;
  }
   */
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogParties(){
    blog('senderID : $senderID');
    blog('senderImageURL : $senderImageURL');
    blog('senderType : $senderType');
    blog('receiverID : $receiverID');
    blog('receiverType : $receiverType');
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
    if (other is NoteParties){
      _areIdentical = checkPartiesAreIdentical(
        parties1: this,
        parties2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      senderID.hashCode^
      senderImageURL.hashCode^
      senderType.hashCode^
      receiverID.hashCode^
      receiverType.hashCode;
  // -----------------------------------------------------------------------------
}
