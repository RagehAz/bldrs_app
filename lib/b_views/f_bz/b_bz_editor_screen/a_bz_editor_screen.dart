import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/secondary_models/alert_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/aa_bz_editor_screen_view.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/x_bz_editor_screen_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

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
  final ValueNotifier<bool> _canPickImage = ValueNotifier(true);
  // --------------------
  final ValueNotifier<BzModel> _tempBz = ValueNotifier<BzModel>(null);
  final ValueNotifier<BzModel> _initialBzModel = ValueNotifier<BzModel>(null);
  // --------------------
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  // --------------------
  final TextEditingController _aboutController = TextEditingController();
  final FocusNode _aboutNode = FocusNode();
  // --------------------
  final ValueNotifier<List<SpecModel>> _selectedScopes = ValueNotifier([]);
  // --------------------
  final ValueNotifier<BzSection> _selectedBzSection = ValueNotifier<BzSection>(null);
  final ValueNotifier<List<BzType>> _inactiveBzTypes = ValueNotifier<List<BzType>>(null);
  final ValueNotifier<List<BzForm>> _inactiveBzForms = ValueNotifier<List<BzForm>>(null);
  final ValueNotifier<List<AlertModel>> _missingFields = ValueNotifier(<AlertModel>[]);
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'EditProfileScreen',);
    }
  }
// -----------------------------------
  @override
  void initState() {
    super.initState();

    initializeLocalVariables(
      context: context,
      tempBz: _tempBz,
      oldBzModel: widget.bzModel,
      initialBzModel: _initialBzModel,
      firstTimer: widget.firstTimer,
      nameController: _nameController,
      aboutController: _aboutController,
      inactiveBzForms: _inactiveBzForms,
      inactiveBzTypes: _inactiveBzTypes,
      selectedBzSection: _selectedBzSection,
      selectedScopes: _selectedScopes,
    );

  }
// -----------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
// -----------------------------------------------------------------
        await prepareBzZoneAndLogoForEditing(
          context: context,
          tempBz: _tempBz,
        );
// -----------------------------------------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------
  /// TAMAM
  @override
  void dispose() {
    _canPickImage.dispose();

    _nameController.dispose();
    _nameNode.dispose();

    _aboutController.dispose();
    _aboutNode.dispose();

    _selectedScopes.dispose();

    _selectedBzSection.dispose();
    _inactiveBzTypes.dispose();
    _inactiveBzForms.dispose();
    _missingFields.dispose();

    _loading.dispose();

    ContactModel.disposeContactsControllers(_tempBz.value.contacts);
    _tempBz.dispose();
    _initialBzModel.dispose();

    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      key: const ValueKey<String>('BzEditorScreen'),
      loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      historyButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      pageTitleVerse: widget.firstTimer == true ? 'phid_createBzAccount' : 'phid_edit_bz_info',
      confirmButtonModel: ConfirmButtonModel(
          firstLine: 'phid_confirm',
          secondLine: widget.firstTimer == true ? 'phid_create_new_bz_profile' : 'phid_update_bz_profile',
          onTap: () => onBzEditsConfirmTap(
            context: context,
            formKey: _formKey,
            missingFields: _missingFields,
            selectedScopes: _selectedScopes,
            bzAboutTextController: _aboutController,
            bzNameTextController: _nameController,
            oldBz: widget.bzModel,
            firstTimer: widget.firstTimer,
            tempBz: _tempBz,
          )
      ),
      layoutWidget: BzEditorScreenView(
        tempBz: _tempBz,
        formKey: _formKey,
        missingFields: _missingFields,
        selectedBzSection: _selectedBzSection,
        inactiveBzTypes: _inactiveBzTypes,
        inactiveBzForms: _inactiveBzForms,
        selectedScopes: _selectedScopes,
        bzNameTextController: _nameController,
        bzAboutTextController: _aboutController,
        appBarType: AppBarType.basic,
        nameNode: _nameNode,
        aboutNode: _aboutNode,
        canPickImage: _canPickImage,
      ),
    );
  }
}
