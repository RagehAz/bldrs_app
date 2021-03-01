// import 'package:path_provider/path_provider.dart' as sysPaths;
// import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:bldrs/ambassadors/services/firebase_storage.dart';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/view_brains/controllers/flyer_controllers.dart';
import 'package:bldrs/view_brains/drafters/imagers.dart';
import 'package:bldrs/view_brains/drafters/text_checkers.dart';
import 'package:bldrs/view_brains/drafters/text_generators.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/add_gallery_pic_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/multiple_choice_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzEditorScreen extends StatefulWidget {
  final bool firstTimer;
  final UserModel userModel;

  BzEditorScreen({
    this.firstTimer = false,
    @required this.userModel,
});

  @override
  _BzEditorScreenState createState() => _BzEditorScreenState();
}

class _BzEditorScreenState extends State<BzEditorScreen> with TickerProviderStateMixin{
  FlyersProvider _prof;
  // -------------------------
  final _formKey = GlobalKey<FormState>();
  // -------------------------
  bool _bzPageIsOn;
  // -------------------------
  BzModel _bz;
  // -------------------------
  BldrsSection _currentSection;
  List<bool> _bzTypeInActivityList;
  BzType _currentBzType;
  List<bool> _bzFormInActivityList;
  BzForm _currentBzForm;
  BzAccountType _currentAccountType;
  // -------------------------
  TextEditingController _bzNameTextController = TextEditingController();
  String _currentBzLogoURL;
  File _currentBzLogoFile;
  TextEditingController _bzScopeTextController = TextEditingController();
  String _currentBzCountry;
  String _currentBzProvince;
  String _currentBzArea;
  TextEditingController _aboutTextController = TextEditingController();
  TextEditingController _bzAboutTextController = TextEditingController();
  GeoPoint _currentBzPosition;
  List<ContactModel> _currentBzContacts;
  List<AuthorModel> _currentBzAuthors;
  bool _currentBzShowsTeam;
  // -------------------------
  AuthorModel _currentAuthor;
  TextEditingController _authorNameTextController = TextEditingController();
  File _currentAuthorPicFile;
  String _currentAuthorPicURL;
  TextEditingController _authorTitleTextController = TextEditingController();
  List<String> _publishedFlyersIDs;
  List<ContactModel> _currentAuthorContacts;
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// ---------------------------------------------------------------------------

