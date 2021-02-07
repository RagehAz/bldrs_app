import 'dart:io';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/texters.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/add_gallery_pic_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/contact_field_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/locale_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
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

class EditProfilePage extends StatefulWidget {
  final Function cancelEdits;
  final Function confirmEdits;

  EditProfilePage({
    this.cancelEdits,
    this.confirmEdits,
});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
  @override
  void initState() {
    UserModel user = Provider.of<UserModel>(context, listen: false);
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxx user is ${user.userID}');
    _currentName = user.name;
    _currentPic = File(user.pic);
    _currentTitle = user.title;
    _currentCompany = user.company;
    _currentGender = user.gender;
    _currentCountryID = user.country;
    _currentProvinceID = user.province;
    _currentAreaID = user.area;
    _currentLanguageCode = user.language;
    _currentPosition = user.position;
    // --------------------
    _currentPhone = getAContactFromContacts(user.contacts, ContactType.Phone);
    _currentEmail = getAContactFromContacts(user.contacts, ContactType.Email);
    _currentWebsite = getAContactFromContacts(user.contacts, ContactType.WebSite);
    _currentFacebook = getAContactFromContacts(user.contacts, ContactType.Facebook);
    _currentLinkedIn = getAContactFromContacts(user.contacts, ContactType.LinkedIn);
    _currentYouTube = getAContactFromContacts(user.contacts, ContactType.YouTube);
    _currentInstagram = getAContactFromContacts(user.contacts, ContactType.Instagram);
    _currentPinterest = getAContactFromContacts(user.contacts, ContactType.Pinterest);
    _currentTikTok = getAContactFromContacts(user.contacts, ContactType.TikTok);
    _currentTwitter = getAContactFromContacts(user.contacts, ContactType.Twitter);
    // --------------------
    super.initState();
  }
  // ---------------------------------------------------------------------------
  void _changeName(String val){
    setState(()=> _currentName = val);
  }
  // ---------------------------------------------------------------------------
  Future<void> _takeGalleryPicture() async {
    final _picker = ImagePicker();
    final _imageFile = await _picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (_imageFile == null){return;}

    setState(() {
      _currentPic = File(_imageFile.path);
    });

    // final _appDir = await sysPaths.getApplicationDocumentsDirectory();
    // final _fileName = path.basename(_imageFile.path);
    // final _savedImage = await _currentPic.copy('${_appDir.path}/$_fileName');
    // _selectImage(savedImage);
  }
  // ---------------------------------------------------------------------------
  void _deleteLogo(){
    setState(() {
      _currentPic = null;
    });
  }
  // ---------------------------------------------------------------------------
  void _changeTitle(String val){
    setState(()=> _currentTitle = val);
  }
  // ---------------------------------------------------------------------------
  void _changeCompany(String val){
    setState(()=> _currentCompany = val);
  }
  // ---------------------------------------------------------------------------
  void _changeGender(Gender gender){
    setState(()=> _currentGender = gender);
  }
  // ---------------------------------------------------------------------------
  void _changeCountry(String countryID){
    setState(() {
      _currentCountryID = countryID;
    });
  }
  // ---------------------------------------------------------------------------
  void _changeProvince(String provinceID){
    setState(() {
      _currentProvinceID = provinceID;
    });
  }
  // ---------------------------------------------------------------------------
  void _changeArea(String areaID){
    setState(() {
      _currentAreaID = areaID;
    });
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
    List<ContactModel> newContacts = new List();
    // _currentEmail = getEmailFromContacts(existingContacts);

    /// _currentEmail
    if (_currentEmail != null){newContacts.add(ContactModel(contact: _currentEmail, contactType: ContactType.Email));}
    /// _currentWebsite
    if (_currentWebsite != null){newContacts.add(ContactModel(contact: _currentWebsite, contactType: ContactType.WebSite));}
    /// _currentPhone
    if (_currentPhone != null){newContacts.add(ContactModel(contact: _currentPhone, contactType: ContactType.Phone));}
    /// _currentFacebook
    if (_currentFacebook != null){newContacts.add(ContactModel(contact: _currentFacebook, contactType: ContactType.Facebook));}
    /// _currentInstagram
    if (_currentInstagram != null){newContacts.add(ContactModel(contact: _currentInstagram, contactType: ContactType.Instagram));}
    /// _currentLinkedIn
    if (_currentLinkedIn != null){newContacts.add(ContactModel(contact: _currentLinkedIn, contactType: ContactType.LinkedIn));}
    /// _currentYouTube
    if (_currentYouTube != null){newContacts.add(ContactModel(contact: _currentYouTube, contactType: ContactType.YouTube));}
    /// _currentPinterest
    if (_currentPinterest != null){newContacts.add(ContactModel(contact: _currentPinterest, contactType: ContactType.Pinterest));}
    /// _currentTikTok
    if (_currentTikTok != null){newContacts.add(ContactModel(contact: _currentTikTok, contactType: ContactType.TikTok));}
    /// _currentTwitter
    if (_currentTwitter != null){newContacts.add(ContactModel(contact: _currentTwitter, contactType: ContactType.Twitter));}

    return newContacts;
  }

  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserModel>(context);

