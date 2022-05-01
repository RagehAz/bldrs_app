import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:flutter/material.dart';

class BzNetworkPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzNetworkPage({
    @required this.bzModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SuperVerse(
        verse: 'Business\nNetwork\nPage',
        size: 4,
        maxLines: 3,
      ),
    );
  }
}
