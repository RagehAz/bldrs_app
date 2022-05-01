import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/alert_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// PLAN : SAVE CURRENT STATES IN LDB IN CASE USER DIDN'T FINISH IN ONE SESSION
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
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BzzProvider _bzzProvider;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
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

    _blogCurrentStates();
  }
// -----------------------------------------------------------------------------
  void _blogCurrentStates(){
    blog('at START : ------------------------------------------ >');
    blog('_selectedBzSection : ${_selectedBzSection.value}');
    blog('_selectedBzTypes : ${_selectedBzTypes.value}');
    blog('_selectedBzForm : ${_selectedBzForm.value}');
    blog('_inactiveBzTypes : ${_inactiveBzTypes.value}');
    blog('_inactiveBzForms : ${_inactiveBzForms.value}');
    blog('at END : ------------------------------------------ EH EL KALAM>');
  }
// -----------------------------------------------------------------------------

  /// LOCAL BZ MODEL VARIABLES

  // -------------------------
  BzModel _initialBzModel;
  // -------------------------
  /// String _bzID; // NOT REQUIRED HERE
  ValueNotifier<List<BzType>> _selectedBzTypes; /// tamam disposed
  ValueNotifier<BzForm> _selectedBzForm; /// tamam disposed
  /// DateTime _createdAt; // NOT REQUIRED HERE
  /// BzAccountType _accountType // NOT REQUIRED HERE
  // -------------------------
  TextEditingController _bzNameTextController;
  ValueNotifier<dynamic> _bzLogo; /// tamam disposed
  TextEditingController _bzScopeTextController;
  ValueNotifier<ZoneModel> _bzZone; /// tamam disposed
  TextEditingController _bzAboutTextController;
  ValueNotifier<GeoPoint> _bzPosition; /// tamam disposed
  ValueNotifier<List<ContactModel>> _bzContacts; /// tamam disposed
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
  ValueNotifier<BzSection> _selectedBzSection; /// tamam disposed
  ValueNotifier<List<BzType>> _inactiveBzTypes; /// tamam disposed
  ValueNotifier<List<BzForm>> _inactiveBzForms; /// tamam disposed
// -------------------------------------
  void _initializeHelperVariables(){
    final BzSection _concludedBzSection = BzModel.concludeBzSectionByBzTypes(_initialBzModel.bzTypes);
    final List<BzType> _concludedInactiveBzTypes = BzModel.generateInactiveBzTypesBySection(
      bzSection: _concludedBzSection,
      initialBzTypes: _initialBzModel.bzTypes,
    );
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

    _missingFields.dispose();
    _loading.dispose();
    _selectedBzTypes.dispose();
    _selectedBzForm.dispose();
    _bzLogo.dispose();
    _bzZone.dispose();
    _bzPosition.dispose();
    _bzContacts.dispose();
    _selectedBzSection.dispose();
    _inactiveBzTypes.dispose();
    _inactiveBzForms.dispose();
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
    final List<BzType> _generatedInactiveBzTypes = BzModel.generateInactiveBzTypesBySection(
      bzSection: _selectedSection,
    );

    _selectedBzSection.value = _selectedSection;
    _inactiveBzTypes.value = _generatedInactiveBzTypes;
    _selectedBzTypes.value = <BzType>[];
    _selectedBzForm.value = null;
    _inactiveBzForms.value = null;

    _blogCurrentStates();
  }
// -------------------------------------
  void _onSelectBzType(int index){

    final BzType _selectedBzType = BzModel.bzTypesList[index];

    /// UPDATE SELECTED BZ TYPES
    _selectedBzTypes.value = BzModel.editSelectedBzTypes(
      selectedBzTypes: _selectedBzTypes.value,
      newSelectedBzType: _selectedBzType,
    );

    /// INACTIVE OTHER BZ TYPES
    _inactiveBzTypes.value = BzModel.generateInactiveBzTypesBasedOnCurrentSituation(
      newSelectedType: _selectedBzType,
      selectedBzTypes: _selectedBzTypes.value,
      selectedBzSection: _selectedBzSection.value,
    );

    /// INACTIVATE BZ FORMS
    _inactiveBzForms.value = BzModel.generateInactiveBzForms(_selectedBzTypes.value);

    /// UN SELECT BZ FORM
    _selectedBzForm.value = null;

    _blogCurrentStates();
  }
