import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/secondary_models/contact_model.dart';
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
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/c_controllers/b_0_auth_controller.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/fire/ops/zone_ops.dart' as ZoneOps;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
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
  final ValueChanged<UserModel> onFinish;
  /// --------------------------------------------------------------------------
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
  /// --------------------------------------------------------------------------
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --------------------
  final ValueNotifier<dynamic> _picture = ValueNotifier(null);
  final ValueNotifier<Gender> _gender = ValueNotifier(null);
  final ValueNotifier<ZoneModel> _zone = ValueNotifier(null);

  String _currentLanguageCode;
  GeoPoint _currentPosition;

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
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(true);
// -----------------------------------
  Future<void> _triggerLoading({@required setTo}) async {
    _loading.value = setTo;
    blogLoading(loading: _loading.value);
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
    _disposeControllers();
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
    _phoneController.text     = ContactModel.getAContactValueFromContacts(widget.userModel.contacts, ContactType.phone);
    _emailController.text     = ContactModel.getAContactValueFromContacts(widget.userModel.contacts, ContactType.email);
    _facebookController.text  = ContactModel.getAContactValueFromContacts(widget.userModel.contacts, ContactType.facebook);
    _linkedInController.text  = ContactModel.getAContactValueFromContacts(widget.userModel.contacts, ContactType.linkedIn);
    _instagramController.text = ContactModel.getAContactValueFromContacts(widget.userModel.contacts, ContactType.instagram);
    _twitterController.text   = ContactModel.getAContactValueFromContacts(widget.userModel.contacts, ContactType.twitter);
  }
// -----------------------------------------------------------------------------
  void _disposeControllers(){
    TextChecker.disposeControllerIfPossible(_nameController);
    TextChecker.disposeControllerIfPossible(_titleController);
    TextChecker.disposeControllerIfPossible(_companyController);
    TextChecker.disposeControllerIfPossible(_phoneController);
    TextChecker.disposeControllerIfPossible(_emailController);
    TextChecker.disposeControllerIfPossible(_facebookController);
    TextChecker.disposeControllerIfPossible(_linkedInController);
    TextChecker.disposeControllerIfPossible(_instagramController);
    TextChecker.disposeControllerIfPossible(_twitterController);
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _canPickImage = ValueNotifier(true);
// -----------------------------------------------------------------------------
  Future<void> _takeGalleryPicture() async {

    if (_canPickImage.value == true) {

      _canPickImage.value = false;

      final File _imageFile = await Imagers.takeGalleryPicture(
          picType: Imagers.PicType.userPic,
      );

      blog('we got the pic in : ${_imageFile.path}');

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
  // void _changePosition(GeoPoint geoPoint){
  //   setState(() => _currentPosition = geoPoint );
  // }
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
        await _updateUserModel(
          updatedUserModel: _updatedModel,
        );
      }

    }

    widget.onFinish(_updatedModel);
  }
// -----------------------------------------------------------------------------
  /// update user
  Future<void> _updateUserModel({
    @required UserModel updatedUserModel,
  }) async {

    unawaited(_triggerLoading(setTo: true));

    /// start create user ops
    await UserFireOps.updateUser(
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
      position: _currentPosition,
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
      pageTitle: Wordz.updateProfile(context),
      appBarRowWidgets: [

        DreamBox(
          height: 40,
          width: 100,
          verse: 'do the thing',
          onTap: () async {
            blog('picture is : ${widget.userModel.pic}');
          },
        )

      ],
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
                    textController: _nameController,
                    key: const Key('name'),
                    fieldIsFormField: true,
                    title: Wordz.name(context),
                    keyboardTextInputType: TextInputType.name,
                    keyboardTextInputAction: TextInputAction.next,
                    fieldIsRequired: true,
                    validator: (String val) =>
                    val.isEmpty ? Wordz.enterName(context) : null,
                  ),

                  GenderBubble(
                    selectedGender: _gender,
                    onTap: (Gender gender) => _onGenderTap(gender),
                  ),

                  /// --- EDIT JOB TITLE
                  TextFieldBubble(
                    textController: _titleController,
                    key: const Key('title'),
                    fieldIsFormField: true,
                    title: Wordz.jobTitle(context),
                    keyboardTextInputType: TextInputType.name,
                    keyboardTextInputAction: TextInputAction.next,
                    fieldIsRequired: true,
                    validator: (String val) =>
                    val.isEmpty ? Wordz.enterJobTitle(context) : null,
                  ),

                  /// --- EDIT COMPANY NAME
                  TextFieldBubble(
                    textController: _companyController,
                    key: const Key('company'),
                    fieldIsFormField: true,
                    title: Wordz.companyName(context),
                    keyboardTextInputType: TextInputType.name,
                    keyboardTextInputAction: TextInputAction.next,
                    fieldIsRequired: true,
                    validator: (String val) =>
                    val.isEmpty ? Wordz.enterCompanyName(context) : null,
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
                    textController: _emailController,
                    fieldIsFormField: true,
                    title: Wordz.emailAddress(context),
                    leadingIcon: Iconz.comEmail,
                    keyboardTextInputAction: TextInputAction.next,
                    fieldIsRequired: true,
                    keyboardTextInputType: TextInputType.emailAddress,
                  ),

                  /// --- EDIT PHONE
                  ContactFieldBubble(
                    textController: _phoneController,
                    fieldIsFormField: true,
                    title: Wordz.phone(context),
                    leadingIcon: Iconz.comPhone,
                    keyboardTextInputAction: TextInputAction.next,
                    keyboardTextInputType: TextInputType.phone,
                  ),

                  /// --- EDIT FACEBOOK
                  ContactFieldBubble(
                    textController: _facebookController,
                    fieldIsFormField: true,
                    title: Wordz.facebookLink(context),
                    leadingIcon: Iconz.comFacebook,
                    keyboardTextInputAction: TextInputAction.next,
                  ),

                  /// --- EDIT INSTAGRAM
                  ContactFieldBubble(
                    textController: _instagramController,
                    fieldIsFormField: true,
                    title: Wordz.instagramLink(context),
                    leadingIcon: Iconz.comInstagram,
                    keyboardTextInputAction: TextInputAction.next,
                  ),

                  /// --- EDIT LINKEDIN
                  ContactFieldBubble(
                    textController: _linkedInController,
                    fieldIsFormField: true,
                    title: Wordz.linkedinLink(context),
                    leadingIcon: Iconz.comLinkedin,
                    keyboardTextInputAction: TextInputAction.next,
                  ),

                  /// --- EDIT TWITTER
                  ContactFieldBubble(
                    textController: _twitterController,
                    fieldIsFormField: true,
                    title: 'Twitter link', //Wordz.twitterLink(context),
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
                  verse: Wordz.updateProfile(context),
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
