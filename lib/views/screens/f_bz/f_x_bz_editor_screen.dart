// import 'package:path_provider/path_provider.dart' as sysPaths;
// import 'package:path/path.dart' as path;
import 'dart:io';

import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/db/fire/ops/bz_ops.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/kw/section_class.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/bzz_provider.dart';
import 'package:bldrs/views/widgets/general/bubbles/add_gallery_pic_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/general/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/multiple_choice_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzEditorScreen extends StatefulWidget {
  final bool firstTimer;
  final UserModel userModel;
  final BzModel bzModel;

  const BzEditorScreen({
    @required this.userModel,
    this.firstTimer = false,
    this.bzModel,
    Key key,
  }) : super(key: key);

  @override
  _BzEditorScreenState createState() => _BzEditorScreenState();
}

class _BzEditorScreenState extends State<BzEditorScreen> with TickerProviderStateMixin{
  BzzProvider _bzzProvider;
  // -------------------------
  // final _formKey = GlobalKey<FormState>();
  // -------------------------
  BzModel _bz;
  // -------------------------
  // String _currentBzID;
  BzAccountType _currentAccountType;
  // -------------------------
  Section _currentSection;
  List<bool> _bzTypeInActivityList;
  BzType _currentBzType; // profession
  List<bool> _bzFormInActivityList;
  BzForm _currentBzForm;
  // -------------------------
  TextEditingController _bzNameTextController = TextEditingController();
  String _currentBzLogoURL;
  File _currentBzLogoFile;
  TextEditingController _bzScopeTextController = TextEditingController();
  String _currentBzCountry;
  String _currentBzCity;
  String _currentBzDistrict;
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
  List<ContactModel> _currentAuthorContacts;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  void initState(){
    super.initState();
    // -------------------------
    _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

    _bz = widget.firstTimer == true ? BzModel.createInitialBzModelFromUserData(widget.userModel) : widget.bzModel;
    // -------------------------
    // _currentBzID = _bz.bzID;
    _currentAccountType = _bz.accountType;
    // -------------------------
    _currentBzType = _bz.bzType;
    _currentSection = SectionClass.getSectionByBzType(_currentBzType);
    _currentBzForm = _bz.bzForm;
    // -------------------------
    _createBzTypeInActivityList();
    _createBzFormInActivityLst();
    // -------------------------
    _bzNameTextController.text = _bz.name;
    _currentBzLogoURL = _bz.logo;
    _bzScopeTextController.text = _bz.scope;
    _currentBzCountry = _bz.zone.countryID;
    _currentBzCity = _bz.zone.cityID;
    _currentBzDistrict = _bz.zone.districtID;
    _bzAboutTextController.text =  _bz.about;
    _currentBzPosition = _bz.position;
    _currentBzContacts = _bz.contacts;
    _currentBzAuthors = _bz.authors;
    _currentBzShowsTeam = _currentBzShowsTeam;
    // -------------------------
    _currentAuthor = AuthorModel.getAuthorFromBzByAuthorID(_bz, widget.userModel.id);
    _authorNameTextController.text = _currentAuthor.name;
    _currentAuthorPicURL = _currentAuthor.pic;
    _authorTitleTextController.text = _currentAuthor.title;
    _currentAuthorContacts = _currentAuthor.contacts;
    // -------------------------
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    if (TextChecker.textControllerIsEmpty(_bzNameTextController))
      _bzNameTextController.dispose();
    if (TextChecker.textControllerIsEmpty(_bzScopeTextController))
      _bzScopeTextController.dispose();
    if (TextChecker.textControllerIsEmpty(_bzAboutTextController))
      _bzAboutTextController.dispose();
    if (TextChecker.textControllerIsEmpty(_authorNameTextController))
      _authorNameTextController.dispose();
    if (TextChecker.textControllerIsEmpty(_authorTitleTextController))
      _authorTitleTextController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _showBzCard () async {
    setState(() {});

    await BottomDialog.slideBzBottomDialog(
      context: context,
      bz: BzModel(
        id: '',
        bzType: _currentBzType,
        bzForm: _currentBzForm,
        createdAt: DateTime.now(),
        accountType: _currentAccountType,
        name: _bzNameTextController.text,
        trigram: TextGen.createTrigram(input: _bzNameTextController.text),
        logo: _currentBzLogoFile ?? _currentBzLogoURL,
        scope: _bzScopeTextController.text,
        zone: ZoneModel(
          countryID: _currentBzCountry,
          cityID: _currentBzCity,
          districtID: _currentBzDistrict,
        ),
        about: _bzAboutTextController.text,
        position: _currentBzPosition,
        contacts: _currentBzContacts,
        authors: _currentBzAuthors,
        showsTeam: _currentBzShowsTeam,
        isVerified: _bz.isVerified,
        bzState: _bz.bzState,
        totalFollowers: _bz.totalFollowers,
        totalSaves: _bz.totalSaves,
        totalShares: _bz.totalShares,
        totalSlides: _bz.totalSlides,
        totalViews: _bz.totalViews,
        totalCalls: _bz.totalCalls,
        flyersIDs: _bz.flyersIDs,
        totalFlyers: _bz.totalFlyers,
      ),
      author: AuthorModel(
        userID: '',
        // bzID: '',
        name: _authorNameTextController.text,
        title: _authorTitleTextController.text,
        pic: _currentAuthorPicFile ?? _currentAuthorPicURL,
        contacts: _currentAuthorContacts,
        isMaster: _currentAuthor.isMaster,
      ),
    );

  }
// -----------------------------------------------------------------------------
  void _selectASection(int index){
    setState(() {
      _currentSection = SectionClass.SectionsList[index];
      /// Task : FIX THIS SHIT
      _bzTypeInActivityList =

      _currentSection == Section.properties ?    <bool>[false, false, true, true, true, true, true] :
      _currentSection == Section.designs ?          <bool>[true, true, false, false, true, true, true] :
      _currentSection == Section.projects ?         <bool>[true, true, false, false, true, true, true] :
      _currentSection == Section.crafts ?           <bool>[true, true, true, true, false, true, true] :
      _currentSection == Section.products ?         <bool>[true, true, true, true, true, false, false] :
      _currentSection == Section.equipment ?        <bool>[true, true, true, true, true, false, false] :
      _bzTypeInActivityList;
    });
  }
// -----------------------------------------------------------------------------
  void _selectBzType(int index){
      setState(() {
        _currentBzType = BzModel.bzTypesList[index];
        _bzFormInActivityList =
        _currentBzType == BzType.developer ?      <bool>[true, false] :
        _currentBzType == BzType.broker ?         <bool>[false, false] :
        _currentBzType == BzType.designer ?       <bool>[false, false] :
        _currentBzType == BzType.contractor ?     <bool>[false, false] :
        _currentBzType == BzType.artisan ?        <bool>[false, false] :
        _currentBzType == BzType.manufacturer ?   <bool>[true, false] :
        _currentBzType == BzType.supplier ?       <bool>[true, false] :
        _bzFormInActivityList;
        // _currentBz.bzType = _currentBzType;
      });
  }
// -----------------------------------------------------------------------------
  void _createBzTypeInActivityList(){
    if(widget.firstTimer){
      setState(() {
        _bzTypeInActivityList = List<bool>.filled(BzModel.bzTypesList.length, true);
      });
    } else {
      /// TASK : FIX THIS SHIT

      final Section _section = SectionClass.getSectionByBzType(_currentBzType);

      setState(() {
        _currentSection = _section;
      });

      // _bzTypeInActivityList =
      // _currentSection == Section.NewProperties ?  <bool>[false, false, true, true, true, true, true] :
      // _currentSection == Section.Projects ?       <bool>[true, true, false, false, false, true, true, true] :
      // _currentSection == Section.Products ?       <bool>[true, true, true, true, true, false, false, true] :
      // _bzTypeInActivityList;
    }
  }
// -----------------------------------------------------------------------------
  void _createBzFormInActivityLst(){
    if (widget.firstTimer){
      setState(() {
        _bzFormInActivityList = List<bool>.filled(BzModel.bzFormsList.length, true);
      });
    } else {
      _bzFormInActivityList =
      _currentBzType == BzType.developer ?      <bool>[true, false] :
      _currentBzType == BzType.broker ?         <bool>[false, false] :
      _currentBzType == BzType.designer ?       <bool>[false, false] :
      _currentBzType == BzType.contractor ?     <bool>[false, false] :
      _currentBzType == BzType.artisan ?        <bool>[false, false] :
      _currentBzType == BzType.manufacturer ?   <bool>[true, false] :
      _currentBzType == BzType.supplier ?       <bool>[true, false] :
      _bzFormInActivityList;
    }
  }
// -----------------------------------------------------------------------------
  Future<void> _takeBzLogo() async {
    final File _imageFile = await Imagers.takeGalleryPicture(picType: PicType.bzLogo);
    setState(() {_currentBzLogoFile = _imageFile;});
  }
// -----------------------------------------------------------------------------
  Future<void> _takeAuthorPicture() async {
    final File _imageFile = await Imagers.takeGalleryPicture(picType: PicType.authorPic);
    setState(() {_currentAuthorPicFile = File(_imageFile.path);});
  }
// -----------------------------------------------------------------------------
  /// TASK : create bzEditors validators for bubbles instead of this basic null checker
  /// TASK : need to validate inputs creating new bz
  bool _inputsAreValid(){
    // final bool isValid = _form.currentState.validate();
    // if(!isValid){return;}
    // _form.currentState.save();

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    bool _inputsAreValid;
    if (
    _currentBzType == null ||
        _currentBzForm == null ||
        _bzNameTextController.text == null ||
        _bzNameTextController.text.length < 3 ||
        _currentBzLogoFile == null ||
        _bzScopeTextController.text == null ||
        _bzScopeTextController.text.length < 3 ||
        _currentBzCountry == null ||
        _currentBzCity == null ||
        _currentBzDistrict == null ||
        _bzAboutTextController.text == null ||
        _bzAboutTextController.text.length < 6
        // _currentBzContacts.length == 0 ||
        // _currentBzShowsTeam == null
    ) {
      _inputsAreValid = false;
    } else {
      _inputsAreValid = true;
    }


    /// TASK : temp bzEditor validator = true
    return _inputsAreValid;
    }
// -----------------------------------------------------------------------------
  /// create new bzModel with current data and start createBzOps
  Future<void> _createNewBz() async {
    /// assert that all required fields are added and valid
    if (_inputsAreValid() == false) {

      /// TASK : add error missing data indicator in UI bubbles
      await CenterDialog.showCenterDialog(
        context: context,
        title: '',
        body: 'Please add all required fields',
        boolDialog: false,
      );

    } else {

      _triggerLoading();

      /// create new master AuthorModel
      final AuthorModel _firstMasterAuthor = AuthorModel(
        userID: widget.userModel.id,
        name: _authorNameTextController.text,
        pic: _currentAuthorPicFile, // if null createBzOps uses user.pic URL instead
        title: _authorTitleTextController.text,
        isMaster: true,
        contacts: _currentAuthorContacts,
      );
      final List<AuthorModel> _firstTimeAuthorsList = <AuthorModel>[_firstMasterAuthor,];

      /// create new first time bzModel
      final BzModel _newBzModel = BzModel(
        id: null, // will be generated in createBzOps
        // -------------------------
        bzType: _currentBzType,
        bzForm: _currentBzForm,
        createdAt: null, // timestamp will be generated inside createBzOps
        accountType: BzAccountType.normal, // changing this is not in bzEditor
        // -------------------------
        name: _bzNameTextController.text,
        trigram: TextGen.createTrigram(input: _bzNameTextController.text),
        logo: _currentBzLogoFile,
        scope: _bzScopeTextController.text,
        zone: ZoneModel(
          countryID: _currentBzCountry,
          cityID: _currentBzCity,
          districtID: _currentBzDistrict,
        ),
        about: _bzAboutTextController.text,
        position: _currentBzPosition,
        contacts: _currentBzContacts,
        authors: _firstTimeAuthorsList,
        showsTeam: _currentBzShowsTeam,
        // -------------------------
        isVerified: false,
        bzState: BzState.offline,
        // -------------------------
        totalFollowers: 0,
        totalSaves: 0,
        totalShares: 0,
        totalSlides: 0,
        totalViews: 0,
        totalCalls: 0,
        // -------------------------
        flyersIDs: <String>[],
        totalFlyers: 0,
      );

      /// start createBzOps
      final BzModel _bzModel = await FireBzOps.createBz(
          context: context,
          inputBz : _newBzModel,
          userModel: widget.userModel
      );


      /// add the final _bzModel to _userBzz
      _bzzProvider.addBzToUserBzz(_bzModel);

      _triggerLoading();

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Great !',
        body: 'Successfully added your Business Account',
        boolDialog: false,
      );

      Nav.goBack(context);

    }

  }
// -----------------------------------------------------------------------------
  /// create updated bzModel with changed data and start updateBzOps
  Future<void> _updateExistingBz() async {

    if (_inputsAreValid() == false) {

      await CenterDialog.showCenterDialog(
        context: context,
        title: '',
        body: 'Please add all required fields',
        boolDialog: false,
      );

    } else {

      _triggerLoading();

      /// create modified authorModel
      final AuthorModel _newAuthor = AuthorModel(
        userID: widget.userModel.id,
        name: _authorNameTextController.text,
        pic: _currentAuthorPicFile ?? _currentAuthorPicURL,
        title: _authorTitleTextController.text,
        isMaster: _currentAuthor.isMaster,
        contacts: _currentAuthorContacts,
      );

      final AuthorModel _oldAuthor = AuthorModel.getAuthorFromBzByAuthorID(widget.bzModel, widget.userModel.id);

      final List<AuthorModel> _modifiedAuthorsList = AuthorModel.replaceAuthorModelInAuthorsList(
        originalAuthors: _currentBzAuthors,
        oldAuthor: _oldAuthor,
        newAuthor: _newAuthor,
      );

      /// create modified bzModel
      final BzModel _modifiedBzModel = BzModel(
        id: widget.bzModel.id,
        // -------------------------
        bzType: _currentBzType,
        bzForm: _currentBzForm,
        createdAt: widget.bzModel.createdAt,
        accountType: _currentAccountType,
        // -------------------------
        name: _bzNameTextController.text,
        trigram: TextGen.createTrigram(input: _bzNameTextController.text),
        logo: _currentBzLogoFile ?? _currentBzLogoURL,
        scope: _bzScopeTextController.text,
        zone: ZoneModel(
          countryID: _currentBzCountry,
          cityID: _currentBzCity,
          districtID: _currentBzDistrict,
        ),
        about: _bzAboutTextController.text,
        position: _currentBzPosition,
        contacts: _currentBzContacts,
        authors: _modifiedAuthorsList,
        showsTeam: _currentBzShowsTeam,
        // -------------------------
        isVerified: widget.bzModel.isVerified,
        bzState: widget.bzModel.bzState,
        // -------------------------
        totalFollowers: widget.bzModel.totalFollowers,
        totalSaves: widget.bzModel.totalSaves,
        totalShares: widget.bzModel.totalShares,
        totalSlides: widget.bzModel.totalSlides,
        totalViews: widget.bzModel.totalViews,
        totalCalls: widget.bzModel.totalCalls,
        // -------------------------
        flyersIDs: widget.bzModel.flyersIDs,
        totalFlyers: widget.bzModel.totalFlyers,
      );

      /// start updateBzOps
      final BzModel _finalBzModel = await FireBzOps.updateBz(
        context: context,
        modifiedBz: _modifiedBzModel,
        originalBz: _bz,
        bzLogoFile: _currentBzLogoFile,
        authorPicFile: _currentAuthorPicFile,
      );


      /// update _bzModel in local list of _userTinyBz
      await _bzzProvider.updateBzInUserBzz(_finalBzModel);

      _triggerLoading();

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Great !',
        body: 'Successfully updated your Business Account',
        boolDialog: false,
      );

      Nav.goBack(context, argument: true);
    }

    }
