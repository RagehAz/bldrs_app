import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/x4_user_follows_page_controllers.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:bldrs/x_dashboard/f_bzz_manager/bz_long_button.dart';
import 'package:flutter/material.dart';

class UserFollowingPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserFollowingPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final UserModel userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );
    final List<String> _followedBzzIds = userModel.followedBzzIDs;
    // --------------------
    /// FOLLOWS EXIST
    if (Mapper.checkCanLoopList(_followedBzzIds) == false){
      return const SuperVerse(
        verse: Verse(
            text: 'phid_no_bzz_are_followed',
            translate: true,
            casing: Casing.capitalizeFirstChar,
        ),
      );
    }
    // --------------------
    /// NO FOLLOWS THERE
    else {

      return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.stratosphereSandwich,
        itemCount: _followedBzzIds.length,
        itemBuilder: (_, int index){

          final String _bzID = _followedBzzIds[index];

          return FutureBuilder(
            future: BzProtocols.fetchBz(context: context, bzID: _bzID),
            builder: (_, AsyncSnapshot<BzModel> snapshot){

              blog('snapshot connectionState is : ${snapshot.connectionState}');

              if (Streamer.connectionIsLoading(snapshot) == true){
                return const SizedBox();
              }

              else {

                if (snapshot.data == null){

                  /// NOTE : WHEN BZ MODEL IS NULL (DELETED) ITS ID IS STILL IN [_followedBzzIds]
                  unawaited(autoDeleteThisBzIDFromMyFollowedBzzIDs(
                    context: context,
                    bzID: _bzID,
                  ));

                  return const SizedBox();
                }

                else {
                  return BzLongButton(
                    bzModel: snapshot?.data,
                  );
                }

              }

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
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
