// import 'package:bldrs/models/enums/enum_bond_state.dart';
// import 'package:flutter/foundation.dart';
//
// class BondModel {
//   final String bondID;
//   final String fromSlideID;
//   final String toSlideID;
//   final DateTime requestTime;
//   final DateTime responseTime;
//   final BondState bondState;
//
//   BondModel({
//     @required this.bondID,
//     @required this.fromSlideID,
//     @required this.toSlideID,
//     @required this.requestTime,
//     @required this.responseTime,
//     @required this.bondState,
//   });
// }
//

// -----------------------------------------------------------------------------

// class ReferenceModel{
//   final String refID;
//   final String slideID;
//   final String originID;
//
//   ReferenceModel({
//     @required this.refID,
//     @required this.slideID,
//     @required this.originID,
//   });
// }

// -----------------------------------------------------------------------------

// class OriginModel{
//   final String originID;
//   final FlyerType originType;
//   final String authorID;
//   final String originName;
//   final String originPic;
//   // final DateTime saveTime;
//
//   OriginModel({
//     @required this.originID,
//     @required this.originType,
//     @required this.authorID,
//     @required this.originName,
//     @required this.originPic,
//     // @required this.saveTime,
//   });
// }

// -----------------------------------------------------------------------------

// OriginModel getOriginByOriginID(String originID){
// OriginModel origin = xOrigins.singleWhere((or) => or.originID == originID, orElse: ()=> null);
// return origin;
// }
//
// List<String> getOriginsIDsBySlideID(String slideID){
// List<String> originsIDs = new List();
// List<ReferenceModel> references = getReferencesBySlideID(slideID);
// references?.forEach((ref) {originsIDs.add(ref.originID);});
// return originsIDs; // should never be null only []
// }
//
// List<OriginModel> getOriginsBySlideID(String slideID){
// List<OriginModel> origins = new List();
// List<String> originsIDs = getOriginsIDsBySlideID(slideID);
// for(String x in originsIDs){
// xOrigins.forEach((or) {
// if (or.originID == x){origins.add(or);}
// });
// }
// return origins.isEmpty? null : origins;
// }
//
// List<ReferenceModel> getReferencesBySlideID(String slideID){
// List<ReferenceModel> references = new List();
// xRefs.forEach((ref) {
// if(ref.slideID == slideID){references.add(ref);}
// });
// return references.isEmpty ? null : references ;
// }

// List<BondModel> getBondsBySlideId(String slideID){
// List<BondModel> bonds = new List();
// xBonds.forEach((bo) {
// if (bo.fromSlideID == slideID || bo.toSlideID == slideID){bonds.add(bo);}
// });
// return bonds.isEmpty ? null : bonds;
// }


// -----------------------------------------------------------------------------

// enum BondState {
//   Accepted,
//   Declined,
//   Seen,
//   Unseen,
// }
// // x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
// List<BondState> bondStatesList = [
//   BondState.Accepted,
//   BondState.Declined,
//   BondState.Seen,
//   BondState.Unseen,
// ];
// // x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
// BondState decipherBondState (int x){
//   switch (x){
//     case 1:   return   BondState.Accepted;    break;
//     case 2:   return   BondState.Declined;    break;
//     case 3:   return   BondState.Seen;        break;
//     case 4:   return   BondState.Unseen;      break;
//     default : return   null;
//   }
// }
// // x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
// int cipherBondState (BondState x){
//   switch (x){
//     case BondState.Accepted:    return 1; break;
//     case BondState.Declined:    return 2; break;
//     case BondState.Seen:        return 3; break ;
//     case BondState.Unseen:      return 4; break ;
//     default : return null;
//   }
// }
// // x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x

// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------