  void initState(){
    _bzPageIsOn = false;
    _createBzTypeInActivityList();
    _createBzFormInActivityLst();
    // -------------------------
    _prof = Provider.of<FlyersProvider>(context, listen: false);
    _bz = widget.firstTimer == true ? createTempBzModelFromUserData(widget.userModel) : _prof.getBzByBzID(widget.userModel.followedBzzIDs[0]);
    // -------------------------
    _currentBzType = _bz.bzType;
    _currentSection = getBldrsSectionByBzType(_currentBzType);
    _currentBzForm = _bz.bzForm;
    _currentAccountType = _bz.accountType;
    // -------------------------
    _bzNameTextController.text = _bz.bzName;
    _currentBzLogoURL = _bz.bzLogo;
    _bzScopeTextController.text = _bz.bzScope;
    _currentBzCountry = _bz.bzCountry;
    _currentBzProvince = _bz.bzProvince;
    _currentBzArea = _bz.bzArea;
    _bzAboutTextController.text =  _bz.bzAbout;
    _currentBzPosition = _bz.bzPosition;
    _currentBzContacts = _bz.bzContacts;
    _currentBzAuthors = _bz.bzAuthors;
    _currentBzShowsTeam = _currentBzShowsTeam;
    // -------------------------
    _currentAuthor = getAuthorFromBzByAuthorID(_bz, widget.userModel.userID);
    _authorNameTextController.text = _currentAuthor.authorName;
    _currentAuthorPicURL = _currentAuthor.authorPic;
    _authorTitleTextController.text = _currentAuthor.authorTitle;
    _publishedFlyersIDs = _currentAuthor.publishedFlyersIDs;
    _currentAuthorContacts = _currentAuthor.authorContacts;
    // -------------------------
    super.initState();
  }
  // ----------------------------------------------------------------------
  @override
  void dispose() {
    if (textControllerHasNoValue(_bzNameTextController))_bzNameTextController.dispose();
    if (textControllerHasNoValue(_bzScopeTextController))_bzScopeTextController.dispose();
    if (textControllerHasNoValue(_aboutTextController))_aboutTextController.dispose();
    if (textControllerHasNoValue(_bzAboutTextController))_bzAboutTextController.dispose();
    if (textControllerHasNoValue(_authorNameTextController))_authorNameTextController.dispose();
    if (textControllerHasNoValue(_authorTitleTextController))_authorTitleTextController.dispose();
    super.dispose();
  }
  // ----------------------------------------------------------------------
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
  void _createBzTypeInActivityList(){
      setState(() {
        _bzTypeInActivityList = List.filled(bzTypesList.length, true);
      });
  }
  // ----------------------------------------------------------------------
  void _createBzFormInActivityLst(){
      setState(() {
        _bzFormInActivityList = List.filled(bzFormsList.length, true);
      });
  }
  // ----------------------------------------------------------------------
  Future<void> _takeBzLogo() async {
    final _imageFile = await takeGalleryPicture(PicType.bzLogo);
    setState(() {_currentBzLogoFile = File(_imageFile.path);});
  }
  // ----------------------------------------------------------------------
  Future<void> _takeAuthorPicture() async {
    final _imageFile = await takeGalleryPicture(PicType.authorPic);
    setState(() {_currentAuthorPicFile = File(_imageFile.path);});
  }
  // ----------------------------------------------------------------------
  Future<BzModel> _createBzModel(UserModel user) async {

    /// saving bzLogo on firebase storage by bzCreator / first Author's userID,,
    /// instead of saving bzID which will be generated later in the creating
    /// bzModel process
    final _bzLogoURL = await savePicOnFirebaseStorageAndGetURL(
        context: context,
        inputFile: _currentBzLogoFile,
        fileName: user.userID,
        picType: PicType.bzLogo
    );

    final _authorPicURL = await savePicOnFirebaseStorageAndGetURL(
        context: context,
        inputFile: _currentAuthorPicFile,
        fileName: user.userID,
        picType: PicType.authorPic
    );

    return new BzModel(
      bzID: '...',
      // -------------------------
      bzType: _currentBzType,
      bzForm: _currentBzForm,
      bldrBirth: DateTime.now(),
      accountType: _currentAccountType,
      bzURL: '...',
      // -------------------------
      bzName: _bzNameTextController.text ?? user.company,
      bzLogo: _bzLogoURL,
      bzScope: _bzScopeTextController.text,
      bzCountry: _currentBzCountry ?? user.country,
      bzProvince: _currentBzProvince ?? user.province,
      bzArea: _currentBzArea ?? user.area,
      bzAbout: _bzAboutTextController.text,
      bzPosition: _currentBzPosition,
      bzContacts: _currentBzContacts ?? user.contacts,
      bzAuthors: <AuthorModel>[AuthorModel(
        userID: user.userID,
        authorName: _authorNameTextController.text ?? user.name,
        authorPic: _authorPicURL ?? user.pic,
        authorTitle: _authorTitleTextController.text ?? user.title,
        publishedFlyersIDs: [],
        bzID: '...',
        authorContacts: _currentAuthorContacts ?? user.contacts,
      ),],
      bzShowsTeam: _currentBzShowsTeam,
      // -------------------------
      bzIsVerified: false,
      bzAccountIsDeactivated: false,
      bzAccountIsBanned: false,
      // -------------------------
      bzTotalFollowers: 0,
      bzTotalSaves: 0,
      bzTotalShares: 0,
      bzTotalSlides: 0,
      bzTotalViews: 0,
      bzTotalCalls: 0,
      bzTotalConnects: 0,
      // -------------------------
      jointsBzzIDs: [],
      // -------------------------
      followIsOn: false,
    );
  }
  // ----------------------------------------------------------------------
  Future <void> _confirmNewBz(BuildContext context, FlyersProvider pro, UserModel userModel) async {
    // final bool isValid = _form.currentState.validate();
    // if(!isValid){return;}
    // _form.currentState.save();

    BzModel _bzModel = await _createBzModel(userModel);

    _triggerLoading();

    await tryAndCatch(
      context: context,
      functions: () async {
        // await pro.addBz(context, _bzModel, userModel);
        await _prof.createBzDocument(_bzModel, userModel);
      },
      finals: (){
        _triggerLoading();
        goBack(context);
      }
    );

    // try {
    //   await pro.addBz(context, _bzModel, userModel);
    // }
    // catch(error) {
    //   await superDialog(context, error, 'Error Creating Business Profile');
    // }
    // finally{
    //   _triggerLoading();
    //   goBack(context);
    // }
  }
  // ----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    Widget _separator = BubblesSeparator();

    String _bzAboutBubbleTitle = _bzNameTextController.text == null || _bzNameTextController.text == '' ?
    '${Wordz.about(context)} ${Wordz.yourBusiness(context)}' : '${Wordz.about(context)} ${_bzNameTextController.text}';