// -------------------------------------
  void _onSelectBzForm(int index){
    _selectedBzForm.value = BzModel.bzFormsList[index];

    _blogCurrentStates();
  }
// -----------------------------------------------------------------------------
  Future<void> _takeBzLogo() async {

    final File _imageFile = await Imagers.takeGalleryPicture(
        picType: Imagers.PicType.bzLogo
    );

    _bzLogo.value = _imageFile;

  }
// -------------------------------------
  void _onDeleteLogo(){
    _bzLogo.value = null;
  }
// -----------------------------------------------------------------------------
  void _onBzZoneChanged(ZoneModel zoneModel){
    _bzZone.value = zoneModel;
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<List<AlertModel>> _missingFields = ValueNotifier(<AlertModel>[]); /// tamam disposed
// -------------------------------------
  Future<bool> _validateInputs(BzModel bzModel) async {

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    bool _inputsAreValid = _formKey.currentState.validate();
    final List<AlertModel> _missingFieldsFound = BzModel.requiredFields(bzModel);

    if (_missingFieldsFound.isNotEmpty == true){

      _missingFields.value = _missingFieldsFound;

      final List<String> _missingFieldsValues = AlertModel.getAlertsIDs(_missingFieldsFound);
      final List<String> _missingFieldsStrings = getStringsFromDynamics(dynamics: _missingFieldsValues);
      final String _missingFieldsString = TextGen.generateStringFromStrings(_missingFieldsStrings);

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Complete Your Business profile',
        body:
        'Required fields :\n'
            '$_missingFieldsString',
      );

      _inputsAreValid = false;
    }

    return _inputsAreValid;
  }
// -------------------------------------
  BzModel _createBzModelFromLocalVariables(){

    final BzModel _bzModel = BzModel(
      id: _initialBzModel.id, /// WILL BE OVERRIDDEN IN CREATE BZ OPS
      bzTypes: _selectedBzTypes.value,
      bzForm: _selectedBzForm.value,
      createdAt: _initialBzModel.createdAt, /// WILL BE OVERRIDDEN
      accountType: _initialBzModel.accountType, /// NEVER CHANGED
      name: _bzNameTextController.text,
      trigram: TextGen.createTrigram(input: _bzNameTextController.text),
      logo: _bzLogo.value, /// WILL CHECK DATA TYPE
      scope: _bzScopeTextController.text,
      zone: _bzZone.value,
      about: _bzAboutTextController.text,
      position: _bzPosition.value,
      contacts: _bzContacts.value,
      authors: _initialBzModel.authors, /// NEVER CHANGED
      showsTeam: _initialBzModel.showsTeam, /// NEVER CHANGED
      isVerified: _initialBzModel.isVerified, /// NEVER CHANGED
      bzState: _initialBzModel.bzState, /// NEVER CHANGED
      totalFollowers: _initialBzModel.totalFollowers, /// NEVER CHANGED
      totalSaves: _initialBzModel.totalSaves, /// NEVER CHANGED
      totalShares: _initialBzModel.totalShares, /// NEVER CHANGED
      totalSlides: _initialBzModel.totalSlides, /// NEVER CHANGED
      totalViews: _initialBzModel.totalViews, /// NEVER CHANGED
      totalCalls: _initialBzModel.totalCalls, /// NEVER CHANGED
      flyersIDs: _initialBzModel.flyersIDs, /// NEVER CHANGED
      totalFlyers: _initialBzModel.totalFlyers, /// NEVER CHANGED
    );

    return _bzModel;
  }
// -------------------------------------
  Future<BzModel> _uploadBzModel(BzModel bzModel) async {
    final BzModel _uploadedBzModel = bzModel; /// TEMP

    // /// FIRST TIME TO CREATE BZ MODEL
    // if (widget.firstTimer == true){
    //   _uploadedBzModel = await FireBzOps.createBz(
    //         context: context,
    //         inputBz: bzModel,
    //         userModel: widget.userModel,
    //     );
    // }
    //
    // /// UPDATING EXISTING BZ MODEL
    // else {
    //     _uploadedBzModel = await FireBzOps.updateBz(
    //       context: context,
    //       modifiedBz: bzModel,
    //       originalBz: _initialBzModel,
    //       bzLogoFile: _currentBzLogoFile,
    //       authorPicFile: _currentAuthorPicFile,
    //     );
    // }

    /// SHOULD BE NULL IF FAILED TO UPLOAD
    return _uploadedBzModel;
  }
