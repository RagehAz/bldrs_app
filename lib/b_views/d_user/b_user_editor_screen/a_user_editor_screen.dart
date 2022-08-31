import 'dart:async';

import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/old_aa_user_editor_screen_view.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/x_user_editor_controllers.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/zone_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const EditProfileScreen({
    @required this.userModel,
    @required this.onFinish,
    @required this.canGoBack,
    @required this.reAuthBeforeConfirm,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final Function onFinish;
  final bool canGoBack;
  final bool reAuthBeforeConfirm;
  /// --------------------------------------------------------------------------
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
/// --------------------------------------------------------------------------
}

class _EditProfileScreenState extends State<EditProfileScreen> {
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _canPickImage = ValueNotifier(true);
  // --------------------
  final ValueNotifier<UserModel> _tempUser = ValueNotifier(null);
  // --------------------
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameNode = FocusNode();
  // --------------------
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _jobNode = FocusNode();
  // --------------------
  final TextEditingController _companyController = TextEditingController();
  final FocusNode _companyNode = FocusNode();
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
// -----------------------------------------------------------------------------
  void _initializeLocalVariables(){

    final UserModel _initialModel = UserModel.initializeModelForEditing(
      context: context,
      userModel: widget.userModel,
    );

    _tempUser.value = _initialModel;

    _nameController.text      = _initialModel.name;
    _companyController.text   = _initialModel.company;
    _titleController.text     = _initialModel.title;

  }
// -----------------------------------
  @override
  void initState() {
    super.initState();
    _initializeLocalVariables();
  }
// -----------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
// -----------------------------------------------------------------
        if (_tempUser.value.zone == null || _tempUser.value.zone.countryID == null){
          _tempUser.value = _tempUser.value.copyWith(
            zone: await ZoneFireOps.superGetZoneByIP(context),
            pic: await FileModel.completeModel(_tempUser.value.pic),
          );
        }
// -----------------------------------------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------
  /// tamam
  @override
  void dispose() {
    _loading.dispose();
    _canPickImage.dispose();

    _nameController.dispose();
    _nameNode.dispose();
    _titleController.dispose();
    _jobNode.dispose();
    _companyController.dispose();
    _companyNode.dispose();

    ContactModel.disposeContactsControllers(_tempUser.value.contacts);
    _tempUser.dispose();

    super.dispose();
  }
// -----------------------------------------------------------------------------

  /// CREATE USER MODEL FROM LOCAL VARIABLES

// -----------------------------------
  UserModel _createUserModelFromLocalVariables(){

    return UserModel.bakeEditorVariablesToUpload(
      context: context,
      existingModel: widget.userModel,
      tempUser: _tempUser.value.copyWith(
        name: _nameController.text,
        title: _titleController.text,
        company: _companyController.text,
      ),
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      canGoBack: widget.canGoBack,
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      historyButtonIsOn: false,
      appBarType: AppBarType.basic,
      pageTitleVerse: 'phid_updateProfile',
      loading: _loading,
      confirmButtonModel: ConfirmButtonModel(
        firstLine: 'phid_updateProfile',
        onSkipTap: (){

          blog('skip');

        },
        onTap: () => confirmEdits(
          context: context,
          formKey: _formKey,
          newUserModel: _createUserModelFromLocalVariables(),
          oldUserModel: widget.userModel,
          onFinish: widget.onFinish,
          loading: _loading,
          forceReAuthentication: widget.reAuthBeforeConfirm,
        ),

      ),
      layoutWidget: UserEditorScreenView(
        appBarType: AppBarType.basic,
        formKey: _formKey,
        fileModel: _picture,
        canPickImage: _canPickImage,
        nameController: _nameController,
        genderNotifier: _gender,
        titleController: _titleController,
        companyController: _companyController,
        zone: _zone,
        contacts: _contacts,
        nameNode: _nameNode,
        jobNode: _jobNode,
        companyNode: _companyNode,
      ),
    );

  }
}
