import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/widgets/bubbles/add_gallery_pic_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/contact_field_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
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
  String _currentCountryID;
  String _currentProvinceID;
  String _currentAreaID;
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
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _nameController.text = widget.user.name;
    _currentPicURL = widget.user.pic;
    _companyController.text = widget.user.company;
    _currentGender = widget.user.gender;
    _titleController.text = widget.user.title;
    _currentCountryID = widget.user.country;
    _currentProvinceID = widget.user.province;
    _currentAreaID = widget.user.area;
    _phoneController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.Phone);
    _emailController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.Email);
    _websiteController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.WebSite);
    _facebookController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.Facebook);
    _linkedInController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.LinkedIn);
    _youTubeController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.YouTube);
    _instagramController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.Instagram);
    _pinterestController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.Pinterest);
    _tiktokController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.TikTok);
    _twitterController.text = ContactModel.getAContactValueFromContacts(widget.user.contacts, ContactType.Twitter);
    super.initState();
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
  Future<void> _takeGalleryPicture() async {
    final _imageFile = await takeGalleryPicture(PicType.userPic);
    setState(() {_currentPicFile = _imageFile;});
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
      _currentCountryID = countryID;
      _currentProvinceID = null;
      _currentAreaID = null;
    });
  }
// -----------------------------------------------------------------------------
  void _changeProvince(String provinceID){
    setState(() {
      _currentProvinceID = provinceID;
      _currentAreaID = null;
    });
  }
// -----------------------------------------------------------------------------
  void _changeArea(String areaID){
    setState(() {_currentAreaID = areaID;});
  }
// -----------------------------------------------------------------------------
  // void _changePosition(GeoPoint geoPoint){
  //   setState(() => _currentPosition = geoPoint );
  // }
