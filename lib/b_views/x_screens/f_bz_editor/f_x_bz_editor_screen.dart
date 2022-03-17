import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/profile_editors/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzEditorScreen({
    @required this.userModel,
    this.firstTimer = false,
    this.bzModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool firstTimer;
  final UserModel userModel;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  _BzEditorScreenState createState() => _BzEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _BzEditorScreenState extends State<BzEditorScreen> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BzzProvider _bzzProvider;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(loading: _loading.value);
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _initializeBzModelVariables();
    _initializeHelperVariables();

    blog('at start : ${widget.bzModel.bzTypes} : ${_initialBzModel.bzTypes} : ${_selectedBzTypes.value} : ${_selectedBzSection.value}');
  }
// -----------------------------------------------------------------------------

  /// LOCAL BZ MODEL VARIABLES

  // -------------------------
  BzModel _initialBzModel;
  // -------------------------
  /// String _bzID; // NOT REQUIRED HERE
  ValueNotifier<List<BzType>> _selectedBzTypes;
  ValueNotifier<BzForm> _selectedBzForm;
  /// DateTime _createdAt; // NOT REQUIRED HERE
  /// BzAccountType _accountType // NOT REQUIRED HERE
  // -------------------------
  TextEditingController _bzNameTextController;
  ValueNotifier<dynamic> _bzLogo;
  TextEditingController _bzScopeTextController;
  ValueNotifier<ZoneModel> _bzZone;
  TextEditingController _bzAboutTextController;
  ValueNotifier<GeoPoint> _bzPosition;
  ValueNotifier<List<ContactModel>> _bzContacts;
  /// List<AuthorModel> _bzAuthors; // NOT REQUIRED HERE
  /// bool _bzShowsTeam; // NOT REQUIRED HERE
  // -------------------------
  /// bool _bzIsVerified; // NOT REQUIRED HERE
  /// bool _bzState; // NOT REQUIRED HERE
  /// FOLLOWERS / SAVES / SHARES / SLIDES / VIEWS / CALLS : NOT REQUIRED HERE
  /// FLYERS IDS / TOTAL FLYERS : NOT REQUIRED HERE
  // -------------------------
  void _initializeBzModelVariables(){
    // -------------------------
    _initialBzModel = widget.firstTimer == true ?
    BzModel.createInitialBzModelFromUserData(widget.userModel)
        :
    widget.bzModel;
    // -------------------------
    _selectedBzTypes = ValueNotifier(_initialBzModel.bzTypes);
    _selectedBzForm = ValueNotifier(_initialBzModel.bzForm);
    _bzNameTextController = TextEditingController(text: _initialBzModel.name);
    _bzLogo = ValueNotifier(_initialBzModel.logo);
    _bzScopeTextController = TextEditingController(text: _initialBzModel.scope);
    _bzZone = ValueNotifier(_initialBzModel.zone);
    _bzAboutTextController = TextEditingController(text: _initialBzModel.about);
    _bzPosition = ValueNotifier(_initialBzModel.position);
    _bzContacts = ValueNotifier(_initialBzModel.contacts);
    // -------------------------
  }
// -----------------------------------------------------------------------------

  /// HELPER VARIABLES
  
// -------------------------------------
  ValueNotifier<BzSection> _selectedBzSection;
  ValueNotifier<List<BzType>> _inactiveBzTypes;
  ValueNotifier<List<BzForm>> _inactiveBzForms;
// -------------------------------------
  void _initializeHelperVariables(){
    final BzSection _concludedBzSection = BzModel.concludeBzSectionByBzTypes(_initialBzModel.bzTypes);
    final List<BzType> _concludedInactiveBzTypes = BzModel.generateInactiveBzTypes(_concludedBzSection);
    final List<BzForm> _concludedInactiveBzForms = BzModel.generateInactiveBzForms(_concludedInactiveBzTypes);
    _selectedBzSection  = ValueNotifier(_concludedBzSection);
    _inactiveBzTypes = ValueNotifier(_concludedInactiveBzTypes);
    _inactiveBzForms = ValueNotifier(_concludedInactiveBzForms);
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    _disposeControllers();
  }
// -----------------------------------------------------------------------------
  void _disposeControllers(){
    TextChecker.disposeControllerIfPossible(_bzNameTextController);
    TextChecker.disposeControllerIfPossible(_bzScopeTextController);
    TextChecker.disposeControllerIfPossible(_bzAboutTextController);
  }
// -----------------------------------------------------------------------------
  void _onSelectSection(int index){
    final BzSection _selectedSection = BzModel.bzSectionsList[index];

    final List<BzType> _generatedInactiveBzTypes = BzModel.generateInactiveBzTypes(_selectedSection);

    _selectedBzSection.value = _selectedSection;
    _inactiveBzTypes.value = _generatedInactiveBzTypes;
    _selectedBzTypes.value = <BzType>[];
  }
// -------------------------------------
  void _onSelectBzType(int index){

    final BzType _selectedBzType = BzModel.bzTypesList[index];

    final bool _alreadySelected = BzModel.bzTypesContainThisType(
      bzTypes: _selectedBzTypes.value,
      bzType: _selectedBzType,
    );

    final bool _canMixWithSelectedTypes = BzModel.canMixWithSelectedTypes(
      bzTypes: _selectedBzTypes.value,
      bzType: _selectedBzType,
    );

    if (_alreadySelected == true){
      final List<BzType> _bzTypes = <BzType>[..._selectedBzTypes.value];
      _bzTypes.remove(_selectedBzType);
      _selectedBzTypes.value = _bzTypes;

      // _selectedBzTypes.value.remove(_selectedBzType);
    }

    else {
      final List<BzType> _bzTypes = <BzType>[..._selectedBzTypes.value];
      _bzTypes.add(_selectedBzType);
      _selectedBzTypes.value = _bzTypes;

      // _selectedBzTypes.value.add(_selectedBzType);
    }

    if (_selectedBzSection.value == BzSection.construction){
      final List<BzType> _newInactiveBzTypes = BzModel.inactivateCraftsmenCondition(
        selectedBzTypes: _selectedBzTypes.value,
        inactiveBzTypes: _inactiveBzTypes.value,
      );
      _inactiveBzTypes.value = _newInactiveBzTypes;
    }

    final List<BzForm> _generatedInactiveBzForms = BzModel.generateInactiveBzForms(_selectedBzTypes.value);
    _inactiveBzForms.value = _generatedInactiveBzForms;

    blog('_selectedBzTypes.value : ${_selectedBzTypes.value} : _inactiveBzTypes.value : ${_inactiveBzTypes.value}');

  }
// -------------------------------------
  void _onSelectBzForm(int index){
    _selectedBzForm.value = BzModel.bzFormsList[index];
  }
// -----------------------------------------------------------------------------
  Future<void> _takeBzLogo() async {

    final File _imageFile = await Imagers.takeGalleryPicture(
        picType: Imagers.PicType.bzLogo
    );

    _bzLogo.value = _imageFile;

  }
// -----------------------------------------------------------------------------
  /// TASK : create bzEditors validators for bubbles instead of this basic null checker
  /// TASK : need to validate inputs creating new bz
  bool _inputsAreValid() {
    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    final bool isValid = _formKey.currentState.validate();
    // if(!isValid){return;}
    // _form.currentState.save();

    final BzModel _bzModel = _createBzModelFromLocalVariables();
    final List<String> _missingFields = BzModel.requiredFields(_bzModel);

    final List<String> _invalidFields = <String>[];

    return isValid;

    // bool _inputsAreValid;
    // if (_currentBzType == null ||
    //     _currentBzForm == null ||
    //     _bzNameTextController.text == null ||
    //     _bzNameTextController.text.length < 3 ||
    //     _currentBzLogoFile == null ||
    //     _bzScopeTextController.text == null ||
    //     _bzScopeTextController.text.length < 3 ||
    //     _currentBzCountry == null ||
    //     _currentBzCity == null ||
    //     _currentBzDistrict == null ||
    //     _bzAboutTextController.text == null ||
    //     _bzAboutTextController.text.length < 6
    //     // _currentBzContacts.length == 0 ||
    //     // _currentBzShowsTeam == null
    //     ) {
    //   _inputsAreValid = false;
    // } else {
    //   _inputsAreValid = true;
    // }
    //
    // /// TASK : temp bzEditor validator = true
    // return _inputsAreValid;
  }
// -----------------------------------------------------------------------------
  BzModel _createBzModelFromLocalVariables(){

    final BzModel _bzModel = BzModel(
      id: _initialBzModel.id,
      bzTypes: _selectedBzTypes.value,
      bzForm: _selectedBzForm.value,
      createdAt: _initialBzModel.createdAt,
      accountType: _initialBzModel.accountType,
      name: _bzNameTextController.text,
      trigram: TextGen.createTrigram(input: _bzNameTextController.text),
      logo: _bzLogo.value,
      scope: _bzScopeTextController.text,
      zone: _bzZone.value,
      about: _bzAboutTextController.text,
      position: _bzPosition.value,
      contacts: _bzContacts.value,
      authors: _initialBzModel.authors,
      showsTeam: _initialBzModel.showsTeam,
      isVerified: _initialBzModel.isVerified,
      bzState: _initialBzModel.bzState,
      totalFollowers: _initialBzModel.totalFollowers,
      totalSaves: _initialBzModel.totalSaves,
      totalShares: _initialBzModel.totalShares,
      totalSlides: _initialBzModel.totalSlides,
      totalViews: _initialBzModel.totalViews,
      totalCalls: _initialBzModel.totalCalls,
      flyersIDs: _initialBzModel.flyersIDs,
      totalFlyers: _initialBzModel.totalFlyers,
    );

    return _bzModel;
  }
// -----------------------------------------------------------------------------
  /// create new bzModel with current data and start createBzOps
  Future<void> _createNewBz() async {
    // /// assert that all required fields are added and valid
    // if (_inputsAreValid() == false) {
    //
    //   /// TASK : add error missing data indicator in UI bubbles
    //   await CenterDialog.showCenterDialog(
    //     context: context,
    //     title: '',
    //     body: 'Please add all required fields',
    //   );
    //
    // }
    //
    // else {
    //   unawaited(_triggerLoading());
    //
    //   /// create new master AuthorModel
    //   final AuthorModel _firstMasterAuthor = AuthorModel(
    //     userID: widget.userModel.id,
    //     name: _authorNameTextController.text,
    //     pic:
    //         _currentAuthorPicFile, // if null createBzOps uses user.pic URL instead
    //     title: _authorTitleTextController.text,
    //     isMaster: true,
    //     contacts: _currentAuthorContacts,
    //   );
    //   final List<AuthorModel> _firstTimeAuthorsList = <AuthorModel>[
    //     _firstMasterAuthor,
    //   ];
    //
    //   /// create new first time bzModel
    //   final BzModel _newBzModel = BzModel(
    //     id: null, // will be generated in createBzOps
    //     // -------------------------
    //     bzTypes: _currentBzType,
    //     bzForm: _currentBzForm,
    //     createdAt: null, // timestamp will be generated inside createBzOps
    //     accountType: BzAccountType.normal, // changing this is not in bzEditor
    //     // -------------------------
    //     name: _bzNameTextController.text,
    //     trigram: TextGen.createTrigram(input: _bzNameTextController.text),
    //     logo: _currentBzLogoFile,
    //     scope: _bzScopeTextController.text,
    //     zone: ZoneModel(
    //       countryID: _currentBzCountry,
    //       cityID: _currentBzCity,
    //       districtID: _currentBzDistrict,
    //     ),
    //     about: _bzAboutTextController.text,
    //     position: _currentBzPosition,
    //     contacts: _currentBzContacts,
    //     authors: _firstTimeAuthorsList,
    //     showsTeam: _currentBzShowsTeam,
    //     // -------------------------
    //     isVerified: false,
    //     bzState: BzState.offline,
    //     // -------------------------
    //     totalFollowers: 0,
    //     totalSaves: 0,
    //     totalShares: 0,
    //     totalSlides: 0,
    //     totalViews: 0,
    //     totalCalls: 0,
    //     // -------------------------
    //     flyersIDs: <String>[],
    //     totalFlyers: 0,
    //   );
    //
    //   /// start createBzOps
    //   final BzModel _bzModel = await FireBzOps.createBz(
    //       context: context,
    //       inputBz: _newBzModel,
    //       userModel: widget.userModel,
    //   );
    //
    //   /// add the final _bzModel to _userBzz
    //   _bzzProvider.addBzToMyBzz(_bzModel);
    //
    //   unawaited(_triggerLoading());
    //
    //   await CenterDialog.showCenterDialog(
    //     context: context,
    //     title: 'Great !',
    //     body: 'Successfully added your Business Account',
    //   );
    //
    //   Nav.goBack(context);
    // }
  }
// -----------------------------------------------------------------------------
  /// create updated bzModel with changed data and start updateBzOps
  Future<void> _updateExistingBz() async {
    // if (_inputsAreValid() == false) {
    //   await CenterDialog.showCenterDialog(
    //     context: context,
    //     title: '',
    //     body: 'Please add all required fields',
    //   );
    // }
    //
    // else {
    //   unawaited(_triggerLoading());
    //
    //   /// create modified authorModel
    //   final AuthorModel _newAuthor = AuthorModel(
    //     userID: widget.userModel.id,
    //     name: _authorNameTextController.text,
    //     pic: _currentAuthorPicFile ?? _currentAuthorPicURL,
    //     title: _authorTitleTextController.text,
    //     isMaster: _currentAuthor.isMaster,
    //     contacts: _currentAuthorContacts,
    //   );
    //
    //   final AuthorModel _oldAuthor = AuthorModel.getAuthorFromBzByAuthorID(
    //       widget.bzModel, widget.userModel.id);
    //
    //   final List<AuthorModel> _modifiedAuthorsList = AuthorModel.replaceAuthorModelInAuthorsList(
    //     originalAuthors: _currentBzAuthors,
    //     oldAuthor: _oldAuthor,
    //     newAuthor: _newAuthor,
    //   );
    //
    //   /// create modified bzModel
    //   final BzModel _modifiedBzModel = BzModel(
    //     id: widget.bzModel.id,
    //     // -------------------------
    //     bzTypes: _currentBzType,
    //     bzForm: _currentBzForm,
    //     createdAt: widget.bzModel.createdAt,
    //     accountType: _currentAccountType,
    //     // -------------------------
    //     name: _bzNameTextController.text,
    //     trigram: TextGen.createTrigram(input: _bzNameTextController.text),
    //     logo: _currentBzLogoFile ?? _currentBzLogoURL,
    //     scope: _bzScopeTextController.text,
    //     zone: ZoneModel(
    //       countryID: _currentBzCountry,
    //       cityID: _currentBzCity,
    //       districtID: _currentBzDistrict,
    //     ),
    //     about: _bzAboutTextController.text,
    //     position: _currentBzPosition,
    //     contacts: _currentBzContacts,
    //     authors: _modifiedAuthorsList,
    //     showsTeam: _currentBzShowsTeam,
    //     // -------------------------
    //     isVerified: widget.bzModel.isVerified,
    //     bzState: widget.bzModel.bzState,
    //     // -------------------------
    //     totalFollowers: widget.bzModel.totalFollowers,
    //     totalSaves: widget.bzModel.totalSaves,
    //     totalShares: widget.bzModel.totalShares,
    //     totalSlides: widget.bzModel.totalSlides,
    //     totalViews: widget.bzModel.totalViews,
    //     totalCalls: widget.bzModel.totalCalls,
    //     // -------------------------
    //     flyersIDs: widget.bzModel.flyersIDs,
    //     totalFlyers: widget.bzModel.totalFlyers,
    //   );
    //
    //   /// start updateBzOps
    //   final BzModel _finalBzModel = await FireBzOps.updateBz(
    //     context: context,
    //     modifiedBz: _modifiedBzModel,
    //     originalBz: _initialBzModel,
    //     bzLogoFile: _currentBzLogoFile,
    //     authorPicFile: _currentAuthorPicFile,
    //   );
    //
    //   /// update _bzModel in local list of _userTinyBz
    //   await _bzzProvider.updateBzInUserBzz(_finalBzModel);
    //
    //   unawaited(_triggerLoading());
    //
    //   await CenterDialog.showCenterDialog(
    //     context: context,
    //     title: 'Great !',
    //     body: 'Successfully updated your Business Account',
    //   );
    //
    //   Nav.goBack(context, argument: true);
    // }
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
    if (_continueOps == true) {
      widget.firstTimer ? await _createNewBz() : await _updateExistingBz();
    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _bzAboutBubbleTitle = Wordz.about(context);

    return MainLayout(
      // loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      historyButtonIsOn: false,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      pageTitle: widget.firstTimer == true ?
      Wordz.createBzAccount(context)
          :
      'Edit Business account info', // createBzAccount
      // appBarBackButton: true,
      layoutWidget: Stack(
        children: <Widget>[

          ///--- BUBBLES
          Form(
            key: _formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[

                const Stratosphere(),

                /// --- SECTION SELECTION
                ValueListenableBuilder(
                    key: const ValueKey<String>('section_selection_bubble'),
                    valueListenable: _selectedBzSection,
                    builder: (_, BzSection selectedSection, Widget child){

                      final String _selectedButton = BzModel.translateBzSection(
                        context: context,
                        bzSection: selectedSection,
                      );

                      final List<String> _allSections = BzModel.translateBzSections(
                        context: context,
                        bzSections: BzModel.bzSectionsList,
                      );

                      return MultipleChoiceBubble(
                        title: Wordz.sections(context),
                        buttonsList: _allSections,
                        selectedButtons: <String>[_selectedButton],
                        onButtonTap: _onSelectSection,
                      );

                    }
                ),

                /// --- BZ TYPE SELECTION
                ValueListenableBuilder(
                    key: const ValueKey<String>('bzType _selection_bubble'),
                    valueListenable: _selectedBzTypes,
                    builder: (_, List<BzType> selectedBzTypes, Widget child){

                      final List<String> _selectedButtons = BzModel.translateBzTypes(
                          context: context,
                          bzTypes: selectedBzTypes,
                          pluralTranslation: false,
                      );

                      final List<String> _allButtons = BzModel.translateBzTypes(
                        context: context,
                        bzTypes: BzModel.bzTypesList,
                        pluralTranslation: false,
                      );

                      return ValueListenableBuilder(
                          valueListenable: _inactiveBzTypes,
                          builder: (_, List<BzType> inactiveBzTypes, Widget child){

                            final List<String> _inactiveButtons = BzModel.translateBzTypes(
                              context: context,
                              bzTypes: inactiveBzTypes,
                              pluralTranslation: false,
                            );

                            return MultipleChoiceBubble(
                              title: 'Business Entity type',
                              buttonsList: _allButtons,
                              onButtonTap: _onSelectBzType,
                              selectedButtons: _selectedButtons,
                              inactiveButtons: _inactiveButtons,
                            );

                          }
                      );

                    }
                ),

                /// --- BZ FORM SELECTION
                ValueListenableBuilder(
                    valueListenable: _selectedBzForm,
                    builder: (_, BzForm selectedBzForm, Widget child){

                      final List<String> _buttonsList = BzModel.translateBzForms(
                        context: context,
                        bzForms: BzModel.bzFormsList,
                      );

                      final String _selectedButton = BzModel.translateBzForm(
                        context: context,
                        bzForm: selectedBzForm,
                      );

                      return ValueListenableBuilder(
                        valueListenable: _inactiveBzForms,
                        builder: (_, List<BzForm> inactiveBzForms, Widget child){

                          final List<String> _inactiveButtons = BzModel.translateBzForms(
                            context: context,
                            bzForms: inactiveBzForms,
                          );

                          return MultipleChoiceBubble(
                            title: Wordz.businessForm(context),
                            buttonsList: _buttonsList,
                            onButtonTap: _onSelectBzForm,
                            selectedButtons: <String>[_selectedButton],
                            inactiveButtons: _inactiveButtons,
                          );

                        },
                      );

                    }
                ),

                const BubblesSeparator(),

                /// --- ADD LOGO
                // AddGalleryPicBubble(
                //   pic: _currentBzLogoFile ?? _currentBzLogoURL,
                //   onAddPicture: _takeBzLogo,
                //   onDeletePicture: () => setState(() {
                //     _currentBzLogoFile = null;
                //   }),
                //   title: Wordz.businessLogo(context),
                //   bubbleType: BubbleType.bzLogo,
                // ),

                /// --- BZ NAME
                ValueListenableBuilder(
                  valueListenable: _selectedBzForm,
                  builder: (_, BzForm selectedBzForm, Widget child){

                    final String _title = selectedBzForm == BzForm.individual
                        ? 'Business Entity name'
                        : Wordz.companyName(context);

                    return TextFieldBubble(
                      textController: _bzNameTextController,
                      key: const Key('bzName'),
                      title:_title,
                      counterIsOn: true,
                      maxLength: 72,

                      maxLines: 2,
                      keyboardTextInputType: TextInputType.name,
                      fieldIsRequired: true,
                      fieldIsFormField: true,
                    );

                  },
                ),

                /// --- BZ SCOPE
                TextFieldBubble(
                  textController: _bzScopeTextController,
                  key: const Key('bzScope'),
                  title: '${Wordz.scopeOfServices(context)} :',
                  counterIsOn: true,
                  maxLength: 500,
                  maxLines: 4,
                  keyboardTextInputType: TextInputType.multiline,
                  fieldIsRequired: true,
                  fieldIsFormField: true,
                ),

                /// --- BZ ABOUT
                TextFieldBubble(
                  textController: _bzAboutTextController,
                  key: const Key('bzAbout'),
                  title: _bzAboutBubbleTitle,
                  counterIsOn: true,
                  maxLength: 193,
                  maxLines: 4,
                  keyboardTextInputType: TextInputType.multiline,
                ),

                const BubblesSeparator(),

                /// --- bzLocale
                // ZoneSelectionBubble(
                //   changeCountry: (String countryID) => setState(() {
                //     _currentBzCountry = countryID;
                //   }),
                //   changeCity: (String cityID) => setState(() {
                //     _currentBzCity = cityID;
                //   }),
                //   changeDistrict: (String districtID) => setState(() {
                //     _currentBzDistrict = districtID;
                //   }),
                //   currentZone: ZoneModel(
                //       countryID: _currentBzCountry,
                //       cityID: _currentBzCity,
                //       districtID: _currentBzDistrict),
                //   title: 'Headquarters District', //Wordz.hqCity(context),
                // ),

                const BubblesSeparator(),


                const Horizon(),
              ],
            ),
          ),

          /// ---  BOTTOM BUTTONS
          Positioned(
            bottom: 0,
            left: 0,
            child: DreamBox(
              height: 50,
              color: Colorz.yellow255,
              verseColor: Colorz.black230,
              verseWeight: VerseWeight.black,
              verse: 'Confirm',
              secondLine: widget.firstTimer
                  ? 'Create new business profile'
                  : 'Update business profile',
              secondLineColor: Colorz.black255,
              verseScaleFactor: 0.7,
              margins: const EdgeInsets.all(5),
              onTap: _confirmButton,
            ),
          ),

        ],
      ),
    );
  }
}
