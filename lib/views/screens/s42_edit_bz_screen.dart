import 'dart:io';
import 'package:bldrs/ambassadors/services/firebase_storage.dart';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/drafters/imagers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/screens/s15_profile_screen.dart';
import 'package:bldrs/views/screens/s41_my_bz_screen.dart';
import 'package:bldrs/views/widgets/bubbles/add_gallery_pic_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/multiple_choice_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/buttons/bt_back.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart' show MainLayout, PyramidsHorizon, Stratosphere;
import 'package:provider/provider.dart';

class EditBzScreen extends StatefulWidget {
  final String bzID;

  EditBzScreen({
    this.bzID,
  });


  @override
  _EditBzScreenState createState() => _EditBzScreenState();
}

class _EditBzScreenState extends State<EditBzScreen> {

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
    _bzID = widget.bzID;
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
    _currentBzLogo = _bz.bzLogo; // temp
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
    _authorPic = _bz.bzAuthors[0].authorPic; // temp
    _authorContacts = _bz.bzAuthors[0].authorContacts;
    super.initState();
  }
// ---------------------------------------------------------------------------
  void _switchEditProfile() {
    setState(() {editMode = !editMode;});
  }
// ---------------------------------------------------------------------------
  void _triggerMaxHeader(){
    setState(() {_bzPageIsOn = !_bzPageIsOn;});
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
  Future<void> _changeBzLogo() async {
    final _imageFile = await takeGalleryPicture(PicType.bzLogo);
    setState(() {_currentBzLogo = File(_imageFile.path);});
  }
  // ----------------------------------------------------------------------
  Future<void> _changeAuthorPic() async {
    final _imageFile = await takeGalleryPicture(PicType.authorPic);
    setState(() {_authorPic = File(_imageFile.path);});

  }
  // ----------------------------------------------------------------------
  Future<BzModel> _createBzModel(String userID) async {

      final _bzLogoURL = objectIsURL(_currentBzLogo) ? _currentBzLogo :
      await saveBzLogoOnFirebaseStorageAndGetURL(inputFile: _currentBzLogo,fileName: userID);

      final _authorPicURL = objectIsURL(_authorPic) ? _authorPic :
      await saveAuthorPicOnFirebaseStorageAndGetURL(inputFile: _authorPic, fileName: userID);

    try{

      int _authorIndex = _currentBzAuthors.indexWhere((au) => au.userID == userID);
      AuthorModel _author = _currentBzAuthors.singleWhere((au) => au.userID == userID);
      _currentBzAuthors.removeAt(_authorIndex);
      AuthorModel newAuthorModel = AuthorModel(
        bzID: _author.bzID,
        userID: _author.userID,
        authorName: _authorName,
        authorPic: _authorPicURL,
        authorTitle: _authorTitle,
        publishedFlyersIDs: _author.publishedFlyersIDs,
        authorContacts: _authorContacts,
      );
      _currentBzAuthors.insert(_authorIndex, newAuthorModel);

    }
    catch(error){
      await superDialog(context, error);
    }

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
        bzLogo: _bzLogoURL,
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

  Future <void> _updateBz(BuildContext context, FlyersProvider pro, String userID) async {
    // final bool isValid = _form.currentState.validate();
    // if(!isValid){return;}
    // _form.currentState.save();
    _triggerLoading();
    BzModel _newBzModel = await _createBzModel(userID);
    try {
      await pro.updateBz(_newBzModel);
    }
    catch(error) { await superDialog(context, error); }
    finally {
      _triggerLoading();
      goBack(context);
    }

  }
  // ----------------------------------------------------------------------
  void _triggerLoading(){setState(() {_isLoading = !_isLoading;});}
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

    String _userID = superUserID();

    return MainLayout(
      layoutWidget: ListView(
        children: <Widget>[

          Stratosphere(),

          // --- CHOOSE SECTION
          MultipleChoiceBubble(
            title: Wordz.sections(context),
            buttonsList: sectionsListStrings(context),
            tappingAButton: _selectASection,
            chosenButton: sectionStringer(context, _currentSection),
          ),

          // --- CHOOSE BzType
          MultipleChoiceBubble(
            title: Wordz.accountType(context),
            buttonsList: bzTypesStrings(context),
            tappingAButton: _selectBzType,
            chosenButton: bzTypeSingleStringer(context, _currentBzType),
            buttonsInActivityList: _bzTypeInActivityList,
          ),

          // --- CHOOSE BzForm
          MultipleChoiceBubble(
            title: Wordz.businessForm(context),
            buttonsList: bzFormStrings(context),
            tappingAButton: (index) => setState(() {_currentBzForm = bzFormsList[index];}),
            chosenButton: bzFormStringer(context, _currentBzForm),
            buttonsInActivityList: _bzFormInActivityList,
          ),

          // --- SEPARATOR
          BubblesSeparator(),

          // --- ADD LOGO
          AddGalleryPicBubble(
            pic: _currentBzLogo,
            addBtFunction: _changeBzLogo,
            deletePicFunction: () => setState(() {_currentBzLogo = null;}),
            title: Wordz.businessLogo(context),
            bubbleType: BubbleType.bzLogo,
          ),

          // --- type BzName
          TextFieldBubble(
            title: _currentBzForm == BzForm.Individual ? 'Business Entity name' : Wordz.companyName(context),
            hintText: '...',
            counterIsOn: true,
            maxLength: 72,
            maxLines: 2,
            keyboardTextInputType: TextInputType.name,
            // textController: _bzNameTextController,
            textOnChanged: (bzName) => setState(() {_currentBzName = bzName;}),
            fieldIsRequired: true,
            initialTextValue: _currentBzName,
            fieldIsFormField: true,
          ),

          // --- type BzScope
          TextFieldBubble(
            title: '${Wordz.scopeOfServices(context)} :',
            hintText: '...',
            counterIsOn: true,
            maxLength: 193,
            maxLines: 4,
            keyboardTextInputType: TextInputType.multiline,
            // textController: _scopeTextController,
            textOnChanged: (bzScope) => setState(() {_currentBzScope = bzScope;}),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _currentBzScope,
          ),

          // --- type BzAbout
          TextFieldBubble(
            title: _bz.bzName == null  || _bz.bzName == '' ? '${Wordz.about(context)} ${Wordz.yourBusiness(context)}' : '${Wordz.about(context)} ${_bz.bzName}',
            hintText: '...',
            counterIsOn: true,
            maxLength: 193,
            maxLines: 4,
            keyboardTextInputType: TextInputType.multiline,
            // textController: _aboutTextController,
            textOnChanged: (bzAbout) => setState(() {_currentBzAbout = bzAbout;}),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _currentBzAbout,
          ),

          // --- SEPARATOR
          BubblesSeparator(),

          // --- bzLocale
          LocaleBubble(
            changeCountry : (countryID) => setState(() {_currentBzCountry = countryID;}),
            changeProvince : (provinceID) => setState(() {_currentBzProvince = provinceID;}),
            changeArea : (areaID) => setState(() {_currentBzArea = areaID;}),
            zone: Zone(countryID: _bz.bzCountry, provinceID: _bz.bzProvince, areaID: _bz.bzArea),
            title: 'Headquarters Area',//Wordz.hqCity(context),
          ),

          // --- SEPARATOR
          BubblesSeparator(),

          // --- type AuthorName
          TextFieldBubble(
            title: Wordz.authorName(context),
            hintText: '...',
            counterIsOn: true,
            maxLength: 20,
            maxLines: 1,
            keyboardTextInputType: TextInputType.name,
            // textController: _authorNameTextController,
            textOnChanged: (authorName) => setState(() {_authorName = authorName;}),
            fieldIsRequired: true,
            initialTextValue: _authorName,
            fieldIsFormField: true,
          ),

          // --- type AuthorTitle
          TextFieldBubble(
            title: Wordz.jobTitle(context),
            hintText: '...',
            counterIsOn: true,
            maxLength: 20,
            maxLines: 1,
            keyboardTextInputType: TextInputType.name,
            // textController: _authorTitleTextController,
            textOnChanged: (authorTitle) => setState(() {_authorTitle = authorTitle;}),
            fieldIsRequired: true,
            fieldIsFormField: true,
            initialTextValue: _authorTitle,
          ),

          // --- ADD AUTHOR PIC
          AddGalleryPicBubble(
            pic: _authorPic,
            addBtFunction: _changeAuthorPic,
            deletePicFunction: () => setState(() {_authorPic = null;}),
            title: 'Add a professional picture of yourself',
            bubbleType: BubbleType.authorPic,
          ),

          // --- FLYER PREVIEW
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Stack(
              children: <Widget>[

                FlyerZone(
                  flyerSizeFactor: 0.8,
                  tappingFlyerZone: (){print('fuck you');},
                  stackWidgets: <Widget>[

                    Header(
                      bz: BzModel(
                        bzID: _bzID,
                        bzType: _currentBzType,
                        bzForm: _currentBzForm,
                        bldrBirth: _bz.bldrBirth,
                        accountType: _currentAccountType,
                        bzURL: _bz.bzURL,
                        bzName: _currentBzName,
                        bzLogo: _currentBzLogo,
                        bzScope: _currentBzScope,
                        bzCountry: _currentBzCountry,
                        bzProvince: _currentBzProvince,
                        bzArea: _currentBzArea,
                        bzAbout: _currentBzAbout,
                        bzPosition: _currentBzPosition,
                        bzContacts: _currentBzContacts,
                        bzAuthors: [AuthorModel(
                          userID: _bz.bzAuthors[0].userID,
                          bzID: _bzID,
                          authorName: _authorName,
                          authorTitle: _authorTitle,
                          authorPic: _authorPic,
                          authorContacts: _authorContacts,
                          publishedFlyersIDs: _bz.bzAuthors[0].publishedFlyersIDs,
                        ),],
                        bzShowsTeam: _bz.bzShowsTeam,
                        bzIsVerified: _bz.bzIsVerified,
                        bzAccountIsDeactivated: _bz.bzAccountIsDeactivated,
                        bzAccountIsBanned: _bz.bzAccountIsBanned,
                        bzTotalFollowers: _bz.bzTotalFollowers,
                        bzTotalSaves: _bz.bzTotalSaves,
                        bzTotalShares: _bz.bzTotalShares,
                        bzTotalSlides: _bz.bzTotalSlides,
                        bzTotalViews: _bz.bzTotalViews,
                        bzTotalCalls: _bz.bzTotalCalls,
                        bzTotalConnects: _bz.bzTotalConnects,
                        jointsBzzIDs: _bz.jointsBzzIDs,
                        followIsOn: _bz.followIsOn,

                      ),
                      author: AuthorModel(
                        userID: _bz.bzAuthors[0].userID,
                        bzID: _bzID,
                        authorName: _authorName,
                        authorTitle: _authorTitle,
                        authorPic: _authorPic,
                        authorContacts: _authorContacts,
                        publishedFlyersIDs: _bz.bzAuthors[0].publishedFlyersIDs,
                      ),
                      flyerShowsAuthor: true,
                      followIsOn: false,
                      flyerZoneWidth: superFlyerZoneWidth(context, 0.8),
                      bzPageIsOn: _bzPageIsOn,
                      tappingHeader: _triggerMaxHeader,
                      tappingFollow: (){},
                      tappingUnfollow: (){},
                    ),

                  ],
                ),

              ],
            ),
          ),

          // --- CONFIRM BUTTON
          DreamBox(
            height: 50,
            verse: 'confirm business info',
            verseScaleFactor: .8,
            boxFunction: () => _updateBz(context, _prof, _userID),
          ),

          PyramidsHorizon(heightFactor: 5,),


        ],
      ),
    );
  }
}
