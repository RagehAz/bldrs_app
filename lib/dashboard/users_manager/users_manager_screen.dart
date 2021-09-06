import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/dashboard/widgets/dashboard_data_row.dart';
import 'package:bldrs/firestore/cloud_functions.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/zones/zone_provider.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/dream_wrapper.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersManagerScreen extends StatefulWidget {

  @override
  _UsersManagerScreenState createState() => _UsersManagerScreenState();
}

class _UsersManagerScreenState extends State<UsersManagerScreen> {
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

  }
  // -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(function: (){}).then((_) async {
        /// ---------------------------------------------------------0

        _readMoreUsers();

        /// ---------------------------------------------------------0
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------


  ScrollController _scrollController = ScrollController();
// -----------------------------------------------------------------------------
  QueryDocumentSnapshot _lastSnapshot;
  List<UserModel> _usersModels = [];
  Future<void> _readMoreUsers() async {

    List<dynamic> _maps = await Fire.readCollectionDocs(
      collectionName:  FireCollection.users,
      orderBy: 'userID',
      limit: 5,
      startAfter: _lastSnapshot,
      addDocSnapshotToEachMap: true,
    );

    List<UserModel> _fetchedModel = UserModel.decipherUsersMaps(_maps);

    setState(() {
      _lastSnapshot = _maps[_maps.length - 1]['docSnapshot'];
      _usersModels.addAll(_fetchedModel);
    });


    await Future.delayed(Duration(milliseconds: 400), () async {

      await Scrollers.scrollToBottom(controller: _scrollController);

    });

  }
