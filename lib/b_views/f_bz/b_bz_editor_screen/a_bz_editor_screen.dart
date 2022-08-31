import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/alert_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/aa_bz_editor_screen_view.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/x_bz_editor_screen_controllers.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// PLAN : SAVE CURRENT STATES IN LDB IN CASE USER DIDN'T FINISH IN ONE SESSION
class BzEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzEditorScreen({
    this.firstTimer = false,
    this.bzModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool firstTimer;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  _BzEditorScreenState createState() => _BzEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _BzEditorScreenState extends State<BzEditorScreen> with TickerProviderStateMixin {
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserModel _userModel;
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  /*
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'BzEditorScreen',);
    }
  }
   */
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _userModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );

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
  ValueNotifier<List<BzType>> _selectedBzTypes;
  ValueNotifier<BzForm> _selectedBzForm;
  /// DateTime _createdAt; // NOT REQUIRED HERE
  /// BzAccountType _accountType // NOT REQUIRED HERE
  // -------------------------
  TextEditingController _bzNameTextController;
  FocusNode _nameNode;
  TextEditingController _bzAboutTextController;
  FocusNode _aboutNode;
  ValueNotifier<FileModel> _bzLogo;
  ValueNotifier<ZoneModel> _selectedBzZone;
  ValueNotifier<List<SpecModel>> _selectedScopes;
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
    BzModel.convertFireUserDataIntoInitialBzModel(_userModel)
        :
    widget.bzModel;
    // -------------------------
    final List<SpecModel> _specs = SpecModel.generateSpecsByPhids(
      context: context,
      phids: _initialBzModel.scope,
    );

    // -------------------------
    _selectedBzTypes = ValueNotifier(_initialBzModel.bzTypes);
    _selectedBzForm = ValueNotifier(_initialBzModel.bzForm);
    _bzNameTextController = TextEditingController(text: _initialBzModel.name);
    _nameNode = FocusNode();
    _bzAboutTextController = TextEditingController(text: _initialBzModel.about);
    _aboutNode = FocusNode();
    _bzLogo = ValueNotifier(FileModel(
      url: _initialBzModel.logo,
      fileName: _initialBzModel.id,
      size: null,
    ));
    _selectedScopes = ValueNotifier(_specs);
    _selectedBzZone = ValueNotifier(_initialBzModel.zone);
    _bzPosition = ValueNotifier(_initialBzModel.position);
    // -------------------------
    final List<ContactModel> _initialContacts = ContactModel.initializeContactsForEditing(
      countryID: _initialBzModel.zone.countryID,
      contacts: _initialBzModel.contacts,
    );
    _bzContacts = ValueNotifier(_initialContacts);
    // -------------------------
  }
// -----------------------------------------------------------------------------

  /// HELPER VARIABLES
  
// -------------------------------------
  ValueNotifier<BzSection> _selectedBzSection;
  ValueNotifier<List<BzType>> _inactiveBzTypes;
  ValueNotifier<List<BzForm>> _inactiveBzForms;
  final ValueNotifier<List<AlertModel>> _missingFields = ValueNotifier(<AlertModel>[]);
// -------------------------------------
  void _initializeHelperVariables(){
    final BzSection _concludedBzSection = BzModel.concludeBzSectionByBzTypes(_initialBzModel.bzTypes);
    final List<BzType> _concludedInactiveBzTypes = BzModel.concludeDeactivatedBzTypesBySection(
      bzSection: _concludedBzSection,
      initialBzTypes: _initialBzModel.bzTypes,
    );
    final List<BzForm> _concludedInactiveBzForms = BzModel.concludeInactiveBzFormsByBzTypes(_concludedInactiveBzTypes);
    _selectedBzSection  = ValueNotifier(_concludedBzSection);
    _inactiveBzTypes = ValueNotifier(_concludedInactiveBzTypes);
    _inactiveBzForms = ValueNotifier(_concludedInactiveBzForms);
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {

    _disposeTextControllers();

    _missingFields.dispose();
    _loading.dispose();
    _selectedBzTypes.dispose();
    _selectedBzForm.dispose();
    _bzLogo.dispose();
    _selectedBzZone.dispose();
    _selectedScopes.dispose();
    _bzPosition.dispose();
    _selectedBzSection.dispose();
    _inactiveBzTypes.dispose();
    _inactiveBzForms.dispose();
    _bzNameTextController.dispose();
    _nameNode.dispose();
    _bzAboutTextController.dispose();
    _aboutNode.dispose();

    ContactModel.disposeContactsControllers(_bzContacts.value);
    _bzContacts.dispose();

    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _disposeTextControllers(){
    // TextChecker.disposeControllerIfPossible(_bzNameTextController);
    // TextChecker.disposeControllerIfPossible(_bzAboutTextController);
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      key: const ValueKey<String>('BzEditorScreen'),
      // loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      historyButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      pageTitleVerse: widget.firstTimer == true ?
      'phid_createBzAccount'
          :
      'phid_edit_bz_info', // createBzAccount
      // appBarBackButton: true,
      confirmButtonModel: ConfirmButtonModel(
          firstLine: '##Confirm',
          secondLine: widget.firstTimer == true ? '##Create new business profile' : '##Update business profile',
          onTap: () => onBzEditsConfirmTap(
            context: context,
            formKey: _formKey,
            missingFields: _missingFields,
            selectedBzTypes: _selectedBzTypes,
            selectedScopes: _selectedScopes,
            bzZone: _selectedBzZone,
            bzLogo: _bzLogo,
            selectedBzForm: _selectedBzForm,
            bzAboutTextController: _bzAboutTextController,
            bzContacts: _bzContacts,
            bzNameTextController: _bzNameTextController,
            bzPosition: _bzPosition,
            initialBzModel: _initialBzModel,
            userModel: _userModel,
            firstTimer: widget.firstTimer,
          )
      )                ,
      layoutWidget: BzEditorScreenView(
        formKey: _formKey,
        missingFields: _missingFields,
        selectedBzSection: _selectedBzSection,
        selectedBzTypes: _selectedBzTypes,
        inactiveBzTypes: _inactiveBzTypes,
        inactiveBzForms: _inactiveBzForms,
        selectedBzForm: _selectedBzForm,
        selectedScopes: _selectedScopes,
        bzLogo: _bzLogo,
        bzNameTextController: _bzNameTextController,
        bzAboutTextController: _bzAboutTextController,
        selectedBzZone: _selectedBzZone,
        bzZone: _selectedBzZone,
        userModel: _userModel,
        bzContacts: _bzContacts,
        appBarType: AppBarType.basic,
        nameNode: _nameNode,
        aboutNode: _aboutNode,
      ),
    );
  }
}
