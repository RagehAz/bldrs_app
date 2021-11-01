import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/db/fire/user_ops.dart';
import 'package:bldrs/db/fire/zone_ops.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/add_gallery_pic_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/contact_field_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  final bool firstTimer;

  EditProfileScreen({
    @required this.user,
    this.firstTimer = false,
});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  // --------------------
  TextEditingController _nameController = TextEditingController();
  File _currentPicFile;
  String _currentPicURL;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  Gender _currentGender;
  ZoneModel _currentZone;
  // String _currentLanguageCode;
  GeoPoint _currentPosition;
  // --------------------
 TextEditingController _phoneController = TextEditingController();
 TextEditingController _emailController = TextEditingController();
 TextEditingController _websiteController = TextEditingController();
 TextEditingController _facebookController = TextEditingController();
 TextEditingController _linkedInController = TextEditingController();
 TextEditingController _youTubeController = TextEditingController();
 TextEditingController _instagramController = TextEditingController();
 TextEditingController _pinterestController = TextEditingController();
 TextEditingController _tiktokController = TextEditingController();
 TextEditingController _twitterController = TextEditingController();
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
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

      if (widget.firstTimer == true){
        _triggerLoading().then((_) async{

          final ZoneModel _zone = await ZoneOps.superGetZone(context);


          _triggerLoading(
              function: (){
                _currentZone = _zone;
              }
          );

        });

      }

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    if (TextChecker.textControllerHasNoValue(_nameController))_nameController.dispose();
    if (TextChecker.textControllerHasNoValue(_titleController))_titleController.dispose();
    if (TextChecker.textControllerHasNoValue(_companyController))_companyController.dispose();
    if (TextChecker.textControllerHasNoValue(_phoneController))_phoneController.dispose();
    if (TextChecker.textControllerHasNoValue(_emailController))_emailController.dispose();
    if (TextChecker.textControllerHasNoValue(_websiteController))_websiteController.dispose();
    if (TextChecker.textControllerHasNoValue(_facebookController))_facebookController.dispose();
    if (TextChecker.textControllerHasNoValue(_linkedInController))_linkedInController.dispose();
    if (TextChecker.textControllerHasNoValue(_youTubeController))_youTubeController.dispose();
    if (TextChecker.textControllerHasNoValue(_instagramController))_instagramController.dispose();
    if (TextChecker.textControllerHasNoValue(_pinterestController))_pinterestController.dispose();
    if (TextChecker.textControllerHasNoValue(_tiktokController))_tiktokController.dispose();
    if (TextChecker.textControllerHasNoValue(_twitterController))_twitterController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  bool _canPickImage = true;
  Future<void> _takeGalleryPicture() async {

    if (_canPickImage == true){
      _canPickImage = false;

      final _imageFile = await Imagers.takeGalleryPicture(PicType.userPic);

      setState(() {
        _currentPicFile = _imageFile;
        _canPickImage = true;
      });

    }
  }
// -----------------------------------------------------------------------------
  void _deleteLogo(){
    setState(() {_currentPicFile = null;});
  }
// -----------------------------------------------------------------------------
  // void _changeGender(Gender gender){
  //   setState(()=> _currentGender = gender);
  // }
// -----------------------------------------------------------------------------
  void _changeCountry(String countryID){
    setState(() {
      _currentZone.countryID = countryID;
      _currentZone.cityID = null;
      _currentZone.districtID = null;
    });
  }
// -----------------------------------------------------------------------------
  void _changeCity(String cityID){
    setState(() {
      _currentZone.cityID = cityID;
      _currentZone.districtID = null;
    });
  }
// -----------------------------------------------------------------------------
  void _changeDistrict(String districtID){
    setState(() {_currentZone.districtID = districtID;});
  }
// -----------------------------------------------------------------------------
  // void _changePosition(GeoPoint geoPoint){
  //   setState(() => _currentPosition = geoPoint );
  // }
