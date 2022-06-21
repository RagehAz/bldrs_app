import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/user_profile/bzz_grid/following_bzz_grid.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
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