    return MainLayout(
      tappingRageh: (){print('image path is ${_currentBzLogoFile?.path}');},
      loading: _loading,
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      pageTitle: widget.firstTimer == true ? Wordz.createBzAccount(context) : 'Edit Business account info', // createBzAccount
      appBarBackButton: true,
      layoutWidget: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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

            _separator,

            // --- ADD LOGO
            AddGalleryPicBubble(
              pic: _currentBzLogoFile == null ? _currentBzLogoURL : _currentBzLogoFile,
              addBtFunction: _takeBzLogo,
              deletePicFunction: () => setState(() {_currentBzLogoFile = null;}),
              title: Wordz.businessLogo(context),
              bubbleType: BubbleType.bzLogo,
            ),

            // --- type BzName
            TextFieldBubble(
              textController: _bzNameTextController,
              key: Key('bzName'),
              title: _currentBzForm == BzForm.Individual ? 'Business Entity name' : Wordz.companyName(context),
              hintText: '...',
              counterIsOn: true,
              maxLength: 72,
              maxLines: 2,
              keyboardTextInputType: TextInputType.name,
              fieldIsRequired: true,
              fieldIsFormField: true,
            ),

            // --- type BzScope
            TextFieldBubble(
              textController: _bzScopeTextController,
              key: Key('bzScope'),
              title: '${Wordz.scopeOfServices(context)} :',
              hintText: '...',
              counterIsOn: true,
              maxLength: 193,
              maxLines: 4,
              keyboardTextInputType: TextInputType.multiline,
              fieldIsRequired: true,
              fieldIsFormField: true,
            ),

            // --- type BzAbout
            TextFieldBubble(
              textController: _aboutTextController,
              key: Key('bzAbout'),
              title: _bzAboutBubbleTitle,
              hintText: '...',
              counterIsOn: true,
              maxLength: 193,
              maxLines: 4,
              keyboardTextInputType: TextInputType.multiline,
            ),

            _separator,

            // --- bzLocale
            LocaleBubble(
              changeCountry : (countryID) => setState(() {_currentBzCountry = countryID;}),
              changeProvince : (provinceID) => setState(() {_currentBzProvince = provinceID;}),
              changeArea : (areaID) => setState(() {_currentBzArea = areaID;}),
              currentZone: Zone(countryID: _currentBzCountry, provinceID: _currentBzProvince, areaID: _currentBzArea),
              title: 'Headquarters Area',//Wordz.hqCity(context),
            ),

            _separator,

            // --- type AuthorName
            TextFieldBubble(
              textController: _authorNameTextController,
              key: Key('authorName'),
              title: Wordz.authorName(context),
              hintText: '...',
              counterIsOn: true,
              maxLength: 20,
              maxLines: 1,
              keyboardTextInputType: TextInputType.name,
              fieldIsRequired: true,
              fieldIsFormField: true,
            ),

            // --- type AuthorTitle
            TextFieldBubble(
              textController: _authorTitleTextController,
              key: Key('authorTitle'),
              title: Wordz.jobTitle(context),
              hintText: '...',
              counterIsOn: true,
              maxLength: 20,
              maxLines: 1,
              keyboardTextInputType: TextInputType.name,
              fieldIsRequired: true,
              fieldIsFormField: true,
            ),

            // --- ADD AUTHOR PIC
            AddGalleryPicBubble(
              pic: _currentAuthorPicFile ?? _currentAuthorPicURL,
              addBtFunction: _takeAuthorPicture,
              deletePicFunction: () => setState(() {_currentAuthorPicFile = null;}),
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
                          bzID: '',
                          bzType: _currentBzType,
                          bzForm: _currentBzForm,
                          bldrBirth: DateTime.now(),
                          accountType: _currentAccountType,
                          bzURL: '',
                          bzName: _bzNameTextController.text,
                          bzLogo: _currentBzLogoFile ?? _currentBzLogoURL,
                          bzScope: _bzScopeTextController.text,
                          bzCountry: _currentBzCountry,
                          bzProvince: _currentBzProvince,
                          bzArea: _currentBzArea,
                          bzAbout: _bzAboutTextController.text,
                          bzPosition: _currentBzPosition,
                          bzContacts: _currentBzContacts,
                          bzAuthors: _currentBzAuthors,
                          bzShowsTeam: _currentBzShowsTeam,
                          bzIsVerified: false,
                          bzAccountIsDeactivated: false,
                          bzAccountIsBanned: false,
                          bzTotalFollowers: 0,
                          bzTotalSaves: 0,
                          bzTotalShares: 0,
                          bzTotalSlides: 0,
                          bzTotalViews: 0,
                          bzTotalCalls: 0,
                          bzTotalConnects: 0,
                          jointsBzzIDs: [],
                          followIsOn: false,

                        ),
                        author: AuthorModel(
                          userID: '',
                          bzID: '',
                          authorName: _authorNameTextController.text,
                          authorTitle: _authorTitleTextController.text,
                          authorPic: _currentAuthorPicFile ?? _currentAuthorPicURL,
                          authorContacts: _currentAuthorContacts,
                          publishedFlyersIDs: [],
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
              boxFunction: () => _confirmNewBz(context, _prof, widget.userModel),
            ),

            PyramidsHorizon(heightFactor: 5,),

          ],
        ),
      ),
    );
  }
}

