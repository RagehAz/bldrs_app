import 'dart:io';
import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/ambassadors/services/firebase_storage.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/controllers/streamerz.dart';
import 'package:bldrs/view_brains/drafters/imagers.dart';
import 'package:bldrs/view_brains/drafters/text_checkers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
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

  EditProfileScreen({
    @required this.user,
});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  File   _currentPic;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  Gender _currentGender;
  String _currentCountryID;
  String _currentProvinceID;
  String _currentAreaID;
  String _currentLanguageCode;
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

  // Important: Call dispose of the TextEditingController when you’ve
  // finished using it. This ensures that you discard any resources used
  // by the object.

// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING') : print('LOADING COMPLETE');
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
  // void _changeTitle(String val){
  //   _titleController.text = val;
  //   _currentTitle = val;
  //   // setState(()=> _currentTitle = val);
  // }
  // ---------------------------------------------------------------------------
  // void _changeCompany(String val){
  //   _companyController.text = val;
  //   _currentCompany = val;
  //   // setState(()=> _currentCompany = val);
  // }
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
  void _changeLanguage(String languageCode){
    setState(() => _currentLanguageCode = languageCode );
  }
  // ---------------------------------------------------------------------------
  void _changePosition(GeoPoint geoPoint){
    setState(() => _currentPosition = geoPoint );
  }
  // ---------------------------------------------------------------------------
  // void _changePhone(String val){
  //   setState(() => _currentPhone = val);
  // }
  // ---------------------------------------------------------------------------
  // void _changeEmail(String val){
  //   setState(() => _currentEmail = val );
  // }
  // ---------------------------------------------------------------------------
  // void _changeWebsite(String val){
  //   setState(() => _currentWebsite = val );
  // }
  // ---------------------------------------------------------------------------
  // void _changeFacebook(String val){
  //   setState(() => _currentFacebook = val );
  //   print(_currentFacebook);
  // }
  // ---------------------------------------------------------------------------
  // void _changeLinkedIn(String val){
  //   setState(() => _currentLinkedIn = val );
  // }
  // ---------------------------------------------------------------------------
  // void _changeYouTube(String val){
  //   setState(() => _currentYouTube = val );
  // }
  // ---------------------------------------------------------------------------
  // void _changeInstagram(String val){
  //   setState(() => _currentInstagram = val );
  // }
  // ---------------------------------------------------------------------------
  // void _changePinterest(String val){
  //   setState(() => _currentPinterest = val );
  // }
  // ---------------------------------------------------------------------------
  // void _changeTikTok(String val){
  //   setState(() => _currentTikTok = val );
  // }
  // ---------------------------------------------------------------------------
  // void _changeTwitter(String val){
  //   setState(() => _currentTwitter = val );
  // }
  // ---------------------------------------------------------------------------
  List<ContactModel> _createContactList(List<ContactModel> existingContacts){
    List<ContactModel> newContacts = new List();
    // _currentEmail = getEmailFromContacts(existingContacts);

    /// _currentEmail
    if (_emailController.text != null){newContacts.add(ContactModel(contact: _emailController.text, contactType: ContactType.Email));}
    else{
      String email = getAContactValueFromContacts(existingContacts, ContactType.Email);
      if (email != null){
        newContacts.add(
            ContactModel(
              contact: email,
              contactType: ContactType.Email,
            )
        );
      }
    }
    /// _currentWebsite
    if (_websiteController.text != null){newContacts.add(ContactModel(contact: _websiteController.text, contactType: ContactType.WebSite));}
    else{
      String webSite = getAContactValueFromContacts(existingContacts, ContactType.WebSite);
      if (webSite != null){
        newContacts.add(
            ContactModel(
              contact: webSite,
              contactType: ContactType.WebSite,
            )
        );
      }
    }
    /// _currentPhone
    if (_phoneController.text != null){newContacts.add(ContactModel(contact: _phoneController.text, contactType: ContactType.Phone));}
    else{
      String phone = getAContactValueFromContacts(existingContacts, ContactType.Phone);
      if (phone != null){
        newContacts.add(
            ContactModel(
              contact: phone,
              contactType: ContactType.Phone,
            )
        );
      }
    }
    /// _currentFacebook
    if (_facebookController.text != null){newContacts.add(ContactModel(contact: _facebookController.text, contactType: ContactType.Facebook));}
    else{
      String facebook = getAContactValueFromContacts(existingContacts, ContactType.Facebook);
      if (facebook != null){
        newContacts.add(
            ContactModel(
              contact: facebook,
              contactType: ContactType.Facebook,
            )
        );
      }
    }
    /// _currentInstagram
    if (_instagramController.text != null){newContacts.add(ContactModel(contact: _instagramController.text, contactType: ContactType.Instagram));}
    else{
      String instagram = getAContactValueFromContacts(existingContacts, ContactType.Instagram);
      if (instagram != null){
        newContacts.add(
            ContactModel(
              contact: instagram,
              contactType: ContactType.Instagram,
            )
        );
      }
    }
    /// _currentLinkedIn
    if (_linkedInController.text != null){newContacts.add(ContactModel(contact: _linkedInController.text, contactType: ContactType.LinkedIn));}
    else{
      String linkedIn = getAContactValueFromContacts(existingContacts, ContactType.LinkedIn);
      if (linkedIn != null){
        newContacts.add(
            ContactModel(
              contact: linkedIn,
              contactType: ContactType.LinkedIn,
            )
        );
      }
    }
    /// _currentYouTube
    if (_youTubeController.text != null){newContacts.add(ContactModel(contact: _youTubeController.text, contactType: ContactType.YouTube));}
    else{
      String youtube = getAContactValueFromContacts(existingContacts, ContactType.YouTube);
      if (youtube != null){
        newContacts.add(
            ContactModel(
              contact: youtube,
              contactType: ContactType.YouTube,
            )
        );
      }
    }
    /// _currentPinterest
    if (_pinterestController.text != null){newContacts.add(ContactModel(contact: _pinterestController.text, contactType: ContactType.Pinterest));}
    else{
      String pinterest = getAContactValueFromContacts(existingContacts, ContactType.Pinterest);
      if (pinterest != null){
        newContacts.add(
            ContactModel(
              contact: pinterest,
              contactType: ContactType.Pinterest,
            )
        );
      }
    }
    /// _currentTikTok
    if (_tiktokController.text != null){newContacts.add(ContactModel(contact: _tiktokController.text, contactType: ContactType.TikTok));}
    else{
      String tiktok = getAContactValueFromContacts(existingContacts, ContactType.TikTok);
      if (tiktok != null){
        newContacts.add(
            ContactModel(
              contact: tiktok,
              contactType: ContactType.TikTok,
            )
        );
      }
    }
    /// _currentTwitter
    if (_twitterController.text != null){newContacts.add(ContactModel(contact: _twitterController.text, contactType: ContactType.Twitter));}
    else{
      String twitter = getAContactValueFromContacts(existingContacts, ContactType.Twitter);
      if (twitter != null){
        newContacts.add(
            ContactModel(
              contact: twitter,
              contactType: ContactType.Twitter,
            )
        );
      }
    }

    return newContacts;
  }

  void _confirmEdits(){
    print('confirm edits');
  }

  @override
  Widget build(BuildContext context) {

    // final _user = Provider.of<UserModel>(context);

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      layoutWidget: ListView(
        children: <Widget>[

          userStreamBuilder(
            context: context,
            builder: (context, UserModel userModel){


              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[

                    // --- PAGE TITLE
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          // --- TITLE
                          SuperVerse(
                            verse: Wordz.editProfile(context),
                            size: 3,
                          ),

                          // --- CANCEL BUTTON
                          DreamBox(
                            height: 35,
                            width: 35,
                            icon: Iconz.XLarge,
                            iconSizeFactor: 0.6,
                            boxFunction: () {
                              // goBack(context);
                              setState(() {

                              });
                            },
                          )
                        ],
                      ),
                    ),

                    // --- EDIT PIC
                    AddGalleryPicBubble(
                      pic: _currentPic == null ? userModel.pic : _currentPic,
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
                      zone: Zone(countryID: _currentCountryID, provinceID: _currentProvinceID, areaID: _currentProvinceID),
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
                      initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.Facebook),
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
                      initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.Instagram),
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
                      initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.LinkedIn),
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
                      initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.YouTube),
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
                      initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.Pinterest),
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
                      initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.TikTok),
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
                      initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.Twitter),
                    ),

                    // --- CONFIRM BUTTON
                    DreamBox(
                      height: 50,
                      color: Colorz.WhiteGlass,
                      icon: Iconz.Check,
                      iconSizeFactor: 0.5,
                      verse: Wordz.updateProfile(context),
                      verseScaleFactor: 1.5,
                      boxMargins: EdgeInsets.all(20),
                      boxFunction: ()async{
                        if(_formKey.currentState.validate()){
                          try{

                            print('wtf');
                            String _userPicURL;

                            if(_currentPic != null){
                              _userPicURL =
                              await saveUserPicOnFirebaseStorageAndGetURL(
                                  inputFile: _currentPic,
                                  fileName: userModel.userID
                              );
                            }

                            print('_userPicURL : $_userPicURL');

                            UserModel _newUserModel = UserModel(
                              // -------------------------
                              userID : userModel.userID,
                              joinedAt : userModel.joinedAt,
                              userStatus : userModel.userStatus ?? UserStatus.Normal,
                              // -------------------------
                              name : _nameController.text ?? userModel.name,
                              pic : _userPicURL ?? userModel.pic,
                              title :  _titleController.text ?? userModel.title,
                              company: _companyController.text ?? userModel.company,
                              gender : _currentGender ?? userModel.gender,
                              country : _currentCountryID ?? userModel.country,
                              province : _currentProvinceID ?? userModel.province,
                              area : _currentAreaID ?? userModel.area,
                              language : Wordz.languageCode(context),
                              position : _currentPosition ?? userModel.position,
                              contacts : _createContactList(userModel.contacts),
                              // -------------------------
                              savedFlyersIDs : userModel.savedFlyersIDs,
                              followedBzzIDs : userModel.followedBzzIDs,
                              // -------------------------
                            );

                            await UserProvider(userID: userModel.userID)
                                .updateFirestoreUserDocument(_newUserModel);

                            print('usermodel successfully edited');
                            goBack(context);

                          }catch(error){
                            superDialog(context, error, 'Could\'nt update profile');
                            print(error.toString());
                          }

                        }

                      },
                    ),

                    // --- DELETE ACCOUNT
                    DreamBox(
                      height: 50,
                      color: Colorz.WhiteGlass,
                      icon: Iconz.XLarge,
                      iconColor: Colorz.BloodRed,
                      iconSizeFactor: 0.5,
                      verse: 'Delete Account',
                      verseScaleFactor: 1.5,
                      boxMargins: EdgeInsets.all(20),
                      boxFunction: () async {
                        _triggerLoading();
                        await superDialog(context, 'You will delete your account, and there is no going back !', 'Take Care !');
                        try{
                          String _email = getAContactValueFromContacts(userModel.contacts, ContactType.Email);
                          await deleteUserDocument(userModel);
                          await AuthService().deleteFirebaseUser(context, _email, '123456');

                        }catch(error){
                          superDialog(context, error, 'Error deleting Account');
                        }

                      },
                    ),

                    PyramidsHorizon(heightFactor: 5,)

                  ],
                ),
              );

            }
          ),

        ],
      ),
    );
  }
}
