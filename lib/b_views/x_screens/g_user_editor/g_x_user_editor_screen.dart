import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/contact_field_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/gender_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/c_controllers/b_0_auth_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/fire/ops/zone_ops.dart' as ZoneOps;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  // --------------------
  final ValueNotifier<dynamic> _picture = ValueNotifier(null); /// tamam disposed
  final ValueNotifier<Gender> _gender = ValueNotifier(null); /// tamam disposed
  final ValueNotifier<ZoneModel> _zone = ValueNotifier(null); /// tamam disposed
  // --------------------
  String _currentLanguageCode;
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
  @override
  void initState() {
    super.initState();
    _initializeLocalVariables();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
// -----------------------------------------------------------------
      if (widget.userModel.zone == null){
        final ZoneModel _superZone = await ZoneOps.superGetZone(context);
        _zone.value = _superZone;
      }
// -----------------------------------------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _canPickImage = ValueNotifier(true); /// tamam disposed
// -----------------------------------------------------------------------------
  Future<void> _takeGalleryPicture() async {

    if (_canPickImage.value == true) {

      _canPickImage.value = false;

      final File _imageFile = await Imagers.takeGalleryPicture(
          picType: Imagers.PicType.userPic,
      );

      blog('we got the pic in : ${_imageFile?.path}');

      /// IF DID NOT PIC ANY IMAGE
      if (_imageFile == null) {
          _picture.value = null;
          _canPickImage.value = true;
      }

      /// IF PICKED AN IMAGE
      else {
          _picture.value = _imageFile;
          _canPickImage.value = true;
      }

    }

  }
// -----------------------------------------------------------------------------
  void _deleteLogo() {
      _picture.value = null;
  }
// -----------------------------------------------------------------------------
  void _onGenderTap(Gender gender){
    _gender.value = gender;
  }
// -----------------------------------------------------------------------------
  void _onZoneChanged(ZoneModel zoneModel) {
    _zone.value = zoneModel;

    zoneModel.blogZone(methodName: 'recieved this zone ahoo');
  }
// -----------------------------------------------------------------------------
  /*
  // void _changePosition(GeoPoint geoPoint){
  //   setState(() => _currentPosition = geoPoint );
  // }
   */
// -----------------------------------------------------------------------------
  List<ContactModel> _createContactList({List<ContactModel> existingContacts}) {
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
  bool _inputsAreValid() {
    bool _inputsAreValid;

    if (_formKey.currentState.validate()) {
      _inputsAreValid = true;
    }

    else {
      _inputsAreValid = false;
    }

    return _inputsAreValid;
  }
// -----------------------------------------------------------------------------
  Future<void> _confirmEdits() async {

    final UserModel _updatedModel = _createUserModelFromLocalVariables();

    /// A - IF ALL REQUIRED FIELDS ARE NOT VALID
    if (_inputsAreValid() == false){
      await showMissingFieldsDialog(
          context: context,
          userModel: _updatedModel
      );
    }

    /// A - IF ALL REQUIRED FIELDS ARE VALID
    else {

      /// B1 - ASK FOR CONFIRMATION
      final bool _continueOps = await CenterDialog.showCenterDialog(
        context: context,
        title: '',
        body: 'Are you sure you want to continue ?',
        boolDialog: true,
      );

      /// B2 - IF USER CONFIRMS
      if (_continueOps == true) {

        final UserModel _uploadedUserModel = await _updateUserModel(
          updatedUserModel: _updatedModel,
        );

        final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
        final AuthModel _authModel = _usersProvider.myAuthModel;

        _authModel.userModel = _uploadedUserModel;

        await setUserModelLocally(
          context: context,
          authModel: _authModel,
        );

        blog('finished updating the user Model ahoooooo');

        widget.onFinish();

      }

    }

  }
// -----------------------------------------------------------------------------
  /// update user
  Future<UserModel> _updateUserModel({
    @required UserModel updatedUserModel,
  }) async {

    unawaited(_triggerLoading(setTo: true));

    /// start create user ops
    final UserModel _uploadedUserModel = await UserFireOps.updateUser(
      context: context,
      oldUserModel: widget.userModel,
      updatedUserModel: updatedUserModel,
    );

    unawaited(_triggerLoading(setTo: false));

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Great !',
      body: 'Successfully updated your user account',
    );

    return _uploadedUserModel;
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _keyboardIsOn = Keyboarders.keyboardIsOn(context);

    return MainLayout(
      pyramidsAreOn: true,
      skyType: SkyType.black,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      historyButtonIsOn: false,
      appBarType: AppBarType.basic,
      pageTitle: superPhrase(context, 'phid_updateProfile'),
      layoutWidget: ValueListenableBuilder(
        valueListenable: _loading,
        builder: (_, bool _isLoading, Widget child){

          if (_isLoading == true){
            return const LoadingFullScreenLayer();
          }

          else {
            return child;
          }

        },

        child: Form(
          key: _formKey,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[

              ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: <Widget>[

                  const Stratosphere(),

                  AddGalleryPicBubble(
                    picture: _picture,
                    onAddPicture: _takeGalleryPicture,
                    onDeletePicture: _deleteLogo,
                    bubbleType: BubbleType.userPic,
                  ),

                  /// --- EDIT NAME
                  TextFieldBubble(
                    isFormField: true,
                    textController: _nameController,
                    key: const Key('name'),
                    title: superPhrase(context, 'phid_name'),
                    keyboardTextInputType: TextInputType.name,
                    keyboardTextInputAction: TextInputAction.next,
                    fieldIsRequired: true,
                    validator: () => _nameController.text.isEmpty ?
                    superPhrase(context, 'phid_enterName')
                        :
                    null,
                  ),

                  GenderBubble(
                    selectedGender: _gender,
                    onTap: (Gender gender) => _onGenderTap(gender),
                  ),

                  /// --- EDIT JOB TITLE
                  TextFieldBubble(
                    isFormField: true,
                    key: const Key('title'),
                    textController: _titleController,
                    title: superPhrase(context, 'phid_jobTitle'),
                    keyboardTextInputType: TextInputType.name,
                    keyboardTextInputAction: TextInputAction.next,
                    fieldIsRequired: true,
                    validator: () => _titleController.text.isEmpty ?
                    superPhrase(context, 'phid_enterJobTitle')
                        :
                    null,
                  ),

                  /// --- EDIT COMPANY NAME
                  TextFieldBubble(
                    isFormField: true,
                    textController: _companyController,
                    key: const Key('company'),
                    title: superPhrase(context, 'phid_companyName'),
                    keyboardTextInputType: TextInputType.name,
                    keyboardTextInputAction: TextInputAction.next,
                    fieldIsRequired: true,
                    validator: () => _companyController.text.isEmpty ?
                    superPhrase(context, 'phid_enterCompanyName')
                        :
                    null,
                  ),

                  /// --- EDIT ZONE
                  ValueListenableBuilder(
                      valueListenable: _zone,
                      builder: (_, ZoneModel _zoneModel, Widget child){

                        return ZoneSelectionBubble(
                          currentZone: _zoneModel,
                          onZoneChanged: (ZoneModel zoneModel) => _onZoneChanged(zoneModel),
                        );

                      }
                  ),

                  /// --- EDIT EMAIL
                  ContactFieldBubble(
                    isFormField: true,
                    textController: _emailController,
                    title: superPhrase(context, 'phid_emailAddress'),
                    leadingIcon: Iconz.comEmail,
                    keyboardTextInputAction: TextInputAction.next,
                    fieldIsRequired: true,
                    keyboardTextInputType: TextInputType.emailAddress,
                  ),

                  /// --- EDIT PHONE
                  ContactFieldBubble(
                    isFormField: true,
                    textController: _phoneController,
                    title: superPhrase(context, 'phid_phone'),
                    leadingIcon: Iconz.comPhone,
                    keyboardTextInputAction: TextInputAction.next,
                    keyboardTextInputType: TextInputType.phone,
                  ),

                  /// --- EDIT FACEBOOK
                  ContactFieldBubble(
                    isFormField: true,
                    textController: _facebookController,
                    title: superPhrase(context, 'phid_facebookLink'),
                    leadingIcon: Iconz.comFacebook,
                    keyboardTextInputAction: TextInputAction.next,
                  ),

                  /// --- EDIT INSTAGRAM
                  ContactFieldBubble(
                    isFormField: true,
                    textController: _instagramController,
                    title: superPhrase(context, 'phid_instagramLink'),
                    leadingIcon: Iconz.comInstagram,
                    keyboardTextInputAction: TextInputAction.next,
                  ),

                  /// --- EDIT LINKEDIN
                  ContactFieldBubble(
                    isFormField: true,
                    textController: _linkedInController,
                    title: superPhrase(context, 'phid_linkedinLink'),
                    leadingIcon: Iconz.comLinkedin,
                    keyboardTextInputAction: TextInputAction.next,
                  ),

                  /// --- EDIT TWITTER
                  ContactFieldBubble(
                    isFormField: true,
                    textController: _twitterController,
                    title: superPhrase(context, 'phid_twitterLink'),
                    leadingIcon: Iconz.comTwitter,
                    keyboardTextInputAction: TextInputAction.done,
                  ),

                  const Horizon(),

                  if (_keyboardIsOn == true)
                    const SizedBox(
                      width: 20,
                      height: 150,
                    ),

                ],
              ),

              /// --- CONFIRM BUTTON
              Positioned(
                bottom: 0,
                child: DreamBox(
                  height: 50,
                  width: Bubble.clearWidth(context),
                  color: Colorz.yellow255,
                  // icon: Iconz.Check,
                  // iconColor: Colorz.Black225,
                  // iconSizeFactor: 0.5,
                  verse: superPhrase(context, 'phid_updateProfile'),
                  verseColor: Colorz.black230,
                  verseScaleFactor: 0.9,
                  verseWeight: VerseWeight.black,
                  margins: const EdgeInsets.all(10),
                  onTap: _confirmEdits,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
