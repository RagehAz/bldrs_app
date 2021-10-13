
// -----------------------------------------------------------------------------
// /// TinyBz
// /// is a small version of BzModel to :-
// /// - (Main Objective) be saved inside FlyerModel to avoid 2 firebase reads if was saved as bzID
// /// - (Trivial Objective) to pass only necessary data
// class TinyBz with ChangeNotifier{
//   final String bzID;
//   final dynamic bzLogo;
//   final String bzName;
//   final BzType bzType;
//   final Zone bzZone;
//   final int bzTotalFollowers;
//   final int bzTotalFlyers;
//
//   TinyBz({
//     @required this.bzID,
//     @required this.bzLogo,
//     @required this.bzName,
//     @required this.bzType,
//     @required this.bzZone,
//     @required this.bzTotalFollowers,
//     @required this.bzTotalFlyers,
//   });
// // -----------------------------------------------------------------------------
//   Map<String,dynamic> toMap(){
//     return {
//       'bzID' : bzID,
//       'bzLogo' : bzLogo,
//       'bzName' : bzName,
//       'bzType' : BzModel.cipherBzType(bzType),
//       'bzZone' : bzZone.toMap(),
//       'bzTotalFollowers' : bzTotalFollowers,
//       'bzTotalFlyers' : bzTotalFlyers,
//     };
//   }
//
//   TinyBz clone(){
//     return TinyBz(
//         bzID: bzID,
//         bzLogo: bzLogo,
//         bzName: bzName,
//         bzType: bzType,
//         bzZone: bzZone.clone(),
//         bzTotalFollowers: bzTotalFollowers,
//         bzTotalFlyers: bzTotalFlyers,
//     );
//   }
// // -----------------------------------------------------------------------------
//   static bool tinyBzzAreTheSame(TinyBz finalBz, TinyBz originalBz){
//     bool _tinyBzzAreTheSame = true;
//
//     if (finalBz.bzLogo != originalBz.bzLogo) {_tinyBzzAreTheSame = false;}
//     else if (finalBz.bzName != originalBz.bzName) {_tinyBzzAreTheSame = false;}
//     else if (finalBz.bzType != originalBz.bzType) {_tinyBzzAreTheSame = false;}
//     else if (Zone.zonesAreTheSame(finalBz.bzZone, originalBz.bzZone)) {_tinyBzzAreTheSame = false;}
//     else if (finalBz.bzTotalFollowers != originalBz.bzTotalFollowers) {_tinyBzzAreTheSame = false;}
//     else if (finalBz.bzTotalFlyers != originalBz.bzTotalFlyers) {_tinyBzzAreTheSame = false;}
//     else {_tinyBzzAreTheSame = true;}
//
//     return _tinyBzzAreTheSame;
//   }
// // -----------------------------------------------------------------------------
//   static TinyBz getTinyBzFromBzModel(BzModel bzModel){
//     return
//       TinyBz(
//         bzID: bzModel.bzID,
//         bzLogo: bzModel.bzLogo,
//         bzName: bzModel.bzName,
//         bzType: bzModel.bzType,
//         bzZone: bzModel.bzZone,
//         bzTotalFollowers: bzModel.bzTotalFollowers,
//         bzTotalFlyers: bzModel.flyersIDs.length,
//       );
//   }
// // -----------------------------------------------------------------------------
//   static List<dynamic> cipherTinyBzzModels(List<TinyBz> tinyBzz){
//     final List<dynamic> _tinyBzzMaps = <dynamic>[];
//     tinyBzz.forEach((b) {
//       _tinyBzzMaps.add(b.toMap());
//     });
//     return _tinyBzzMaps;
//   }
// // -----------------------------------------------------------------------------
//   static TinyBz decipherTinyBzMap(dynamic map){
//     TinyBz _tinyBz;
//
//     if(map != null){
//       _tinyBz = TinyBz(
//         bzID: map['bzID'],
//         bzLogo: map['bzLogo'],
//         bzName: map['bzName'],
//         bzType: BzModel.decipherBzType(map['bzType']),
//         bzZone: Zone.decipherZoneMap(map['bzZone']),
//         bzTotalFollowers: map['bzTotalFollowers'],
//         bzTotalFlyers: map['bzTotalFlyers'],
//       );
//     }
//     return _tinyBz;
//   }
// // -----------------------------------------------------------------------------
//   static List<TinyBz> decipherTinyBzzMaps(List<dynamic> maps){
//     final List<TinyBz> _tinyBzz = <TinyBz>[];
//     maps.forEach((map){
//       _tinyBzz.add(decipherTinyBzMap(map));
//     });
//     return _tinyBzz;
//   }
// // -----------------------------------------------------------------------------
//   static List<String> getBzzIDsFromTinyBzz(List<TinyBz> _tinyBzz){
//     final List<String> _ids = <String>[];
//
//     if (_tinyBzz != null){
//       _tinyBzz.forEach((tinyBz) {
//         _ids.add(tinyBz.bzID);
//       });
//     }
//
//     return _ids;
//   }
// // -----------------------------------------------------------------------------
//   static List<TinyBz> getTinyBzzFromBzzModels(List<BzModel> bzzModels){
//     final List<TinyBz> _tinyBzz = <TinyBz>[];
//
//     bzzModels.forEach((bz) {
//       _tinyBzz.add(getTinyBzFromBzModel(bz));
//     });
//
//     return _tinyBzz;
//   }
// // -----------------------------------------------------------------------------
//   static TinyBz dummyTinyBz(String bzID){
//
//     final String _bzID = bzID ?? 'ytLfMwdqK565ByP1p56G';
//
//     return
//         TinyBz(
//             bzID: _bzID,
//             bzLogo: Iconz.DumBusinessLogo, //'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bzLogos%2Far1.jpg?alt=media&token=f68673f8-409a-426a-9a80-f1026715c469'
//             bzName: 'Business Name',
//             bzType: BzType.designer,
//             bzZone: Zone(countryID: 'egy', cityID: 'cairo', districtID: 'heliopolis'),
//             bzTotalFollowers: 1000,
//             bzTotalFlyers: 10,
//         );
//   }
// // -----------------------------------------------------------------------------
//   static List<TinyBz> dummyTinyBzz(){
//     return
//         <TinyBz>[
//           dummyTinyBz('bz1'),
//           dummyTinyBz('bz2'),
//           dummyTinyBz('bz3'),
//         ];
//   }
// // -----------------------------------------------------------------------------
//   static TinyBz getTinyBzFromSuperFlyer(SuperFlyer superFlyer){
//     return
//         TinyBz(
//             bzID: superFlyer.bz.bzID,
//             bzLogo:  superFlyer.bz.bzLogo,
//             bzName: superFlyer.bz.bzName,
//             bzType: superFlyer.bz.bzType,
//             bzZone:  superFlyer.bz.bzZone,
//             bzTotalFollowers: superFlyer.bz.bzTotalFollowers,
//             bzTotalFlyers: superFlyer.bz.bzTotalFlyers,
//         );
//   }
// // -----------------------------------------------------------------------------
//   static TinyBz getTinyBzModelFromSnapshot(DocumentSnapshot doc){
//     final Object _map = doc.data();
//     final TinyBz _tinyBz = TinyBz.decipherTinyBzMap(_map);
//     return _tinyBz;
//   }
// // -----------------------------------------------------------------------------
//   static bool tinyBzzContainThisTinyBz({List<TinyBz> tinyBzz, TinyBz tinyBz}){
//     bool _contains = false;
//
//     final bool _canLoop = tinyBzz != null && tinyBzz.length > 0 && tinyBz != null;
//
//     if (_canLoop == true){
//
//       for (TinyBz bz in tinyBzz){
//
//         if (bz.bzID == tinyBz.bzID){
//           _contains = true;
//           break;
//         }
//
//       }
//
//     }
//
//     return _contains;
//   }
// // -----------------------------------------------------------------------------
// }

