import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/ab_in_pyramids/ab_in_pyramids.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/pyramids/enum_lister.dart';
import 'package:flutter/material.dart';
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
  UserStatus _currentUserStatus;
  inPyramidsPage _currentPage;
  bool _enumListerIsOn = false;
  String _enumListTitle = '';
  List<String> _enumListerStrings = [''];
  List<bool> _enumListerTriggers = [false];
  // bool tileIsOn = false;
  String country;
// ----------------------------------------------------------------------------
  @override
  void initState(){
  _currentUserStatus = widget.userStatus; // userStatus.PlanningUser
  _currentPage = inPyramidsPage.SavedFlyers;
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
      _currentPage = page;
    });
  }
// ----------------------------------------------------------------------------
  void _switchUserStatus (UserStatus type){
    setState(() {
      _currentUserStatus = type;
    });
  }
// ----------------------------------------------------------------------------
  void _openEnumLister(Map<String,Object> passedMap){
    setState(() {
      _enumListTitle = passedMap['Title'];
      _enumListerStrings = passedMap['Strings'];
      _enumListerTriggers = passedMap['Triggers'];
      _enumListerIsOn = true;
    });
  }
// ----------------------------------------------------------------------------
  void _closeEnumLister(){
    setState(() {
      _enumListerIsOn = false;
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
      _enumListerTriggers[index] == false ?
      _enumListerTriggers[index] = true :
      _enumListerTriggers[index] = false;

      // listData['Triggers'] = updatedTriggersList;
    });
  }
// ----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: _enumListerIsOn == true ? Iconz.PyramidzWhite : Iconz.PyramidsWhite,
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
                currentPage: _currentPage,
                userStatus: _currentUserStatus,
              ),

              _currentPage == inPyramidsPage.Profile ?
              ProfilePage(
                status: _status,
                userStatus: _currentUserStatus,
                switchUserStatus: _switchUserStatus,
                // bzLogos: dummyCollection,
                currentUserStatus: _currentUserStatus,
                openEnumLister: _openEnumLister,
              )
                  :
              _currentPage == inPyramidsPage.SavedFlyers ?
              SavedFlyersPage()
                  :
              _currentPage == inPyramidsPage.News ?
              NewsPage()
                  :
              _currentPage == inPyramidsPage.More ?
              MorePage()
                  :
              SavedFlyersPage()
            ],
          ),

          // --- LIST TEMPLATE
          _enumListerIsOn == true ?
          EnumLister(
            listTitle: _enumListTitle,
            stringsList: _enumListerStrings,//listData['Strings'],
            triggersList: _enumListerTriggers,//listData['Triggers'],
            triggerTile: _triggerTile,
            closeEnumLister: _closeEnumLister,
          ) : Container(),

        ],
      ),

    );

  }
}
