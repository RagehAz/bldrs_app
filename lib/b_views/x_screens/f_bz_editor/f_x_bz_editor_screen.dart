import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/alert_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/y_views/f_bz_editor/bz_editor_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'BzEditorScreen',
    );
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
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
  ValueNotifier<ZoneModel> _selectedBzZone; /// tamam disposed
  ValueNotifier<List<String>> _selectedScopes;
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
    BzModel.convertFireUserDataIntoInitialBzModel(widget.userModel)
        :
    widget.bzModel;
    // -------------------------
    _selectedBzTypes = ValueNotifier(_initialBzModel.bzTypes);
    _selectedBzForm = ValueNotifier(_initialBzModel.bzForm);
    _bzNameTextController = TextEditingController(text: _initialBzModel.name);
    _bzLogo = ValueNotifier(_initialBzModel.logo);
    _selectedScopes = ValueNotifier(_initialBzModel.scope);
    _selectedBzZone = ValueNotifier(_initialBzModel.zone);
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
  final ValueNotifier<List<AlertModel>> _missingFields = ValueNotifier(<AlertModel>[]); /// tamam disposed
// -------------------------------------
  void _initializeHelperVariables(){
    final BzSection _concludedBzSection = BzModel.concludeBzSectionByBzTypes(_initialBzModel.bzTypes);
    final List<BzType> _concludedInactiveBzTypes = BzModel.concludeInactiveBzTypesBySection(
      bzSection: _concludedBzSection,
      initialBzTypes: _initialBzModel.bzTypes,
    );
    final List<BzForm> _concludedInactiveBzForms = BzModel.concludeInactiveBzFormsByBzTypes(_concludedInactiveBzTypes);
    _selectedBzSection  = ValueNotifier(_concludedBzSection);
    _inactiveBzTypes = ValueNotifier(_concludedInactiveBzTypes);
    _inactiveBzForms = ValueNotifier(_concludedInactiveBzForms);
  }
// -----------------------------------------------------------------------------
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
    _bzContacts.dispose();
    _selectedBzSection.dispose();
    _inactiveBzTypes.dispose();
    _inactiveBzForms.dispose();

    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  void _disposeTextControllers(){
    TextChecker.disposeControllerIfPossible(_bzNameTextController);
    TextChecker.disposeControllerIfPossible(_bzAboutTextController);
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
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      pageTitle: widget.firstTimer == true ?
      superPhrase(context, 'phid_createBzAccount')
          :
      superPhrase(context, 'phid_edit_bz_info'), // createBzAccount
      // appBarBackButton: true,
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
        firstTimer: widget.firstTimer,
        bzContacts: _bzContacts,
        bzPosition: _bzPosition,
        bzZone: _selectedBzZone,
        initialBzModel: _initialBzModel,
        userModel: widget.userModel,
      ),
    );
  }
}