class OLDTinyBzMethods {
// // -----------------------------------------------------------------------------
//   static Future<TinyBz> readTinyBzOps({BuildContext context, String bzID}) async {
//
//     final Map<String, dynamic> _tinyBzMap = await Fire.readDoc(
//       context: context,
//       collName: FireCollection.tinyBzz,
//       docName: bzID,
//     );
//
//     final TinyBz _tinyBz = TinyBz.decipherTinyBzMap(_tinyBzMap);
//
//     return _tinyBz;
//   }
// // -----------------------------------------------------------------------------
//   /// get bz doc stream
//   Stream<TinyBz> getTinyBzStream(String bzID) {
//     final Stream<DocumentSnapshot> _bzSnapshot = Fire.streamDoc(FireCollection.tinyBzz, bzID);
//     final Stream<TinyBz> _tinyBzStream = _bzSnapshot.map(TinyBz.getTinyBzModelFromSnapshot);
//     return _tinyBzStream;
// // -----------------------------------------------------------------------------
//   Widget tinyBzModelBuilder({
//     String bzID,
//     BuildContext context,
//     tinyBzModelWidgetBuilder builder,
//   }){
//
//     return FutureBuilder(
//         future: Fire.readDoc(
//           context: context,
//           collName: FireCollection.tinyBzz,
//           docName: bzID,
//         ),
//         builder: (ctx, snapshot){
//
//           if (snapshot.connectionState == ConnectionState.waiting){
//             return Loading(loading: true,);
//           } else {
//             if (snapshot.error != null){
//               return Container(); // superDialog(context, snapshot.error, 'error');
//             } else {
//
//               final Map<String, dynamic> _map = snapshot.data;
//               final TinyBz tinyBz = TinyBz.decipherTinyBzMap(_map);
//
//               return builder(context, tinyBz);
//             }
//           }
//         }
//     );
//   }
// // -----------------------------------------------------------------------------
//   typedef tinyBzModelWidgetBuilder = Widget Function(
//       BuildContext context,
//       TinyBz tinyBz,
//       );
// // ----------------------
//   /// IMPLEMENTATION
//   /// bzModelBuilder(
//   ///         bzID: bzID,
//   ///         context: context,
//   ///         builder: (context, BzModel bzModel){
//   ///           return WidgetThatUsesTheAboveBzModel;
//   ///         }
//   ///      ) xxxxxxxxxxxxx ; or , xxxxxxxxxxxxx
//   Widget tinyBzModelStreamBuilder({
//     String bzID,
//     BuildContext context,
//     tinyBzModelWidgetBuilder builder,
//     bool listen,
//   }){
//
//     // bool _listen = listen == null ? true : listen;
//
//     return
//
//       StreamBuilder<TinyBz>(
//         stream: getTinyBzStream(bzID),
//         builder: (context, snapshot){
//           if(StreamChecker.connectionIsLoading(snapshot) == true){
//             return Loading(loading: true,);
//           } else {
//             final TinyBz tinyBz = snapshot.data;
//             return
//               builder(context, tinyBz);
//           }
//         },
//       );
//
//   }
// // -----------------------------------------------------------------------------
  // update bz ops
  //     /// only if TinyBz changed :-
  //     if(
  //     // bzID and BzLogo URL will always stay the same after creation
  //     _finalBz.bzName != originalBz.bzName ||
  //         _finalBz.bzLogo != originalBz.bzLogo ||
  //         _finalBz.bzType != originalBz.bzType ||
  //         _finalBz.bzZone.countryID != originalBz.bzZone.countryID ||
  //         _finalBz.bzZone.cityID != originalBz.bzZone.cityID ||
  //         _finalBz.bzZone.districtID != originalBz.bzZone.districtID
  //     ){
  //
  //       final TinyBz _modifiedTinyBz = TinyBz.getTinyBzFromBzModel(_finalBz)  ;
  //       final Map<String, dynamic> _modifiedTinyBzMap = _modifiedTinyBz.toMap();
  //
  //     /// update tinyBz document
  //     await Fire.updateDoc(
  //       context: context,
  //       collName: FireCollection.tinyBzz,
  //       docName: _finalBz.bzID,
  //       input: _modifiedTinyBzMap,
  //     );
  //
  //     /// update tinyBz in all flyers
  //     /// TASK : this may require firestore batch write
  //       final List<String> _bzFlyersIDs = _finalBz.flyersIDs;
  //       if(_bzFlyersIDs.length > 0){
  //         for (var id in _bzFlyersIDs){
  //           await Fire.updateDocField(
  //             context: context,
  //             collName: FireCollection.flyers,
  //             docName: id,
  //             field: 'tinyBz',
  //             input: _modifiedTinyBzMap,
  //           );
  //         }
  //       }
  //
  //     /// update tinyBz in all Tinyflyers
  //     /// TASK : this may require firestore batch write
  //     if(_bzFlyersIDs.length > 0){
  //       for (var id in _bzFlyersIDs){
  //         await Fire.updateDocField(
  //           context: context,
  //           collName: FireCollection.tinyFlyers,
  //           docName: id,
  //           field: 'tinyBz',
  //           input: _modifiedTinyBzMap,
  //         );
  //       }
  //     }
  //
  //     }
  // // -----------------------------------------------------------------------------
//   static Future<List<TinyBz>> readTinyBzz({BuildContext context, List<String> bzzIDs}) async {
//     final List<TinyBz> _tinyBzz = <TinyBz>[];
//
//     if (bzzIDs != null && bzzIDs.isNotEmpty){
//
//       for (var id in bzzIDs){
//         final TinyBz _tinyBz = await BzOps.readTinyBzOps(context: context, bzID: id);
//         _tinyBzz.add(_tinyBz);
//       }
//
//     }
//
//     return _tinyBzz;
//   }
// // -----------------------------------------------------------------------------
//   static BzModel getTempBzModelFromTinyBz(TinyBz tinyBz){
//     BzModel _bz;
//     if (tinyBz != null){
//       _bz = BzModel(
//         bzID : tinyBz.bzID,
//         // -------------------------
//         bzType : tinyBz.bzType,
//         bzForm : null,
//         createdAt : null,
//         accountType : null,
//         // -------------------------
//         bzName :tinyBz.bzName,
//         bzLogo : tinyBz.bzLogo,
//         bzScope : null,
//         bzZone : tinyBz.bzZone,
//         bzAbout : null,
//         bzPosition : null,
//         bzContacts : null,
//         bzAuthors : null,
//         bzShowsTeam : null,
//         // -------------------------
//         bzIsVerified : null,
//         bzAccountIsDeactivated : null,
//         bzAccountIsBanned : null,
//         // -------------------------
//         bzTotalFollowers : tinyBz.bzTotalFollowers,
//         bzTotalSaves : null,
//         bzTotalShares : null,
//         bzTotalSlides : null,
//         bzTotalViews : null,
//         bzTotalCalls : null,
//         // -------------------------
//         flyersIDs: <String>[],
//         bzTotalFlyers: null,
//         authorsIDs: <String>[],
//       );
//     }
//     return _bz;
//   }
}