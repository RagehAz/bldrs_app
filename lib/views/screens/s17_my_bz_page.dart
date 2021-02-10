// import 'dart:io';
//
// import 'package:bldrs/models/bldrs_sections.dart';
// import 'package:bldrs/models/bz_model.dart';
// import 'package:bldrs/models/sub_models/author_model.dart';
// import 'package:bldrs/models/sub_models/contact_model.dart';
// import 'package:bldrs/models/user_model.dart';
// import 'package:bldrs/providers/flyers_provider.dart';
// import 'package:bldrs/providers/users_provider.dart';
// import 'package:bldrs/view_brains/drafters/borderers.dart';
// import 'package:bldrs/view_brains/drafters/scalers.dart';
// import 'package:bldrs/view_brains/drafters/stringers.dart';
// import 'package:bldrs/view_brains/router/navigators.dart';
// import 'package:bldrs/view_brains/theme/colorz.dart';
// import 'package:bldrs/view_brains/theme/iconz.dart';
// import 'package:bldrs/view_brains/theme/wordz.dart';
// import 'package:bldrs/views/widgets/bubbles/add_gallery_pic_bubble.dart';
// import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
// import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
// import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
// import 'package:bldrs/views/widgets/bubbles/multiple_choice_bubble.dart';
// import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
// import 'package:bldrs/views/widgets/buttons/bt_back.dart';
// import 'package:bldrs/views/widgets/buttons/dream_box.dart';
// import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
// import 'package:bldrs/views/widgets/flyer/parts/header.dart';
// import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
// import 'package:bldrs/views/widgets/textings/super_verse.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:bldrs/views/widgets/layouts/main_layout.dart' show PyramidsHorizon, Stratosphere;
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// class MyBzPage extends StatefulWidget {
//   final UserModel userModel;
//
//   MyBzPage({
//     @required this.userModel,
// });
//
//   @override
//   _MyBzPageState createState() => _MyBzPageState();
// }
//
// class _MyBzPageState extends State<MyBzPage> {
//   bool _bzPageIsOn = false;
//   bool editMode = false;
//   BldrsSection _currentSection;
//   List<bool> _bzTypeInActivityList;
//   List<bool> _bzFormInActivityList;
//   bool _isLoading;
//   // -------------------------
//   String _bzID;
//   BzModel _bz;
//   // -------------------------
//   BzType _currentBzType;
//   BzForm _currentBzForm;
//   BzAccountType _currentAccountType;
//   // -------------------------
//   String _currentBzName;
//   dynamic _currentBzLogo;
//   String _currentBzScope;
//   String _currentBzCountry;
//   String _currentBzProvince;
//   String _currentBzArea;
//   String _currentBzAbout;
//   GeoPoint _currentBzPosition;
//   List<ContactModel> _currentBzContacts;
//   List<AuthorModel> _currentBzAuthors;
//   bool _currentBzShowsTeam;
//   // -------------------------
//   String _authorName;
//   String _authorTitle;
//   File _authorPic;
//   List<ContactModel> _authorContacts;
// // ---------------------------------------------------------------------------
//   @override
//   void initState() {
//     _bzID = widget.userModel.followedBzzIDs[0];
//     FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
//     _bz = _prof.getBzByBzID(_bzID);
//     print(_bz.bzName);
//     // // -------------------------
//     // _bzTypeInActivityList =
//     // _currentSection == BldrsSection.RealEstate ? [false, false, true, true, true, true, true] :
//     // _currentSection == BldrsSection.Construction ? [true, true, false, false, false, true, true] :
//     // _currentSection == BldrsSection.Supplies ? [true, true, true, true, true, false, false] :
//     // _bzTypeInActivityList;
//     // // -------------------------
//     // _currentSection = getBldrsSectionByBzType(_bz.bzType);
//     // _currentBzType = _bz.bzType;
//     // _currentBzForm = _bz.bzForm;
//     // _currentAccountType = BzAccountType.Default; // ----- mankash
//     // // -------------------------
//     // _currentBzName = _bz.bzName;
//     // _currentBzLogo = _bz.bzLogo;
//     // _currentBzScope = _bz.bzScope;
//     // _currentBzCountry = _bz.bzCountry;
//     // _currentBzProvince = _bz.bzProvince;
//     // _currentBzArea = _bz.bzArea;
//     // _currentBzAbout = _bz.bzAbout;
//     // _currentBzPosition = _bz.bzPosition;
//     // _currentBzContacts = _bz.bzContacts;
//     // _currentBzAuthors = _bz.bzAuthors;
//     // _currentBzShowsTeam = _bz.bzShowsTeam;
//     // // -------------------------
//     // _authorName = _bz.bzAuthors[0].authorName;
//     // _authorTitle = _bz.bzAuthors[0].authorTitle;
//     // _authorPic = _bz.bzAuthors[0].authorPic;
//     // _authorContacts = _bz.bzAuthors[0].authorContacts;
//     super.initState();
//   }
// // ---------------------------------------------------------------------------
//   void switchEditProfile(){
//     setState(() {
//       editMode = !editMode;
//     });
//   }
// // ---------------------------------------------------------------------------
//   void _triggerMaxHeader(){
//     setState(() {
//     _bzPageIsOn = !_bzPageIsOn;
//     });
//   }
//   // ----------------------------------------------------------------------
//   void _selectASection(int index){
//     setState(() {
//       _currentSection = bldrsSectionsList[index];
//       _bzTypeInActivityList =
//       _currentSection == BldrsSection.RealEstate ? [false, false, true, true, true, true, true] :
//       _currentSection == BldrsSection.Construction ? [true, true, false, false, false, true, true] :
//       _currentSection == BldrsSection.Supplies ? [true, true, true, true, true, false, false] :
//       _bzTypeInActivityList;
//     });
//   }
//   // ----------------------------------------------------------------------
//   void _selectBzType(int index){
//     setState(() {
//       _currentBzType = bzTypesList[index];
//       _bzFormInActivityList =
//       _currentBzType == BzType.Developer ? [true, false] :
//       _currentBzType == BzType.Broker ? [false, false] :
//       _currentBzType == BzType.Designer ? [false, false] :
//       _currentBzType == BzType.Contractor ? [false, false] :
//       _currentBzType == BzType.Artisan ? [false, false] :
//       _currentBzType == BzType.Manufacturer ? [true, false] :
//       _currentBzType == BzType.Supplier ? [true, false] :
//       _bzFormInActivityList;
//       // _currentBz.bzType = _currentBzType;
//     });
//   }
//   // ----------------------------------------------------------------------
//   Future<void> _takeGalleryPicture() async {
//     // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _takeCameraPicture');
//     final picker = ImagePicker();
//     final imageFile = await picker.getImage(
//       source: ImageSource.gallery,
//       maxWidth: 600,
//     );
//
//     if (imageFile == null){return;}
//
//     setState(() {
//       _currentBzLogo = File(imageFile.path);
//       // newBz.bz.bzLogo = _storedLogo;
//     });
//
//     // final appDir = await sysPaths.getApplicationDocumentsDirectory();
//     // final fileName = path.basename(imageFile.path);
//     // final savedImage = await _currentBzLogo.copy('${appDir.path}/$fileName');
//     // _selectImage(savedImage);
//   }
//   // ----------------------------------------------------------------------
//   Future<void> _takeAuthorPicture() async {
//     final picker = ImagePicker();
//     final imageFile = await picker.getImage(
//       source: ImageSource.gallery,
//       maxWidth: 600,
//     );
//
//     if (imageFile == null){return;}
//
//     setState(() {
//       _authorPic = File(imageFile.path);
//       // newBz.bz.bzLogo = _storedLogo;
//     });
//   }
//   // ----------------------------------------------------------------------
//   BzModel _createBzModel(UserModel user){
//     return new BzModel(
//       bzID: _bz.bzID,
//       // -------------------------
//       bzType: _currentBzType,
//       bzForm: _currentBzForm,
//       bldrBirth: _bz.bldrBirth,
//       accountType: _currentAccountType,
//       bzURL: _bz.bzURL,
//       // -------------------------
//       bzName: _currentBzName,
//       bzLogo: _currentBzLogo,
//       bzScope: _currentBzScope,
//       bzCountry: _currentBzCountry,
//       bzProvince: _currentBzProvince,
//       bzArea: _currentBzArea,
//       bzAbout: _currentBzAbout,
//       bzPosition: _currentBzPosition,
//       bzContacts: _currentBzContacts,
//       bzAuthors: _currentBzAuthors,
//       bzShowsTeam: _currentBzShowsTeam,
//       // -------------------------
//       bzIsVerified: _bz.bzIsVerified,
//       bzAccountIsDeactivated: _bz.bzAccountIsDeactivated,
//       bzAccountIsBanned: _bz.bzAccountIsBanned,
//       // -------------------------
//       bzTotalFollowers: _bz.bzTotalFollowers,
//       bzTotalSaves: _bz.bzTotalSaves,
//       bzTotalShares: _bz.bzTotalShares,
//       bzTotalSlides: _bz.bzTotalSlides,
//       bzTotalViews: _bz.bzTotalViews,
//       bzTotalCalls: _bz.bzTotalCalls,
//       bzTotalConnects: _bz.bzTotalCalls,
//       // -------------------------
//       jointsBzzIDs: _bz.jointsBzzIDs,
//       // -------------------------
//       followIsOn: _bz.followIsOn,
//     );
//   }
//   // ----------------------------------------------------------------------
//   Future <void> _updateBz(BuildContext context, FlyersProvider pro, UserModel userModel) async {
//     // final bool isValid = _form.currentState.validate();
//     // if(!isValid){return;}
//     // _form.currentState.save();
//     _triggerLoading();
//     try { await pro.addBz(_createBzModel(userModel), userModel); }
//     catch(error) {
//       await showDialog(
//         context: context,
//         builder: (ctx)=>
//             AlertDialog(
//               title: SuperVerse(verse: 'error man', color: Colorz.BlackBlack,),
//               content: SuperVerse(verse: 'error is : ${error.toString()}', color: Colorz.BlackBlack, maxLines: 10,),
//               backgroundColor: Colorz.Grey,
//               elevation: 10,
//               shape: RoundedRectangleBorder(borderRadius: superBorderAll(context, 20)),
//               contentPadding: EdgeInsets.all(10),
//               actionsOverflowButtonSpacing: 10,
//               actionsPadding: EdgeInsets.all(5),
//               insetPadding: EdgeInsets.symmetric(vertical: (superScreenHeight(context)*0.32), horizontal: 35),
//               buttonPadding:  EdgeInsets.all(5),
//               titlePadding:  EdgeInsets.all(20),
//               actions: <Widget>[BldrsBackButton(onTap: ()=> goBack(ctx)),],
//
//             ),
//       );
//     }
//     finally {
//       _triggerLoading();
//       goBack(context);
//     }
//   }
//   // ----------------------------------------------------------------------
//   void _triggerLoading(){
//     setState(() {
//       _isLoading = !_isLoading;
//     });
//   }
//   // ----------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
//     _bz = _prof.getBzByBzID(_bzID);
//     double _flyerSizeFactor = 0.70;
//     double _flyerZoneWidth = superFlyerZoneWidth(context, _flyerSizeFactor);
//     double _achievementsIconWidth = 60;
//
//     return
//       _currentPage == PageType.MyBz ?
//
//       // --- MY BZ PAGE
//       SliverList(
//       delegate: SliverChildListDelegate([
//
//         Stratosphere(),
//
//         // --- ACHIEVEMENTS
//         InPyramidsBubble(
//           bubbleColor: Colorz.WhiteGlass,
//           centered: true,
//           columnChildren: <Widget>[
//
//             GestureDetector(
//               onTap: (){print('achievements are going to be awesome bitches');},
//               child: Container(
//                 width: superBubbleClearWidth(context),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//
//                     DreamBox(
//                       height: _achievementsIconWidth,
//                       width: _achievementsIconWidth,
//                       bubble: false,
//                       icon: Iconz.Achievement,
//                     ),
//
//                     Container(
//                       width: superBubbleClearWidth(context) - _achievementsIconWidth,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//
//                           SuperVerse(
//                             verse: 'Achievements',
//                             color: Colorz.Yellow,
//                             size: 3,
//                             maxLines: 2,
//                           ),
//
//                           SuperVerse(
//                             verse: 'Perform specific tasks, '
//                                 'market your flyers, '
//                                 'grow your Bldrs network and reach your targeted customers.',
//                             color: Colorz.Grey,
//                             size: 2,
//                             italic: true,
//                             weight: VerseWeight.thin,
//                             maxLines: 5,
//                             centered: false,
//                           ),
//
//                         ],
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//
//         // --- BZ CARD REVIEW
//         Center(
//           child: ChangeNotifierProvider.value(
//             value: _bz,
//             child: Column(
//               children: <Widget>[
//
//                 // --- Edit BZCARD
//                 Container(
//                   width: _flyerZoneWidth,
//                   height: _flyerZoneWidth * 0.14,
//                   // color: Colorz.Facebook,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//
//                       // --- EDIT BZ BUTTON
//                       DreamBox(
//                         // width: 30,
//                         height: _flyerZoneWidth * 0.1,
//                         icon: Iconz.Gears,
//                         color: Colorz.WhiteGlass,
//                         bubble: false,
//                         iconSizeFactor: 0.6,
//                         verse: 'Edit Your Business details',
//                         verseItalic: true,
//                         verseWeight: VerseWeight.thin,
//                         boxMargins: EdgeInsets.symmetric(vertical : _flyerZoneWidth * 0.02),
//                         boxFunction: switchEditProfile,
//                       ),
//
//                     ],
//                   ),
//                 ),
//
//                 FlyerZone(
//                   flyerSizeFactor: _flyerSizeFactor,
//                   tappingFlyerZone: (){print('fuck you');},
//                   stackWidgets: <Widget>[
//
//                     SingleSlide(
//                       flyerZoneWidth: _flyerZoneWidth,
//                       slideColor: Colorz.WhiteSmoke,
//                     ),
//
//                     Header(
//                       bz: _bz,
//                       author: _bz.bzAuthors[0],
//                       flyerShowsAuthor: true,
//                       followIsOn: null,
//                       flyerZoneWidth: _flyerZoneWidth,
//                       bzPageIsOn: _bzPageIsOn,
//                       tappingHeader: _triggerMaxHeader,
//                       tappingFollow: null,
//                       tappingUnfollow: null,
//                     ),
//
//                   ],
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//
//         PyramidsHorizon(heightFactor: 5,),
//
//       ]),
//     )
//
//           :
//
//           // --- EDIT MY BZ PAGE
//           SliverList(
//             delegate: SliverChildListDelegate([
//
//               Stratosphere(),
//
//               // --- CHOOSE SECTION
//               MultipleChoiceBubble(
//                 title: Wordz.sections(context),
//                 buttonsList: sectionsListStrings(context),
//                 tappingAButton: _selectASection,
//                 chosenButton: sectionStringer(context, _currentSection),
//               ),
//
//               // --- CHOOSE BzType
//               MultipleChoiceBubble(
//                 title: Wordz.accountType(context),
//                 buttonsList: bzTypesStrings(context),
//                 tappingAButton: _selectBzType,
//                 chosenButton: bzTypeSingleStringer(context, _currentBzType),
//                 buttonsInActivityList: _bzTypeInActivityList,
//               ),
//
//               // --- CHOOSE BzForm
//               MultipleChoiceBubble(
//                 title: Wordz.businessForm(context),
//                 buttonsList: bzFormStrings(context),
//                 tappingAButton: (index) => setState(() {_currentBzForm = bzFormsList[index];}),
//                 chosenButton: bzFormStringer(context, _currentBzForm),
//                 buttonsInActivityList: _bzFormInActivityList,
//               ),
//
//               // --- SEPARATOR
//               BubblesSeparator(),
//
//               // --- ADD LOGO
//               AddGalleryPicBubble(
//                 logo: _currentBzLogo,
//                 addBtFunction: _takeGalleryPicture,
//                 deleteLogoFunction: () => setState(() {_currentBzLogo = null;}),
//                 title: Wordz.businessLogo(context),
//                 picOwner: PicOwner.bzLogo,
//               ),
//
//               // --- type BzName
//               TextFieldBubble(
//                 title: _currentBzForm == BzForm.Individual ? 'Business Entity name' : Wordz.companyName(context),
//                 hintText: '...',
//                 counterIsOn: true,
//                 maxLength: 72,
//                 maxLines: 2,
//                 keyboardTextInputType: TextInputType.name,
//                 // textController: _bzNameTextController,
//                 textOnChanged: (bzName) => setState(() {_currentBzName = bzName;}),
//                 fieldIsRequired: true,
//                 initialTextValue: _currentBzName,
//                 fieldIsFormField: true,
//               ),
//
//               // --- type BzScope
//               TextFieldBubble(
//                 title: '${Wordz.scopeOfServices(context)} :',
//                 hintText: '...',
//                 counterIsOn: true,
//                 maxLength: 193,
//                 maxLines: 4,
//                 keyboardTextInputType: TextInputType.multiline,
//                 // textController: _scopeTextController,
//                 textOnChanged: (bzScope) => setState(() {_currentBzScope = bzScope;}),
//                 fieldIsRequired: true,
//                 fieldIsFormField: true,
//               ),
//
//               // --- type BzAbout
//               TextFieldBubble(
//                 title: _bz.bzName == null  || _bz.bzName == '' ? '${Wordz.about(context)} ${Wordz.yourBusiness(context)}' : '${Wordz.about(context)} ${_bz.bzName}',
//                 hintText: '...',
//                 counterIsOn: true,
//                 maxLength: 193,
//                 maxLines: 4,
//                 keyboardTextInputType: TextInputType.multiline,
//                 // textController: _aboutTextController,
//                 textOnChanged: (bzAbout) => setState(() {_currentBzAbout = bzAbout;}),
//                 fieldIsRequired: true,
//                 fieldIsFormField: true,
//           ),
//
//               // --- SEPARATOR
//               BubblesSeparator(),
//
//               // --- bzLocale
//               LocaleBubble(
//                 changeCountry : (countryID) => setState(() {_currentBzCountry = countryID;}),
//                 changeProvince : (provinceID) => setState(() {_currentBzProvince = provinceID;}),
//                 changeArea : (areaID) => setState(() {_currentBzArea = areaID;}),
//                 hq: HQ(countryID: _bz.bzCountry, provinceID: _bz.bzProvince, areaID: _bz.bzArea),
//                 title: 'Headquarters Area',//Wordz.hqCity(context),
//               ),
//
//               // --- SEPARATOR
//               BubblesSeparator(),
//
//               // --- type AuthorName
//               TextFieldBubble(
//                 title: Wordz.authorName(context),
//                 hintText: '...',
//                 counterIsOn: true,
//                 maxLength: 20,
//                 maxLines: 1,
//                 keyboardTextInputType: TextInputType.name,
//                 // textController: _authorNameTextController,
//                 textOnChanged: (authorName) => setState(() {_authorName = authorName;}),
//                 fieldIsRequired: true,
//                 initialTextValue: _authorName,
//                 fieldIsFormField: true,
//               ),
//
//               // --- type AuthorTitle
//               TextFieldBubble(
//                 title: Wordz.jobTitle(context),
//                 hintText: '...',
//                 counterIsOn: true,
//                 maxLength: 20,
//                 maxLines: 1,
//                 keyboardTextInputType: TextInputType.name,
//                 // textController: _authorTitleTextController,
//                 textOnChanged: (authorTitle) => setState(() {_authorTitle = authorTitle;}),
//                 fieldIsRequired: true,
//                 fieldIsFormField: true,
//                 initialTextValue: _authorTitle,
//               ),
//
//               // --- ADD AUTHOR PIC
//               AddGalleryPicBubble(
//                 logo: _authorPic,
//                 addBtFunction: _takeAuthorPicture,
//                 deleteLogoFunction: () => setState(() {_authorPic = null;}),
//                 title: 'Add a _professional picture of yourself',
//                 picOwner: PicOwner.author,
//               ),
//
//               // // --- FLYER PREVIEW
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(vertical: 50),
//               //   child: Stack(
//               //     children: <Widget>[
//               //
//               //       FlyerZone(
//               //         flyerSizeFactor: 0.8,
//               //         tappingFlyerZone: (){print('fuck you');},
//               //         stackWidgets: <Widget>[
//               //
//               //           Header(
//               //             bz: BzModel(
//               //               bzID: '',
//               //               bzType: _currentBzType,
//               //               bzForm: _currentBzForm,
//               //               bldrBirth: DateTime.now(),
//               //               accountType: _currentAccountType,
//               //               bzURL: '',
//               //               bzName: _currentBzName ?? userModel.company,
//               //               bzLogo: _currentBzLogo,
//               //               bzScope: _currentBzScope,
//               //               bzCountry: _currentBzCountry ?? userModel.country,
//               //               bzProvince: _currentBzProvince ?? userModel.province,
//               //               bzArea: _currentBzArea ?? userModel.area,
//               //               bzAbout: _currentBzAbout,
//               //               bzPosition: GeoPoint(0,0),
//               //               bzContacts: _currentBzContacts ?? userModel.contacts,
//               //               bzAuthors: [AuthorModel(
//               //                 userID: userModel.userID,
//               //                 bzID: '',
//               //                 authorName: _authorName ?? userModel.name,
//               //                 authorTitle: _authorTitle ?? userModel.title,
//               //                 authorPic: _authorPic ?? userModel.pic,
//               //                 authorContacts: _authorContacts ?? userModel.contacts,
//               //                 publishedFlyersIDs: [],
//               //               ),],
//               //               bzShowsTeam: true,
//               //               bzIsVerified: false,
//               //               bzAccountIsDeactivated: false,
//               //               bzAccountIsBanned: false,
//               //               bzTotalFollowers: 0,
//               //               bzTotalSaves: 0,
//               //               bzTotalShares: 0,
//               //               bzTotalSlides: 0,
//               //               bzTotalViews: 0,
//               //               bzTotalCalls: 0,
//               //               bzTotalConnects: 0,
//               //               jointsBzzIDs: [],
//               //               followIsOn: false,
//               //
//               //             ),
//               //             author: AuthorModel(
//               //               userID: userModel.userID,
//               //               bzID: '',
//               //               authorName: _authorName ?? userModel.name,
//               //               authorTitle: _authorTitle ?? userModel.title,
//               //               authorPic: _authorPic ?? userModel.pic,
//               //               authorContacts: _authorContacts ?? userModel.contacts,
//               //               publishedFlyersIDs: [],
//               //             ),
//               //             flyerShowsAuthor: true,
//               //             followIsOn: false,
//               //             flyerZoneWidth: superFlyerZoneWidth(context, 0.8),
//               //             bzPageIsOn: _bzPageIsOn,
//               //             tappingHeader: _triggerMaxHeader,
//               //             tappingFollow: (){},
//               //             tappingUnfollow: (){},
//               //           ),
//               //
//               //         ],
//               //       ),
//               //
//               //     ],
//               //   ),
//               // ),
//
//               // --- CONFIRM BUTTON
//               DreamBox(
//                 height: 50,
//                 verse: 'confirm business info',
//                 verseScaleFactor: .8,
//                 boxFunction: () => _updateBz(context, _prof, widget.userModel),
//               ),
//
//               PyramidsHorizon(heightFactor: 5,),
//
//             ]),
//           );
//   }
// }