// -------------------------------------
  bool _uploadOpsSucceeded(BzModel uploadedBzModel){
    bool _opsSucceeded;

    if (uploadedBzModel == null){
      _opsSucceeded = false;
    }

    else {
      _opsSucceeded = true;
    }

    return _opsSucceeded;
  }
// -------------------------------------
  Future<void> _setNewBzModelLocally({
    @required BzModel uploadedBzModel,
    @required bool uploadOpsSucceeded,
  }) async {

    if (uploadOpsSucceeded == true){
      await _bzzProvider.updateBzInUserBzz(uploadedBzModel);
    }

  }
// -------------------------------------
  Future<bool> _showConfirmationDialog() async {

    final bool _continueOps = await CenterDialog.showCenterDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to continue ?',
      boolDialog: true,
    );

    return _continueOps;
  }
// -------------------------------------
  Future<void> _onConfirmTap() async {

    final BzModel _bzModel = _createBzModelFromLocalVariables();

    /// ONLY VALIDATION TO INPUTS
    final bool _inputsAreValid = await _validateInputs(_bzModel);

    if (_inputsAreValid == true){

      final bool _canContinue = await _showConfirmationDialog();

      if (_canContinue == true){

        final BzModel _uploadedBzModel = await _uploadBzModel(_bzModel);

        final bool _opSuccess = _uploadOpsSucceeded(_uploadedBzModel);

        await _setNewBzModelLocally(
          uploadedBzModel: _uploadedBzModel,
          uploadOpsSucceeded: _opSuccess,
        );

        await _onUploadOpsEnd(_opSuccess);

      }

    }

  }
// -------------------------------------
  Future<void> _onUploadOpsEnd(bool onOpSuccess) async {

    /// ON SUCCESS
    if (onOpSuccess == true){

        await CenterDialog.showCenterDialog(
          context: context,
          title: 'Great !',
          body: 'Successfully updated your Business Account',
        );

        Nav.goBack(context,
          /// TASK : need to check this
          // argument: widget.firstTimer ? null : true,
        );

    }

    /// ON FAILURE
    else {
      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Ops !',
        body: 'Something went wrong, Please try again',
      );
    }

  }
