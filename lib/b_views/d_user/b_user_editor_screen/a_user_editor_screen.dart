import 'dart:async';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/user/user_validators.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/x_user_editor_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/gender_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const EditProfileScreen({
    @required this.userModel,
    @required this.onFinish,
    @required this.canGoBack,
    @required this.reAuthBeforeConfirm,
    this.checkLastSession = true,
    this.validateOnStartup = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final Function onFinish;
  final bool canGoBack;
  final bool reAuthBeforeConfirm;
  final bool checkLastSession;
  final bool validateOnStartup;
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
  final ValueNotifier<UserModel> _lastTempUser = ValueNotifier(null);
  // --------------------
  final FocusNode _nameNode = FocusNode();
  final FocusNode _titleNode = FocusNode();
  final FocusNode _companyNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
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

    initializeUserEditorLocalVariables(
      context: context,
      oldUser: widget.userModel,
      tempUser: _tempUser,
    );

  }
// -----------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        await prepareUserZoneAndPicForEditing(
          context: context,
          tempUser: _tempUser,
          oldUser: widget.userModel,
        );
        // -----------------------------
        if (widget.checkLastSession == true){
          await loadUserEditorLastSession(
            context: context,
            oldUser: widget.userModel,
            onFinish: widget.onFinish,
            canGoBack: widget.canGoBack,
            reAuthBeforeConfirm: widget.reAuthBeforeConfirm,
          );
        }
        // -----------------------------
        if (widget.validateOnStartup == true){
          Formers.validateForm(_formKey);
        }
        // -----------------------------
        if (mounted == true){
          _tempUser.addListener((){
            saveUserEditorSession(
              context: context,
              mounted: mounted,
              oldUserModel: widget.userModel,
              tempUser: _tempUser,
              lastTempUser: _lastTempUser,
            );
          });
        }
        // -----------------------------
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

    _nameNode.dispose();
    _titleNode.dispose();
    _companyNode.dispose();
    _emailNode.dispose();
    _phoneNode.dispose();

    _tempUser.dispose();
    _lastTempUser.dispose();

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
        ),

      ),
      layoutWidget: Form(
        key: _formKey,
        child: ValueListenableBuilder(
          valueListenable: _tempUser,
          builder: (_, UserModel userModel, Widget child){

            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: <Widget>[

                const Stratosphere(),

                /// PICTURE
                AddImagePicBubble(
                  titleVerse: 'phid_picture',
                  redDot: true,
                  fileModel: userModel.pic,
                  bubbleType: BubbleType.userPic,
                  onAddPicture: (ImagePickerType imagePickerType) => takeUserPicture(
                    context: context,
                    canPickImage: _canPickImage,
                    userNotifier: _tempUser,
                    imagePickerType: imagePickerType,
                  ),
                ),

                /// GENDER
                GenderBubble(
                  selectedGender: userModel.gender,
                  onTap: (Gender gender) => onChangeGender(
                    selectedGender: gender,
                    tempUser: _tempUser,
                  ),
                ),

                /// NAME
                TextFieldBubble(
                  key: const ValueKey<String>('name'),
                  globalKey: _formKey,
                  focusNode: _nameNode,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  titleVerse: 'phid_name',
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  initialTextValue: userModel.name,
                  textOnChanged: (String text) => onUserNameChanged(
                    text: text,
                    tempUser: _tempUser,
                  ),
                  autoValidate: true,
                  validator: () => UserValidators.nameValidator(
                    userModel: userModel,
                  ),
                ),

                /// JOB TITLE
                TextFieldBubble(
                  key: const ValueKey<String>('title'),
                  globalKey: _formKey,

                  focusNode: _titleNode,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  titleVerse: 'phid_jobTitle',
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  initialTextValue: userModel.title,
                  textOnChanged: (String text) => onUserJobTitleChanged(
                    tempUser: _tempUser,
                    text: text,
                  ),
                  autoValidate: true,
                  validator: () => UserValidators.jobTitleValidator(
                    userModel: userModel,
                  ),
                ),

                /// COMPANY NAME
                TextFieldBubble(
                  key: const ValueKey<String>('company'),
                  globalKey: _formKey,
                  focusNode: _companyNode,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  titleVerse: 'phid_companyName',
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  initialTextValue: userModel.company,
                  autoValidate: true,
                  textOnChanged: (String text) => onUserCompanyNameChanged(
                    text: text,
                    tempUser: _tempUser,
                  ),

                  validator: () => UserValidators.companyNameValidator(
                    userModel: userModel,
                  ),
                ),

                /// PHONE
                TextFieldBubble(
                  key: const ValueKey<String>('phone'),
                  globalKey: _formKey,
                  focusNode: _phoneNode,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  // textController: _companyController,
                  titleVerse: 'phid_phone',
                  keyboardTextInputType: TextInputType.phone,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  initialTextValue: ContactModel.getInitialContactValue(
                    type: ContactType.phone,
                    countryID: userModel.zone.countryID,
                    existingContacts: userModel.contacts,
                  ),
                  textOnChanged: (String text) => onUserContactChanged(
                    contactType: ContactType.phone,
                    value: text,
                    tempUser: _tempUser,
                  ),
                  validator: () => UserValidators.phoneValidator(userModel),
                ),

                /// EMAIL
                TextFieldBubble(
                  key: const ValueKey<String>('email'),
                  globalKey: _formKey,
                  focusNode: _emailNode,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  titleVerse: 'phid_email',
                  keyboardTextInputType: TextInputType.emailAddress,
                  keyboardTextInputAction: TextInputAction.done,
                  fieldIsRequired: true,
                  initialTextValue: ContactModel.getInitialContactValue(
                    type: ContactType.email,
                    countryID: userModel.zone.countryID,
                    existingContacts: userModel.contacts,
                  ),
                  textOnChanged: (String text) => onUserContactChanged(
                    contactType: ContactType.email,
                    value: text,
                    tempUser: _tempUser,
                  ),
                  validator: () => UserValidators.emailValidator(userModel),
                ),

                /// ZONE
                ZoneSelectionBubble(
                  currentZone: userModel.zone,
                  onZoneChanged: (ZoneModel zoneModel) => onUserZoneChanged(
                    selectedZone: zoneModel,
                    tempUser: _tempUser,
                  ),
                ),

                /// CONTACTS
                // ContactsEditorsBubbles(
                //   globalKey: formKey,
                //   contacts: userModel.contacts,
                //   contactsOwnerType: ContactsOwnerType.user,
                //   appBarType: appBarType,
                // ),

                const Horizon(),

              ],
            );

          },
        ),
      ),

    );

  }
}
