import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/specific/bz/targets_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:flutter/material.dart';

class BzTargetsTab extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzTargetsTab({
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