// -----------------------------------------------------------------------------
  bool errorIsOn({
    @required List<String> missingFieldsKeys,
    @required String fieldKey,
  }){

    final bool _isError = Mapper.stringsContainString(
      strings: missingFieldsKeys,
      string: fieldKey,
    );

    return _isError;
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final String _bzAboutBubbleTitle = superPhrase(context, 'phid_about');

    return MainLayout(
      key: const ValueKey<String>('BzEditorScreen'),
      // loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      historyButtonIsOn: false,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      pageTitle: widget.firstTimer == true ?
      superPhrase(context, 'phid_createBzAccount')
          :
      superPhrase(context, 'phid_edit_bz_info'), // createBzAccount
      // appBarBackButton: true,
      layoutWidget: Stack(
        children: <Widget>[

          ///--- BUBBLES
          Form(
            key: _formKey,
            child: ValueListenableBuilder(
              valueListenable: _missingFields,
              builder: (_, List<AlertModel> missingFields, Widget child){

                // final List<String> _missingFieldsKeys = MapModel.getKeysFromMapModels(missingFields);


                return ListView(
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
                            title: superPhrase(context, 'phid_sections'),
                            buttonsList: _allSections,
                            selectedButtons: <String>[_selectedButton],
                            onButtonTap: _onSelectSection,
                            isInError: false,
                          );

                        }
                    ),

                    /// --- BZ TYPE SELECTION
                    ValueListenableBuilder(
                        key: const ValueKey<String>('bzType_selection_bubble'),
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
                                  isInError: false,
                                );

                              }
                          );

                        }
                    ),

                    /// --- BZ FORM SELECTION
                    ValueListenableBuilder(
                        key: const ValueKey<String>('bzForm_selection_bubble'),
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
                                title: superPhrase(context, 'phid_businessForm'),
                                // description: superPhrase(context, 'phid_businessForm_description'),
                                buttonsList: _buttonsList,
                                onButtonTap: _onSelectBzForm,
                                selectedButtons: <String>[_selectedButton],
                                inactiveButtons: _inactiveButtons,
                                isInError: false,
                              );

                            },
                          );

                        }
                    ),

                    const BubblesSeparator(),

                    /// --- ADD LOGO
                    AddGalleryPicBubble(
                      key: const ValueKey<String>('add_logo_bubble'),
                      picture: _bzLogo,
                      onAddPicture: _takeBzLogo,
                      onDeletePicture: _onDeleteLogo,
                      title: superPhrase(context, 'phid_businessLogo'),
                      bubbleType: BubbleType.bzLogo,
                    ),

                    /// --- BZ NAME
                    ValueListenableBuilder(
                      key: const ValueKey<String>('bz_name_bubble'),
                      valueListenable: _selectedBzForm,
                      builder: (_, BzForm selectedBzForm, Widget child){

                        final String _title =
                        selectedBzForm == BzForm.individual ?
                        superPhrase(context, 'phid_business_entity_name')
                            :
                        superPhrase(context, 'phid_companyName');

                        return TextFieldBubble(
                          isFormField: true,
                          key: const Key('bzName'),
                          textController: _bzNameTextController,
                          title:_title,
                          counterIsOn: true,
                          maxLength: 72,
                          maxLines: 2,
                          keyboardTextInputType: TextInputType.name,
                          fieldIsRequired: true,
                        );

                      },
                    ),

                    /// --- BZ SCOPE
                    TextFieldBubble(
                      isFormField: true,
                      key: const ValueKey<String>('bz_scope_bubble'),
                      textController: _bzScopeTextController,
                      title: '${superPhrase(context, 'phid_scopeOfServices')} :',
                      counterIsOn: true,
                      maxLength: 500,
                      maxLines: 4,
                      keyboardTextInputType: TextInputType.multiline,
                      fieldIsRequired: true,
                      // bubbleColor: _bzScopeError ? Colorz.red125 : Colorz.white20,
                    ),

                    /// --- BZ ABOUT
                    TextFieldBubble(
                      key: const ValueKey<String>('bz_about_bubble'),
                      textController: _bzAboutTextController,
                      title: _bzAboutBubbleTitle,
                      counterIsOn: true,
                      maxLength: 1000,
                      maxLines: 20,
                      keyboardTextInputType: TextInputType.multiline,
                    ),

                    const BubblesSeparator(),

                    /// --- BZ ZONE
                    ValueListenableBuilder(
                        key: const ValueKey<String>('bz_zone_bubble'),
                        valueListenable: _bzZone,
                        builder: (_, ZoneModel bzZone, Widget child){

                          return ZoneSelectionBubble(
                            title: 'Headquarters zone', //Wordz.hqCity(context),
                            onZoneChanged: _onBzZoneChanged,
                            currentZone: bzZone,
                          );

                        }
                    ),

                    /// --- BZ POSITION

                    /// --- BZ CONTACTS

                    const BubblesSeparator(),

                    const Horizon(),

                    if (Keyboarders.keyboardIsOn(context))
                      const SizedBox(
                        width: 20,
                        height: 150,
                      ),

                  ],
                );

              },
            ),
          ),

          /// ---  BOTTOM BUTTONS
          Positioned(
            key: const ValueKey<String>('confirm_button'),
            bottom: 0,
            left: 0,
            child: DreamBox(
              height: 50,
              color: Colorz.yellow255,
              verseColor: Colorz.black230,
              verseWeight: VerseWeight.black,
              verse: 'Confirm',
              secondLine: widget.firstTimer ?
              'Create new business profile'
                  :
              'Update business profile',
              secondLineColor: Colorz.black255,
              verseScaleFactor: 0.7,
              margins: const EdgeInsets.all(10),
              onTap: _onConfirmTap,
            ),
          ),

        ],
      ),
    );
  }
}
