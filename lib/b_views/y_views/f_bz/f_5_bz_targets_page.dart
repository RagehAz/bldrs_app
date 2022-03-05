import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bz_profile/targets/targets_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:flutter/material.dart';

class BzTargetsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzTargetsPage({
    @required this.bzModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: const <Widget>[

        TargetsBubble(),

        Horizon(),

      ],
    );
  }
}
