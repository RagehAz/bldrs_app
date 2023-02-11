import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:flutter/material.dart';

class BzNetworkPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzNetworkPage({
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );

    return BldrsFloatingList(
      columnChildren: <Widget>[

        SuperVerse(
          verse: Verse(
            id: '#!#${_bzModel.name}\nNetwork\nPage',
            translate: true,
            variables: _bzModel.name,
          ),
          size: 4,
          maxLines: 3,
        ),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
