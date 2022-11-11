import 'package:bldrs/b_views/z_components/bz_profile/targets/targets_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:flutter/material.dart';

class BzTargetsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzTargetsPage({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      children: const <Widget>[

        TargetsBubble(),

        Horizon(),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
