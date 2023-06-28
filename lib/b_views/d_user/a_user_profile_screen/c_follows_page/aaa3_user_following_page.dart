import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/c_follows_page/x3_user_follows_page_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/bz_long_button.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/material.dart';

class UserFollowingPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserFollowingPage({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final UserModel? userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );
    final List<String> _followedBzzIds = userModel.followedBzz?.all;
    // --------------------
    /// FOLLOWS EXIST
    if (Mapper.checkCanLoopList(_followedBzzIds) == false){
      return const BldrsText(
        verse: Verse(
            id: 'phid_no_bzz_are_followed',
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
            future: BzProtocols.fetchBz(bzID: _bzID),
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
          //     bzModel.blogBz(invoker: 'Yabny tapped bzModel aho tapped aho');
          //   },
          // );

        },
      );

    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
