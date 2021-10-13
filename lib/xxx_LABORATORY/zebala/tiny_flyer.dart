

// -----------------------------------------------------------------------------
// class TinyFlyer with ChangeNotifier{
//   final String flyerID;
//   final FlyerType flyerType;
//   final TinyBz tinyBz;
//   final String authorID;
//   final int slideIndex;
//   final String slidePic;
//   final Zone flyerZone;
//   final BoxFit picFit;
//   final Color midColor;
//   final List<String> keywordsIDs;
//   final ImageSize imageSize;
//   final String headline;
//   final bool priceTagIsOn;
//
//   TinyFlyer({
//     @required this.flyerID,
//     @required this.flyerType,
//     this.tinyBz,
//     @required this.authorID,
//     @required this.slideIndex,
//     @required this.slidePic,
//     @required this.flyerZone,
//     @required this.midColor,
//     @required this.keywordsIDs, /// TASK : integrate keywords in tiny flyers
//     @required this.picFit, /// TASK : integrate this in all below methods
//     @required this.imageSize,
//     @required this.headline,
//     @required this.priceTagIsOn,
//   });
// // -----------------------------------------------------------------------------
//   Map<String,dynamic> toMap (){
//     return {
//       'flyerID' : flyerID,
//       'flyerType' : FlyerTypeClass.cipherFlyerType(flyerType),
//       'tinyBz' : tinyBz.toMap(),
//       'authorID' : authorID,
//       'slideIndex' : slideIndex,
//       'slidePic' : slidePic,
//       'flyerZone' : flyerZone.toMap(),
//       'midColor' : Colorizer.cipherColor(midColor),
//       'keywordsIDs' : keywordsIDs,
//       'picFit' : ImageSize.cipherBoxFit(picFit),
//       'imageSize' : imageSize.toMap(),
//       'headline' : headline,
//       'priceTagIsOn' : priceTagIsOn,
//     };
//   }
// // -----------------------------------------------------------------------------
//   static bool tinyFlyersAreTheSame(FlyerModel finalFlyer, FlyerModel originalFlyer){
//     bool tinyFlyersAreTheSame = true;
//
//     if (finalFlyer.flyerType != originalFlyer.flyerType) {tinyFlyersAreTheSame = false;}
//     else if (TinyBz.tinyBzzAreTheSame(finalFlyer.tinyBz, originalFlyer.tinyBz) == false) {tinyFlyersAreTheSame = false;}
//     else if(Mapper.listsAreTheSame(list1: finalFlyer.keywordsIDs, list2: originalFlyer.keywordsIDs) == false) {tinyFlyersAreTheSame = false;}
//
//     else if (finalFlyer.slides[0].pic != originalFlyer.slides[0].pic) {tinyFlyersAreTheSame = false;}
//     else if (finalFlyer.slides[0].picFit != originalFlyer.slides[0].picFit) {tinyFlyersAreTheSame = false;}
//     else if (Colorizer.colorsAreTheSame(finalFlyer.slides[0].midColor, originalFlyer.slides[0].midColor) == false) {tinyFlyersAreTheSame = false;}
//     else if (finalFlyer.slides[0].headline != originalFlyer.slides[0].headline) {tinyFlyersAreTheSame = false;}
//
//     else if (finalFlyer.slides[0].imageSize.width != originalFlyer.slides[0].imageSize.width) {tinyFlyersAreTheSame = false;}
//     else if (finalFlyer.slides[0].imageSize.height != originalFlyer.slides[0].imageSize.height) {tinyFlyersAreTheSame = false;}
//
//     else if (finalFlyer.flyerZone.countryID != originalFlyer.flyerZone.countryID) {tinyFlyersAreTheSame = false;}
//     else if (finalFlyer.flyerZone.cityID != originalFlyer.flyerZone.cityID) {tinyFlyersAreTheSame = false;}
//     else if (finalFlyer.flyerZone.districtID != originalFlyer.flyerZone.districtID) {tinyFlyersAreTheSame = false;}
//
//     else if (finalFlyer.priceTagIsOn != originalFlyer.priceTagIsOn) {tinyFlyersAreTheSame = false;}
//
//     else {tinyFlyersAreTheSame = true;}
//
//     return tinyFlyersAreTheSame;
//   }
// // -----------------------------------------------------------------------------
//   static List<TinyFlyer> decipherTinyFlyersMaps(List<dynamic> tinyFlyersMaps){
//     final List<TinyFlyer> _tinyFlyers = <TinyFlyer>[];
//
//     tinyFlyersMaps.forEach((map) {
//       _tinyFlyers.add(decipherTinyFlyerMap(map));
//     });
//
//     return _tinyFlyers;
//   }
// // -----------------------------------------------------------------------------
//   static TinyFlyer decipherTinyFlyerMap(dynamic map){
//     return TinyFlyer(
//       flyerID: map['flyerID'],
//       flyerType: FlyerTypeClass.decipherFlyerType(map['flyerType']),
//       tinyBz: TinyBz.decipherTinyBzMap(map['tinyBz']),
//       authorID: map['authorID'],
//       slideIndex: map['slideIndex'],
//       slidePic: map['slidePic'],
//       flyerZone: Zone.decipherZoneMap(map['flyerZone']),
//       midColor: Colorizer.decipherColor(map['midColor']),
//       keywordsIDs: Mapper.getStringsFromDynamics(dynamics: map['keywordsIDs']),
//       picFit: ImageSize.decipherBoxFit(map['picFit']),
//       imageSize: ImageSize.decipherImageSize(map['imageSize']),
//       headline: map['headline'],
//       priceTagIsOn: map['priceTagIsOn'],
//       // keywords: Keyword.de
//     );
//   }
// // -----------------------------------------------------------------------------
//   static TinyFlyer getTinyFlyerFromFlyerModel(FlyerModel flyerModel){
//     TinyFlyer _tinyFlyer;
//
//     if(flyerModel != null){
//       if(flyerModel.slides != null){
//         if(flyerModel.slides.length != 0){
//           _tinyFlyer = TinyFlyer(
//             flyerID: flyerModel?.flyerID,
//             flyerType: flyerModel?.flyerType,
//             authorID: flyerModel?.tinyAuthor?.userID,
//             slideIndex: 0,
//             slidePic: flyerModel?.slides[0]?.pic,
//             midColor: flyerModel?.slides[0]?.midColor,
//             picFit: flyerModel?.slides[0]?.picFit,
//             tinyBz: flyerModel?.tinyBz,
//             flyerZone: flyerModel?.flyerZone,
//             keywordsIDs: flyerModel?.keywordsIDs,
//             imageSize: flyerModel?.slides[0]?.imageSize,
//             headline: flyerModel?.slides[0]?.headline,
//             priceTagIsOn: flyerModel?.priceTagIsOn,
//           );
//         }
//       }
//     }
//
//     return _tinyFlyer;
//   }
// // -----------------------------------------------------------------------------
//   static List<dynamic> cipherTinyFlyers (List<TinyFlyer> tinyFlyers){
//     final List<dynamic> _tinyFlyersMaps = <dynamic>[];
//
//     tinyFlyers.forEach((f) {
//       _tinyFlyersMaps.add(f.toMap());
//     });
//
//     return _tinyFlyersMaps;
//   }
// // -----------------------------------------------------------------------------
// //   static List<TinyFlyer> getTinyFlyersFromBzModel(BzModel bzModel){
// //     final List<TinyFlyer> _tinyFlyers = <TinyFlyer>[];
// //
// //     final List<NanoFlyer> _nanoFlyers = bzModel.nanoFlyers;
// //
// //     if (_nanoFlyers != null){
// //       for (var nano in _nanoFlyers){
// //
// //         final TinyFlyer _tinyFlyer = TinyFlyer.getTinyFlyerFromNanoFlyerAndBzModel(nano: nano, bzModel: bzModel);
// //
// //         _tinyFlyers.add(_tinyFlyer);
// //       }
// //
// //     }
// //
// //     return _tinyFlyers;
// //   }
// // -----------------------------------------------------------------------------
//   static List<TinyFlyer> getTinyFlyersFromFlyersModels(List<FlyerModel> flyers){
//     final List<TinyFlyer> _tinyFlyers = <TinyFlyer>[];
//
//     for (var flyer in flyers){
//       final TinyFlyer _tinyFlyer = getTinyFlyerFromFlyerModel(flyer);
//       _tinyFlyers.add(_tinyFlyer);
//     }
//
//     return _tinyFlyers;
//   }
// // -----------------------------------------------------------------------------
//   static List<String> getListOfFlyerIDsFromTinyFlyers(List<TinyFlyer> tinyFlyers){
//     final List<String> _flyerIDs = <String>[];
//
//     tinyFlyers?.forEach((flyer) {
//       _flyerIDs.add(flyer.flyerID);
//     });
//
//     return _flyerIDs;
//   }
// // -----------------------------------------------------------------------------
//   static TinyFlyer getTinyFlyerFromTinyFlyers({List<TinyFlyer> tinyFlyers, String flyerID}){
//     final TinyFlyer _tinyFlyer = tinyFlyers.singleWhere((tinyFlyer) => tinyFlyer.flyerID == flyerID, orElse: () => null);
//     return _tinyFlyer;
//   }
// // -----------------------------------------------------------------------------
//   static TinyFlyer dummyTinyFlyer(String id){
//     return TinyFlyer(
//       flyerID: id,
//       flyerType: FlyerType.rentalProperty,
//       authorID: 'dummyAuthor',
//       slideIndex: 0,
//       slidePic: 'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/slidesPics%2F0HHptUSLQI907nEYizpX_00.jpg?alt=media&token=976bae0a-04fe-44da-9f1a-3ee27522bc06',
//       flyerZone: Zone(countryID: 'egy', cityID: 'cairo', districtID: 'heliopolis'),
//       tinyBz: TinyBz.dummyTinyBz('bzID'),
//       picFit: BoxFit.cover,
//       midColor: Colorz.Black255,
//       keywordsIDs: [Keyword.bldrsKeywords()[50].keywordID],
//       imageSize: ImageSize(height: 630, width: 460),
//       headline: 'Headline',
//       priceTagIsOn: true,
//     );
//   }
// // -----------------------------------------------------------------------------
//   static List<TinyFlyer> dummyTinyFlyers(){
//     return
//         <TinyFlyer>[
//           TinyFlyer.dummyTinyFlyer('1'),
//           TinyFlyer.dummyTinyFlyer('2'),
//           TinyFlyer.dummyTinyFlyer('3'),
//           TinyFlyer.dummyTinyFlyer('4'),
//           TinyFlyer.dummyTinyFlyer('5'),
//         ];
//   }
// // -----------------------------------------------------------------------------
//   static TinyFlyer getTinyFlyerFromSuperFlyer(SuperFlyer superFlyer){
//     TinyFlyer _tinyFlyer = TinyFlyer(
//       flyerID: superFlyer.flyerID,
//       flyerType: superFlyer.flyerType,
//       authorID: superFlyer.authorID,
//       slideIndex: superFlyer.currentSlideIndex,
//       slidePic: superFlyer.mSlides[superFlyer.currentSlideIndex].picURL,
//       flyerZone: superFlyer.flyerZone,
//       tinyBz: TinyBz.getTinyBzFromSuperFlyer(superFlyer),
//       picFit: superFlyer.mSlides[superFlyer.currentSlideIndex].picFit,
//       keywordsIDs: Keyword.getKeywordsIDsFromKeywords(superFlyer.keywords,),
//       midColor: superFlyer.mSlides[superFlyer.currentSlideIndex].midColor,
//       imageSize: superFlyer.mSlides[superFlyer.currentSlideIndex].imageSize,
//       headline: superFlyer.mSlides[superFlyer.currentSlideIndex].headline,
//       priceTagIsOn: superFlyer.priceTagIsOn,
//     );
//
//     return _tinyFlyer;
//   }
// // -----------------------------------------------------------------------------
// //   static TinyFlyer getTinyFlyerFromNanoFlyerAndBzModel({NanoFlyer nano, BzModel bzModel}){
// //     TinyFlyer _tiny;
// //     if(nano != null){
// //       _tiny = TinyFlyer(
// //         flyerID: nano.flyerID,
// //         flyerType: nano.flyerType,
// //         authorID: nano.authorID,
// //         slideIndex: 0,
// //         slidePic: nano.slidePic,
// //         flyerZone: nano.flyerZone,
// //         midColor: nano.midColor,
// //         keywords: null, /// TASK : add keywords to tinyFlyers from nano flyers
// //         picFit: null, /// TASK : add picFit to tinyFlyers from nano flyers
// //         imageSize: null, /// TASK : add imageSize to tinyFlyers from nano flyers
// //         headline: 'fix nano headline',
// //         tinyBz: TinyBz.getTinyBzFromBzModel(bzModel),
// //         priceTagIsOn: true,
// //       );
// //     }
// //     return _tiny;
// //   }
// // -----------------------------------------------------------------------------
//   static List<TinyFlyer> filterTinyFlyersBySection({List<TinyFlyer> tinyFlyers, Section section}){
//     List<TinyFlyer> _filteredTinyFlyers = <TinyFlyer>[];
//
//     if (section == Section.All){
//       _filteredTinyFlyers = tinyFlyers;
//     }
//
//     else {
//
//       final FlyerType _flyerType = FlyerTypeClass.getFlyerTypeBySection(section: section);
//
//       for (TinyFlyer tiny in tinyFlyers){
//         if (tiny.flyerType == _flyerType){
//           _filteredTinyFlyers.add(tiny);
//         }
//       }
//
//     }
//
//     return _filteredTinyFlyers;
//   }
// // -----------------------------------------------------------------------------
//   static bool tinyFlyersContainThisID({String flyerID, List<TinyFlyer> tinyFlyers}){
//     bool _hasTheID = false;
//
//     if (flyerID != null && Mapper.canLoopList(tinyFlyers)){
//
//       for (TinyFlyer tinyFlyer in tinyFlyers){
//
//         if (tinyFlyer.flyerID == flyerID){
//           _hasTheID = true;
//           break;
//         }
//
//       }
//
//     }
//
//     return _hasTheID;
//   }
// }
// -----------------------------------------------------------------------------
  class OldTinyFlyerMethods{
// // -----------------------------------------------------------------------------
//     List<TinyFlyer> getTinyFlyersByFlyerType(FlyerType flyerType){
//       final List<TinyFlyer> _tinyFlyers = <TinyFlyer>[];
//       final List<String> _flyersIDs = getTinyFlyersIDsByFlyerType(flyerType);
//       _flyersIDs.forEach((fID) {
//         _tinyFlyers.add(getTinyFlyerByFlyerID(fID));
//       });
//       return _tinyFlyers;
//     }
// // -----------------------------------------------------------------------------
//     static const String tinyFlyers = 'tinyFlyers';
//     static const String flyersKeys = 'flyersKeys';
// // -----------------------------------------------------------------------------
//     Future<TinyFlyer> readTinyFlyerOps({BuildContext context, String flyerID}) async {
//
//       final Map<String, dynamic> _tinyFlyerMap = await Fire.readDoc(
//         context: context,
//         collName: FireCollection.tinyFlyers,
//         docName: flyerID,
//       );
//
//       // print(_tinyFlyerMap);
//
//       final TinyFlyer _tinyFlyer = _tinyFlyerMap == null ? null : TinyFlyer.decipherTinyFlyerMap(_tinyFlyerMap);
//
//       // print(' ')
//
//       return _tinyFlyer;
//
//     }
// -----------------------------------------------------------------------------
//     static Future<List<TinyFlyer>> readAllTinyFlyers({BuildContext context, int limit,}) async {
//
//       final List<dynamic> _maps = await Fire.readCollectionDocs(
//         limit: limit ?? 100,
//         collectionName: FireCollection.tinyFlyers,
//         addDocSnapshotToEachMap: false,
//         addDocID: false,
//         orderBy: 'flyerID',
//       );
//
//       final List<TinyFlyer> _allModels = TinyFlyer.decipherTinyFlyersMaps(_maps);
//
//       return _allModels;
//     }

// -----------------------------------------------------------------------------
//     static SuperFlyer createViewSuperFlyerFromTinyFlyer({
//       @required BuildContext context,
//       @required TinyFlyer tinyFlyer,
//       @required Function onHeaderTap,
//       @required Function onTinyFlyerTap,
//       @required Function onAnkhTap,
//     }){
//
//       // print('CREATING view super flyer from tiny flyer : ${tinyFlyer.flyerID} : ${tinyFlyer?.midColor} : : ${tinyFlyer?.tinyBz?.bzName}');
//
//       final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
//       final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
//
//       return
//         SuperFlyer(
//           nav: FlyerNavigator(
//             /// animation controller
//             horizontalController: null,
//             verticalController: null,
//             infoScrollController: null,
//             /// animation functions
//             onHorizontalSlideSwipe: null,
//             onVerticalPageSwipe: null,
//             onVerticalPageBack: null,
//             onHeaderTap: onHeaderTap,
//             onSlideRightTap: null,
//             onSlideLeftTap: null,
//             onSwipeFlyer: null,
//             onTinyFlyerTap: onTinyFlyerTap,
//             /// animation parameters
//             progressBarOpacity: 1,
//             swipeDirection: SwipeDirection.next,
//             bzPageIsOn: false,
//             listenToSwipe: false,
//             getInfoScrollOffset: null,
//             onSaveInfoScrollOffset: null,
//           ),
//           rec: FlyerRecorder(
//             /// record functions
//             onViewSlide: null,
//             onAnkhTap: onAnkhTap,
//             onShareTap: null,
//             onFollowTap: null,
//             onCallTap: null,
//             onCountersTap: null,
//             /// user based bool triggers
//             ankhIsOn: _flyersProvider.checkAnkh(tinyFlyer.flyerID),
//             followIsOn: _bzzProvider.checkFollow(context: context, bzID: tinyFlyer.bzID.bzID),
//             onEditReview: null,
//             onSubmitReview: null,
//             reviewController: null,
//             onShowReviewOptions: null,
//           ),
//           edit: FlyerEditor(
//             /// editor functions
//             onAddImages: null,
//             onDeleteSlide: null,
//             onCropImage: null,
//             onResetImage: null,
//             onFitImage: null,
//             onFlyerTypeTap: null,
//             onZoneTap: null,
//             onEditInfoTap: null,
//             onEditKeywordsTap: null,
//             onShowAuthorTap: null,
//             onTriggerEditMode: null,
//             onPublishFlyer: null,
//             onDeleteFlyer: null,
//             onUnPublishFlyer: null,
//             onRepublishFlyer: null,
//             /// editor data
//             firstTimer: false,
//             editMode: false,
//             canDelete: true,
//           ),
//           mSlides: <MutableSlide>[MutableSlide(
//             slideIndex: tinyFlyer.slideIndex,
//             picURL: tinyFlyer.slidePic,
//             picFile: null,
//             picAsset: null,
//             headline: tinyFlyer.headline,
//             headlineController: null,
//             description: null,
//             descriptionController: null,
//             picFit: tinyFlyer.picFit,
//             savesCount: null,
//             sharesCount: null,
//             viewsCount: null,
//             imageSize: null,
//             midColor: tinyFlyer.midColor,
//             opacity: 1,
//           ),],
//           bz: BzModel(
//             bzID: tinyFlyer.bzID.bzID,
//             bzType: tinyFlyer?.bzID?.bzType,
//             bzForm: null,
//             createdAt: null,
//             accountType: null,
//             bzName: tinyFlyer.bzID.bzName,
//             bzLogo: tinyFlyer.bzID.bzLogo,
//             bzScope: null,
//             bzZone: tinyFlyer.bzID.bzZone,
//             bzAbout: null,
//             bzPosition: null,
//             bzContacts: null,
//             bzAuthors: null,
//             bzShowsTeam: null,
//             bzIsVerified: null,
//             bzAccountIsDeactivated: null,
//             bzAccountIsBanned: null,
//             flyersIDs: <String>[],
//             bzTotalFollowers: tinyFlyer.bzID.bzTotalFollowers,
//             bzTotalFlyers: tinyFlyer.bzID.bzTotalFlyers,
//             bzTotalSaves: null,
//             bzTotalShares: null,
//             bzTotalSlides: null,
//             bzTotalViews: null,
//             bzTotalCalls: null,
//             authorsIDs: <String>[tinyFlyer.authorID],
//
//           ),
//           loading: false,
//
//
//
//           /// editor data
//           infoController: null,
//           screenShots: null,
//
//           /// slides settings
//           numberOfSlides: 1,
//           numberOfStrips: 1,
//
//           /// current slide settings
//           initialSlideIndex: 0,
//           currentSlideIndex: 0,
//           verticalIndex: 0,
//
//
//           /// flyer identifiers
//           key: ValueKey(tinyFlyer.flyerID),
//           flyerID: tinyFlyer.flyerID,
//           authorID: tinyFlyer.authorID,
//
//           /// flyer data
//           flyerType: tinyFlyer.flyerType,
//           flyerState: null,
//           flyerTinyAuthor: null,
//           flyerShowsAuthor: null,
//
//           /// flyer tags
//           flyerInfo: null,
//           specs: null,
//           keywords: Keyword.getKeywordsByKeywordsIDs(tinyFlyer.keywordsIDs),
//
//           /// flyer location
//           flyerZone: tinyFlyer.flyerZone,
//           position: null,
//
//           /// publishing times
//           times: null,
//           priceTagIsOn: tinyFlyer.priceTagIsOn,
//         );
//     }
// -----------------------------------------------------------------------------
//     static TinyBz getTinyBzFromSuperFlyer(SuperFlyer superFlyer){
//       return
//         TinyBz(
//           bzID: superFlyer.bz.bzID,
//           bzLogo: superFlyer.bz.bzLogo,
//           bzName: superFlyer.bz.bzName,
//           bzType: superFlyer.bz.bzType,
//           bzZone: superFlyer.bz.bzZone,
//           bzTotalFollowers: superFlyer.bz.bzTotalFollowers,
//           bzTotalFlyers: superFlyer.bz.bzTotalFlyers,
//         );
//     }
// -----------------------------------------------------------------------------
//     SuperFlyer _getSuperFlyerFromTinyFlyer({TinyFlyer tinyFlyer}){
//       final SuperFlyer _superFlyer = SuperFlyer.createViewSuperFlyerFromTinyFlyer(
//         context: context,
//         tinyFlyer: tinyFlyer,
//         onHeaderTap: () async {await _openTinyFlyer();},
//         onTinyFlyerTap: () async {await _openTinyFlyer();},
//         onAnkhTap: () async {await _onAnkhTap();},
//       );
//       return _superFlyer;
//     }
// -----------------------------------------------------------------------------
//     static Aggredocs createAggredocsFromTinyFlyers({List<TinyFlyer> tinyFlyers}){
//       List<dynamic> _tinyFlyersMaps = TinyFlyer.cipherTinyFlyers(tinyFlyers);
//
//       Aggredocs _aggredocs = createAggredocsFromMaps(
//         maps: _tinyFlyersMaps,
//         numberOfMapKeys: 12,
//         collName: 'tinyFlyers',
//       );
//
//       return _aggredocs;
//     }
// -----------------------------------------------------------------------------
  }
