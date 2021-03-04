import 'dart:io';
import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/ambassadors/services/firebase_storage.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/drafters/imagers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/text_checkers.dart';
import 'package:bldrs/view_brains/drafters/text_manipulators.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/add_gallery_pic_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/contact_field_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
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
  File   _currentPic;
  TextEditingController _nameController = TextEditingController();
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
    _companyController.text = widget.user.company;
    _titleController.text = widget.user.title;
    _currentCountryID = widget.user.country;
    _currentProvinceID = widget.user.province;
    _currentAreaID = widget.user.area;
    _phoneController.text = getAContactValueFromContacts(widget.user.contacts, ContactType.Phone);
    _emailController.text = getAContactValueFromContacts(widget.user.contacts, ContactType.Email);
    _websiteController.text = getAContactValueFromContacts(widget.user.contacts, ContactType.WebSite);
    _facebookController.text = getAContactValueFromContacts(widget.user.contacts, ContactType.Facebook);
    _linkedInController.text = getAContactValueFromContacts(widget.user.contacts, ContactType.LinkedIn);
    _youTubeController.text = getAContactValueFromContacts(widget.user.contacts, ContactType.YouTube);
    _instagramController.text = getAContactValueFromContacts(widget.user.contacts, ContactType.Instagram);
    _pinterestController.text = getAContactValueFromContacts(widget.user.contacts, ContactType.Pinterest);
    _tiktokController.text = getAContactValueFromContacts(widget.user.contacts, ContactType.TikTok);
    _twitterController.text = getAContactValueFromContacts(widget.user.contacts, ContactType.Twitter);
    super.initState();
  }
  // ---------------------------------------------------------------------------
  @override
  void dispose() {
    if (textControllerHasNoValue(_nameController))_nameController.dispose();
    if (textControllerHasNoValue(_titleController))_titleController.dispose();
    if (textControllerHasNoValue(_companyController))_companyController.dispose();
    if (textControllerHasNoValue(_phoneController))_phoneController.dispose();
    if (textControllerHasNoValue(_emailController))_emailController.dispose();
    if (textControllerHasNoValue(_websiteController))_websiteController.dispose();
    if (textControllerHasNoValue(_facebookController))_facebookController.dispose();
    if (textControllerHasNoValue(_linkedInController))_linkedInController.dispose();
    if (textControllerHasNoValue(_youTubeController))_youTubeController.dispose();
    if (textControllerHasNoValue(_instagramController))_instagramController.dispose();
    if (textControllerHasNoValue(_pinterestController))_pinterestController.dispose();
    if (textControllerHasNoValue(_tiktokController))_tiktokController.dispose();
    if (textControllerHasNoValue(_twitterController))_twitterController.dispose();
    super.dispose();
  }
  // ---------------------------------------------------------------------------
  Future<void> _takeGalleryPicture() async {
    final _imageFile = await takeGalleryPicture(PicType.userPic);
    setState(() {_currentPic = File(_imageFile.path);});
  }
  // ---------------------------------------------------------------------------
  void _deleteLogo(){
    setState(() {_currentPic = null;});
  }
  // ---------------------------------------------------------------------------
  void _changeGender(Gender gender){
    setState(()=> _currentGender = gender);
  }
  // ---------------------------------------------------------------------------
  void _changeCountry(String countryID){
    setState(() {
      _currentCountryID = countryID;
      _currentProvinceID = null;
      _currentAreaID = null;
    });
  }
  // ---------------------------------------------------------------------------
  void _changeProvince(String provinceID){
    setState(() {
      _currentProvinceID = provinceID;
      _currentAreaID = null;
    });
  }
  // ---------------------------------------------------------------------------
  void _changeArea(String areaID){
    setState(() {_currentAreaID = areaID;});
  }
  // ---------------------------------------------------------------------------
  // void _changeLanguage(String languageCode){
  //   setState(() => _currentLanguageCode = languageCode );
  // }
  // ---------------------------------------------------------------------------
  void _changePosition(GeoPoint geoPoint){
    setState(() => _currentPosition = geoPoint );
  }
  // ---------------------------------------------------------------------------
  List<ContactModel> _createContactList(List<ContactModel> existingContacts){
    List<ContactModel> newContacts = createContactsList(
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
  // ---------------------------------------------------------------------------
  void _confirmEdits() async {
    if(_formKey.currentState.validate()){

      _triggerLoading();

      await tryAndCatch(
          context: context,
          functions: () async {
            String _userPicURL;

            if(_currentPic != null){
              _userPicURL =
              await saveUserPicOnFirebaseStorageAndGetURL(
                  inputFile: _currentPic,
                  fileName: widget.user.userID
              );
            }

            // print('_userPicURL : $_userPicURL');

            UserModel _newUserModel = UserModel(
              // -------------------------
              userID : widget.user.userID,
              joinedAt : widget.firstTimer == true ? DateTime.now() : widget.user.joinedAt ?? DateTime.now(),
              userStatus : widget.user.userStatus ?? UserStatus.Normal,
              // -------------------------
              name : _nameController.text ?? widget.user.name,
              pic : _userPicURL ?? widget.user.pic,
              title :  _titleController.text ?? widget.user.title,
              company: _companyController.text ?? widget.user.company,
              gender : _currentGender ?? widget.user.gender,
              country : _currentCountryID ?? widget.user.country,
              province : _currentProvinceID ?? widget.user.province,
              area : _currentAreaID ?? widget.user.area,
              language : Wordz.languageCode(context),
              position : _currentPosition ?? widget.user.position,
              contacts : _createContactList(widget.user.contacts),
              // -------------------------
              savedFlyersIDs : widget.user.savedFlyersIDs,
              followedBzzIDs : widget.user.followedBzzIDs,
              // -------------------------
            );

            await UserProvider(userID: widget.user.userID)
                .updateFirestoreUserDocument(_newUserModel);

            print('User Model successfully edited');
            _triggerLoading();

            if (widget.firstTimer){
              goToRoute(context, Routez.Home);
            } else {
              goBack(context);
            }

          }
      );

      _triggerLoading();

      ///////////////////////////////////////////////////////////
      // try{
      //   _triggerLoading();
      //   String _userPicURL;
      //
      //   if(_currentPic != null){
      //     _userPicURL =
      //     await saveUserPicOnFirebaseStorageAndGetURL(
      //         inputFile: _currentPic,
      //         fileName: widget.user.userID
      //     );
      //   }
      //
      //   // print('_userPicURL : $_userPicURL');
      //
      //   UserModel _newUserModel = UserModel(
      //     // -------------------------
      //     userID : widget.user.userID,
      //     joinedAt : widget.user.joinedAt,
      //     userStatus : widget.user.userStatus ?? UserStatus.Normal,
      //     // -------------------------
      //     name : _nameController.text ?? widget.user.name,
      //     pic : _userPicURL ?? widget.user.pic,
      //     title :  _titleController.text ?? widget.user.title,
      //     company: _companyController.text ?? widget.user.company,
      //     gender : _currentGender ?? widget.user.gender,
      //     country : _currentCountryID ?? widget.user.country,
      //     province : _currentProvinceID ?? widget.user.province,
      //     area : _currentAreaID ?? widget.user.area,
      //     language : Wordz.languageCode(context),
      //     position : _currentPosition ?? widget.user.position,
      //     contacts : _createContactList(widget.user.contacts),
      //     // -------------------------
      //     savedFlyersIDs : widget.user.savedFlyersIDs,
      //     followedBzzIDs : widget.user.followedBzzIDs,
      //     // -------------------------
      //   );
      //
      //   await UserProvider(userID: widget.user.userID)
      //       .updateFirestoreUserDocument(_newUserModel);
      //
      //   print('User Model successfully edited');
      //   _triggerLoading();
      //
      //   if (widget.firstTimer){
      //     goToRoute(context, Routez.Home);
      //   } else {
      //   goBack(context);
      //   }
      //
      // }catch(error){
      //   superDialog(context, error, 'Could\'nt update profile');
      //   print(error.toString());
      // }
      ///////////////////////////////////////////////////////////

    }
  }
  // ---------------------------------------------------------------------------
  // void _createNewProfile() async {
  //   if(_formKey.currentState.validate()){
  //
  //     _triggerLoading();
  //
  //     String _userPicURL;
  //
  //     if(_currentPic != null){
  //       _userPicURL =
  //       await saveUserPicOnFirebaseStorageAndGetURL(
  //           inputFile: _currentPic,
  //           fileName: userModel.userID
  //       );
  //     }
  //
  //     print('_userPicURL : $_userPicURL');
  //
  //     try{
  //       UserModel _newUserModel = UserModel(
  //         // -------------------------
  //         userID : userModel.userID,
  //         joinedAt : userModel.joinedAt,
  //         userStatus : userModel.userStatus ?? UserStatus.Normal,
  //         // -------------------------
  //         name : _currentName ?? userModel.name,
  //         pic : _userPicURL ?? userModel.pic,
  //         title :  _currentTitle ?? userModel.title,
  //         company: _currentCompany ?? userModel.company,
  //         gender : _currentGender ?? userModel.gender,
  //         country : _currentCountryID ?? userModel.country,
  //         province : _currentProvinceID ?? userModel.province,
  //         area : _currentAreaID ?? userModel.area,
  //         language : Wordz.languageCode(context),
  //         position : _currentPosition ?? userModel.position,
  //         contacts : _createContactList(userModel.contacts),
  //         // -------------------------
  //         savedFlyersIDs : userModel.savedFlyersIDs,
  //         followedBzzIDs : userModel.followedBzzIDs,
  //         // -------------------------
  //       );
  //
  //       await UserProvider(userID: userModel.userID)
  //           .updateFirestoreUserDocument(_newUserModel);
  //
  //       print('user model successfully edited');
  //       goToRoute(context, Routez.Home);
  //
  //     }catch(error){
  //       print(error.toString());
  //       superDialog(context, error, 'Error Creating profile');
  //     }
  //     _triggerLoading();
  //   }
  // }
  // ---------------------------------------------------------------------------
  // void _confirmEdits() async {
  //
  // }
  // ---------------------------------------------------------------------------
  void _deleteAccount () async {
    _triggerLoading();
    await superDialog(context, 'You will delete your account, and there is no going back !', 'Take Care !');

    await tryAndCatch(
      context: context,
      functions: () async {

        String _email = getAContactValueFromContacts(widget.user.contacts, ContactType.Email);
        await deleteUserDocument(widget.user);
        await AuthService().deleteFirebaseUser(context, _email, '123456');

      }
    );

    // try{
    //   String _email = getAContactValueFromContacts(widget.user.contacts, ContactType.Email);
    //   await deleteUserDocument(widget.user);
    //   await AuthService().deleteFirebaseUser(context, _email, '123456');
    //
    // }catch(error){
    //   superDialog(context, error, 'Error deleting Account');
    // }

    _triggerLoading();

    goToRoute(context, Routez.Starting);

  }
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      appBarType: AppBarType.Basic,
      tappingRageh: _triggerLoading,
      pageTitle: widget.firstTimer == true ? 'Add your profile data' : Wordz.editProfile(context),
      layoutWidget: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[

            Stratosphere(),

            AddGalleryPicBubble(
              pic: _currentPic == null ? widget.user.pic : _currentPic,
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
              // initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.Email),
            ),

            // --- EDIT PHONE
            ContactFieldBubble(
              textController: _phoneController,
              // key: Key('phone');
              fieldIsFormField: true,
              title: Wordz.phone(context),
              leadingIcon: Iconz.ComPhone,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.phone,
              // initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.Phone),
            ),

            // --- EDIT WEBSITE
            ContactFieldBubble(
              textController: _websiteController,
              // key: Key('website');
              fieldIsFormField: true,
              title: Wordz.website(context),
              leadingIcon: Iconz.ComWebsite,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
              // initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.WebSite),
            ),

            // --- EDIT FACEBOOK
            ContactFieldBubble(
              textController: _facebookController,
              // key: Key('facebook');
              fieldIsFormField: true,
              title: Wordz.facebookLink(context),
              leadingIcon: Iconz.ComFacebook,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
              // initialTextValue: getAContactValueFromContacts(widget.user.contacts, ContactType.Facebook),
            ),

            // --- EDIT INSTAGRAM
            ContactFieldBubble(
              textController: _instagramController,
              // key: Key('instagram');
              fieldIsFormField: true,
              title: Wordz.instagramLink(context),
              leadingIcon: Iconz.ComInstagram,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
              // initialTextValue: getAContactValueFromContacts(widget.user.contacts, ContactType.Instagram),
            ),

            // --- EDIT LINKEDIN
            ContactFieldBubble(
              textController: _linkedInController,
              // key: Key('linkedin');
              fieldIsFormField: true,
              title: Wordz.linkedinLink(context),
              leadingIcon: Iconz.ComLinkedin,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
              // initialTextValue: getAContactValueFromContacts(widget.user.contacts, ContactType.LinkedIn),
            ),

            // --- EDIT YOUTUBE
            ContactFieldBubble(
              textController: _youTubeController,
              // key: Key('youtube');
              fieldIsFormField: true,
              title: Wordz.youtubeChannel(context),
              leadingIcon: Iconz.ComYoutube,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
              // initialTextValue: getAContactValueFromContacts(widget.user.contacts, ContactType.YouTube),
            ),

            // --- EDIT PINTEREST
            ContactFieldBubble(
              textController: _pinterestController,
              // key: Key('pinterest');
              fieldIsFormField: true,
              title: Wordz.pinterestLink(context),
              leadingIcon: Iconz.ComPinterest,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
              // initialTextValue: getAContactValueFromContacts(widget.user.contacts, ContactType.Pinterest),
            ),

            // --- EDIT TIKTOK
            ContactFieldBubble(
              textController: _tiktokController,
              // key: Key('tiktok');
              fieldIsFormField: true,
              title: Wordz.tiktokLink(context),
              leadingIcon: Iconz.ComTikTok,
              keyboardTextInputAction: TextInputAction.next,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
              // initialTextValue: getAContactValueFromContacts(widget.user.contacts, ContactType.TikTok),
            ),

            // --- EDIT TWITTER
            ContactFieldBubble(
              textController: _twitterController,
              // key: Key('twitter');
              fieldIsFormField: true,
              title: 'Twitter link',//Wordz.twitterLink(context),
              leadingIcon: Iconz.ComTwitter,
              keyboardTextInputAction: TextInputAction.done,
              fieldIsRequired: false,
              keyboardTextInputType: TextInputType.url,
              // initialTextValue: getAContactValueFromContacts(widget.user.contacts, ContactType.Twitter),
            ),

            // --- CONFIRM BUTTON
            DreamBox(
              height: 50,
              width: superBubbleClearWidth(context),
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

            // --- DELETE ACCOUNT
            if(!widget.firstTimer)
            DreamBox(
              height: 50,
              color: Colorz.WhiteGlass,
              icon: Iconz.XLarge,
              iconColor: Colorz.BloodRed,
              iconSizeFactor: 0.5,
              verse: 'Delete Account',
              verseScaleFactor: 1.5,
              boxMargins: EdgeInsets.all(20),
              boxFunction: _deleteAccount,
            ),

            PyramidsHorizon(heightFactor: 5,)

          ],
        ),
      ),
    );
  }
}
