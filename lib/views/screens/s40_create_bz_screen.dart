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
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
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
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateBzScreen extends StatefulWidget {
  @override
  _CreateBzScreenState createState() => _CreateBzScreenState();
}

class _CreateBzScreenState extends State<CreateBzScreen> with TickerProviderStateMixin{
  bool _bzPageIsOn;
  BldrsSection _currentSection;
  List<bool> _bzTypeInActivityList;
  List<bool> _bzFormInActivityList;
  TextEditingController _scopeTextController;
  TextEditingController _bzNameTextController;
  TextEditingController _aboutTextController;
  bool _isLoading;
  // -------------------------
  BzModel _currentBz;
  // -------------------------
  BzType _currentBzType;
  BzForm _currentBzForm;
  BzAccountType _currentAccountType;
  // -------------------------
  UserModel _currentUser;
  String _currentUserID;
  String _currentBzName;
  File _currentBzLogo;
  String _currentBzScope;
  String _currentBzCountry;
  String _currentBzProvince;
  String _currentBzArea;
  String _currentBzAbout;
  GeoPoint _currentBzPosition;
  List<ContactModel> _currentBzContacts;
  AuthorModel _currentAuthor;
  bool _currentBzShowsTeam;
  String _bzID;
  String _authorName;
  File _authorPic;
  String _authorTitle;
  List<String> _publishedFlyersIDs;
  List<ContactModel> _authorContacts;
  // ----------------------------------------------------------------------
  void initState(){
    _isLoading = false;
    _bzPageIsOn = false;
    _createBzTypeInActivityList();
    _createBzFormInActivityLst();
    _scopeTextController = new TextEditingController();
    _bzNameTextController = new TextEditingController();
    _currentBz = new BzModel();
    _currentAuthor = new AuthorModel();
    super.initState();
  }
  // ----------------------------------------------------------------------
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
  Future<void> _takeGalleryPicture() async {
    final _picker = ImagePicker();
    final _imageFile = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (_imageFile == null){return;}

    setState(() {
      _currentBzLogo = File(_imageFile.path);
    });

    // final _appDir = await sysPaths.getApplicationDocumentsDirectory();
    // final _fileName = path.basename(_imageFile.path);
    // final _savedImage = await _currentPic.copy('${_appDir.path}/$_fileName');
    // _selectImage(savedImage);
  }
  // ----------------------------------------------------------------------
  Future<void> _takeAuthorPicture() async {
    final _picker = ImagePicker();
    final _imageFile = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (_imageFile == null){return;}

    setState(() {
      _authorPic = File(_imageFile.path);
      // newBz.bz.bzLogo = _storedLogo;
    });
  }
  // ----------------------------------------------------------------------
  // void _selectImage(File pickedImage){
  //   _pickedLogo = pickedImage;
  // }
  // ----------------------------------------------------------------------
  Future<BzModel> _createBzModel(UserModel user) async {

    /// saving bzLogo on firebase storage by bzCreator / first Author's userID,,
    /// instead of saving bzID which will be generated later in the creating
    /// bzModel process
    final _bzLogoURL = await saveBzLogoOnFirebaseStorageAndGetURL(inputFile: _currentBzLogo,fileName: user.userID);
    final _authorPicURL = await saveAuthorPicOnFirebaseStorageAndGetURL(inputFile: _authorPic, fileName: user.userID);

    return new BzModel(
      bzID: '...',
      // -------------------------
      bzType: _currentBzType,
      bzForm: _currentBzForm,
      bldrBirth: DateTime.now(),
      accountType: _currentAccountType,
      bzURL: '...',
      // -------------------------
      bzName: _currentBzName ?? user.company,
      bzLogo: _bzLogoURL,
      bzScope: _currentBzScope,
      bzCountry: _currentBzCountry ?? user.country,
      bzProvince: _currentBzProvince ?? user.province,
      bzArea: _currentBzArea ?? user.area,
      bzAbout: _currentBzAbout,
      bzPosition: _currentBzPosition,
      bzContacts: _currentBzContacts ?? user.contacts,
      bzAuthors: [AuthorModel(
        userID: user.userID,
        authorName: _authorName ?? user.name,
        authorPic: _authorPicURL ?? user.pic,
        authorTitle: _authorTitle ?? user.title,
        publishedFlyersIDs: [],
        bzID: '...',
        authorContacts: _authorContacts ?? user.contacts,
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
    try {
      await pro.addBz(context, _bzModel, userModel);
    }
    catch(error) {
      await superDialog(context, error, 'Error Creating Business Profile');
    }
    finally{
      _triggerLoading();
      goBack(context);
    }
  }
  // ----------------------------------------------------------------------
  void _triggerLoading(){
    setState(() {
      _isLoading = !_isLoading;
    });
  }
  // ----------------------------------------------------------------------
  void _assignUserData(UserModel user){
    setState(() {
      _currentBzName = user.company;
      _currentBzCountry = user.country;
      _currentBzProvince = user.province;
      _currentBzArea = user.area;
      _authorName = user.name;
      _authorTitle = user.title;
    });
  }

  @override
  Widget build(BuildContext context) {
    final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: false);
    final _user = Provider.of<UserModel>(context, listen: true);


    return MainLayout(
      tappingRageh: (){print(_currentBzArea);},

      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      pageTitle: Wordz.createBzAccount(context), // createBzAccount

      appBarRowWidgets: <Widget>[BldrsBackButton(onTap: () => goBack(context),),],

      layoutWidget: StreamBuilder<UserModel>(
          stream: UserProvider(userID: _user.userID).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return LoadingFullScreenLayer();
            } else {
              UserModel userModel = snapshot.data;
              return SingleChildScrollView(

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

                    // --- SEPARATOR
                    BubblesSeparator(),

                    // --- ADD LOGO
                    AddGalleryPicBubble(
                      pic: _currentBzLogo,
                      addBtFunction: _takeGalleryPicture,
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
                      initialTextValue: userModel.company,
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
                    ),

                    // --- type BzAbout
                    TextFieldBubble(
                      title: _currentBz.bzName == null  || _currentBz.bzName == '' ? '${Wordz.about(context)} ${Wordz.yourBusiness(context)}' : '${Wordz.about(context)} ${_currentBz.bzName}',
                      hintText: '...',
                      counterIsOn: true,
                      maxLength: 193,
                      maxLines: 4,
                      keyboardTextInputType: TextInputType.multiline,
                      textController: _aboutTextController,
                      textOnChanged: (bzAbout) => setState(() {_currentBzAbout = bzAbout;}),
                    ),

                    // --- SEPARATOR
                    BubblesSeparator(),

                    // --- bzLocale
                    LocaleBubble(
                      changeCountry : (countryID) => setState(() {_currentBzCountry = countryID;}),
                      changeProvince : (provinceID) => setState(() {_currentBzProvince = provinceID;}),
                      changeArea : (areaID) => setState(() {_currentBzArea = areaID;}),
                      zone: Zone(countryID: userModel.country, provinceID: userModel.province, areaID: userModel.area),
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
                      initialTextValue: userModel.name,
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
                      initialTextValue: userModel.title,
                    ),

                    // --- ADD AUTHOR PIC
                    AddGalleryPicBubble(
                      pic: _authorPic,
                      addBtFunction: _takeAuthorPicture,
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
                                  bzID: '',
                                  bzType: _currentBzType,
                                  bzForm: _currentBzForm,
                                  bldrBirth: DateTime.now(),
                                  accountType: _currentAccountType,
                                  bzURL: '',
                                  bzName: _currentBzName ?? userModel.company,
                                  bzLogo: _currentBzLogo,
                                  bzScope: _currentBzScope,
                                  bzCountry: _currentBzCountry ?? userModel.country,
                                  bzProvince: _currentBzProvince ?? userModel.province,
                                  bzArea: _currentBzArea ?? userModel.area,
                                  bzAbout: _currentBzAbout,
                                  bzPosition: GeoPoint(0,0),
                                  bzContacts: _currentBzContacts ?? userModel.contacts,
                                  bzAuthors: [AuthorModel(
                                    userID: userModel.userID,
                                    bzID: '',
                                    authorName: _authorName ?? userModel.name,
                                    authorTitle: _authorTitle ?? userModel.title,
                                    authorPic: _authorPic ?? userModel.pic,
                                    authorContacts: _authorContacts ?? userModel.contacts,
                                    publishedFlyersIDs: [],
                                  ),],
                                  bzShowsTeam: true,
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
                                  userID: userModel.userID,
                                  bzID: '',
                                  authorName: _authorName ?? userModel.name,
                                  authorTitle: _authorTitle ?? userModel.title,
                                  authorPic: _authorPic ?? userModel.pic,
                                  authorContacts: _authorContacts ?? userModel.contacts,
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
                      boxFunction: () => _confirmNewBz(context, _pro, userModel),
                    ),

                    PyramidsHorizon(heightFactor: 5,),

                ],
              ),
            );
          }
        }
      ),
    );
  }
}

