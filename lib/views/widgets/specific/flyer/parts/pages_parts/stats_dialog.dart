import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class FlyerStatsDialog extends StatefulWidget {
  final String flyerID;

  const FlyerStatsDialog({
    @required this.flyerID,
    Key key,
}) : super(key: key);
// -----------------------------------------------------------------------------
  @override
  State<FlyerStatsDialog> createState() => _FlyerStatsDialogState();
// -----------------------------------------------------------------------------
  static Future<void> show({@required BuildContext context, @required String flyerID}) async {
    await BottomDialog.showBottomDialog(
      context: context,
      // title: 'things',
      draggable: true,
      child: FlyerStatsDialog(flyerID: flyerID,),
    );
  }
// -----------------------------------------------------------------------------
}

class _FlyerStatsDialogState extends State<FlyerStatsDialog> {
  List<UserModel> _usersShares = UserModel.dummyUsers(numberOfUsers: 2);
  List<UserModel> _usersViews = UserModel.dummyUsers(numberOfUsers: 5);
  List<UserModel> _usersSaves = UserModel.dummyUsers(numberOfUsers: 4);
  List<UserModel> _users;
  String _currentTab = 'views';

  @override
  void initState() {
    super.initState();
    _users = _usersViews;
  }
// -----------------------------------------------------------------------------
  void _onSelectTab(String tab){
    setState(() {
      _currentTab = tab;
      _statelessSetTabUsers(tab);
    });
  }
// -----------------------------------------------------------------------------
  void _statelessSetTabUsers(String tab){
    if(tab == 'views'){
      _users = _usersViews;
    }
    else if (tab == 'shares'){
      _users = _usersShares;
    }
    else {
      _users = _usersSaves;
    }
  }
// -----------------------------------------------------------------------------
  Widget button({BuildContext context, String icon, String verse, Function onTap, bool isSelected}){

    final Color _buttonColor = isSelected == true ? Colorz.yellow255 : Colorz.white10;
    final Color _verseColor = isSelected == true ? Colorz.black255 : Colorz.white255;

    return
      GestureDetector(
        onTap: onTap,
        child: Stack(
          children: <Widget>[

            DreamBox(
              height: 50,
              width: Scale.getUniformRowItemWidth(context, 3),
              corners: Borderers.superBorderAll(context, BottomDialog.dialogClearCornerValue()),
              color: _buttonColor,
            ),

            Container(
              width: Scale.getUniformRowItemWidth(context, 3),
              height: 50,
              // decoration: BoxDecoration(
              //   color: _buttonColor,
              //   borderRadius: Borderers.superBorderAll(context, BottomDialog.dialogClearCornerValue()),
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  DreamBox(
                    height: 30,
                    width: 30,
                    icon: icon,
                    iconColor: _verseColor,
                    iconSizeFactor: 0.8,
                    bubble: false,
                  ),

                  Container(
                    height: 20,
                    child: SuperVerse(
                      verse: verse,
                      size: 1,
                      color: _verseColor,
                    ),
                  ),

                ],

              ),
            ),

          ],
        ),
      );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final  double _clearWidth = BottomDialog.dialogClearWidth(context);
    final double _clearHeight = BottomDialog.dialogClearHeight(context: context, draggable: true, titleIsOn: false);
    const double _tabsHeight = 50;
    final double _bodyHeight =  _clearHeight - _tabsHeight;

    return Container(
      width: _clearWidth,
      height: _clearHeight,
      // color: Colorz.Yellow80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// TABS
          Container(
            width: _clearWidth,
            height: 50,
            // color: Colorz.Blue125,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                button(
                  context: context,
                  verse: 'xxx shares',
                  icon: Iconz.Share,
                  onTap: () => _onSelectTab('shares'),
                  isSelected: _currentTab == 'shares',
                ),

                button(
                  context: context,
                  verse: 'xxx views',
                  icon: Iconz.Views,
                  onTap: () => _onSelectTab('views'),
                  isSelected: _currentTab == 'views',
                ),

                button(
                  context: context,
                  verse: 'xxx saves',
                  icon: Iconz.Save,
                  onTap: () => _onSelectTab('saves'),
                  isSelected: _currentTab == 'saves',
                ),

              ],
            ),
          ),

          /// TINY USERS
          Container(
            width: _clearWidth,
            height: _bodyHeight,
            // color: Colorz.BloodTest,
            // padding: const EdgeInsets.only(top: Ratioz.appBarMargin),
            child: MaxBounceNavigator(
              axis: Axis.vertical,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(top: Ratioz.appBarMargin, left: Ratioz.appBarMargin, right: Ratioz.appBarMargin, bottom: Ratioz.horizon),
                  shrinkWrap: false,
                  itemCount: _users.length,
                  itemBuilder: (BuildContext ctx, int index){

                    UserModel _userModel = _users[index];

                    return
                        DreamBox(
                          height: 50,
                          width: _clearWidth - (Ratioz.appBarMargin * 4),
                          icon: _userModel.pic,
                          verse: _userModel.name,
                          secondLine: _userModel.title,
                          verseScaleFactor: 0.65,
                          secondLineScaleFactor: 0.9,
                          verseCentered: false,
                          margins: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
                          bubble: false,
                          color: Colorz.white10,
                        );

                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
