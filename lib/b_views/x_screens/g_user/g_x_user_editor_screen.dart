import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/contact_field_bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/locale_bubble.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/text_field_bubble.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/fire/ops/zone_ops.dart' as ZoneOps;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const EditProfileScreen({
    @required this.user,
    this.firstTimer = false,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final UserModel user;
  final bool firstTimer;

  /// --------------------------------------------------------------------------
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();

  /// --------------------------------------------------------------------------
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --------------------
  final TextEditingController _nameController = TextEditingController();
  File _currentPicFile;
  String _currentPicURL;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  Gender _currentGender;
  ZoneModel _currentZone;
  // String _currentLanguageCode;
  GeoPoint _currentPosition;
  // --------------------
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _youTubeController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _pinterestController = TextEditingController();
  final TextEditingController _tiktokController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (function == null) {
      setState(() {
        _loading = !_loading;
      });
    } else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
  }

// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
    _currentPicURL = widget.user.pic;
    _companyController.text = widget.user.company;
    _currentGender = widget.user.gender;
    _titleController.text = widget.user.title;
    _currentZone = widget.firstTimer == true ? null : widget.user.zone;
    _phoneController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.phone);
    _emailController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.email);
    _websiteController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.website);
    _facebookController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.facebook);
    _linkedInController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.linkedIn);
    _youTubeController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.youtube);
    _instagramController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.instagram);
    _pinterestController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.pinterest);
    _tiktokController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.tiktok);
    _twitterController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.twitter);
  }

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (widget.firstTimer == true) {
        _triggerLoading().then((_) async {
          final ZoneModel _zone = await ZoneOps.superGetZone(context);

          unawaited(_triggerLoading(function: () {
            _currentZone = _zone;
          }));
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

// -----------------------------------------------------------------------------
  @override
  void dispose() {
    if (TextChecker.textControllerIsEmpty(_nameController)) {
      _nameController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_titleController)) {
      _titleController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_companyController)) {
      _companyController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_phoneController)) {
      _phoneController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_emailController)) {
      _emailController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_websiteController)) {
      _websiteController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_facebookController)) {
      _facebookController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_linkedInController)) {
      _linkedInController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_youTubeController)) {
      _youTubeController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_instagramController)) {
      _instagramController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_pinterestController)) {
      _pinterestController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_tiktokController)) {
      _tiktokController.dispose();
    }
    if (TextChecker.textControllerIsEmpty(_twitterController)) {
      _twitterController.dispose();
    }

    super.dispose();
  }

// -----------------------------------------------------------------------------
  bool _canPickImage = true;
  Future<void> _takeGalleryPicture() async {
    if (_canPickImage == true) {
      _canPickImage = false;

      blog('getting the pic');

      final File _imageFile =
          await Imagers.takeGalleryPicture(picType: Imagers.PicType.userPic);

      blog('we got the pic in : ${_imageFile.path}');

      if (_imageFile == null) {
        setState(() {
          _currentPicFile = null;
          _canPickImage = true;
        });
      } else {
        setState(() {
          _currentPicFile = _imageFile;
          _canPickImage = true;
        });
      }
    }
  }

// -----------------------------------------------------------------------------
  void _deleteLogo() {
    setState(() {
      _currentPicFile = null;
    });
  }

// -----------------------------------------------------------------------------
  // void _changeGender(Gender gender){
  //   setState(()=> _currentGender = gender);
  // }
// -----------------------------------------------------------------------------
  void _changeCountry(String countryID) {
    setState(() {
      _currentZone.countryID = countryID;
      _currentZone.cityID = null;
      _currentZone.districtID = null;
    });
  }

// -----------------------------------------------------------------------------
  void _changeCity(String cityID) {
    setState(() {
      _currentZone.cityID = cityID;
      _currentZone.districtID = null;
    });
  }

// -----------------------------------------------------------------------------
  void _changeDistrict(String districtID) {
    setState(() {
      _currentZone.districtID = districtID;
    });
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
      webSite: TextMod.removeSpacesFromAString(_websiteController.text),
      facebook: TextMod.removeSpacesFromAString(_facebookController.text),
      linkedIn: TextMod.removeSpacesFromAString(_linkedInController.text),
      youTube: TextMod.removeSpacesFromAString(_youTubeController.text),
      instagram: TextMod.removeSpacesFromAString(_instagramController.text),
      pinterest: TextMod.removeSpacesFromAString(_pinterestController.text),
      tikTok: TextMod.removeSpacesFromAString(_tiktokController.text),
      twitter: TextMod.removeSpacesFromAString(_twitterController.text),
    );
    return newContacts;
  }

