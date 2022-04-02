import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/chain/chain_equipment.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/a_modules/keywords/widgets/chains_data_tree_starter.dart';
import 'package:flutter/material.dart';

class KeywordsManager extends StatefulWidget {

  const KeywordsManager({
    Key key
  }) : super(key: key);

  @override
  _KeywordsManagerState createState() => _KeywordsManagerState();
}

class _KeywordsManagerState extends State<KeywordsManager> {

// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth  = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    final List<Chain> _chains = [
      ... Chain.bldrsChain.sons,
    ];

    return MainLayout(
      pageTitle: 'All Keywords',
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      skyType: SkyType.black,

      layoutWidget: ChainsTreesStarter(
        chains: _chains,
      ),

    );
  }
}
