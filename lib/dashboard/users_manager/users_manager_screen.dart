import 'package:bldrs/models/planet/area_model.dart';
import 'package:bldrs/models/planet/country_model.dart';
import 'package:bldrs/models/planet/province_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/controllers/streamerz.dart';
import 'package:bldrs/view_brains/drafters/aligners.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/drafters/texters.dart';
import 'package:bldrs/view_brains/drafters/timerz.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/bubbles/contacts_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/dream_wrapper.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersManagerScreen extends StatefulWidget {

  @override
  _UsersManagerScreenState createState() => _UsersManagerScreenState();
}

class _UsersManagerScreenState extends State<UsersManagerScreen> {
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
    super.initState();
  }
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);

    double _screenWidth = superScreenWidth(context);
    double _screenHeight = superScreenHeight(context);

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
                _loading = true;
                return LoadingFullScreenLayer();
              } else {
                _loading = true;
                List<UserModel> usersModels = snapshot.data;
                return
                  Container(
                    width: _screenWidth,
                    height: _screenHeight - Ratioz.stratosphere,
                    child: ListView.builder(
                      itemCount: usersModels.length,
                      padding: EdgeInsets.only(bottom: Ratioz.grandHorizon),
                      itemBuilder: (context, index){

                        UserModel _userModel = usersModels[index];
                        String _countryName = _countryPro .getCountryNameInCurrentLanguageByIso3(context, _userModel.country);
                        String _provinceName = _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, _userModel.province);
                        String _areaName = _countryPro.getAreaNameWithCurrentLanguageIfPossible(context, _userModel.area);

                        return
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                // --- INDEX AND ID
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin),
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
                                        ),

                                        SizedBox(
                                          width: Ratioz.ddAppBarMargin,
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
                                            _smallVerse(dayMonthYearStringer(context, _userModel.joinedAt)),

                                            _titleVerse('preferred language'),
                                            _smallVerse(_userModel.language),

                                            _titleVerse('Following'),
                                            _smallVerse('${_userModel.followedBzzIDs.length} Businesses'),

                                            _titleVerse('Saved flyers'),
                                            _smallVerse('${_userModel.savedFlyersIDs.length} flyers'),

                                            _titleVerse('Main Contacts'),
                                            DreamWrapper(
                                              boxWidth: 250,
                                              boxHeight: 100,
                                              verses: getListOfValuesFromContactsModelsList(getContactsWithStringsFromContacts(_userModel.contacts)),
                                              icons: getListOfIconzFromContactsModelsList(getContactsWithStringsFromContacts(_userModel.contacts)),
                                              buttonHeight: 20,
                                              spacing: 2.5,
                                              margins: EdgeInsets.all(2.5),
                                              onTap: () => superDialog(context, '${getListOfValuesFromContactsModelsList(getContactsWithStringsFromContacts(_userModel.contacts))}', 'Contact'),
                                            ),

                                            _titleVerse('Social Media Contacts'),
                                            DreamWrapper(
                                              boxWidth: 250,
                                              boxHeight: 100,
                                              verses: getListOfValuesFromContactsModelsList(getSocialMediaContactsFromContacts(_userModel.contacts)),
                                              icons: getListOfIconzFromContactsModelsList(getSocialMediaContactsFromContacts(_userModel.contacts)),
                                              buttonHeight: 20,
                                              spacing: 2.5,
                                              margins: EdgeInsets.all(2.5),
                                              onTap: () => superDialog(context, '${getListOfValuesFromContactsModelsList(getSocialMediaContactsFromContacts(_userModel.contacts))}', 'Contact'),
                                            ),

                                          ],
                                        ),

                                        // --- Expander
                                        Expanded(child: Container()),

                                        DreamBox(
                                          height: 25,
                                          width: 25,
                                          icon: getFlagByIso3(_userModel.country),
                                          corners: 5,
                                        ),

                                      ],
                                    ),

                                  ],
                                )
                              ],
                            );
                      },
                    ),
                  );
              }
            }
        )

      ],
    );
  }
}
