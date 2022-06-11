import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/user_profile/bzz_grid/following_bzz_grid.dart';
import 'package:bldrs/c_controllers/g_user_controllers/user_screen_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserFollowingPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserFollowingPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final UserModel userModel = UsersProvider.proGetMyUserModel(context, listen: true);

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: true);

    final List<BzModel> _myBzzTempDeleteAfterDoneUI = _bzzProvider.myBzz;
    final List<BzModel> _followedBzz = _myBzzTempDeleteAfterDoneUI; //_bzzProvider.followedBzz;

    const List<BzType> _bzTypes = BzModel.bzTypesList;

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      itemCount: _bzTypes.length,
      itemBuilder: (_, int index){

        final BzType _bzType = _bzTypes[index];

        final String _bzTypeString = BzModel.translateBzType(
            context: context,
            bzType: _bzType
        );

        final List<BzModel> _bzzOfThisType = BzModel.getBzzFromBzzByBzType(
            bzz: _followedBzz,
            bzType: _bzType
        );

        final String _bzTypeIcon = BzModel.getBzTypeIconOff(_bzType);

        return FollowingBzzGrid(
          bzzModels: _bzzOfThisType,
          title: _bzTypeString,
          icon: _bzTypeIcon,
          onBzTap: (BzModel bzModel){
            bzModel.blogBz(methodName: 'Yabny tapped bzModel aho tapped aho');
          },
        );

      },
    );

  }
}

class InviteBzzButton extends StatelessWidget {

  const InviteBzzButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Aligners.superBottomAlignment(context),
      child: DreamBox(
        height: 50,
        margins: const EdgeInsets.all(Ratioz.appBarMargin),
        // width: Scale.appBarWidth(context),
        color: Colorz.yellow255,
        verse: 'Invite Businesses you know',
        secondLine: 'To join Bldrs.net',
        secondLineColor: Colorz.black255,
        secondLineScaleFactor: 1.2,
        verseColor: Colorz.black255,
        verseCentered: false,
        icon: Iconz.bz,
        iconColor: Colorz.black255,
        iconSizeFactor: 0.7,
        onTap: () => onInviteBusinessesTap(context),
      ),
    );
  }
}

class UserSettingsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserSettingsPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final UserModel userModel = UsersProvider.proGetMyUserModel(context, listen: true);

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      children: const <Widget>[

        SuperVerse(
          verse: 'Settings page',
        ),

       InviteBzzButton(),

      ],
    );

  }
}