    // print('_currentPic : $_currentPic ,'
    //     '_currentName : $_currentName ,'
    //     '_currentTitle : $_currentTitle ,'
    //     '_currentCompany : $_currentCompany ,'
    //     '_currentCountryID : $_currentCountryID ,'
    //     '_currentProvinceID : $_currentProvinceID ,'
    //     '_currentAreaID : $_currentAreaID ,'
    //     '_currentEmail : $_currentEmail ,'
    //     '_currentPhone : $_currentPhone ,'
    //     '_currentFacebook : $_currentFacebook ,'
    //     ' _currentInstagram : $_currentInstagram ,'
    //     ' _currentLinkedIn : $_currentLinkedIn ,'
    //     ' _currentYouTube : $_currentYouTube ,'
    //     ' _currentPinterest : $_currentPinterest ,'
    //     ' _currentTikTok : $_currentTikTok ,'
    //     '');

    return StreamBuilder<UserModel>(
      stream: UserProvider(userID: _user.userID).userData,
      builder: (context, snapshot){
        if(snapshot.hasData == false){
          return LoadingFullScreenLayer();
        } else {
          UserModel userModel = snapshot.data;
          print('user e-mail is : ${getAContactFromContacts(userModel.contacts, ContactType.Email)}');
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
                        boxFunction: widget.cancelEdits,
                      )
                    ],
                  ),
                ),

                // --- EDIT PIC
                AddGalleryPicBubble(
                  logo: _currentPic,
                  addBtFunction: _takeGalleryPicture,
                  deleteLogoFunction: _deleteLogo,
                ),

                // --- EDIT NAME
                TextFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.name(context),
                  initialTextValue: userModel.name,
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
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  validator: (val) => val.isEmpty ? Wordz.enterCompanyName(context) : null,
                  textOnChanged: (val) => _changeCompany(val),
                ),

                LocaleBubble(
                  title : 'Preferred Location',
                  changeCountry : (countryID) => _changeCountry(countryID),
                  changeProvince : (provinceID) => _changeProvince(provinceID),
                  changeArea : (areaID) => _changeArea(areaID),
                  hq: HQ(countryID: userModel.country, provinceID: userModel.province, areaID: userModel.area),
                ),

                // --- EDIT EMAIL
                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.emailAddress(context),
                  leadingIcon: Iconz.ComEmail,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  keyboardTextInputType: TextInputType.emailAddress,
                  initialTextValue: _currentEmail,
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
                  initialTextValue: _currentPhone,
                  textOnChanged: (val) => _changePhone(val),
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.website(context),
                  leadingIcon: Iconz.ComWebsite,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: false,
                  keyboardTextInputType: TextInputType.url,
                  initialTextValue: _currentWebsite,
                  textOnChanged: (val) => _changeWebsite(val),
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.facebookLink(context),
                  leadingIcon: Iconz.ComFacebook,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: false,
                  keyboardTextInputType: TextInputType.url,
                  initialTextValue: _currentFacebook,
                  textOnChanged: (val) => _changeFacebook(val),
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.instagramLink(context),
                  leadingIcon: Iconz.ComInstagram,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: false,
                  keyboardTextInputType: TextInputType.url,
                  initialTextValue: _currentInstagram,
                  textOnChanged: (val) => _changeInstagram(val),
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.linkedinLink(context),
                  leadingIcon: Iconz.ComLinkedin,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: false,
                  keyboardTextInputType: TextInputType.url,
                  initialTextValue: _currentLinkedIn,
                  textOnChanged: (val) => _changeLinkedIn(val),
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.youtubeChannel(context),
                  leadingIcon: Iconz.ComYoutube,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: false,
                  keyboardTextInputType: TextInputType.url,
                  initialTextValue: _currentYouTube,
                  textOnChanged: (val) => _changeYouTube(val),
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.pinterestLink(context),
                  leadingIcon: Iconz.ComPinterest,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: false,
                  keyboardTextInputType: TextInputType.url,
                  initialTextValue: _currentPinterest,
                  textOnChanged: (val) => _changePinterest(val),
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.tiktokLink(context),
                  leadingIcon: Iconz.ComTikTok,
                  keyboardTextInputAction: TextInputAction.done,
                  fieldIsRequired: false,
                  keyboardTextInputType: TextInputType.url,
                  initialTextValue: _currentTikTok,
                  textOnChanged: (val) => _changeTikTok(val),
                ),

                // --- CONFIRM BUTTON
                DreamBox(
                  height: 50,
                  verse: Wordz.updateProfile(context),
                  boxMargins: EdgeInsets.all(10),
                  boxFunction: ()async{
                    if(_formKey.currentState.validate()){
                      await UserProvider(userID: userModel.userID).updateUserData(
                        // -------------------------
                        userID : userModel.userID,
                        joinedAt : userModel.joinedAt,
                        userStatus : userModel.userStatus ?? UserStatus.NormalUser,
                        // -------------------------
                        name : _currentName ?? userModel.name,
                        pic : _currentPic ?? userModel.pic,
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
                    }
                    print(_currentName);
                    print(_currentTitle);
                    print(_currentCompany);
                  },
                ),

                DropDownBubble(
                  title: 'Will continue this later isa',
                  list: ['koko', 'soso', 'fofo', 'wtf'],
                ),

                PyramidsHorizon(heightFactor: 5,)

              ],
            ),
        );
        }
      },
    );
  }
}

