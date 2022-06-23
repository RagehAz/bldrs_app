import 'dart:async';

import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/d_user/b_user_editor/aa_user_editor_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/c_controllers/d_user_controllers/b_user_editor/a_user_editor_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/zone_ops.dart' as ZoneOps;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const EditProfileScreen({
    @required this.userModel,
    @required this.onFinish,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final Function onFinish;
  /// --------------------------------------------------------------------------
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
  /// --------------------------------------------------------------------------
}

class _EditProfileScreenState extends State<EditProfileScreen> {
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _canPickImage = ValueNotifier(true); /// tamam disposed
  // --------------------
  final ValueNotifier<dynamic> _picture = ValueNotifier(null); /// tamam disposed
  final ValueNotifier<Gender> _gender = ValueNotifier(null); /// tamam disposed
  final ValueNotifier<ZoneModel> _zone = ValueNotifier(null); /// tamam disposed
  // --------------------
  // String _currentLanguageCode;
  GeoPoint _currentPosition;
  // --------------------
  final TextEditingController _nameController = TextEditingController(); /// tamam disposed
  final TextEditingController _titleController = TextEditingController(); /// tamam disposed
  final TextEditingController _companyController = TextEditingController(); /// tamam disposed
  final TextEditingController _phoneController = TextEditingController(); /// tamam disposed
  final TextEditingController _emailController = TextEditingController(); /// tamam disposed
  final TextEditingController _facebookController = TextEditingController(); /// tamam disposed
  final TextEditingController _linkedInController = TextEditingController(); /// tamam disposed
  final TextEditingController _instagramController = TextEditingController(); /// tamam disposed
  final TextEditingController _twitterController = TextEditingController(); /// tamam disposed
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(true); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading({
    @required setTo,
  }) async {
    _loading.value = setTo;
    blogLoading(
      loading: _loading.value,
      callerName: 'EditProfileScreen',
    );
  }
// -----------------------------------------------------------------------------
  void _initializeLocalVariables(){
    _picture.value            = widget.userModel.pic;
    _gender.value             = widget.userModel.gender;
    _zone.value               = widget.userModel.zone;

    // _currentLanguageCode      = Wordz.languageCode(context);

    _nameController.text      = widget.userModel.name;
    _companyController.text   = widget.userModel.company;
    _titleController.text     = widget.userModel.title;

    _phoneController.text     = ContactModel.getAContactValueFromContacts(
        contacts: widget.userModel.contacts,
        contactType: ContactType.phone
    );
    _emailController.text     = ContactModel.getAContactValueFromContacts(
      contacts: widget.userModel.contacts,
      contactType: ContactType.email,
    );
    _facebookController.text  = ContactModel.getAContactValueFromContacts(
      contacts: widget.userModel.contacts,
      contactType: ContactType.facebook,
    );
    _linkedInController.text  = ContactModel.getAContactValueFromContacts(
      contacts: widget.userModel.contacts,
      contactType: ContactType.linkedIn,
    );
    _instagramController.text = ContactModel.getAContactValueFromContacts(
      contacts: widget.userModel.contacts,
      contactType: ContactType.instagram,
    );
    _twitterController.text   = ContactModel.getAContactValueFromContacts(
      contacts: widget.userModel.contacts,
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
      if (widget.userModel.zone == null){
        final ZoneModel _superZone = await ZoneOps.superGetZoneByIP(context);
        _zone.value = _superZone;
      }
// -----------------------------------------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------
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

    super.dispose(); /// tamam
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
      trigram: TextGen.createTrigram(input: _nameController.text),
      pic: _picture.value ?? widget.userModel.pic,
      title: _titleController.text,
      company: _companyController.text,
      gender: _gender.value,
      zone: _zone.value,
      language: Wordz.languageCode(context),
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
      phone: TextMod.removeSpacesFromAString(_phoneController.text),
      email: TextMod.removeSpacesFromAString(_emailController.text),
      facebook: TextMod.removeSpacesFromAString(_facebookController.text),
      linkedIn: TextMod.removeSpacesFromAString(_linkedInController.text),
      instagram: TextMod.removeSpacesFromAString(_instagramController.text),
      twitter: TextMod.removeSpacesFromAString(_twitterController.text),
    );
    return newContacts;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MainLayout(
        skyType: SkyType.black,
        zoneButtonIsOn: false,
        sectionButtonIsOn: false,
        historyButtonIsOn: false,
        appBarType: AppBarType.basic,
        pageTitle: superPhrase(context, 'phid_updateProfile'),
        onBack: () => confirmEdits(
            context: context,
            formKey: _formKey,
            newUserModel: _createUserModelFromLocalVariables(),
            oldUserModel: widget.userModel,
            onFinish: widget.onFinish,
            loading: _loading
        ),
        layoutWidget: UserEditorScreenView(
          loading: _loading,
          formKey: _formKey,
          picture: _picture,
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
          oldUserModel: widget.userModel,
          createNewUserModel: _createUserModelFromLocalVariables,
          onFinish: widget.onFinish,
        ),
      ),
    );

  }
}