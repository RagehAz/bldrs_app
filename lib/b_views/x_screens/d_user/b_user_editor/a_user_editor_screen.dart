import 'dart:async';

import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/d_user/b_user_editor/aa_user_editor_screen_view.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/c_controllers/d_user_controllers/b_user_editor/a_user_editor_controllers.dart';
import 'package:bldrs/e_db/fire/ops/zone_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
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
  final ValueNotifier<FileModel> _picture = ValueNotifier(null);
  final ValueNotifier<Gender> _gender = ValueNotifier(null);
  final ValueNotifier<ZoneModel> _zone = ValueNotifier(null);
  // --------------------
  // String _currentLanguageCode;
  GeoPoint _currentPosition;
  // --------------------
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();
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
    _zone.value               = widget.userModel?.zone;

    // _currentLanguageCode      = Wordz.languageCode(context);

    _nameController.text      = widget.userModel?.name;
    _companyController.text   = widget.userModel?.company;
    _titleController.text     = widget.userModel?.title;

    _phoneController.text     = TextMod.initializePhoneNumber(
      countryID : _zone.value?.countryID,
      number : ContactModel.getAContactValueFromContacts(
          contacts: widget.userModel?.contacts,
          contactType: ContactType.phone
      ),
    );
    _emailController.text     = ContactModel.getAContactValueFromContacts(
      contacts: widget.userModel?.contacts,
      contactType: ContactType.email,
    );
    _facebookController.text  = ContactModel.initializeWebLinkValue(
      contacts: widget.userModel?.contacts,
      contactType: ContactType.facebook,
    );
    _linkedInController.text  = ContactModel.initializeWebLinkValue(
      contacts: widget.userModel?.contacts,
      contactType: ContactType.linkedIn,
    );
    _instagramController.text = ContactModel.initializeWebLinkValue(
      contacts: widget.userModel?.contacts,
      contactType: ContactType.instagram,
    );
    _twitterController.text   = ContactModel.initializeWebLinkValue(
      contacts: widget.userModel?.contacts,
      contactType: ContactType.twitter,
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
    _phoneController.dispose();
    _emailController.dispose();
    _facebookController.dispose();
    _linkedInController.dispose();
    _instagramController.dispose();
    _twitterController.dispose();
    _loading.dispose();
    _canPickImage.dispose();
    _picture.dispose();
    _gender.dispose();
    _zone.dispose();
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
      contacts: _createContactList(existingContacts: widget.userModel.contacts),
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
// -----------------------------------
  List<ContactModel> _createContactList({
    @required List<ContactModel> existingContacts,
  }) {
    /// takes current contacts, overrides them on existing contact list, then
    /// return a new contacts list with all old values and new overridden values
    final List<ContactModel> newContacts = ContactModel.createContactsList(
      existingContacts: existingContacts,
      phone: TextMod.nullifyNumberIfOnlyCountryCode(
          number: _phoneController.text,
          countryID: _zone.value.countryID,
      ),
      email: TextMod.removeSpacesFromAString(_emailController.text),
      facebook: TextMod.nullifyUrlLinkIfOnlyHTTPS(url: _facebookController.text),
      linkedIn: TextMod.nullifyUrlLinkIfOnlyHTTPS(url: _linkedInController.text),
      instagram: TextMod.nullifyUrlLinkIfOnlyHTTPS(url: _instagramController.text),
      twitter: TextMod.nullifyUrlLinkIfOnlyHTTPS(url: _twitterController.text),
    );
    return newContacts;
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
        firstLine: 'phid_updateProfile'.toUpperCase(),
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
        formKey: _formKey,
        fileModel: _picture,
        canPickImage: _canPickImage,
        nameController: _nameController,
        genderNotifier: _gender,
        titleController: _titleController,
        companyController: _companyController,
        zone: _zone,
        emailController: _emailController,
        phoneController: _phoneController,
        facebookController: _facebookController,
        instagramController: _instagramController,
        linkedInController: _linkedInController,
        twitterController: _twitterController,
      ),
    );

  }
}
