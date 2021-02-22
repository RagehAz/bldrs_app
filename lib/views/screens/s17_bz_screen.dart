import 'dart:io';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/screens/s15_profile_screen.dart';
import 'package:bldrs/views/screens/s17_edit_bz_screen.dart';
import 'package:bldrs/views/widgets/bubbles/add_gallery_pic_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/multiple_choice_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/buttons/bt_back.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show MainLayout, PyramidsHorizon, Stratosphere;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MyBzScreen extends StatefulWidget {
  final UserModel userModel;
  final Function switchPage;

  MyBzScreen({
    @required this.userModel,
    @required this.switchPage,
  });

  @override
  _MyBzScreenState createState() => _MyBzScreenState();
}

class _MyBzScreenState extends State<MyBzScreen> {
  bool _bzPageIsOn = false;
  bool editMode = false;
  BldrsSection _currentSection;
  List<bool> _bzTypeInActivityList;
  List<bool> _bzFormInActivityList;
  bool _isLoading =false;
  // -------------------------
  String _bzID;
  BzModel _bz;
  // -------------------------
  BzType _currentBzType;
  BzForm _currentBzForm;
  BzAccountType _currentAccountType;
  // -------------------------
  String _currentBzName;
  dynamic _currentBzLogo;
  String _currentBzScope;
  String _currentBzCountry;
  String _currentBzProvince;
  String _currentBzArea;
  String _currentBzAbout;
  GeoPoint _currentBzPosition;
  List<ContactModel> _currentBzContacts;
  List<AuthorModel> _currentBzAuthors;
  bool _currentBzShowsTeam;
  // -------------------------
  String _authorName;
  String _authorTitle;
  dynamic _authorPic;
  List<ContactModel> _authorContacts;
// ---------------------------------------------------------------------------
  FlyersProvider _prof;


  @override
  void initState() {
    _bzID = widget.userModel.followedBzzIDs[0];
    _prof = Provider.of<FlyersProvider>(context, listen: false);
    _bz = _prof.getBzByBzID(_bzID);
    print(_bz.bzAuthors);
    // -------------------------
    _bzTypeInActivityList =
    _currentSection == BldrsSection.RealEstate ? [false, false, true, true, true, true, true] :
    _currentSection == BldrsSection.Construction ? [true, true, false, false, false, true, true] :
    _currentSection == BldrsSection.Supplies ? [true, true, true, true, true, false, false] :
    _bzTypeInActivityList;
    // -------------------------
    _currentSection = getBldrsSectionByBzType(_bz.bzType);
    _currentBzType = _bz.bzType;
    _currentBzForm = _bz.bzForm;
    _currentAccountType = BzAccountType.Default; // ----- mankash
    // -------------------------
    _currentBzName = _bz.bzName;
    _currentBzLogo = objectIsFile(_bz.bzLogo) ? null : _bz.bzLogo; // temp
    _currentBzScope = _bz.bzScope;
    _currentBzCountry = _bz.bzCountry;
    _currentBzProvince = _bz.bzProvince;
    _currentBzArea = _bz.bzArea;
    _currentBzAbout = _bz.bzAbout;
    _currentBzPosition = _bz.bzPosition;
    _currentBzContacts = _bz.bzContacts;
    _currentBzAuthors = _bz.bzAuthors;
    _currentBzShowsTeam = _bz.bzShowsTeam;
    // -------------------------
    _authorName = _bz.bzAuthors[0].authorName;
    _authorTitle = _bz.bzAuthors[0].authorTitle;
    _authorPic = objectIsFile(_bz.bzAuthors[0].authorPic) ? null : _bz.bzAuthors[0].authorPic; // temp
    _authorContacts = _bz.bzAuthors[0].authorContacts;
    super.initState();
  }
// ---------------------------------------------------------------------------
  void _goToEditBzProfile() {
    // should delete this
     setState(() {
      editMode = !editMode;
    });

     goToNewScreen(context, EditBzScreen(bzID: _bzID,));
  }
// ---------------------------------------------------------------------------
  void _triggerMaxHeader(){
    setState(() {
      _bzPageIsOn = !_bzPageIsOn;
    });
  }
  // ----------------------------------------------------------------------
  void _selectASection(int index){
    setState(() {
      _currentSection = bldrsSectionsList[index];
      _bzTypeInActivityList =
      _currentSection == BldrsSection.RealEstate ? [false, false, true, true, true, true, true] :
      _currentSection == BldrsSection.Construction ? [true, true, false, false, false, true, true] :
      _currentSection == BldrsSection.Supplies ? [true, true, true, true, true, false, false] :
      _bzTypeInActivityList;
    });
  }
  // ----------------------------------------------------------------------
  void _selectBzType(int index){
    setState(() {
      _currentBzType = bzTypesList[index];
      _bzFormInActivityList =
      _currentBzType == BzType.Developer ? [true, false] :
      _currentBzType == BzType.Broker ? [false, false] :
      _currentBzType == BzType.Designer ? [false, false] :
      _currentBzType == BzType.Contractor ? [false, false] :
      _currentBzType == BzType.Artisan ? [false, false] :
      _currentBzType == BzType.Manufacturer ? [true, false] :
      _currentBzType == BzType.Supplier ? [true, false] :
      _bzFormInActivityList;
      // _currentBz.bzType = _currentBzType;
    });
  }
  // ----------------------------------------------------------------------
  Future<void> _takeGalleryPicture() async {
    // print('=======================================|| i: $currentSlide || #: $numberOfSlides || --> before _takeCameraPicture');
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageFile == null){return;}

