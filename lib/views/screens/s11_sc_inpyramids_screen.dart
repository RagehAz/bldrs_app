import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/ab_in_pyramids/ab_in_pyramids.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/pyramids/enum_lister.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 's12_pg_saved_flyers_page.dart';
import 's13_pg_news_page.dart';
import 's14_pg_more_page.dart';
import 's15_pg_profile_page.dart';

enum inPyramidsPage {
  SavedFlyers,
  News,
  More,
  Profile,
}

class InPyramidsScreen extends StatefulWidget {
  final UserStatus userStatus;

  InPyramidsScreen({
    this.userStatus = UserStatus.PlanningUser,
});

  @override
  _InPyramidsScreenState createState() => _InPyramidsScreenState();
}

class _InPyramidsScreenState extends State<InPyramidsScreen> {
  UserStatus currentUserStatus;
  inPyramidsPage currentPage;
  bool enumListerIsOn = false;
  String enumListTitle = '';
  List<String> enumListerStrings = [''];
  List<bool> enumListerTriggers = [false];
  // bool tileIsOn = false;
  String country;
// ----------------------------------------------------------------------------
  @override
  void initState(){
  currentUserStatus = widget.userStatus; // userStatus.PlanningUser
  currentPage = inPyramidsPage.SavedFlyers;
    super.initState();
  }
// ----------------------------------------------------------------------------
  final _status = [
    {
      'title': 'Property Status',
    'buttons': [
      {'state': 'Looking for a\nnew property', 'userStatus' : UserStatus.SearchingUser},
      {'state': 'Constructing\nan existing\nproperty', 'userStatus' : UserStatus.ConstructingUser},
      {'state': 'Want to\nSell / Rent\nmy property', 'userStatus' : UserStatus.SellingUser}
      ],
    },
    {
      'title': 'Construction Status',
    'buttons': [
      {'state': 'Planning Construction', 'userStatus' : UserStatus.PlanningUser},
      {'state': 'Under Construction', 'userStatus' : UserStatus.BuildingUser}
      ],
    },
  ];
// ----------------------------------------------------------------------------
  void _switchingPages(inPyramidsPage page) {
    setState(() {
      currentPage = page;
    });
  }
// ----------------------------------------------------------------------------
  void _switchUserStatus (UserStatus type){
    setState(() {
      currentUserStatus = type;
    });
  }
// ----------------------------------------------------------------------------
  void _openEnumLister(Map<String,Object> passedMap){
    setState(() {
      enumListTitle = passedMap['Title'];
      enumListerStrings = passedMap['Strings'];
      enumListerTriggers = passedMap['Triggers'];
      enumListerIsOn = true;
    });
  }
// ----------------------------------------------------------------------------
  void _closeEnumLister(){
    setState(() {
      enumListerIsOn = false;
    });
  }
// ----------------------------------------------------------------------------
  // Map<String, Object> listData = {
  //   'Strings' : ['Residential', 'Commercial', 'Admin', 'Medical', 'Religious'],
  //   'Triggers' : [false, false, false, false, false]
  // };
// ----------------------------------------------------------------------------
  void _triggerTile(int index) {
    setState(() {

      // List<bool>  updatedTriggersList = listData['Triggers'];
      enumListerTriggers[index] == false ?
      enumListerTriggers[index] = true :
      enumListerTriggers[index] = false;

      // listData['Triggers'] = updatedTriggersList;
    });
  }
// ----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    String country = Provider.of<CountryProvider>(context, listen: false).currentCountry;

    return MainLayout(
      pyramids: enumListerIsOn == true ? Iconz.PyramidzWhite : Iconz.PyramidsWhite,
      sky: Sky.Black,

      // appBarType: AppBarType.Basic,
      // appBarRowWidgets: <Widget>[
      // ],
      tappingRageh: (){print(country);},
      layoutWidget:
      Stack(
        children: <Widget>[

          CustomScrollView(
            slivers: <Widget>[

              ABInPyramids(
                switchingPages: _switchingPages,
                currentPage: currentPage,
                userStatus: currentUserStatus,
              ),

              currentPage == inPyramidsPage.Profile ?
              ProfilePage(
                status: _status,
                userStatus: currentUserStatus,
                switchUserStatus: _switchUserStatus,
                // bzLogos: dummyCollection,
                currentUserStatus: currentUserStatus,
                openEnumLister: _openEnumLister,
              )
                  :
              currentPage == inPyramidsPage.SavedFlyers ?
              SavedFlyersPage()
                  :
              currentPage == inPyramidsPage.News ?
              NewsPage()
                  :
              currentPage == inPyramidsPage.More ?
              MorePage()
                  :
              SavedFlyersPage()
            ],
          ),

          // --- LIST TEMPLATE
          enumListerIsOn == true ?
          EnumLister(
            listTitle: enumListTitle,
            stringsList: enumListerStrings,//listData['Strings'],
            triggersList: enumListerTriggers,//listData['Triggers'],
            triggerTile: _triggerTile,
            closeEnumLister: _closeEnumLister,
          ) : Container(),

        ],
      ),

    );

  }
}
