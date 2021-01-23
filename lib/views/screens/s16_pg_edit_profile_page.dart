import 'dart:io';
import 'package:bldrs/ambassadors/services/database.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/texters.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/add_logo_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/contact_field_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/text_field_bubble.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:path_provider/path_provider.dart' as sysPaths;
import 'package:path/path.dart' as path;
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
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
  File _currentPic;
  String _currentName;
  String _currentJobTitle;
  String _currentCompany;
  String _currentCity;
  String _currentCountry;
  String _currentEmail;
  String _currentPhone;
  String _currentFacebook;
  String _currentInstagram;
  String _currentLinkedIn;
  String _currentYouTube;
  String _currentPinterest;
  String _currentTiktok;
// ---------------------------------------------------------------------------
  Future<void> _takeGalleryPicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );

    if (imageFile == null){return;}

    setState(() {
      _currentPic = File(imageFile.path);
    });

    final appDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _currentPic.copy('${appDir.path}/$fileName');
    // _selectImage(savedImage);
  }
// ---------------------------------------------------------------------------
  void _deleteLogo(){
    setState(() {
      _currentPic = null;
    });
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserModel>(
      stream: DatabaseService(userID: user.userID).userData,
      builder: (context, snapshot){
        if(snapshot.hasData == false){
          return Container(
              width: superScreenWidth(context),
              height: superScreenWidth(context),
              child: Center(child: Loading()));
        } else {
          UserModel userModel = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

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

                // --- ADD LOGO
                AddLogoBubble(
                  logo: _currentPic,
                  addBtFunction: _takeGalleryPicture,
                  deleteLogoFunction: _deleteLogo,
                ),

                TextFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.name(context),
                  initialTextValue: userModel.name,
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  validator: (val) => val.isEmpty ? Wordz.enterName(context) : null,
                  textOnChanged: (val) => setState(()=> _currentName = val),
                ),

                TextFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.jobTitle(context),
                  initialTextValue: userModel.title,
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  validator: (val) => val.isEmpty ? Wordz.enterJobTitle(context) : null,
                  textOnChanged: (val) => setState(()=> _currentJobTitle = val),
                ),

                TextFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.companyName(context),
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  validator: (val) => val.isEmpty ? Wordz.enterCompanyName(context) : null,
                  textOnChanged: (val) => setState(()=> _currentCompany = val),
                ),

                TextFieldBubble(
                  fieldIsFormField: true,
                  title: '${Wordz.city(context)}, ${Wordz.country(context)}',
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                ),

                TextFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.emailAddress(context),
                  initialTextValue: userModel.userID, // works
                  keyboardTextInputType: TextInputType.emailAddress,
                  keyboardTextInputAction: TextInputAction.next,
                  fieldIsRequired: true,
                  leadingIcon: Iconz.ComEmail,
                ),

                TextFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.phone(context),
                  keyboardTextInputType: TextInputType.phone,
                  keyboardTextInputAction: TextInputAction.next,
                  leadingIcon: Iconz.ComPhone,
                  textDirection: TextDirection.ltr,
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.website(context),
                  leadingIcon: Iconz.ComWebsite,
                  keyboardTextInputAction: TextInputAction.next,
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.facebookLink(context),
                  leadingIcon: Iconz.ComFacebook,
                  keyboardTextInputAction: TextInputAction.next,
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.instagramLink(context),
                  leadingIcon: Iconz.ComInstagram,
                  keyboardTextInputAction: TextInputAction.next,
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.linkedinLink(context),
                  leadingIcon: Iconz.ComLinkedin,
                  keyboardTextInputAction: TextInputAction.next,
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.youtubeChannel(context),
                  leadingIcon: Iconz.ComYoutube,
                  keyboardTextInputAction: TextInputAction.next,
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.pinterestLink(context),
                  leadingIcon: Iconz.ComPinterest,
                  keyboardTextInputAction: TextInputAction.next,
                ),

                ContactFieldBubble(
                  fieldIsFormField: true,
                  title: Wordz.tiktokLink(context),
                  leadingIcon: Iconz.ComTikTok,
                  keyboardTextInputAction: TextInputAction.done,
                ),

                // --- CONFIRM BUTTON
                DreamBox(
                  height: 50,
                  verse: Wordz.updateProfile(context),
                  boxMargins: EdgeInsets.all(10),
                  boxFunction: ()async{
                    if(_formKey.currentState.validate()){
                      await DatabaseService(userID: user.userID).updateUserData(
                        userID              : user.userID                  ?? '',
                        // savedFlyersIDs      : _savedFlyersIDs                       ?? [''],
                        // followedBzzIDs      : _followedBzzIDs                       ?? [''],
                        // publishedFlyersIDs  : _publishedFlyersIDs                   ?? [''],
                        name                : _currentName ?? userModel.name,
                        pic                 : _currentPic ?? userModel.pic,
                        title               : _currentJobTitle ?? userModel.title,
                        city                : _currentCity ?? userModel.city
                        // whatsAppIsOn        : _currentWhatsApp          ?? false,
                        // // contacts            : doc.data()['contacts']                ?? [{'type': '', 'value': '', 'show': false}],
                        // position            : doc.data()['position']                ?? GeoPoint(0, 0),
                        // // joinedAt            : doc.data()['joinedAt']                ?? DateTime.june,
                        // gender              : doc.data()['gender']                  ?? '',
                        // language            : doc.data()['language']                ?? '',
                        // userStatus          : doc.data()['userStatus']              ?? 1,
                      );
                    }
                    print(_currentName);
                    print(_currentJobTitle);
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