    setState(() {
      _currentBzLogo = File(imageFile.path);
      // newBz.bz.bzLogo = _storedLogo;
    });

    // final appDir = await sysPaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // final savedImage = await _currentBzLogo.copy('${appDir.path}/$fileName');
    // _selectImage(savedImage);
  }
  // ----------------------------------------------------------------------
  Future<void> _takeAuthorPicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageFile == null){return;}

    setState(() {
      _authorPic = File(imageFile.path);
      // newBz.bz.bzLogo = _storedLogo;
    });
  }
  // ----------------------------------------------------------------------
  BzModel _createBzModel(){
    return new BzModel(
      bzID: _bz.bzID,
      // -------------------------
      bzType: _currentBzType,
      bzForm: _currentBzForm,
      bldrBirth: _bz.bldrBirth,
      accountType: _currentAccountType,
      bzURL: _bz.bzURL,
      // -------------------------
      bzName: _currentBzName,
      bzLogo: '',
      bzScope: _currentBzScope,
      bzCountry: _currentBzCountry,
      bzProvince: _currentBzProvince,
      bzArea: _currentBzArea,
      bzAbout: _currentBzAbout,
      bzPosition: _currentBzPosition,
      bzContacts: _currentBzContacts,
      bzAuthors: _currentBzAuthors,
      bzShowsTeam: _currentBzShowsTeam,
      // -------------------------
      bzIsVerified: _bz.bzIsVerified,
      bzAccountIsDeactivated: _bz.bzAccountIsDeactivated,
      bzAccountIsBanned: _bz.bzAccountIsBanned,
      // -------------------------
      bzTotalFollowers: _bz.bzTotalFollowers,
      bzTotalSaves: _bz.bzTotalSaves,
      bzTotalShares: _bz.bzTotalShares,
      bzTotalSlides: _bz.bzTotalSlides,
      bzTotalViews: _bz.bzTotalViews,
      bzTotalCalls: _bz.bzTotalCalls,
      bzTotalConnects: _bz.bzTotalCalls,
      // -------------------------
      jointsBzzIDs: _bz.jointsBzzIDs,
      // -------------------------
      followIsOn: _bz.followIsOn,
    );
  }
  // ----------------------------------------------------------------------
  Future <void> _updateBz(BuildContext context, FlyersProvider pro,) async {
    // final bool isValid = _form.currentState.validate();
    // if(!isValid){return;}
    // _form.currentState.save();
    _triggerLoading();
    try { await pro.updateBz(_createBzModel()); }
    catch(error) {
      await showDialog(
        context: context,
        builder: (ctx)=> superAlert(context, ctx, error),
      );
    }
    finally {
      _triggerLoading();
      _goToEditBzProfile();
    }

  }
  // ----------------------------------------------------------------------
  void _triggerLoading(){
    setState(() {
      _isLoading = !_isLoading;
    });
  }
  // ----------------------------------------------------------------------
  Future<void> _deleteBzProfile(BuildContext context, FlyersProvider pro, UserModel userModel) async {
    _triggerLoading();
    try { await pro.deleteBz(_bzID, userModel); }
    catch(error) {
      await showDialog(
        context: context,
        builder: (ctx)=>
            AlertDialog(
              title: SuperVerse(verse: 'error man', color: Colorz.BlackBlack,),
              content: SuperVerse(verse: 'error is : ${error.toString()}', color: Colorz.BlackBlack, maxLines: 10,),
              backgroundColor: Colorz.Grey,
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: superBorderAll(context, 20)),
              contentPadding: EdgeInsets.all(10),
              actionsOverflowButtonSpacing: 10,
              actionsPadding: EdgeInsets.all(5),
              insetPadding: EdgeInsets.symmetric(vertical: (superScreenHeight(context)*0.32), horizontal: 35),
              buttonPadding:  EdgeInsets.all(5),
              titlePadding:  EdgeInsets.all(20),
              actions: <Widget>[BldrsBackButton(onTap: ()=> goBack(ctx)),],

            ),
      );
    }
    finally {
      _triggerLoading();
      goToNewScreen(context, UserProfileScreen());
    }

  }

  void _tapAchievements(){
    setState(() {print('Bz data edited successfully');});
  }

  @override
  Widget build(BuildContext context) {

    double _flyerSizeFactor = 0.70;
    double _flyerZoneWidth = superFlyerZoneWidth(context, _flyerSizeFactor);
    double _achievementsIconWidth = 60;

    String _testPrint = '${_bz.bzAuthors}';

    return
        MainLayout(
          layoutWidget: ListView(
            children: <Widget>[

              Stratosphere(),

              // --- ACHIEVEMENTS
              InPyramidsBubble(
                bubbleColor: Colorz.WhiteGlass,
                centered: true,
                columnChildren: <Widget>[

                  GestureDetector(
                    onTap: _tapAchievements,
                    child: Container(
                      width: superBubbleClearWidth(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          DreamBox(
                            height: _achievementsIconWidth,
                            width: _achievementsIconWidth,
                            bubble: false,
                            icon: Iconz.Achievement,
                          ),

                          Container(
                            width: superBubbleClearWidth(context) - _achievementsIconWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                SuperVerse(
                                  verse: 'Achievements',
                                  color: Colorz.Yellow,
                                  size: 3,
                                  maxLines: 2,
                                ),

                                SuperVerse(
                                  verse: 'Perform specific tasks, '
                                      'market your flyers, '
                                      'grow your Bldrs network and reach your targeted customers.',
                                  color: Colorz.Grey,
                                  size: 2,
                                  italic: true,
                                  weight: VerseWeight.thin,
                                  maxLines: 5,
                                  centered: false,
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                ],
              ),

              // --- BZ CARD REVIEW
              Center(
                child: Column(
                  children: <Widget>[

                    // --- Edit BZCARD
                    Container(
                      width: _flyerZoneWidth,
                      height: _flyerZoneWidth * 0.14,
                      // color: Colorz.Facebook,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          // --- EDIT BZ BUTTON
                          DreamBox(
                            // width: 30,
                            height: _flyerZoneWidth * 0.1,
                            icon: Iconz.Gears,
                            color: Colorz.WhiteGlass,
                            bubble: false,
                            iconSizeFactor: 0.6,
                            verse: 'Edit Your Business details',
                            verseItalic: true,
                            verseWeight: VerseWeight.thin,
                            boxMargins: EdgeInsets.symmetric(vertical : _flyerZoneWidth * 0.02),
                            boxFunction: _goToEditBzProfile,
                          ),

                          DreamBox(
                            width: _flyerZoneWidth * 0.1,
                            height: _flyerZoneWidth * 0.1,
                            icon: Iconz.XLarge,
                            iconColor: Colorz.BloodRed,
                            color: Colorz.WhiteGlass,
                            bubble: false,
                            iconSizeFactor: 0.6,
                            // verse: 'Delete Account',
                            verseItalic: true,
                            verseWeight: VerseWeight.thin,
                            boxMargins: EdgeInsets.symmetric(vertical : _flyerZoneWidth * 0.02),
                            boxFunction: () =>_deleteBzProfile(context, _prof, widget.userModel),
                          ),

                        ],
                      ),
                    ),

                    FlyerZone(
                      flyerSizeFactor: _flyerSizeFactor,
                      tappingFlyerZone: (){print('fuck you');},
                      stackWidgets: <Widget>[

                        SingleSlide(
                          flyerZoneWidth: _flyerZoneWidth,
                          slideColor: Colorz.WhiteSmoke,
                        ),

                        Header(
                          bz: _bz,
                          author: _currentBzAuthors[0] ?? null,
                          flyerShowsAuthor: true,
                          followIsOn: false,
                          flyerZoneWidth: _flyerZoneWidth,
                          bzPageIsOn: _bzPageIsOn,
                          tappingHeader: ()=>_triggerMaxHeader(),
                          tappingFollow: (){},
                          tappingUnfollow: (){},
                        ),

                      ],
                    ),

                  ],
                ),
              ),

              PyramidsHorizon(heightFactor: 5,),



            ],
          ),
        );

  }
}