// -----------------------------------------------------------------------------
  Future<void> _deleteUser(UserModel userModel) async {

    String _result = await CloudFunctionz.deleteFirebaseUser(userID: userModel.userID);

    if (_result == 'stop'){
      print('operation stopped');
    }

    else if (_result == 'deleted'){

      int _userIndex = _usersModels.indexWhere((user) => user.userID == userModel.userID);
      setState(() {
      _usersModels.removeAt(_userIndex);
      });

    }

  }


  @override
  Widget build(BuildContext context) {

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);

    double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    SuperVerse _titleVerse(String title){
      return SuperVerse(
        verse: title,
        size: 0,
        color: Colorz.Grey80,
      );
    }

    return MainLayout(
      loading: _loading,
      pageTitle: 'Users Manager',
      appBarType: AppBarType.Basic,
      pyramids: Iconz.DvBlankSVG,
      sky: Sky.Black,
      appBarRowWidgets: <Widget>[

        Expander(),

        DreamBox(
          width: 150,
          height: 40,
          verse: 'Load More',
          secondLine: 'showing ${_usersModels.length} users',
          verseScaleFactor: 0.7,
          secondLineScaleFactor: 0.9,
          margins: EdgeInsets.symmetric(horizontal: 5),
          onTap: () async {

            await _readMoreUsers();

          },
        ),

      ],
      layoutWidget: ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: _usersModels.length,
        padding: const EdgeInsets.only(bottom: Ratioz.grandHorizon, top: Ratioz.stratosphere),
        itemExtent: 70,
        itemBuilder: (context, index){

          UserModel _userModel = _usersModels[index];
          String _countryName = _countryPro .getCountryNameInCurrentLanguageByIso3(context, _userModel.zone.countryID);
          String _provinceName = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, _userModel.zone.cityID);
          String _districtName = _countryPro.getDistrictNameWithCurrentLanguageIfPossible(context, _userModel.zone.districtID);

          List<ContactModel> _stringyContacts = ContactModel.getContactsWithStringsFromContacts(_userModel.contacts);
          List<String> _stringyContactsValues = ContactModel.getListOfValuesFromContactsModelsList(_stringyContacts);
          List<String> _stringyContactsIcons = ContactModel.getListOfIconzFromContactsModelsList(_stringyContacts);

          List<ContactModel> _socialContacts = ContactModel.getSocialMediaContactsFromContacts(_userModel.contacts);
          List<String> _socialContactsValues = ContactModel.getListOfValuesFromContactsModelsList(_socialContacts);
          List<String> _socialContactsIcons = ContactModel.getListOfIconzFromContactsModelsList(_socialContacts);

          // dynamic bobo = ContactModel.getListOfValuesFromContactsModelsList(_stringyContacts);

          return
            DreamBox(
              height: 60,
              width: _screenWidth - 20,
              icon: _userModel.pic,
              color: Colorz.White20,
              verse: _userModel.name,
              secondLine: '$index : ${_userModel.userID}',
              verseScaleFactor: 0.6,
              verseCentered: false,
              secondLineScaleFactor: 0.9,
              margins: EdgeInsets.symmetric(vertical: 5),
              onTap: () async {

                double _clearDialogWidth = BottomDialog.dialogClearWidth(context);

                await BottomDialog.slideBottomDialog(
                  context: context,
                  title: _userModel.name,
                  draggable: true,
                  child: Container(
                    width: _clearDialogWidth,
                    height: BottomDialog.dialogClearHeight(draggable: true, title: 'x', context: context,),
                    color: Colorz.BloodTest,
                    child: GoHomeOnMaxBounce(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: <Widget>[

                          DreamBox(
                            height: 25,
                            width: 25,
                            icon: Flagz.getFlagByIso3(_userModel.zone.countryID),
                            corners: 5,
                          ),

                          SuperVerse(verse: 'is admin or not ? ,, work this out please',),

                          BottomDialogRow(dataKey: 'userID', value: _userModel.userID),
                          BottomDialogRow(dataKey: 'authBy', value: _userModel.authBy),
                          BottomDialogRow(dataKey: 'joinedAt', value: _userModel.joinedAt),
                          BottomDialogRow(dataKey: 'timeString', value: Timers.dayMonthYearStringer(context, _userModel.joinedAt)),
                          BottomDialogRow(dataKey: 'userStatus', value: _userModel.userStatus),
                          BottomDialogRow(dataKey: 'name', value: _userModel.name),
                          BottomDialogRow(dataKey: 'pic', value: _userModel.pic),
                          BottomDialogRow(dataKey: 'title', value: _userModel.title),
                          BottomDialogRow(dataKey: 'company', value: _userModel.company),
                          BottomDialogRow(dataKey: 'gender', value: _userModel.gender),
                          BottomDialogRow(dataKey: 'zone', value: _userModel.zone),
                          BottomDialogRow(dataKey: 'zone String', value: 'in [ $_districtName ] - [ $_provinceName ] - [ $_countryName ]'),
                          BottomDialogRow(dataKey: 'language', value: _userModel.language),
                          BottomDialogRow(dataKey: 'position', value: _userModel.position),
                          BottomDialogRow(dataKey: 'contacts', value: _userModel.contacts),
                          BottomDialogRow(dataKey: 'Stringy contacts', value: '$_stringyContactsValues'),
                          BottomDialogRow(dataKey: 'Social Contacts', value: '$_socialContactsValues'),
                          BottomDialogRow(dataKey: 'myBzzIDs', value: _userModel.myBzzIDs),
                          BottomDialogRow(dataKey: 'emailIsVerified', value: _userModel.emailIsVerified),
                          // DataRow(dataKey: 'SavedFlyers', value: '${_userModel.savedFlyersIDs.length} flyers')
                          // DataRow(dataKey: 'followedBzz', value: '${_userModel.followedBzzIDs.length} Businesses'),

                          _titleVerse('Main Contacts'),
                          DreamWrapper(
                              boxWidth: 250,
                              boxHeight: 100,
                              verses: _stringyContactsValues,
                              icons: _stringyContactsIcons,
                              buttonHeight: 20,
                              spacing: 2.5,
                              margins: const EdgeInsets.all(2.5),
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
                              margins: const EdgeInsets.all(2.5),
                              onTap: () async {
                                await superDialog(
                                  context: context,
                                  title: 'Contact',
                                  body: '$_socialContactsValues',
                                  boolDialog: false,
                                );
                              }
                          ),

                          Container(
                              width: _clearDialogWidth,
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  DreamBox(
                                    height: 80,
                                    width: 80,
                                    verse: 'Delete User',
                                    verseMaxLines: 2,
                                    onTap: () => _deleteUser(_userModel),
                                  ),

                                ],
                              )
                          )

                        ],
                      ),
                    ),
                  ),
                );

              },
            );
        },
      ),

    );
  }
}