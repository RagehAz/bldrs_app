import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
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
  List<Chain> _allChains;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    final Chain _keywordsChain = _chainsProvider.keywordsChain;
    final Chain _specsChain = _chainsProvider.specsChain;

    _allChains = <Chain>[
      _keywordsChain,
      _specsChain,
    ];

  }
// -----------------------------------------------------------------------------
  Future<void> _onUploadChains() async {

    // final Chain _keywordsChain = _chainsProvider.keywordsChain;
    // final Chain _specsChain = _chainsProvider.specsChain;

    // final Chain _keywordsChain = await ChainOps.readKeywordsChain(context);

    // _keywordsChain?.blogChain();
    //
    // final List<Chain> _newSpecsChains = <Chain>[
    //   propertySalePrice,
    //   propertyRentPrice,
    //   propertyDecorationStyle,
    //   designType,
    //   projectCost,
    //   constructionDuration,
    // ];
    //
    // await onAddMoreSpecsChainsToExistingSpecsChains(
    //   context: context,
    //   chainsToAdd: _newSpecsChains,
    // );


    await deleteAllCollectionDocs(
        context: context,
        collName: 'countries',
    );

    // return 'b';
  }
// -----------------------------------------------------------------------------
  Future<void> _onStripTap({
    @required String phraseIDPath, // will look like this 'idA/idB/idC'
}) async {

    blog(phraseIDPath);

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
// ------------------------------------------------
  Future<void> _onSearchSubmit(String text) async {

    blog('text is : $text');

    triggerIsSearchingNotifier(
        text: text,
        isSearching: _isSearching
    );

    _onSearchChains(
      chains: _allChains,
    );

  }

  void _onSearchChains({
  @required List<Chain> chains,
}){

    /// SEARCH CHAINS FOR MATCH CASES

    /// GENERATE PATHS FOR THOSE CASES

    /// BUILD CHAINS FOR THOSE PATHS

    /// SEAT FOUND CHAINS AS SEARCH RESULT
  }

  @override
  Widget build(BuildContext context) {


    return MainLayout(
      key: const ValueKey<String>('ChainsManagerScreen'),
      pageTitle: 'All Keywords',
      appBarType: AppBarType.search,
      pyramidsAreOn: true,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      skyType: SkyType.black,
      onSearchSubmit: (String text) => _onSearchSubmit(text),
      appBarRowWidgets: [

        const Expander(),

        /// UPLOAD CHAIN
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

      canLoopList(_allChains) == true ?
      ChainsTreesStarter(
        chains: _allChains,
        onStripTap: (String path) => _onStripTap(
            phraseIDPath: path
        )
      )
          :
      const SizedBox(),

    );
  }
}
