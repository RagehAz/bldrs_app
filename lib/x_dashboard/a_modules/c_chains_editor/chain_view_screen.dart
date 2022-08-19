import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/expander_structure/b_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ChainViewScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainViewScreen({
    @required this.chain,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Chain chain;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitle: chain.id,
      sectionButtonIsOn: false,
      appBarType: AppBarType.basic,
      layoutWidget: Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeightWithoutSafeArea(context),
        color: Colorz.bloodTest,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: Stratosphere.stratosphereSandwich,
          child: ChainSplitter(
            initiallyExpanded: false,
            chainOrChainsOrSonOrSons: chain,
          ),
        ),
      ),
    );

  }
}