// -----------------------------------------------------------------------------
  Future<void> _confirmButton() async {
    // TASK : create bool dialog and use it here before confirming bz edits in bzEditor
    // temp solution here below to just notify
      bool _continueOps = await CenterDialog.showCenterDialog(
        context: context,
        title: '',
        body: 'Are you sure you want to continue ?',
        boolDialog: true,
      );

      _continueOps = true;
      if (_continueOps == true){
        widget.firstTimer ? _createNewBz() : _updateExistingBz();
      }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _bzAboutBubbleTitle = Wordz.about(context);

    // _bzNameTextController.text == null || _bzNameTextController.text == '' ?
    // '${Wordz.about(context)} ${Wordz.yourBusiness(context)}' :
    // '${Wordz.about(context)} ${_bzNameTextController.text}';

    print('bzZone is : countryID : $_currentBzCountry : cityID : $_currentBzCity : districtID : $_currentBzDistrict');

    return MainLayout(
      loading: _loading,
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      skyType: SkyType.Black,
      pageTitle: widget.firstTimer == true ? Wordz.createBzAccount(context) : 'Edit Business account info', // createBzAccount
      // appBarBackButton: true,
      layoutWidget: Stack(
        children: <Widget>[

          ///--- BUBBLES
          ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              const Stratosphere(),

              /// --- CHOOSE SECTION
              MultipleChoiceBubble(
                title: Wordz.sections(context),
                buttonsList: TextGen.sectionsListStrings(context),
                tappingAButton: _selectASection,
                chosenButton: TextGen.sectionStringer(context, _currentSection),
              ),

              /// --- CHOOSE BzType
              MultipleChoiceBubble(
                title: 'Profession',
                buttonsList: TextGen.bzTypesStrings(context),
                tappingAButton: _selectBzType,
                chosenButton: TextGen.bzTypeSingleStringer(context, _currentBzType),
                buttonsInActivityList: _bzTypeInActivityList,
              ),

              /// --- CHOOSE BzForm
              MultipleChoiceBubble(
                title: Wordz.businessForm(context),
                buttonsList: TextGen.bzFormStrings(context),
                tappingAButton: (index) => setState(() {_currentBzForm = BzModel.bzFormsList[index];}),
                chosenButton: TextGen.bzFormStringer(context, _currentBzForm),
                buttonsInActivityList: _bzFormInActivityList,
              ),

              const BubblesSeparator(),

              /// --- ADD LOGO
              AddGalleryPicBubble(
                pic: _currentBzLogoFile == null ? _currentBzLogoURL : _currentBzLogoFile,
                addBtFunction: _takeBzLogo,
                deletePicFunction: () => setState(() {_currentBzLogoFile = null;}),
                title: Wordz.businessLogo(context),
                bubbleType: BubbleType.bzLogo,
              ),

              /// --- type BzName
              TextFieldBubble(
                textController: _bzNameTextController,
                key: const Key('bzName'),
                title: _currentBzForm == BzForm.individual ? 'Business Entity name' : Wordz.companyName(context),
                hintText: '...',
                counterIsOn: true,
                maxLength: 72,
                maxLines: 2,
                keyboardTextInputType: TextInputType.name,
                fieldIsRequired: true,
                fieldIsFormField: true,
              ),

              /// --- type BzScope
              TextFieldBubble(
                textController: _bzScopeTextController,
                key: const Key('bzScope'),
                title: '${Wordz.scopeOfServices(context)} :',
                hintText: '...',
                counterIsOn: true,
                maxLength: 500,
                maxLines: 4,
                keyboardTextInputType: TextInputType.multiline,
                fieldIsRequired: true,
                fieldIsFormField: true,
              ),

              /// --- type BzAbout
              TextFieldBubble(
                textController: _bzAboutTextController,
                key: const Key('bzAbout'),
                title: _bzAboutBubbleTitle,
                hintText: '...',
                counterIsOn: true,
                maxLength: 193,
                maxLines: 4,
                keyboardTextInputType: TextInputType.multiline,
              ),

              const BubblesSeparator(),

              /// --- bzLocale
              LocaleBubble(
                changeCountry : (String countryID) => setState(() {_currentBzCountry = countryID;}),
                changeCity : (String cityID) => setState(() {_currentBzCity = cityID;}),
                changeDistrict : (String districtID) => setState(() {_currentBzDistrict = districtID;}),
                currentZone: ZoneModel(countryID: _currentBzCountry, cityID: _currentBzCity, districtID: _currentBzDistrict),
                title: 'Headquarters District',//Wordz.hqCity(context),
              ),

              const BubblesSeparator(),

              /// --- type AuthorName
              TextFieldBubble(
                textController: _authorNameTextController,
                key: const Key('authorName'),
                title: Wordz.authorName(context),
                hintText: '...',
                counterIsOn: true,
                maxLength: 20,
                maxLines: 1,
                keyboardTextInputType: TextInputType.name,
                fieldIsRequired: true,
                fieldIsFormField: true,
              ),

              /// --- type AuthorTitle
              TextFieldBubble(
                textController: _authorTitleTextController,
                key: const Key('authorTitle'),
                title: Wordz.jobTitle(context),
                hintText: '...',
                counterIsOn: true,
                maxLength: 20,
                maxLines: 1,
                keyboardTextInputType: TextInputType.name,
                fieldIsRequired: true,
                fieldIsFormField: true,
              ),

              /// --- ADD AUTHOR PIC
              AddGalleryPicBubble(
                pic: _currentAuthorPicFile ?? _currentAuthorPicURL,
                addBtFunction: _takeAuthorPicture,
                deletePicFunction: () => setState(() {_currentAuthorPicFile = null;}),
                title: 'Add a professional picture of yourself',
                bubbleType: BubbleType.authorPic,
              ),

              const PyramidsHorizon(),

            ],
          ),

          /// ---  BOTTOM BUTTONS
          Positioned(
            bottom: 0,
            left: 0,
            child: Row(
              children: <Widget>[

                /// --- SHOW BZCARD
                DreamBox(
                  height: 50,
                  color: Colorz.blue225,
                  icon: Iconz.Flyer,
                  iconSizeFactor: 0.7,
                  verse: 'Show\nFlyer',
                  verseScaleFactor: 0.8,
                  verseColor: Colorz.black230,
                  verseMaxLines: 2,
                  margins: const EdgeInsets.all(5),
                  onTap: _showBzCard,
                ),

                /// --- CONFIRM BUTTON
                DreamBox(
                  height: 50,
                  color: Colorz.yellow255,
                  verseColor: Colorz.black230,
                  verseWeight: VerseWeight.black,
                  verse: 'Confirm',
                  secondLine: widget.firstTimer ? 'Create new business profile' : 'Update business profile',
                  verseScaleFactor: 0.7,
                  margins: const EdgeInsets.all(5),
                  onTap: _confirmButton,
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}

