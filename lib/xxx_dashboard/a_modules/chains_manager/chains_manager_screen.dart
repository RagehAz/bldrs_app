import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/raw_data/all_chains.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/chain_ops.dart' as ChainOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:bldrs/xxx_dashboard/a_modules/chains_manager/widgets/chains_data_tree_starter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainsManagerScreen extends StatefulWidget {

  const ChainsManagerScreen({
    Key key
  }) : super(key: key);

  @override
  _ChainsManagerScreenState createState() => _ChainsManagerScreenState();
}

class _ChainsManagerScreenState extends State<ChainsManagerScreen> {

// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _onUploadChains() async {

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    // final Chain _keywordsChain = _chainsProvider.keywordsChain;
    // final Chain _specsChain = _chainsProvider.specsChain;

    // final Chain _keywordsChain = await ChainOps.readKeywordsChain(context);

    // _keywordsChain?.blogChain();

    // await _chainsProvider.clearCurrentKeyword(context);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: true);
    final Chain _keywordsChain = _chainsProvider.keywordsChain;
    final Chain _specsChain = _chainsProvider.specsChain;

    final List<Chain> _chains = [
      _keywordsChain,
      _specsChain,
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

        ///
        DreamBox(
          height: 40,
          verse: 'Upload',
          secondLine: 'Chains',
          iconSizeFactor: 0.6,
          onTap: _onUploadChains,
        ),


        /// SWITCH LANGUAGE BUTTON
        DreamBox(
          height: 40,
          icon: Iconz.language,
          iconSizeFactor: 0.6,
          margins: const EdgeInsets.symmetric(horizontal: 5),
          onTap: () async {

            final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
            final String _currentLangCode = Wordz.languageCode(context);
            await _phraseProvider.changeAppLang(
                context: context,
                langCode: _currentLangCode == 'en' ? 'ar' : 'en',
            );

            setState(() {});

          },
        ),

      ],
      layoutWidget:

      canLoopList(_chains) == true ?
      ChainsTreesStarter(
        chains: _chains,
      )
          :
      const SizedBox(),

    );
  }
}
