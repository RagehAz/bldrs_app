import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:flutter/material.dart';

class BzNetworkPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzNetworkPage({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    return Center(
      child: SuperVerse(
        verse: '${_bzModel.name}\nNetwork\nPage',
        size: 4,
        maxLines: 3,
      ),
    );
  }
}