// -----------------------------------------------------------------------------
  List<ContactModel> _createContactList({List<ContactModel> existingContacts}){
  /// takes current contacts, overrides them on existing contact list, then
  /// return a new contacts list with all old values and new overridden values
    List<ContactModel> newContacts = ContactModel.createContactsList(
      existingContacts: existingContacts,
      phone: removeSpacesFromAString(_phoneController.text),
      email: removeSpacesFromAString(_emailController.text),
      webSite: removeSpacesFromAString(_websiteController.text),
      facebook: removeSpacesFromAString(_facebookController.text),
      linkedIn: removeSpacesFromAString(_linkedInController.text),
      youTube: removeSpacesFromAString(_youTubeController.text),
      instagram: removeSpacesFromAString(_instagramController.text),
      pinterest: removeSpacesFromAString(_pinterestController.text),
      tikTok: removeSpacesFromAString(_tiktokController.text),
      twitter: removeSpacesFromAString(_twitterController.text),
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

    bool _continueOps = await superDialog(
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
      await superDialog(
        context: context,
        title: '',
        body: 'Please add all required fields',
        boolDialog: false,
      );

    } else {

      _triggerLoading();

      /// create new UserModel
      UserModel _newUserModel = UserModel(
          userID : widget.user.userID,
          joinedAt : DateTime.now(), // will be overridden in createUserOps
          userStatus : UserStatus.Normal,
          // -------------------------
          name : _nameController.text,
          pic : _currentPicFile ?? _currentPicURL,
          title :  _titleController.text,
          company: _companyController.text,
          gender : _currentGender,
          country : _currentCountryID,
          province : _currentProvinceID,
          area : _currentAreaID,
          language : Wordz.languageCode(context),
          position : _currentPosition,
          contacts : _createContactList(existingContacts : widget.user.contacts),
          // -------------------------
          myBzzIDs: [],
        // -------------------------
      );

      /// start create user ops
      await UserOps().createUserOps(
          context: context,
          userModel: _newUserModel
      );

      _triggerLoading();

      await superDialog(
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
      await superDialog(
        context: context,
        title: '',
        body: 'Please add all required fields',
        boolDialog: false,
      );

    } else {

      _triggerLoading();

      /// create new updated user model
      UserModel _updatedModel = UserModel(
        // -------------------------
          userID : widget.user.userID,
          joinedAt : widget.user.joinedAt,
          userStatus : widget.user.userStatus,
          // -------------------------
          name : _nameController.text,
          pic :  _currentPicFile ?? _currentPicURL,
          title :  _titleController.text,
          company: _companyController.text,
          gender : _currentGender,
          country : _currentCountryID,
          province : _currentProvinceID,
          area : _currentAreaID,
          language : Wordz.languageCode(context),
          position : _currentPosition,
          contacts : _createContactList(existingContacts : widget.user.contacts),
          // -------------------------
          myBzzIDs: widget.user.myBzzIDs,
        // -------------------------
      );

      /// start create user ops
      await UserOps().updateUserOps(
        context: context,
        oldUserModel: widget.user,
        updatedUserModel: _updatedModel,
      );

      _triggerLoading();

      await superDialog(
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
      appBarBackButton: true,
      loading: _loading,
      appBarType: AppBarType.Basic,
      tappingRageh: (){
        print(_currentAreaID,);
        print(_currentProvinceID,);
        print(_currentCountryID,);
      },
      pageTitle: widget.firstTimer == true ? 'Add your profile data' : Wordz.editProfile(context),
      layoutWidget: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[

            Stratosphere(),

            AddGalleryPicBubble(
              pic: _currentPicFile == null ? _currentPicURL : _currentPicFile,
              addBtFunction: _takeGalleryPicture,
              deletePicFunction: _deleteLogo,
              bubbleType: BubbleType.userPic,
            ),

            // --- EDIT NAME
            TextFieldBubble(
              textController: _nameController,
              key: Key('name'),
              fieldIsFormField: true,
              title: Wordz.name(context),
              keyboardTextInputType: TextInputType.name,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: true,
              validator: (val) => val.isEmpty ? Wordz.enterName(context) : null,
            ),

            // --- EDIT JOB TITLE
            TextFieldBubble(
              textController: _titleController,
              key: Key('title'),
              fieldIsFormField: true,
              title: Wordz.jobTitle(context),
              keyboardTextInputType: TextInputType.name,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: true,
              validator: (val) => val.isEmpty ? Wordz.enterJobTitle(context) : null,
            ),

            // --- EDIT COMPANY NAME
            TextFieldBubble(
              textController: _companyController,
              key: Key('company'),
              fieldIsFormField: true,
              title: Wordz.companyName(context),
              keyboardTextInputType: TextInputType.name,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: true,
              validator: (val) => val.isEmpty ? Wordz.enterCompanyName(context) : null,
            ),

            // --- EDIT HQ
            LocaleBubble(
              title : 'Preferred Location',
              changeCountry : (countryID) => _changeCountry(countryID),
              changeProvince : (provinceID) => _changeProvince(provinceID),
              changeArea : (areaID) => _changeArea(areaID),
              // zone: Zone(countryID: userModel.country, provinceID: userModel.province, areaID: userModel.area),
              currentZone: Zone(countryID: _currentCountryID, provinceID: _currentProvinceID, areaID: _currentAreaID),
            ),

            // --- EDIT EMAIL
            ContactFieldBubble(
              textController: _emailController,
              fieldIsFormField: true,
              title: Wordz.emailAddress(context),
              leadingIcon: Iconz.ComEmail,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: true,
              keyboardTextInputType: TextInputType.emailAddress,
            ),

            // --- EDIT PHONE
            ContactFieldBubble(
              textController: _phoneController,
              fieldIsFormField: true,
              title: Wordz.phone(context),
              leadingIcon: Iconz.ComPhone,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.phone,
            ),

            // --- EDIT WEBSITE
            ContactFieldBubble(
              textController: _websiteController,
              fieldIsFormField: true,
              title: Wordz.website(context),
              leadingIcon: Iconz.ComWebsite,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            // --- EDIT FACEBOOK
            ContactFieldBubble(
              textController: _facebookController,
              fieldIsFormField: true,
              title: Wordz.facebookLink(context),
              leadingIcon: Iconz.ComFacebook,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            // --- EDIT INSTAGRAM
            ContactFieldBubble(
              textController: _instagramController,
              fieldIsFormField: true,
              title: Wordz.instagramLink(context),
              leadingIcon: Iconz.ComInstagram,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            // --- EDIT LINKEDIN
            ContactFieldBubble(
              textController: _linkedInController,
              fieldIsFormField: true,
              title: Wordz.linkedinLink(context),
              leadingIcon: Iconz.ComLinkedin,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            // --- EDIT YOUTUBE
            ContactFieldBubble(
              textController: _youTubeController,
              fieldIsFormField: true,
              title: Wordz.youtubeChannel(context),
              leadingIcon: Iconz.ComYoutube,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            // --- EDIT PINTEREST
            ContactFieldBubble(
              textController: _pinterestController,
              fieldIsFormField: true,
              title: Wordz.pinterestLink(context),
              leadingIcon: Iconz.ComPinterest,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            // --- EDIT TIKTOK
            ContactFieldBubble(
              textController: _tiktokController,
              fieldIsFormField: true,
              title: Wordz.tiktokLink(context),
              leadingIcon: Iconz.ComTikTok,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            // --- EDIT TWITTER
            ContactFieldBubble(
              textController: _twitterController,
              fieldIsFormField: true,
              title: 'Twitter link',//Wordz.twitterLink(context),
              leadingIcon: Iconz.ComTwitter,
              keyboardTextInputAction: TextInputAction.done,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
            ),

            // --- CONFIRM BUTTON
            DreamBox(
              height: 50,
              width: Scale.superBubbleClearWidth(context),
              color: Colorz.Yellow,
              // icon: Iconz.Check,
              // iconColor: Colorz.BlackBlack,
              // iconSizeFactor: 0.5,
              verse: widget.firstTimer == true ? Wordz.confirm(context) : Wordz.updateProfile(context),
              verseColor: Colorz.BlackBlack,
              verseScaleFactor: 0.9,
              verseWeight: VerseWeight.black,
              boxMargins: EdgeInsets.all(20),
              boxFunction: _confirmEdits,
            ),

            PyramidsHorizon(heightFactor: 5,)

          ],
        ),
      ),
    );
  }
}
