import 'dart:async';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/aa_user_editor_screen_view.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/x_user_editor_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
// -----------------------------------
  @override
  void initState() {
    super.initState();

    initializeLocalVariables(
      context: context,
      oldUserModel: widget.userModel,
      tempUser: _tempUser,
      titleController: _titleController,
      nameController: _nameController,
      companyController: _companyController,
    );

  }
// -----------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
// -----------------------------------------------------------------
        await prepareUserZoneAndPicForEditing(
          context: context,
          tempUser: _tempUser,
        );
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
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      canGoBack: widget.canGoBack,
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      historyButtonIsOn: false,
      appBarType: AppBarType.basic,
      pageTitleVerse: 'phid_update_profile',
      loading: _loading,

      confirmButtonModel: ConfirmButtonModel(
        firstLine: 'phid_updateProfile',
        onSkipTap: (){

          blog('skip');

        },
        onTap: () => confirmEdits(
          context: context,
          formKey: _formKey,
          tempUser: _tempUser,
          oldUserModel: widget.userModel,
          onFinish: widget.onFinish,
          loading: _loading,
          forceReAuthentication: widget.reAuthBeforeConfirm,
          companyController: _companyController,
          nameController: _nameController,
          titleController: _titleController,
        ),

      ),
      layoutWidget: UserEditorScreenView(
        appBarType: AppBarType.basic,
        formKey: _formKey,
        canPickImage: _canPickImage,
        nameController: _nameController,
        tempUser: _tempUser,
        titleController: _titleController,
        companyController: _companyController,
        nameNode: _nameNode,
        jobNode: _jobNode,
        companyNode: _companyNode,
      ),
    );

  }
}
