// import 'package:bldrs/a_models/bz/author_model.dart';
// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/a_models/zone/city_model.dart';
// import 'package:bldrs/a_models/zone/country_model.dart';
// import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/author_bubble/author_bubble.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/stacks/old_gallery_grid.dart';
// import 'package:bldrs/d_providers/bzz_provider.dart';
// import 'package:bldrs/d_providers/zone_provider.dart';
// import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Gallery extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const Gallery({
//     @required this.bzModel,
//     @required this.galleryBoxWidth,
//     @required this.showFlyers,
//     this.addAuthorButtonIsOn = true,
//     // @required this.tinyFlyers,
//     Key key,
//   }) : super(key: key);
//
//   /// --------------------------------------------------------------------------
//   final BzModel bzModel;
//   final double galleryBoxWidth;
//   final bool showFlyers; // why ?
//   final bool addAuthorButtonIsOn;
//   // final List<TinyFlyer> tinyFlyers;
//   /// --------------------------------------------------------------------------
//   @override
//   _GalleryState createState() => _GalleryState();
//
//   /// --------------------------------------------------------------------------
// }
//
// class _GalleryState extends State<Gallery> {
//   List<bool> _flyersVisibilities;
//   // List<bool> _authorsVisibilities;
//   String _selectedAuthorID;
//   List<String> _bzTeamIDs;
//   BzModel _bzModel;
//   CountryModel _bzCountry;
//   CityModel _bzCity;
//   List<FlyerModel> _flyers = <FlyerModel>[];
// // -----------------------------------------------------------------------------
//   /// --- FUTURE LOADING BLOCK
//   bool _loading = false;
//   Future<void> _triggerLoading({Function function}) async {
//     if (function == null) {
//       setState(() {
//         _loading = !_loading;
//       });
//     } else {
//       setState(() {
//         _loading = !_loading;
//         function();
//       });
//     }
//
//     _loading == true
//         ? blog('LOADING--------------------------------------')
//         : blog('LOADING COMPLETE--------------------------------------');
//   }
//
// // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//
//     blog('starting gallery init');
//     _bzModel = widget.bzModel;
//
//     _flyers = <FlyerModel>[];
//
//     blog('flyersIDs are ${_bzModel.flyersIDs}');
//
//     _bzTeamIDs = BzModel.getBzTeamIDs(_bzModel);
//     setFlyersVisibility();
//   }
//
// // -----------------------------------------------------------------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (_isInit) {
//       _triggerLoading(function: () {}).then((_) async {
//         /// ---------------------------------------------------------0
//
//         // final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
//         final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
//         final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
//
//         await _bzzProvider.getsetActiveBzFlyers(
//             context: context,
//             bzID: _bzModel.id
//         );
//
//         final List<FlyerModel> _flyersFromProvider = _bzzProvider.myActiveBzFlyers;
//
//         final CountryModel _country = await _zoneProvider.fetchCountryByID(
//             context: context,
//             countryID: _bzModel.zone.countryID
//         );
//
//         final CityModel _city = await _zoneProvider.fetchCityByID(
//             context: context,
//             cityID: _bzModel.zone.cityID,
//         );
//
//         // blog('active bz flyers are : $_flyersFromProvider');
//
//         setState(() {
//           _flyers = _flyersFromProvider;
//           _bzCountry = _country;
//           _bzCity = _city;
//           _loading = false;
//         });
//
//         /// ---------------------------------------------------------0
//       });
//     }
//     _isInit = false;
//   }
//
// // -----------------------------------------------------------------------------
//   List<bool> _createVisibilities({bool fillingValue}) {
//     final List<bool> _visibilities = <bool>[];
//
//     for (int i = 0; i < _flyers.length; i++) {
//       _visibilities.add(fillingValue);
//     }
//
//     return _visibilities;
//   }
//
// // -----------------------------------------------------------------------------
//   void setFlyersVisibility() {
//     final List<bool> _visibilities = _createVisibilities(fillingValue: true);
//
//     setState(() {
//       _flyersVisibilities = _visibilities;
//       _selectedAuthorID = _bzTeamIDs.length == 1 ? _bzTeamIDs[0] : '';
//     });
//   }
//
// // -----------------------------------------------------------------------------
//   void _onAuthorLabelTap(String authorID) {
//     setState(() {
//       _flyersVisibilities = _createVisibilities(fillingValue: false);
//
//       if (_selectedAuthorID != authorID) {
//         _selectedAuthorID = '';
//         _flyersVisibilities = _createVisibilities(fillingValue: true);
//       }
//
//       _flyers.asMap().forEach((int index, FlyerModel flyer) {
//         if (_flyers[index].authorID == _selectedAuthorID) {
//           _flyersVisibilities[index] = true;
//         }
//       });
//     });
//   }
//
// // -----------------------------------------------------------------------------
//   void _addPublishedFlyerToGallery(FlyerModel flyerModel) {
//     // TASK : of the tasks
//     // _prof.updateTinyFlyerInLocalBzTinyFlyers(tinyFlyer);
//
//     blog('starting _addPublishedFlyerToGallery white tiny flyers were ${_flyers.length} flyers WHILE flyer visibilities were ${_flyersVisibilities.length} visibilities');
//
//     blog('tiny flyer is ${flyerModel.id}');
//
//     _flyers.add(flyerModel);
//
//     blog('_tinyFlyers are now  ${_flyers.length} flyers');
//
//     _flyersVisibilities.add(true);
//
//     blog('_flyersVisibilities are now  ${_flyersVisibilities.length} visibilities');
//
//     _onAuthorLabelTap(flyerModel.authorID);
//   }
//
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     // bool _thisIsMyBz = _bzTeamIDs.contains(superUserID());
//
//     return Container(
//       width: widget.galleryBoxWidth,
//       margin: EdgeInsets.only(top: widget.galleryBoxWidth * 0.005),
//       color: widget.addAuthorButtonIsOn == false ? Colorz.bzPageBGColor : null,
//       child: widget.showFlyers == false ? Container()
//           :
//       Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//
//             /// GRID TITLE
//             Container(
//               width: widget.galleryBoxWidth,
//               // height: ,
//               alignment: Aligners.superCenterAlignment(context),
//               padding: const EdgeInsets.symmetric(
//                   horizontal: Ratioz.appBarMargin),
//               child: _bzModel.showsTeam == false ?
//               SuperVerse(
//                 verse: '${Wordz.flyersPublishedBy(context)} ${_bzModel.name}',
//                 italic: true,
//                 margin: widget.galleryBoxWidth * Ratioz.xxflyersGridSpacing,
//                 maxLines: 3,
//                 centered: false,
//                 shadow: true,
//                 leadingDot: true,
//               )
//                   :
//               SuperVerse(
//                 verse: _bzTeamIDs.length == 1 ?
//                 '${Wordz.flyersPublishedBy(context)} ${_bzModel.authors[0].name}'
//                     :
//                 '${_bzModel.name} ${Wordz.authorsTeam(context)}',
//                 italic: true,
//                 margin: widget.galleryBoxWidth * Ratioz.xxflyersGridSpacing,
//                 maxLines: 3,
//                 centered: false,
//                 shadow: true,
//                 leadingDot: true,
//               ),
//             ),
//
//             /// AUTHORS BUBBLE
//             if (_bzModel.showsTeam != false)
//               AuthorBubble(
//                 flyerBoxWidth: widget.galleryBoxWidth,
//                 addAuthorButtonIsOn: widget.addAuthorButtonIsOn,
//                 bzAuthors: _bzModel.authors,
//                 showFlyers: widget.showFlyers,
//                 bzModel: _bzModel,
//                 onAuthorLabelTap: (String id) => _onAuthorLabelTap(id),
//                 selectedAuthorID: _selectedAuthorID,
//                 bzFlyers: _flyers,
//               ),
//
//             /// FLYERS
//             // if (widget.galleryBoxWidth != null)
//             OldGalleryGrid(
//               gridZoneWidth: widget.galleryBoxWidth,
//               bzID: _bzModel.authors == null ||
//                   _bzModel.authors == <AuthorModel>[] ||
//                   _bzModel.authors.isEmpty
//                   ?
//               ''
//                   :
//               _bzModel.id,
//               flyersVisibilities: _flyersVisibilities,
//               galleryFlyers: _flyers,
//               bzAuthors: _bzModel.authors,
//               bz: _bzModel,
//               /// TASK : maybe should remove this as long as super flyer is here
//               // flyerOnTap: widget.flyerOnTap,
//               addPublishedFlyerToGallery: (FlyerModel flyerModel) => _addPublishedFlyerToGallery(flyerModel),
//               addButtonIsOn: widget.addAuthorButtonIsOn,
//               bzCountry: _bzCountry,
//               bzCity: _bzCity,
//             ),
//
//           ]
//       ),
//     );
//   }
// }