class DropDownBubble extends StatefulWidget {
  final String title;
  final List<String> list;
  final bool fieldIsRequired;
  final String actionBtIcon;
  final Color actionBtColor;
  final Function actionBtFunction;


  DropDownBubble({
    @required this.title,
    @required this.list,
    this.fieldIsRequired = false,
    this.actionBtColor,
    this.actionBtIcon,
    this.actionBtFunction,
  });

  @override
  _DropDownBubbleState createState() => _DropDownBubbleState();
}

class _DropDownBubbleState extends State<DropDownBubble> {
  String chosenValue = '';

  @override
  Widget build(BuildContext context) {

    int titleVerseSize = 2;
    double actionBtSize = superVerseRealHeight(context, titleVerseSize, 1, null);
    double actionBtCorner = actionBtSize * 0.4;

    return InPyramidsBubble(
        columnChildren: <Widget>[


          Container(
            // color: Colorz.YellowSmoke,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                // --- BUBBLE TITLE
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                  child: SuperVerse(
                    verse: widget.title,
                    size: titleVerseSize,
                    redDot: widget.fieldIsRequired,
                  ),
                ),

                // --- ACTION BUTTON
                widget.actionBtIcon == null ? Container() :
                DreamBox(
                  height: actionBtSize,
                  width: actionBtSize,
                  corners: actionBtCorner,
                  color: widget.actionBtColor,
                  icon: widget.actionBtIcon,
                  iconSizeFactor: 0.6,
                  boxFunction: widget.actionBtFunction,
                ),

              ],
            ),
          ),


          Container(
            width: superBubbleClearWidth(context),
            height: 35,
            decoration: BoxDecoration(
            color: Colorz.BloodTest,
              borderRadius: superBorderRadius(context, 10, 10, 10, 10),
            ),
            child: DropdownButtonFormField(
              // value: widget.list[0] ?? widget.list[0],
              dropdownColor: Colorz.BabyBlue,
              elevation: 0,
              style: TextStyle(color: Colorz.BloodRed, ),
              iconSize: 30,
              isExpanded: true,
              isDense: true,

              itemHeight: 48,
              onTap: (){print('ganzabeel');},
              icon: DreamBox(height: 20, icon: Iconz.ArrowDown, bubble: false,),
              decoration: InputDecoration(
                border: superOutlineInputBorder(Colorz.BloodRed, 10),
                isDense: true,
                contentPadding: EdgeInsets.all(0),
                // labelText: 'label text',
                icon: DreamBox(height: 35, icon: Iconz.DvGouran,),
                fillColor: Colorz.BabyBlue,
                filled: true,
                enabled: true,
                focusColor: Colorz.BloodTest,

              ),
              items: widget.list.map((item){
                return DropdownMenuItem(
                  // value: widget.list[0] ?? widget.list[0],
                  onTap: (){print(item);},
                  child: SuperVerse(
                    color: Colorz.BlackBlack,
                    verse: item,
                  ),
                );
              }).toList(),
              onChanged: (val) => setState(()=> chosenValue = val),
            ),
          ),

        ],
    );
  }
}
