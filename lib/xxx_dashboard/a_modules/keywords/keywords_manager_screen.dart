import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/specs/raw_specs.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:bldrs/xxx_dashboard/a_modules/keywords/widgets/chains_data_tree_starter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      ... allSpecsChains,
    ];

    return MainLayout(
      pageTitle: 'All Keywords',
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      skyType: SkyType.black,
      appBarRowWidgets: [

        const Expander(),

        DreamBox(
          height: 40,
          icon: Iconz.language,
          iconSizeFactor: 0.6,
          onTap: () async {

            final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
            final String _currentLangCode = Wordz.languageCode(context);
            await _phraseProvider.changeAppLang(
                context: context,
                langCode: _currentLangCode == 'en' ? 'ar' : 'en',
            );

          },
        ),

      ],
      layoutWidget: ChainsTreesStarter(
        chains: _chains,
      ),

    );
  }
}
