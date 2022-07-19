import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/x_dashboard/a_modules/f_bzz_manager/bz_long_button.dart';
import 'package:flutter/material.dart';

class UserFollowingPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserFollowingPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel userModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: true,
    );

    final List<String> _followedBzzIds = userModel.followedBzzIDs;

    if (Mapper.checkCanLoopList(_followedBzzIds) == false){
      return const SuperVerse(verse: 'Fuck you');
    }

    else {

      return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        itemCount: _followedBzzIds.length,
        itemBuilder: (_, int index){

          final String _bzID = _followedBzzIds[index];

          return FutureBuilder(
            future: BzzProvider.proFetchBzModel(context: context, bzID: _bzID),
            builder: (_, AsyncSnapshot<BzModel> bzModel){
              return BzLongButton(
                bzModel: bzModel?.data,
              );
            },
          );

          // return FollowingBzzGrid(
          //   bzzModels: _bzzOfThisType,
          //   title: _bzTypeString,
          //   icon: _bzTypeIcon,
          //   onBzTap: (BzModel bzModel){
          //     bzModel.blogBz(methodName: 'Yabny tapped bzModel aho tapped aho');
          //   },
          // );

        },
      );

    }

  }
}
