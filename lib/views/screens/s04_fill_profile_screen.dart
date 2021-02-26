import 'dart:io';
import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/ambassadors/services/firebase_storage.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/drafters/imagers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/add_gallery_pic_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/contact_field_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
// import 'package:path_provider/path_provider.dart' as sysPaths;
// import 'package:path/path.dart' as path;
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FillProfileScreen extends StatefulWidget {
  @override
  _FillProfileScreenState createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _currentName;
  File   _currentPic;
  String _currentTitle;
  String _currentCompany;
  Gender _currentGender;
  String _currentCountryID;
  String _currentProvinceID;
  String _currentAreaID;
  String _currentLanguageCode;
  GeoPoint _currentPosition;
  // --------------------
  String _currentPhone;
  String _currentEmail;
  String _currentWebsite;
  String _currentFacebook;
  String _currentLinkedIn;
  String _currentYouTube;
  String _currentInstagram;
  String _currentPinterest;
  String _currentTikTok;
  String _currentTwitter;
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
    final _user = superFirebaseUser();
    _currentName = _user.displayName;
    _currentEmail = _user.email;
    super.initState();
  }


  void _changeName(String val){
    setState(()=> _currentName = val);
  }
  // ---------------------------------------------------------------------------
  Future<void> _changeUserPic() async {
    final _imageFile = await takeGalleryPicture(PicType.userPic);
    setState(() {_currentPic = File(_imageFile.path);});
  }
  // ---------------------------------------------------------------------------
  void _deleteLogo(){setState(() {_currentPic = null;});}
  // ---------------------------------------------------------------------------
  void _changeTitle(String val){setState(()=> _currentTitle = val);}
  // ---------------------------------------------------------------------------
  void _changeCompany(String val){setState(()=> _currentCompany = val);}
  // ---------------------------------------------------------------------------
  void _changeGender(Gender gender){setState(()=> _currentGender = gender);}
  // ---------------------------------------------------------------------------
  void _changeCountry(String countryID){
    setState(() {_currentCountryID = countryID;});
  }
  // ---------------------------------------------------------------------------
  void _changeProvince(String provinceID){
    setState(() {_currentProvinceID = provinceID;});
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
  void _changePhone(String val){
    setState(() => _currentPhone = val);
  }
  // ---------------------------------------------------------------------------
  void _changeEmail(String val){
    setState(() => _currentEmail = val );
  }
  // ---------------------------------------------------------------------------
  void _changeWebsite(String val){
    setState(() => _currentWebsite = val );
  }
  // ---------------------------------------------------------------------------
  void _changeFacebook(String val){
    setState(() => _currentFacebook = val );
    print(_currentFacebook);
  }
  // ---------------------------------------------------------------------------
  void _changeLinkedIn(String val){
    setState(() => _currentLinkedIn = val );
  }
  // ---------------------------------------------------------------------------
  void _changeYouTube(String val){
    setState(() => _currentYouTube = val );
  }
  // ---------------------------------------------------------------------------
  void _changeInstagram(String val){
    setState(() => _currentInstagram = val );
  }
  // ---------------------------------------------------------------------------
  void _changePinterest(String val){
    setState(() => _currentPinterest = val );
  }
  // ---------------------------------------------------------------------------
  void _changeTikTok(String val){
    setState(() => _currentTikTok = val );
  }
  // ---------------------------------------------------------------------------
  void _changeTwitter(String val){
    setState(() => _currentTwitter = val );
  }
  // ---------------------------------------------------------------------------
  List<ContactModel> _createContactList(List<ContactModel> existingContacts){
    return createContactsList(
      existingContacts: existingContacts,
      phone: _currentPhone,
      email: _currentEmail,
      webSite: _currentWebsite,
      facebook: _currentFacebook,
      linkedIn: _currentLinkedIn,
      youTube: _currentYouTube,
      instagram: _currentInstagram,
      pinterest: _currentPinterest,
      tikTok: _currentTikTok,
      twitter: _currentTwitter,
    );

    ////////////////////////////////////////////////////////////////// delete below solution if the above works
    // List<ContactModel> newContacts = new List();
    // // _currentEmail = getEmailFromContacts(existingContacts);
    //
    // /// _currentEmail
    // if (_currentEmail != null){newContacts.add(ContactModel(value: _currentEmail, type: ContactType.Email));}
    // else{
    //   String email = getAContactValueFromContacts(existingContacts, ContactType.Email);
    //   if (email != null){
    //     newContacts.add(
    //         ContactModel(
    //           value: email,
    //           type: ContactType.Email,
    //         )
    //     );
    //   }
    // }
    // /// _currentWebsite
    // if (_currentWebsite != null){newContacts.add(ContactModel(value: _currentWebsite, type: ContactType.WebSite));}
    // else{
    //   String webSite = getAContactValueFromContacts(existingContacts, ContactType.WebSite);
    //   if (webSite != null){
    //     newContacts.add(
    //         ContactModel(
    //           value: webSite,
    //           type: ContactType.WebSite,
    //         )
    //     );
    //   }
    // }
    // /// _currentPhone
    // if (_currentPhone != null){newContacts.add(ContactModel(value: _currentPhone, type: ContactType.Phone));}
    // else{
    //   String phone = getAContactValueFromContacts(existingContacts, ContactType.Phone);
    //   if (phone != null){
    //     newContacts.add(
    //         ContactModel(
    //           value: phone,
    //           type: ContactType.Phone,
    //         )
    //     );
    //   }
    // }
    // /// _currentFacebook
    // if (_currentFacebook != null){newContacts.add(ContactModel(value: _currentFacebook, type: ContactType.Facebook));}
    // else{
    //   String facebook = getAContactValueFromContacts(existingContacts, ContactType.Facebook);
    //   if (facebook != null){
    //     newContacts.add(
    //         ContactModel(
    //           value: facebook,
    //           type: ContactType.Facebook,
    //         )
    //     );
    //   }
    // }
    // /// _currentInstagram
    // if (_currentInstagram != null){newContacts.add(ContactModel(value: _currentInstagram, type: ContactType.Instagram));}
    // else{
    //   String instagram = getAContactValueFromContacts(existingContacts, ContactType.Instagram);
    //   if (instagram != null){
    //     newContacts.add(
    //         ContactModel(
    //           value: instagram,
    //           type: ContactType.Instagram,
    //         )
    //     );
    //   }
    // }
    // /// _currentLinkedIn
    // if (_currentLinkedIn != null){newContacts.add(ContactModel(value: _currentLinkedIn, type: ContactType.LinkedIn));}
    // else{
    //   String linkedIn = getAContactValueFromContacts(existingContacts, ContactType.LinkedIn);
    //   if (linkedIn != null){
    //     newContacts.add(
    //         ContactModel(
    //           value: linkedIn,
    //           type: ContactType.LinkedIn,
    //         )
    //     );
    //   }
    // }
    // /// _currentYouTube
    // if (_currentYouTube != null){newContacts.add(ContactModel(value: _currentYouTube, type: ContactType.YouTube));}
    // else{
    //   String youtube = getAContactValueFromContacts(existingContacts, ContactType.YouTube);
    //   if (youtube != null){
    //     newContacts.add(
    //         ContactModel(
    //           value: youtube,
    //           type: ContactType.YouTube,
    //         )
    //     );
    //   }
    // }
    // /// _currentPinterest
    // if (_currentPinterest != null){newContacts.add(ContactModel(value: _currentPinterest, type: ContactType.Pinterest));}
    // else{
    //   String pinterest = getAContactValueFromContacts(existingContacts, ContactType.Pinterest);
    //   if (pinterest != null){
    //     newContacts.add(
    //         ContactModel(
    //           value: pinterest,
    //           type: ContactType.Pinterest,
    //         )
    //     );
    //   }
    // }
    // /// _currentTikTok
    // if (_currentTikTok != null){newContacts.add(ContactModel(value: _currentTikTok, type: ContactType.TikTok));}
    // else{
    //   String tiktok = getAContactValueFromContacts(existingContacts, ContactType.TikTok);
    //   if (tiktok != null){
    //     newContacts.add(
    //         ContactModel(
    //           value: tiktok,
    //           type: ContactType.TikTok,
    //         )
    //     );
    //   }
    // }
    // /// _currentTwitter
    // if (_currentTwitter != null){newContacts.add(ContactModel(value: _currentTwitter, type: ContactType.Twitter));}
    // else{
    //   String twitter = getAContactValueFromContacts(existingContacts, ContactType.Twitter);
    //   if (twitter != null){
    //     newContacts.add(
    //         ContactModel(
    //           value: twitter,
    //           type: ContactType.Twitter,
    //         )
    //     );
    //   }
    // }
    //
    // return newContacts;
  }


  @override
  Widget build(BuildContext context) {

    final _user = superFirebaseUser();
    final _userID = _user?.uid;

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      loading: _loading,
      layoutWidget: ListView(
        children: <Widget>[

          StreamBuilder<UserModel>(
            stream: UserProvider(userID: _userID).userData,
            builder: (context, snapshot){
              if(snapshot.hasData == false){
                return LoadingFullScreenLayer();
              } else {
                UserModel userModel = snapshot.data;
                // print('user name : ${userModel.name}');
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
                              verse: 'Add your profile data',
                              size: 3,
                            ),

                            // --- CANCEL BUTTON
                            // DreamBox(
                            //   height: 35,
                            //   width: 35,
                            //   icon: Iconz.XLarge,
                            //   iconSizeFactor: 0.6,
                            //   boxFunction: (){print('cancel edits');},
                            // )

                          ],
                        ),
                      ),

                      // --- EDIT PIC
                      AddGalleryPicBubble(
                        pic: _currentPic,
                        addBtFunction: _changeUserPic,
                        deletePicFunction: _deleteLogo,
                        bubbleType: BubbleType.userPic,
                      ),

                      // --- EDIT NAME
                      TextFieldBubble(
                        fieldIsFormField: true,
                        title: Wordz.name(context),
                        initialTextValue: _currentName, //userModel.name,
                        keyboardTextInputType: TextInputType.name,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: true,
                        validator: (val) => val.isEmpty ? Wordz.enterName(context) : null,
                        textOnChanged: (val) => _changeName(val),
                      ),

                      // --- EDIT JOB TITLE
                      TextFieldBubble(
                        fieldIsFormField: true,
                        title: Wordz.jobTitle(context),
                        initialTextValue: userModel.title,
                        keyboardTextInputType: TextInputType.name,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: true,
                        validator: (val) => val.isEmpty ? Wordz.enterJobTitle(context) : null,
                        textOnChanged: (val) => _changeTitle(val),
                      ),

                      // --- EDIT COMPANY NAME
                      TextFieldBubble(
                        fieldIsFormField: true,
                        title: Wordz.companyName(context),
                        initialTextValue: userModel.company,
                        keyboardTextInputType: TextInputType.name,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: true,
                        validator: (val) => val.isEmpty ? Wordz.enterCompanyName(context) : null,
                        textOnChanged: (val) => _changeCompany(val),
                      ),

                      // --- EDIT HQ
                      LocaleBubble(
                        title : 'Preferred Location',
                        changeCountry : (countryID) => _changeCountry(countryID),
                        changeProvince : (provinceID) => _changeProvince(provinceID),
                        changeArea : (areaID) => _changeArea(areaID),
                        zone: Zone(countryID: userModel.country, provinceID: userModel.province, areaID: userModel.area),
                      ),

                      // --- EDIT EMAIL
                      ContactFieldBubble(
                        fieldIsFormField: true,
                        title: Wordz.emailAddress(context),
                        leadingIcon: Iconz.ComEmail,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: true,
                        keyboardTextInputType: TextInputType.emailAddress,
                        initialTextValue: _currentEmail,//getAContactValueFromContacts(userModel.contacts, ContactType.Email),
                        textOnChanged: (val) => _changeEmail(val),
                      ),

                      // --- EDIT PHONE
                      ContactFieldBubble(
                        fieldIsFormField: true,
                        title: Wordz.phone(context),
                        leadingIcon: Iconz.ComPhone,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: false,
                        keyboardTextInputType: TextInputType.phone,
                        initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.Phone),
                        textOnChanged: (val) => _changePhone(val),
                      ),

                      // --- EDIT WEBSITE
                      ContactFieldBubble(
                        fieldIsFormField: true,
                        title: Wordz.website(context),
                        leadingIcon: Iconz.ComWebsite,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: false,
                        keyboardTextInputType: TextInputType.url,
                        initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.WebSite),
                        textOnChanged: (val) => _changeWebsite(val),
                      ),

                      // --- EDIT FACEBOOK
                      ContactFieldBubble(
                        fieldIsFormField: true,
                        title: Wordz.facebookLink(context),
                        leadingIcon: Iconz.ComFacebook,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: false,
                        keyboardTextInputType: TextInputType.url,
                        initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.Facebook),
                        textOnChanged: (val) => _changeFacebook(val),
                      ),

                      // --- EDIT INSTAGRAM
                      ContactFieldBubble(
                        fieldIsFormField: true,
                        title: Wordz.instagramLink(context),
                        leadingIcon: Iconz.ComInstagram,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: false,
                        keyboardTextInputType: TextInputType.url,
                        initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.Instagram),
                        textOnChanged: (val) => _changeInstagram(val),
                      ),

                      // --- EDIT LINKEDIN
                      ContactFieldBubble(
                        fieldIsFormField: true,
                        title: Wordz.linkedinLink(context),
                        leadingIcon: Iconz.ComLinkedin,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: false,
                        keyboardTextInputType: TextInputType.url,
                        initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.LinkedIn),
                        textOnChanged: (val) => _changeLinkedIn(val),
                      ),

                      // --- EDIT YOUTUBE
                      ContactFieldBubble(
                        fieldIsFormField: true,
                        title: Wordz.youtubeChannel(context),
                        leadingIcon: Iconz.ComYoutube,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: false,
                        keyboardTextInputType: TextInputType.url,
                        initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.YouTube),
                        textOnChanged: (val) => _changeYouTube(val),
                      ),

                      // --- EDIT PINTEREST
                      ContactFieldBubble(
                        fieldIsFormField: true,
                        title: Wordz.pinterestLink(context),
                        leadingIcon: Iconz.ComPinterest,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: false,
                        keyboardTextInputType: TextInputType.url,
                        initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.Pinterest),
                        textOnChanged: (val) => _changePinterest(val),
                      ),

                      // --- EDIT TIKTOK
                      ContactFieldBubble(
                        fieldIsFormField: true,
                        title: Wordz.tiktokLink(context),
                        leadingIcon: Iconz.ComTikTok,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: false,
                        keyboardTextInputType: TextInputType.url,
                        initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.TikTok),
                        textOnChanged: (val) => _changeTikTok(val),
                      ),

                      // --- EDIT TWITTER
                      ContactFieldBubble(
                        fieldIsFormField: true,
                        title: 'Twitter link',//Wordz.twitterLink(context),
                        leadingIcon: Iconz.ComTwitter,
                        keyboardTextInputAction: TextInputAction.done,
                        fieldIsRequired: false,
                        keyboardTextInputType: TextInputType.url,
                        initialTextValue: getAContactValueFromContacts(userModel.contacts, ContactType.Twitter),
                        textOnChanged: (val) => _changeTwitter(val),
                      ),

                      // --- CONFIRM BUTTON
                      DreamBox(
                        height: 50,
                        color: Colorz.WhiteGlass,
                        icon: Iconz.Check,
                        iconSizeFactor: 0.5,
                        verse: 'Confirm',
                        verseScaleFactor: 1.5,
                        boxMargins: EdgeInsets.all(20),
                        boxFunction: ()async{

                          if(_formKey.currentState.validate()){

                            _triggerLoading();

                            String _userPicURL;

                            if(_currentPic != null){
                              _userPicURL =
                              await saveUserPicOnFirebaseStorageAndGetURL(
                                  inputFile: _currentPic,
                                  fileName: userModel.userID
                              );
                            }

                            print('_userPicURL : $_userPicURL');

                            try{
                              await UserProvider(userID: userModel.userID).updateUserData(
                                // -------------------------
                                userID : userModel.userID,
                                joinedAt : userModel.joinedAt,
                                userStatus : userModel.userStatus ?? UserStatus.Normal,
                                // -------------------------
                                name : _currentName ?? userModel.name,
                                pic : _userPicURL ?? userModel.pic,
                                title :  _currentTitle ?? userModel.title,
                                company: _currentCompany ?? userModel.company,
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
                              print('user model successfully edited');
                              goToRoute(context, Routez.Home);

                            }catch(error){
                              print(error.toString());
                              superDialog(context, error, 'Error Creating profile');
                            }
                            _triggerLoading();
                          }

                        },
                      ),

                      PyramidsHorizon(heightFactor: 5,)

                    ],
                  ),
                );
              }
            },
          )

        ],
      ),
    );
  }
}
