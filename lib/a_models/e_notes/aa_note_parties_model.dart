import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:mapper/mapper.dart';
import 'package:filers/filers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
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
    @required this.senderID,
    @required this.senderImageURL,
    @required this.senderType,
    @required this.receiverID,
    @required this.receiverType,
  });
  /// --------------------------------------------------------------------------
  final String senderID;
  final String senderImageURL;
  final PartyType senderType;
  final String receiverID;
  final PartyType receiverType;
  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  /// URL will be reassigned in NoteFireOps.create if note.sender == bldrsSenderID
  // i bet the below link will be expired soon : today is 2 Oct 2022 => validate my claim when u see this again please
  static const String bldrsLogoStaticURL = 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/admin%2Fbldrs_notification_icon?alt=media&token=d4f781f3-ea1b-4974-b6e3-990da03c980b';
  // --------------------
  static const String bldrsSenderID = 'Bldrs.net';
  static const String bldrsFCMIconFireStorageFileName = 'bldrs_notification_icon';
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  NoteParties copyWith({
    String senderID,
    String senderImageURL,
    PartyType senderType,
    String receiverID,
    PartyType receiverType,
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
  static NoteParties decipherParties(Map<String, dynamic> map){
    NoteParties _parties;

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
  static String cipherPartyType(PartyType type){
    switch (type) {
      case PartyType.bz:           return 'bz';      break; /// data type : String bzID
    // case NoteSenderOrRecieverType.author:       return 'author';  break; /// data type : String authorID
      case PartyType.user:         return 'user';    break; /// data type : String userID
      case PartyType.country:      return 'country'; break; /// data type : String countryID
      case PartyType.bldrs:        return 'bldrs';   break; /// data type : String graphicID
      default:return 'non';
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PartyType decipherPartyType(String type){
    switch (type) {
      case 'bldrs':   return PartyType.bldrs;    break;
      case 'user':    return PartyType.user;     break;
    // case 'author':  return NoteSenderOrRecieverType.author;   break;
      case 'bz':      return PartyType.bz;       break;
      case 'country': return PartyType.country;  break;
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
  static String getPartyIcon(PartyType type){
    switch(type){
      case PartyType.user:        return Iconz.normalUser;      break;
      case PartyType.bz:          return Iconz.bz;              break;
      case PartyType.country:     return Iconz.flag;            break;
      case PartyType.bldrs:       return Iconz.bldrsNameSquare; break;
      default:                        return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getReceiversIDs({
    @required List<dynamic> receiversModels,
    @required PartyType partyType,
  }){
    List<String> _ids = [];

    if (Mapper.checkCanLoopList(receiversModels) == true){

      if (partyType == PartyType.bz){
        _ids = BzModel.getBzzIDs(receiversModels);
      }

      else if (partyType == PartyType.user){
        _ids = UserModel.getUsersIDs(receiversModels);
      }

    }

    return _ids;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getReceiversPics({
    @required List<dynamic> receiversModels,
    @required PartyType partyType,
  }){
    List<String> _pics = [];

    if (Mapper.checkCanLoopList(receiversModels) == true){

      if (partyType == PartyType.bz){
        _pics = BzModel.getBzzLogos(receiversModels);
      }

      else if (partyType == PartyType.user){
        _pics = UserModel.getUsersPics(receiversModels);
      }

    }

    return _pics;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getReceiversTypePhid({
    @required List<dynamic> receiversModels,
    @required PartyType partyType,
    bool plural = true,
  }){
    String _phid = '';

    if (Mapper.checkCanLoopList(receiversModels) == true){

      if (partyType == PartyType.bz){
        _phid = plural == true ? 'phid_bzz' : 'phid_bz';
      }

      else if (partyType == PartyType.user){
        _phid = plural == true ? 'phid_users' : 'phid_user';
      }

    }

    return _phid;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPartiesAreIdentical({
    @required NoteParties parties1,
    @required NoteParties parties2,
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
