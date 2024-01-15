import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class BzNetworkPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzNetworkPage({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel? _bzModel = HomeProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );

    return BldrsFloatingList(
      columnChildren: <Widget>[

        BldrsText(
          verse: Verse(
            id: '#!#${_bzModel?.name}\nNetwork\nPage',
            translate: true,
            variables: _bzModel?.name,
          ),
          size: 4,
          maxLines: 3,
        ),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
