import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/ab_in_pyramids/ab_in_pyramids.dart';
import 'package:bldrs/views/widgets/buttons/user_bubble.dart';
import 'package:bldrs/views/widgets/in_pyramids/more_page.dart';
import 'package:bldrs/views/widgets/in_pyramids/news/news_page.dart';
import 'package:bldrs/views/widgets/in_pyramids/profile/profile_page.dart';
import 'package:bldrs/views/widgets/in_pyramids/saved_flyers/saved_flyers_page.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/pyramids/enum_lister.dart';
import 'package:flutter/material.dart';

enum inPyramidsPage {
  SavedFlyers,
  News,
  More,
  Profile,
}

class InPyramidsScreen extends StatefulWidget {
  final UserType userType;

  InPyramidsScreen({
    this.userType = UserType.PlanningUser,
});

  @override
  _InPyramidsScreenState createState() => _InPyramidsScreenState();
}

class _InPyramidsScreenState extends State<InPyramidsScreen> {
  UserType currentUserType;
  inPyramidsPage currentPage;
  bool enumListerIsOn = false;
  String enumListTitle = '';
  List<String> enumListerStrings = [''];
  List<bool> enumListerTriggers = [false];
  // bool tileIsOn = false;
// ----------------------------------------------------------------------------
  @override
  void initState(){
  currentUserType = widget.userType; // UserType.PlanningUser
  currentPage = inPyramidsPage.SavedFlyers;
    super.initState();
  }
// ----------------------------------------------------------------------------
  final _status = [
    {
      'title': 'Property Status',
    'buttons': [
      {'state': 'Looking for a\nnew property', 'userType' : UserType.SearchingUser},
      {'state': 'Constructing\nan existing\nproperty', 'userType' : UserType.ConstructingUser},
      {'state': 'Want to\nSell / Rent\nmy property', 'userType' : UserType.SellingUser}
      ],
    },
    {
      'title': 'Construction Status',
    'buttons': [
      {'state': 'Planning Construction', 'userType' : UserType.PlanningUser},
      {'state': 'Under Construction', 'userType' : UserType.BuildingUser}
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
  void _switchUserType (UserType type){
    setState(() {
      currentUserType = type;
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

    return MainLayout(
      pyramids: enumListerIsOn == true ? Iconz.PyramidzWhite : Iconz.PyramidsWhite,
      sky: Sky.Black,

      // appBarType: AppBarType.Basic,
      // appBarRowWidgets: <Widget>[
      // ],

      layoutWidget:
      Stack(
        children: <Widget>[

          CustomScrollView(
            slivers: <Widget>[

              ABInPyramids(
                switchingPages: _switchingPages,
                currentPage: currentPage,
                userType: currentUserType,
              ),

              currentPage == inPyramidsPage.Profile ?
              ProfilePage(
                status: _status,
                userType: currentUserType,
                switchUserType: _switchUserType,
                // bzLogos: dummyCollection,
                currentUserType: currentUserType,
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
