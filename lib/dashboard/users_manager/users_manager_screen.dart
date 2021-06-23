import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/dream_wrapper.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_sheet.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersManagerScreen extends StatefulWidget {

  @override
  _UsersManagerScreenState createState() => _UsersManagerScreenState();
}

class _UsersManagerScreenState extends State<UsersManagerScreen> {
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    SuperVerse _titleVerse(String title){
      return SuperVerse(
        verse: title,
        size: 0,
        color: Colorz.GreySmoke,
      );
    }

    SuperVerse _smallVerse(String verse){
      return SuperVerse(
        verse: verse,
        size: 1,
        weight: VerseWeight.thin,
      );
    }

    return DashBoardLayout(
      loading: _loading,
      pageTitle: 'Users Manager',
      listWidgets: <Widget>[

        StreamBuilder<List<UserModel>>(
            stream: UserProvider().allUsersStream,
            builder: (context, snapshot){
              if(connectionHasNoData(snapshot) || connectionIsWaiting(snapshot)){
                return LoadingFullScreenLayer();
              } else {
                List<UserModel> _usersModels = snapshot.data;
                return

                Column(
                  children: <Widget>[

                    SuperVerse(
                      verse: '${_usersModels.length} users in Bldrs.net',
                      labelColor: Colorz.WhiteGlass,
                      centered: true,
                      size: 4,
                      margin: 5,
                    ),

                    Container(
                      width: _screenWidth,
                      height: _screenHeight - Ratioz.stratosphere,
                      child: ListView.builder(
                        itemCount: _usersModels.length,
                        padding: EdgeInsets.only(bottom: Ratioz.grandHorizon),
                        itemBuilder: (context, index){

                          UserModel _userModel = _usersModels[index];
                          String _countryName = _countryPro .getCountryNameInCurrentLanguageByIso3(context, _userModel.zone.countryID);
                          String _provinceName = _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, _userModel.zone.provinceID);
                          String _areaName = _countryPro.getAreaNameWithCurrentLanguageIfPossible(context, _userModel.zone.areaID);

                          List<ContactModel> _stringyContacts = ContactModel.getContactsWithStringsFromContacts(_userModel.contacts);
                          List<String> _stringyContactsValues = ContactModel.getListOfValuesFromContactsModelsList(_stringyContacts);
                          List<String> _stringyContactsIcons = ContactModel.getListOfIconzFromContactsModelsList(_stringyContacts);

                          List<ContactModel> _socialContacts = ContactModel.getSocialMediaContactsFromContacts(_userModel.contacts);
                          List<String> _socialContactsValues = ContactModel.getListOfValuesFromContactsModelsList(_socialContacts);
                          List<String> _socialContactsIcons = ContactModel.getListOfIconzFromContactsModelsList(_socialContacts);

                          // dynamic bobo = ContactModel.getListOfValuesFromContactsModelsList(_stringyContacts);

                          return
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                // --- INDEX AND ID
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                                  child: SuperVerse(
                                    verse: '$index : ${_userModel.userID}',
                                    size: 1,
                                    weight: VerseWeight.thin,
                                  ),
                                ),

                                InPyramidsBubble(
                                  columnChildren: <Widget>[

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        // --- USER PIC
                                        DreamBox(
                                          height: 70,
                                          width: 70,
                                          icon: _userModel.pic,
                                          boxFunction: () => BottomSlider.slideBottomSheet(
                                            context: context,
                                            draggable: true,
                                            height: null,
                                            child: Column(
                                              children: <Widget>[

                                                DreamBox(
                                                  height: 60,
                                                  width: BottomSlider.bottomSheetClearWidth(context),
                                                  icon: _userModel.pic,
                                                  verse: 'Delete this fucker (${_userModel.name})',
                                                  verseScaleFactor: 0.7,
                                                  secondLine: 'This will delete user document from firebase, and delete his firebase User authentication record',
                                                  secondLineColor: Colorz.BloodRed,
                                                  boxFunction: () async {
                                                    _triggerLoading();

                                                    try{
                                                      // await UserCRUD().deleteUserDoc(_userModel.userID);
                                                    } catch (error){

                                                      await superDialog(
                                                        context: context,
                                                        title: 'Ops',
                                                        body: error,
                                                        boolDialog: true,
                                                      );

                                                    }

                                                    _triggerLoading();
                                                  },
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          width: Ratioz.appBarMargin,
                                        ),

                                        // --- USER DATA
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[

                                            _titleVerse('Name'),
                                            SuperVerse(
                                              verse: _userModel.name,
                                            ),

                                            _titleVerse('Title'),
                                            _smallVerse(_userModel.title),


                                            _titleVerse('Company'),
                                            _smallVerse(_userModel.company),

                                            _titleVerse('Zone'),
                                            _smallVerse('in [ $_areaName ] - [ $_provinceName ] - [ $_countryName ]'),

                                            _titleVerse('joined At'),
                                            _smallVerse(TextGenerator.dayMonthYearStringer(context, _userModel.joinedAt)),

                                            _titleVerse('preferred language'),
                                            _smallVerse(_userModel.language),

                                            _titleVerse('Following'),
                                            // _smallVerse('${_userModel.followedBzzIDs.length} Businesses'),

                                            _titleVerse('Saved flyers'),
                                            // _smallVerse('${_userModel.savedFlyersIDs.length} flyers'),

                                            _titleVerse('Main Contacts'),
                                            DreamWrapper(
                                              boxWidth: 250,
                                              boxHeight: 100,
                                              verses: _stringyContactsValues,
                                              icons: _stringyContactsIcons,
                                              buttonHeight: 20,
                                              spacing: 2.5,
                                              margins: EdgeInsets.all(2.5),
                                              onTap: () async {
                                                await superDialog(
                                                  context: context,
                                                  title: 'Contact',
                                                  body: '$_stringyContactsValues',
                                                  boolDialog: false,
                                                );
                                              }

                                            ),

                                            _titleVerse('Social Media Contacts'),
                                            DreamWrapper(
                                              boxWidth: 250,
                                              boxHeight: 100,
                                              verses: _socialContactsValues,
                                              icons: _socialContactsIcons,
                                              buttonHeight: 20,
                                              spacing: 2.5,
                                              margins: EdgeInsets.all(2.5),
                                              onTap: () async {
                                                  await superDialog(
                                                    context: context,
                                                    title: 'Contact',
                                                    body: '$_socialContactsValues',
                                                    boolDialog: false,
                                                  );
                                              }
                                            ),

                                          ],
                                        ),

                                        // --- Expander
                                        Expanded(child: Container()),

                                        DreamBox(
                                          height: 25,
                                          width: 25,
                                          icon: Flagz.getFlagByIso3(_userModel.zone.countryID),
                                          corners: 5,
                                        ),

                                      ],
                                    ),

                                  ],
                                ),

                              ],
                            );
                          },
                      ),
                    ),


                  ],
                );
              }
            }
            ),

      ],
    );
  }
}
