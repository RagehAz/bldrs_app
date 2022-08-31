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

class OLDEditProfileScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const OLDEditProfileScreen({
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
  _OLDEditProfileScreenState createState() => _OLDEditProfileScreenState();
  /// --------------------------------------------------------------------------
}

class _OLDEditProfileScreenState extends State<OLDEditProfileScreen> {
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _canPickImage = ValueNotifier(true);
  // --------------------
  final ValueNotifier<FileModel> _picture = ValueNotifier(null);
  final ValueNotifier<Gender> _gender = ValueNotifier(null);
  final ValueNotifier<ZoneModel> _zone = ValueNotifier(null);
  // --------------------
  // String _currentLanguageCode;
  GeoPoint _currentPosition;
  // --------------------
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameNode = FocusNode();

  final TextEditingController _titleController = TextEditingController();
  final FocusNode _jobNode = FocusNode();

  final TextEditingController _companyController = TextEditingController();
  final FocusNode _companyNode = FocusNode();

  List<ContactModel> _contacts;
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
    _picture.value            = FileModel(url: widget.userModel?.pic, fileName: null, size: null);
    _gender.value             = widget.userModel?.gender;
    _zone.value               = widget.userModel?.zone ?? ZoneProvider.proGetCurrentZone(
        context: context,
        listen: false,
    );

    // _currentLanguageCode      = Wordz.languageCode(context);

    _nameController.text      = widget.userModel?.name;
    _companyController.text   = widget.userModel?.company;
    _titleController.text     = widget.userModel?.title;

    _contacts = ContactModel.initializeContactsForEditing(
      countryID: _zone.value.countryID,
      contacts: widget.userModel?.contacts,
    );

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
      if (widget.userModel?.zone == null){
        final ZoneModel _superZone = await ZoneFireOps.superGetZoneByIP(context);
        _zone.value = _superZone;
        _picture.value = await FileModel.completeModel(_picture.value);
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
    _nameController.dispose();
    _titleController.dispose();
    _companyController.dispose();
    _loading.dispose();
    _canPickImage.dispose();
    _picture.dispose();
    _gender.dispose();
    _zone.dispose();
    _nameNode.dispose();
    _companyNode.dispose();
    _jobNode.dispose();
    ContactModel.disposeContactsControllers(_contacts);
    super.dispose();
  }
// -----------------------------------------------------------------------------

  /// CREATE USER MODEL FROM LOCAL VARIABLES

// -----------------------------------
  UserModel _createUserModelFromLocalVariables(){
    return UserModel(
      // -------------------------
      id: widget.userModel.id,
      createdAt: widget.userModel.createdAt,
      status: widget.userModel.status,
      // -------------------------
      name: _nameController.text,
      trigram: Stringer.createTrigram(input: _nameController.text),
      pic: _picture.value.file ?? _picture.value.url ?? widget.userModel.pic,
      title: _titleController.text,
      company: _companyController.text,
      gender: _gender.value,
      zone: _zone.value,
      language: Words.languageCode(context),
      location: _currentPosition,
      contacts: ContactModel.bakeContactsAfterEditing(
        contacts: _contacts,
        countryID: _zone.value.countryID,
      ),
      // -------------------------
      myBzzIDs: widget.userModel.myBzzIDs,
      // -------------------------
      isAdmin: widget.userModel.isAdmin,
      emailIsVerified: widget.userModel.emailIsVerified,
      authBy: widget.userModel.authBy,
      fcmToken: widget.userModel.fcmToken,
      followedBzzIDs: widget.userModel.followedBzzIDs,
      savedFlyersIDs: widget.userModel.savedFlyersIDs,
      appState: widget.userModel.appState,
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
      layoutWidget: OLDUserEditorScreenView(
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