// -----------------------------------------------------------------------------
  bool _inputsAreValid() {
    bool _inputsAreValid;
    if (_formKey.currentState.validate()) {
      _inputsAreValid = true;
    } else {
      _inputsAreValid = false;
    }
    return _inputsAreValid;
  }

// -----------------------------------------------------------------------------
  Future<void> _confirmEdits() async {
    bool _continueOps = await CenterDialog.showCenterDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to continue ?',
      boolDialog: true,
    );

    _continueOps = true;
    if (_continueOps == true) {
      widget.firstTimer ? await _createNewUser() : await _updateExistingUser();
    }
  }

// -----------------------------------------------------------------------------
  /// create new user
  Future<void> _createNewUser() async {
    /// validate all required fields are valid
    if (_inputsAreValid() == false) {
      /// TASK : add error missing data indicator in UI bubbles
      await CenterDialog.showCenterDialog(
        context: context,
        title: '',
        body: 'Please add all required fields',
      );
    } else {
      unawaited(_triggerLoading());

      /// create new UserModel
      final UserModel _newUserModel = UserModel(
        id: widget.user.id,
        createdAt: DateTime.now(), // will be overridden in createUserOps
        status: UserStatus.normal,
        // -------------------------
        name: _nameController.text,
        trigram: TextGen.createTrigram(input: _nameController.text),
        pic: _currentPicFile ?? _currentPicURL,
        title: _titleController.text,
        company: _companyController.text,
        gender: _currentGender,
        zone: _currentZone,
        language: Wordz.languageCode(context),
        position: _currentPosition,
        contacts: _createContactList(existingContacts: widget.user.contacts),
        // -------------------------
        myBzzIDs: <String>[],
        // -------------------------
        isAdmin: widget.user.isAdmin,
        authBy: widget.user.authBy,
        emailIsVerified: widget.user.emailIsVerified,
        fcmToken: widget.user.fcmToken,
        savedFlyersIDs: widget.user.savedFlyersIDs,
        followedBzzIDs: widget.user.followedBzzIDs,
      );

      /// start create user ops
      await UserFireOps.createUser(
        context: context,
        userModel: _newUserModel,
        authBy: widget.user.authBy,
      );

      unawaited(_triggerLoading());

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Great !',
        body: 'Successfully created your user account',
      );

      // Nav.goToRoute(context, Routez.UserChecker);
      Nav.goBack(context);
      // Nav.goBackToUserChecker(context);
    }
  }