// -----------------------------------------------------------------------------
  List<ContactModel> _createContactList({List<ContactModel> existingContacts}){
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
  bool _inputsAreValid(){
    bool _inputsAreValid;
    if (_formKey.currentState.validate()){
      _inputsAreValid = true;
    } else {
      _inputsAreValid = false;
    }
    return _inputsAreValid;
  }
// -----------------------------------------------------------------------------
  void _confirmEdits() async {

    bool _continueOps = await CenterDialog.showCenterDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to continue ?',
      boolDialog: true,
    );

    _continueOps = true;
    if (_continueOps == true){
      widget.firstTimer ? _createNewUser() : _updateExistingUser();
    }
  }
// -----------------------------------------------------------------------------
  /// create new user
  void _createNewUser() async {
    /// validate all required fields are valid
    if(_inputsAreValid() == false){

      /// TASK : add error missing data indicator in UI bubbles
      await CenterDialog.showCenterDialog(
        context: context,
        title: '',
        body: 'Please add all required fields',
        boolDialog: false,
      );

    } else {

      _triggerLoading();

      /// create new UserModel
      final UserModel _newUserModel = UserModel(
          id : widget.user.id,
        createdAt : DateTime.now(), // will be overridden in createUserOps
          status : UserStatus.normal,
          // -------------------------
          name : _nameController.text,
          trigram: TextMod.createTrigram(input: _nameController.text),
          pic : _currentPicFile ?? _currentPicURL,
          title :  _titleController.text,
          company: _companyController.text,
          gender : _currentGender,
          zone : _currentZone,
          language : Wordz.languageCode(context),
          position : _currentPosition,
          contacts : _createContactList(existingContacts : widget.user.contacts),
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
      await UserOps.createUserOps(
          context: context,
          userModel: _newUserModel
      );

      _triggerLoading();

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Great !',
        body: 'Successfully created your user account',
        boolDialog: false,
      );

      // Nav.goToRoute(context, Routez.UserChecker);
      Nav.goBack(context);
      // Nav.goBackToUserChecker(context);
    }

  }