// -----------------------------------------------------------------------------
  /// update user
  Future<void> _updateExistingUser() async {
    /// validate all required fields are valid
    if (_inputsAreValid() == false) {
      /// TASK : add error missing data indicator in UI bubbles
      await CenterDialog.showCenterDialog(
        context: context,
        title: '',
        body: 'Please add all required fields',
      );
    } else {
      unawaited(_triggerLoading());

      /// create new updated user model
      final UserModel _updatedModel = UserModel(
        // -------------------------
        id: widget.user.id,
        createdAt: widget.user.createdAt,
        status: widget.user.status,
        // -------------------------
        name: _nameController.text,
        trigram: TextGen.createTrigram(input: _nameController.text),
        pic: _currentPicFile ?? _currentPicURL,
        title: _titleController.text,
        company: _companyController.text,
        gender: _currentGender,
        zone: _currentZone,
        language: Wordz.languageCode(context),
        position: _currentPosition,
        contacts: _createContactList(existingContacts: widget.user.contacts),
        // -------------------------
        myBzzIDs: widget.user.myBzzIDs,
        // -------------------------
        isAdmin: widget.user.isAdmin,
        emailIsVerified: widget.user.emailIsVerified,
        authBy: widget.user.authBy,
        fcmToken: widget.user.fcmToken,
        followedBzzIDs: widget.user.followedBzzIDs,
        savedFlyersIDs: widget.user.savedFlyersIDs,
      );

      /// start create user ops
      await UserFireOps.updateUser(
        context: context,
        oldUserModel: widget.user,
        updatedUserModel: _updatedModel,
      );

      unawaited(_triggerLoading());

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Great !',
        body: 'Successfully updated your user account',
      );

      Nav.goBack(context);
    }
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.pyramidzYellow,
      skyType: SkyType.black,
      // appBarBackButton: true,
      loading: _loading,
      appBarType: AppBarType.basic,
      pageTitle: widget.firstTimer == true
          ? 'Add your profile data'
          : Wordz.editProfile(context),
      // tappingRageh: () async {
      //
      //   final bool _result = await CenterDialog.showCenterDialog(
      //     context: context,
      //     title: 'Delete user ?',
      //     boolDialog: true,
      //   );
      //
      //   if (_result == true){
      //
      //     /// create new updated user model
      //     final UserModel _updatedModel = UserModel(
      //       // -------------------------
      //       id : widget.user.id,
      //       createdAt : widget.user.createdAt,
      //       status : widget.user.status,
      //       // -------------------------
      //       name : _nameController.text,
      //       trigram: TextGen.createTrigram(input: _nameController.text),
      //       pic :  _currentPicFile ?? _currentPicURL,
      //       title :  _titleController.text,
      //       company: _companyController.text,
      //       gender : _currentGender,
      //       zone : _currentZone,
      //       language : Wordz.languageCode(context),
      //       position : _currentPosition,
      //       contacts : _createContactList(existingContacts : widget.user.contacts),
      //       // -------------------------
      //       myBzzIDs: widget.user.myBzzIDs,
      //       // -------------------------
      //       isAdmin: widget.user.isAdmin,
      //       emailIsVerified: widget.user.emailIsVerified,
      //       authBy: widget.user.authBy,
      //       fcmToken: widget.user.fcmToken,
      //       followedBzzIDs: widget.user.followedBzzIDs,
      //       savedFlyersIDs: widget.user.savedFlyersIDs,
      //     );
      //     await UserFireOps.deleteUser(context: context, userModel: _updatedModel);
      //     await Nav.goBack(context);
      //   }
      //
      //   else {
      //     _currentZone.printZone();
      //
      //     setState(() {
      //
      //     });
      //
      //   }
      //
      // },
      layoutWidget: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[

            const Stratosphere(),

            AddGalleryPicBubble(
              pic: _currentPicFile ?? _currentPicURL,
              addBtFunction: _takeGalleryPicture,
              deletePicFunction: _deleteLogo,
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
            if (_currentZone?.isNotEmpty() == true)
              LocaleBubble(
                changeCountry: (String countryID) => _changeCountry(countryID),
                changeCity: (String cityID) => _changeCity(cityID),
                changeDistrict: (String districtID) =>
                    _changeDistrict(districtID),
                // zone: Zone(countryID: userModel.country, cityID: userModel.city, districtID: userModel.districtID),
                currentZone: _currentZone,
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

            /// --- EDIT WEBSITE
            ContactFieldBubble(
              textController: _websiteController,
              fieldIsFormField: true,
              title: Wordz.website(context),
              leadingIcon: Iconz.comWebsite,
              keyboardTextInputAction: TextInputAction.next,
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

            /// --- EDIT YOUTUBE
            ContactFieldBubble(
              textController: _youTubeController,
              fieldIsFormField: true,
              title: Wordz.youtubeChannel(context),
              leadingIcon: Iconz.comYoutube,
              keyboardTextInputAction: TextInputAction.next,
            ),

            /// --- EDIT PINTEREST
            ContactFieldBubble(
              textController: _pinterestController,
              fieldIsFormField: true,
              title: Wordz.pinterestLink(context),
              leadingIcon: Iconz.comPinterest,
              keyboardTextInputAction: TextInputAction.next,
            ),

            /// --- EDIT TIKTOK
            ContactFieldBubble(
              textController: _tiktokController,
              fieldIsFormField: true,
              title: Wordz.tiktokLink(context),
              leadingIcon: Iconz.comTikTok,
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

            /// --- CONFIRM BUTTON
            DreamBox(
              height: 50,
              width: Bubble.clearWidth(context),
              color: Colorz.yellow255,
              // icon: Iconz.Check,
              // iconColor: Colorz.Black225,
              // iconSizeFactor: 0.5,
              verse: widget.firstTimer == true
                  ? Wordz.confirm(context)
                  : Wordz.updateProfile(context),
              verseColor: Colorz.black230,
              verseScaleFactor: 0.9,
              verseWeight: VerseWeight.black,
              margins: const EdgeInsets.all(20),
              onTap: _confirmEdits,
            ),

            const Horizon(),
          ],
        ),
      ),
    );
  }
}