// -----------------------------------------------------------------------------
  /// update user
  void _updateExistingUser() async {
    /// validate all required fields are valid
    if(_inputsAreValid() == false){

      /// TASK : add error missing data indicator in UI bubbles
      await CenterDialog.showCenterDialog(
        context: context,
        title: '',
        body: 'Please add all required fields',
        boolDialog: false,
      );

    } else {

      _triggerLoading();

      /// create new updated user model
      final UserModel _updatedModel = UserModel(
        // -------------------------
        id : widget.user.id,
        createdAt : widget.user.createdAt,
        status : widget.user.status,
        // -------------------------
        name : _nameController.text,
        trigram: TextMod.createTrigram(input: _nameController.text),
        pic :  _currentPicFile ?? _currentPicURL,
        title :  _titleController.text,
        company: _companyController.text,
        gender : _currentGender,
        zone : _currentZone,
        language : Wordz.languageCode(context),
        position : _currentPosition,
        contacts : _createContactList(existingContacts : widget.user.contacts),
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
      await UserOps.updateUserOps(
        context: context,
        oldUserModel: widget.user,
        updatedUserModel: _updatedModel,
      );

      _triggerLoading();

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Great !',
        body: 'Successfully updated your user account',
        boolDialog: false,
      );

      Nav.goBack(context);

    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      sky: Sky.Black,
      // appBarBackButton: true,
      loading: _loading,
      appBarType: AppBarType.Basic,
      pageTitle: widget.firstTimer == true ? 'Add your profile data' : Wordz.editProfile(context),
      tappingRageh: () async {
        
        final bool _result = await CenterDialog.showCenterDialog(
          context: context,
          title: 'Delete user ?',
          boolDialog: true,
        );
        
        if (_result == true){

          /// create new updated user model
          final UserModel _updatedModel = UserModel(
            // -------------------------
            id : widget.user.id,
            createdAt : widget.user.createdAt,
            status : widget.user.status,
            // -------------------------
            name : _nameController.text,
            trigram: TextMod.createTrigram(input: _nameController.text),
            pic :  _currentPicFile ?? _currentPicURL,
            title :  _titleController.text,
            company: _companyController.text,
            gender : _currentGender,
            zone : _currentZone,
            language : Wordz.languageCode(context),
            position : _currentPosition,
            contacts : _createContactList(existingContacts : widget.user.contacts),
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
          await UserOps.superDeleteUserOps(context: context, userModel: _updatedModel);
          await Nav.goBack(context);
        }

        else {
          _currentZone.printZone();

          setState(() {

          });

        }
        
      },
      layoutWidget: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[

            const Stratosphere(),

            AddGalleryPicBubble(
              pic: _currentPicFile == null ? _currentPicURL : _currentPicFile,
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
              validator: (val) => val.isEmpty ? Wordz.enterName(context) : null,
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
              validator: (val) => val.isEmpty ? Wordz.enterJobTitle(context) : null,
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
              validator: (val) => val.isEmpty ? Wordz.enterCompanyName(context) : null,
            ),

            /// --- EDIT ZONE
            if (_currentZone?.isNotEmpty() == true)
            LocaleBubble(
              title : 'Preferred Location',
              changeCountry : (countryID) => _changeCountry(countryID),
              changeCity : (cityID) => _changeCity(cityID),
              changeDistrict : (districtID) => _changeDistrict(districtID),
              // zone: Zone(countryID: userModel.country, cityID: userModel.city, districtID: userModel.districtID),
              currentZone: _currentZone,
            ),

            /// --- EDIT EMAIL
            ContactFieldBubble(
              textController: _emailController,
              fieldIsFormField: true,
              title: Wordz.emailAddress(context),
              leadingIcon: Iconz.ComEmail,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: true,
              keyboardTextInputType: TextInputType.emailAddress,
            ),

            /// --- EDIT PHONE
            ContactFieldBubble(
              textController: _phoneController,
              fieldIsFormField: true,
              title: Wordz.phone(context),
              leadingIcon: Iconz.ComPhone,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.phone,
            ),

            /// --- EDIT WEBSITE
            ContactFieldBubble(
              textController: _websiteController,
              fieldIsFormField: true,
              title: Wordz.website(context),
              leadingIcon: Iconz.ComWebsite,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            /// --- EDIT FACEBOOK
            ContactFieldBubble(
              textController: _facebookController,
              fieldIsFormField: true,
              title: Wordz.facebookLink(context),
              leadingIcon: Iconz.ComFacebook,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            /// --- EDIT INSTAGRAM
            ContactFieldBubble(
              textController: _instagramController,
              fieldIsFormField: true,
              title: Wordz.instagramLink(context),
              leadingIcon: Iconz.ComInstagram,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            /// --- EDIT LINKEDIN
            ContactFieldBubble(
              textController: _linkedInController,
              fieldIsFormField: true,
              title: Wordz.linkedinLink(context),
              leadingIcon: Iconz.ComLinkedin,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            /// --- EDIT YOUTUBE
            ContactFieldBubble(
              textController: _youTubeController,
              fieldIsFormField: true,
              title: Wordz.youtubeChannel(context),
              leadingIcon: Iconz.ComYoutube,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            /// --- EDIT PINTEREST
            ContactFieldBubble(
              textController: _pinterestController,
              fieldIsFormField: true,
              title: Wordz.pinterestLink(context),
              leadingIcon: Iconz.ComPinterest,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            /// --- EDIT TIKTOK
            ContactFieldBubble(
              textController: _tiktokController,
              fieldIsFormField: true,
              title: Wordz.tiktokLink(context),
              leadingIcon: Iconz.ComTikTok,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            /// --- EDIT TWITTER
            ContactFieldBubble(
              textController: _twitterController,
              fieldIsFormField: true,
              title: 'Twitter link',//Wordz.twitterLink(context),
              leadingIcon: Iconz.ComTwitter,
              keyboardTextInputAction: TextInputAction.done,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            /// --- CONFIRM BUTTON
            DreamBox(
              height: 50,
              width: Bubble.clearWidth(context),
              color: Colorz.yellow255,
              // icon: Iconz.Check,
              // iconColor: Colorz.Black225,
              // iconSizeFactor: 0.5,
              verse: widget.firstTimer == true ? Wordz.confirm(context) : Wordz.updateProfile(context),
              verseColor: Colorz.black230,
              verseScaleFactor: 0.9,
              verseWeight: VerseWeight.black,
              margins: const EdgeInsets.all(20),
              onTap: _confirmEdits,
            ),

            const PyramidsHorizon(),

          ],
        ),
      ),
    );
  }
}
